/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';

import '../app/data_repository/settings_repository.dart';
import '../app/data_source/database.dart';
import 'background.dart';
import 'repo/alerts.dart';
import 'repo/notifications.dart';
import 'repo/sources.dart';

class BackgroundDesktop extends BackgroundChannelResponse
    implements BackgroundChannel {
  @override
  Future<void> spawn({required String appVersion}) async {
    final receivePort = ReceivePort();
    receivePort.listen(handleResponsesFromBackground);
    var isolate = await Isolate.spawn(BackgroundIsolate().init,
        (receivePort.sendPort, RootIsolateToken.instance, appVersion));
    isolate.addErrorListener(receivePort.sendPort);
  }

  @override
  Future<void> makeRequest(IsolateMessage message) async {
    await isolateReady.future;
    sendPort.send(message);
  }
}

class BackgroundIsolate with BackgroundTranslator {
  late LocalDatabase _db;
  late SettingsRepo _settings;
  late SourcesRepo _sourcesRepo;
  late AlertsRepo _alertsRepo;
  late NotificationRepo _notifier;

  Future<void> init((SendPort, RootIsolateToken?, String) init) async {
    SendPort port;
    RootIsolateToken token;
    String appVersion;
    (port, token!, appVersion) = init;
    final receivePort = ReceivePort();
    port.send(receivePort.sendPort);
    BackgroundIsolateBinaryMessenger.ensureInitialized(token);
    _db = LocalDatabase();
    await _db.open();
    SettingsRepo.appVersion = appVersion;
    _settings = SettingsRepo(db: _db);
    BackgroundChannel.settings = _settings;
    _notifier = NotificationRepo(settings: _settings);
    await _notifier.initializeAlertNotifications();
    await _notifier.startAnroidStickyNotification();
    var outboundStream = StreamController<IsolateMessage>();
    _sourcesRepo = SourcesRepo(
        db: _db, outboundStream: outboundStream, settings: _settings);
    _alertsRepo = AlertsRepo(
        db: _db,
        settings: _settings,
        sourcesRepo: _sourcesRepo,
        notifier: _notifier);
    _alertsRepo.init(outboundStream);
    outboundStream.stream.listen((event) {
      if (event.destination == null) {
        throw Exception(
            "Background worker sending message without destination");
      }
      port.send(event);
    });
    receivePort.listen((dynamic message) async {
      if (message is IsolateMessage) {
        if (message.name == MessageName.fetchAlerts) {
          _alertsRepo.fetchAlerts(
              forceRefreshNow: message.forceRefreshNow ?? false);
        } else if (message.name == MessageName.refreshTimer) {
          _alertsRepo.refreshTimer();
        } else if (message.name == MessageName.confirmSources) {
          _confirmSource(outboundStream, message);
        } else if (message.name == MessageName.addSource) {
          _sourcesRepo.addSource(sourceData: message.sourceData!);
        } else if (message.name == MessageName.updateSource) {
          _sourcesRepo.updateSource(
              sourceData: message.sourceData!, updateUIandRefresh: true);
        } else if (message.name == MessageName.removeSource) {
          _sourcesRepo.removeSource(id: message.id!);
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
        throw Exception("Invalid message type: $message");
      }
    });
  }

  Future<void> _confirmSource(
      StreamController<IsolateMessage> stream, IsolateMessage message) async {
    var result =
        await _sourcesRepo.getSourceType(sourceData: message.sourceData!);
    stream.add(IsolateMessage(
        name: MessageName.confirmSourcesReply,
        destination: MessageDestination.accountSettings,
        sourceData: result));
  }
}
