/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 * 
 * Based on BSD-3 Clause code from:
 * <https://dart.dev/language/isolates#complete-example>
 */

import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';

import '../alerts/model/alerts.dart';
import '../app/data_repository/settings_repository.dart';
import '../app/data_source/database.dart';
import './alerts.dart';
import './notifications.dart';
import './sources.dart';

class IsolateMessage {
  const IsolateMessage(
      {required this.name,
      this.id,
      this.alerts,
      this.sourceStrings,
      this.sources,
      this.forceRefreshNow});
  final String name;
  final int? id;
  final List<Alert>? alerts;
  final List<String>? sourceStrings;
  final List<AlertSource>? sources;
  final bool? forceRefreshNow;
}

class BackgroundWorker {
  BackgroundWorker({required StreamController<IsolateMessage> alertStream})
      : _alertStream = alertStream;

  final StreamController<IsolateMessage> _alertStream;
  final Completer<void> _isolateReady = Completer.sync();
  late SendPort _sendPort;
  static late LocalDatabase db;
  static late SettingsRepo settings;
  static late SourcesRepo sourcesRepo;
  static late AlertsRepo alertsRepo;
  static late NotificationRepo notifier;

  Future<void> spawn() async {
    final receivePort = ReceivePort();
    receivePort.listen(_handleResponsesFromIsolate);
    await Isolate.spawn(
        _startRemoteIsolate, (receivePort.sendPort, RootIsolateToken.instance));
  }

  Future<void> makeRequest(IsolateMessage message) async {
    await _isolateReady.future;
    _sendPort.send(message);
  }

  void _handleResponsesFromIsolate(dynamic message) {
    if (message is SendPort) {
      _sendPort = message;
      _isolateReady.complete();
    } else if (message is IsolateMessage) {
      _alertStream.add(message);
    } else {
      throw "Invalid message type: $message";
    }
  }

  static void _startRemoteIsolate((SendPort, RootIsolateToken?) init) async {
    SendPort port;
    RootIsolateToken token;
    (port, token!) = init;
    final receivePort = ReceivePort();
    port.send(receivePort.sendPort);
    BackgroundIsolateBinaryMessenger.ensureInitialized(token);
    db = LocalDatabase();
    await db.open();
    settings = SettingsRepo(db: db);
    sourcesRepo = SourcesRepo(db: db);
    notifier = NotificationRepo(settings: settings);
    await notifier.initializeAlertNotifications();
    await notifier.startAnroidStickyNotification();
    var bgAlertStream = StreamController<IsolateMessage>();
    alertsRepo = AlertsRepo(
        db: db,
        settings: settings,
        sourcesRepo: sourcesRepo,
        notifier: notifier);
    alertsRepo.init(bgAlertStream);
    bgAlertStream.stream.listen((event) {
      port.send(event);
    });
    receivePort.listen((dynamic message) async {
      if (message is IsolateMessage) {
        if (message.name == "fetch alerts") {
          alertsRepo.fetchAlerts(
              forceRefreshNow: message.forceRefreshNow ?? false);
        } else if (message.name == "refresh timer") {
          alertsRepo.refreshTimer();
        } else if (message.name == "add source") {
          var result = sourcesRepo.addSource(source: message.sourceStrings!);
          _sourcesChangeResult(port, (result >= 0));
        } else if (message.name == "update source") {
          var result = sourcesRepo.updateSource(
              id: message.id!, values: message.sourceStrings!);
          _sourcesChangeResult(port, result);
        } else if (message.name == "remove source") {
          sourcesRepo.removeSource(id: message.id!);
          _sourcesChangeResult(port, true);
        } else if (message.name == "enable notifications") {
          notifier.startAnroidStickyNotification();
        } else if (message.name == "disable notifications") {
          notifier.disableNotifications();
        } else {
          throw "Invalid message name: $message";
        }
      } else {
        throw "Invalid message type: $message";
      }
    });
  }

  static void _sourcesChangeResult(SendPort port, bool success) {
    if (success) {
      port.send(const IsolateMessage(name: "sources changed"));
      alertsRepo.fetchAlerts(forceRefreshNow: true);
    } else {
      port.send(const IsolateMessage(name: "sources failure"));
    }
  }
}
