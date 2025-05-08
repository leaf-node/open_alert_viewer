/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';

import '../../data/repositories/settings_repo.dart';
import '../../domain/alerts.dart';
import '../../utils/utils.dart';
import 'background_internal.dart';
import 'background_shared.dart';

class BackgroundChannel {
  BackgroundChannel() {
    for (var destination in MessageDestination.values) {
      isolateStreams[destination] = StreamController<IsolateMessage>();
    }
  }
  final Map<MessageDestination, StreamController<IsolateMessage>>
  isolateStreams = {};
  SendPort? portToBackground;
  final Completer<void> backgroundReady = Completer();
  SendPort? _portToBackground;
  static SettingsRepo? settings;

  Future<void> spawn() async {
    final portFromBackground = ReceivePort();
    portFromBackground.listen((message) {
      if (message is SendPort) {
        _portToBackground = message;
      } else {
        handleResponsesFromBackground(message);
      }
    });
    String appVersion = await Util.getVersion();
    var isolate = await Isolate.spawn(BackgroundChannelInternal().spawned, (
      portFromBackground.sendPort,
      RootIsolateToken.instance,
      appVersion,
    ));
    isolate.addErrorListener(portFromBackground.sendPort);
  }

  Future<void> makeRequest(IsolateMessage message) async {
    await backgroundReady.future;
    _portToBackground!.send(BackgroundTranslator.serialize(message));
  }

  void handleResponsesFromBackground(dynamic rawMessage) {
    IsolateMessage message;
    if (rawMessage is String) {
      message = BackgroundTranslator.deserialize(rawMessage);
      if (message.destination == MessageDestination.drop) {
        if (message.name == MessageName.backgroundReady) {
          backgroundReady.complete();
        }
      } else {
        isolateStreams[message.destination]!.add(message);
      }
    } else if (rawMessage is List<dynamic>) {
      internalErrorsToAlerts(rawMessage.toString());
    } else {
      throw Exception("Invalid message type: $rawMessage");
    }
  }

  void internalErrorsToAlerts(String errorMessage) {
    isolateStreams[MessageDestination.alerts]!.add(
      IsolateMessage(
        name: MessageName.alertsFetched,
        alerts: [
          const Alert(
            source: 0,
            kind: AlertType.syncFailure,
            hostname: "Open Alert Viewer",
            service: "Background Isolate",
            message:
                "Oh no! The background isolate crashed. "
                "Please check whether an app upgrade is available and "
                "resolves this issue. If that does not help, "
                "please take a screen shot, and submit it using "
                "the alert link so we can help resolve the "
                "problem. Sorry for the inconvenience.",
            serviceUrl:
                "https://github.com/leaf-node/open_alert_viewer/issues",
            monitorUrl: "",
            age: Duration.zero,
            silenced: false,
            downtimeScheduled: false,
            active: true,
            enabled: true,
          ),
          Alert(
            source: 0,
            kind: AlertType.syncFailure,
            hostname: "Open Alert Viewer version ${SettingsRepo.appVersion}",
            service: "Stack Trace",
            message: errorMessage,
            serviceUrl:
                "https://github.com/leaf-node/open_alert_viewer/issues",
            monitorUrl: "",
            age: Duration.zero,
            silenced: false,
            downtimeScheduled: false,
            active: true,
            enabled: true,
          ),
        ],
      ),
    );
  }
}
