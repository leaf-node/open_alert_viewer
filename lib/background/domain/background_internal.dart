/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';

import '../../data/repositories/settings_repo.dart';
import '../../data/services/database.dart';
import '../../domain/platform_channel.dart';
import '../repositories/alerts_bg_repo.dart';
import '../repositories/notifications_bg_repo.dart';
import '../repositories/sources_bg_repo.dart';
import 'background_external.dart';
import 'background_shared.dart';

class BackgroundChannelInternal {
  late LocalDatabase _db;
  late SettingsRepo _settings;
  late PlatformChannel _platformChannel;
  late SourcesBackgroundRepo _sourcesRepo;
  late AlertsBackgroundRepo _alertsRepo;
  late NotificationsBackgroundRepo _notifier;
  late StreamController<IsolateMessage> _outboundStream;
  late SendPort portToForeground;

  Future<void> spawned((SendPort, RootIsolateToken?, String) initArgs) async {
    SendPort localPortToForeground;
    RootIsolateToken? token;
    String appVersion;
    (localPortToForeground, token, appVersion) = initArgs;
    BackgroundIsolateBinaryMessenger.ensureInitialized(token!);
    portToForeground = localPortToForeground;
    SettingsRepo.appVersion = appVersion;
    final portFromForeground = ReceivePort();
    portToForeground.send(portFromForeground.sendPort);
    try {
      await init();
      portFromForeground.listen(handleRequestsToBackground);
    } catch (e) {
      sendBackgroundReady();
      rethrow;
    }
    sendBackgroundReady();
  }

  Future<void> init() async {
    _db = LocalDatabase();
    await _db.openAndMigrate(showPath: true);
    _settings = SettingsRepo(db: _db);
    _platformChannel = PlatformChannel();
    BackgroundChannel.settings = _settings;
    _notifier = NotificationsBackgroundRepo(
        settings: _settings, platformChannel: _platformChannel);
    await _notifier.startOrStopStickyNotification();
    await _notifier.initializeAlertNotifications();
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
      sendMessageToForeground(event);
    });
  }

  void sendMessageToForeground(IsolateMessage message) {
    portToForeground.send(BackgroundTranslator.serialize(message));
  }

  void sendBackgroundReady() {
    portToForeground.send(BackgroundTranslator.serialize(IsolateMessage(
        name: MessageName.backgroundReady,
        destination: MessageDestination.drop)));
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
      } else if (message.name == MessageName.alertFiltersChanged) {
        sendMessageToForeground(IsolateMessage(
            name: MessageName.alertFiltersChanged,
            destination: MessageDestination.alerts));
      } else {
        throw Exception("Invalid message name: $message");
      }
    } else {
      throw Exception("Invalid message type: $rawMessage");
    }
  }
}
