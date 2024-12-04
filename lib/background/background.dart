/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:isolate';

import '../alerts/model/alerts.dart';
import '../app/data_repository/settings_repository.dart';

enum MessageName {
  alertsInit,
  alertsFetching,
  alertsFetched,
  fetchAlerts,
  refreshTimer,
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
  accountSettings,
}

class IsolateMessage {
  const IsolateMessage(
      {required this.name,
      this.destination,
      this.id,
      this.alerts,
      this.sourceData,
      this.sources,
      this.forceRefreshNow,
      this.alreadyFetching});
  final MessageName name;
  final MessageDestination? destination;
  final int? id;
  final List<Alert>? alerts;
  final AlertSourceData? sourceData;
  final List<AlertSource>? sources;
  final bool? forceRefreshNow;
  final bool? alreadyFetching;
}

abstract class BackgroundWorker {
  Future<void> spawn({required String appVersion});
  Future<void> makeRequest(IsolateMessage message);
  final Map<MessageDestination, StreamController<IsolateMessage>>
      isolateStreams = {};
  static SettingsRepo? settings;
}

mixin BackgroundTranslator {
  String serializeMessage(IsolateMessage message) {
    return '{name: "fetchAlerts"}';
  }

  IsolateMessage deserializeToMessage(String message) {
    return IsolateMessage(name: MessageName.fetchAlerts);
  }
}

class BackgroundChannel with BackgroundTranslator {
  BackgroundChannel() {
    for (var destination in MessageDestination.values) {
      isolateStreams[destination] = StreamController<IsolateMessage>();
    }
  }
  final Map<MessageDestination, StreamController<IsolateMessage>>
      isolateStreams = {};
  final Completer<void> isolateReady = Completer.sync();
  late SendPort sendPort;

  void handleResponsesFromBackground(dynamic message) {
    if (message is SendPort) {
      sendPort = message;
      isolateReady.complete();
    } else if (message is IsolateMessage) {
      isolateStreams[message.destination]!.add(message);
    } else if (message is List<dynamic>) {
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
            message: message.toString(),
            url: "https://github.com/okcode-studio/open_alert_viewer/issues",
            age: Duration.zero,
            silenced: false,
            downtimeScheduled: false,
            active: true),
      ]));
    } else {
      throw Exception("Invalid message type: $message");
    }
  }
}
