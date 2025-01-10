/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/repositories/settings_repo.dart';
import '../../data/services/database.dart';
import '../../domain/alerts.dart';
import '../../domain/platform_channel.dart';
import '../repositories/alerts_bg_repo.dart';
import '../repositories/notifications_bg_repo.dart';
import '../repositories/sources_bg_repo.dart';

part 'background.freezed.dart';
part 'background.g.dart';

enum MessageName {
  alertsInit,
  alertsFetching,
  alertsFetched,
  fetchAlerts,
  refreshTimer,
  initSources,
  addSource,
  updateSource,
  removeSource,
  enableNotifications,
  disableNotifications,
  toggleSounds,
  playDesktopSound,
  sourcesChanged,
  sourcesFailure,
  showRefreshIndicator,
  updateLastSeen,
  confirmSources,
  confirmSourcesReply,
}

enum MessageDestination {
  alerts,
  notifications,
  refreshIcon,
  sourceSettings,
  accountSettings,
}

@freezed
class IsolateMessage with _$IsolateMessage {
  const factory IsolateMessage({
    required MessageName name,
    MessageDestination? destination,
    int? id,
    List<Alert>? alerts,
    AlertSourceData? sourceData,
    List<AlertSourceData>? allSources,
    bool? forceRefreshNow,
    bool? alreadyFetching,
  }) = _IsolateMessage;

  factory IsolateMessage.fromJson(Map<String, dynamic> json) =>
      _$IsolateMessageFromJson(json);
}

abstract class BackgroundChannel {
  Future<void> makeRequest(IsolateMessage message);
  Future<void> spawn();
  static SettingsRepo? settings;
  final Map<MessageDestination, StreamController<IsolateMessage>>
      isolateStreams = {};
}

class BackgroundTranslator {
  static String serialize(IsolateMessage message) {
    return jsonEncode(message);
  }

  static IsolateMessage deserialize(String message) {
    final messageMap = jsonDecode(message) as Map<String, dynamic>;
    return IsolateMessage.fromJson(messageMap);
  }
}

class BackgroundChannelExternal {
  BackgroundChannelExternal() {
    for (var destination in MessageDestination.values) {
      isolateStreams[destination] = StreamController<IsolateMessage>();
    }
  }
  final Map<MessageDestination, StreamController<IsolateMessage>>
      isolateStreams = {};
  Completer<void>? backgroundReady;
  SendPort? portToBackground;

  void handleResponsesFromBackground(dynamic rawMessage) {
    IsolateMessage message;
    if (rawMessage is String) {
      message = BackgroundTranslator.deserialize(rawMessage);
      isolateStreams[message.destination]!.add(message);
    } else if (rawMessage is List<dynamic>) {
      internalErrorsToAlerts(rawMessage.toString());
    } else {
      throw Exception("Invalid message type: $rawMessage");
    }
  }

  void internalErrorsToAlerts(String errorMessage) {
    isolateStreams[MessageDestination.alerts]!
        .add(IsolateMessage(name: MessageName.alertsFetched, alerts: [
      const Alert(
          source: 0,
          kind: AlertType.syncFailure,
          hostname: "Open Alert Viewer",
          service: "Background Isolate",
          message: "Oh no! The background isolate crashed. "
              "Please check whether an app upgrade is available and "
              "resolves this issue. If that does not help, "
              "please take a screen shot, and submit it using "
              "the link icon to the left so we can help resolve the "
              "problem. Sorry for the inconvenience.",
          url: "https://github.com/okcode-studio/open_alert_viewer/issues",
          age: Duration.zero,
          silenced: false,
          downtimeScheduled: false,
          active: true),
      Alert(
          source: 0,
          kind: AlertType.syncFailure,
          hostname: "Open Alert Viewer version ${SettingsRepo.appVersion}",
          service: "Stack Trace",
          message: errorMessage,
          url: "https://github.com/okcode-studio/open_alert_viewer/issues",
          age: Duration.zero,
          silenced: false,
          downtimeScheduled: false,
          active: true),
    ]));
  }
}

mixin BackgroundChannelInternal {
  late LocalDatabase _db;
  late SettingsRepo _settings;
  late PlatformChannel _platformChannel;
  late SourcesBackgroundRepo _sourcesRepo;
  late AlertsBackgroundRepo _alertsRepo;
  late NotificationsBackgroundRepo _notifier;
  late StreamController<IsolateMessage> _outboundStream;

  Future<void> init(String appVersion, Function(IsolateMessage) sender) async {
    _db = LocalDatabase();
    await _db.migrate();
    SettingsRepo.appVersion = appVersion;
    _settings = SettingsRepo(db: _db);
    _platformChannel = PlatformChannel();
    BackgroundChannel.settings = _settings;
    _notifier = NotificationsBackgroundRepo(
        settings: _settings, platformChannel: _platformChannel);
    await _notifier.initializeAlertNotifications();
    await _notifier.startOrStopStickyNotification();
    _outboundStream = StreamController<IsolateMessage>();
    _sourcesRepo = SourcesBackgroundRepo(
        db: _db, outboundStream: _outboundStream, settings: _settings);
    _alertsRepo = AlertsBackgroundRepo(
        db: _db,
        settings: _settings,
        sourcesRepo: _sourcesRepo,
        notifier: _notifier);
    _alertsRepo.init(_outboundStream);
    _outboundStream.stream.listen((event) {
      if (event.destination == null) {
        throw Exception(
            "Background worker sending message without destination");
      }
      sender(event);
    });
  }

  void handleRequestsToBackground(dynamic rawMessage) async {
    if (rawMessage is String) {
      final message = BackgroundTranslator.deserialize(rawMessage);
      if (message.name == MessageName.fetchAlerts) {
        _alertsRepo.fetchAlerts(
            forceRefreshNow: message.forceRefreshNow ?? false);
      } else if (message.name == MessageName.refreshTimer) {
        _alertsRepo.refreshTimer();
      } else if (message.name == MessageName.confirmSources) {
        _sourcesRepo.confirmSource(message);
      } else if (message.name == MessageName.addSource) {
        _sourcesRepo.addSource(sourceData: message.sourceData!);
        _alertsRepo.fetchAlerts(forceRefreshNow: true);
      } else if (message.name == MessageName.updateSource) {
        _sourcesRepo.updateSource(
            sourceData: message.sourceData!, updateUIandRefresh: true);
        _alertsRepo.fetchAlerts(forceRefreshNow: true);
      } else if (message.name == MessageName.removeSource) {
        _sourcesRepo.removeSource(id: message.id!);
        _alertsRepo.fetchAlerts(forceRefreshNow: true);
      } else if (message.name == MessageName.updateLastSeen) {
        _sourcesRepo.updateLastSeen();
      } else if (message.name == MessageName.enableNotifications) {
        _notifier.startAnroidStickyNotification();
      } else if (message.name == MessageName.disableNotifications) {
        _notifier.disableNotifications();
      } else if (message.name == MessageName.toggleSounds) {
        _notifier.updateAlertDetails();
      } else {
        throw Exception("Invalid message name: $message");
      }
    } else {
      throw Exception("Invalid message type: $rawMessage");
    }
  }
}
