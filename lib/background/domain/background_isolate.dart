/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';

import '../../utils/utils.dart';
import 'background.dart';

class BackgroundIsolate implements BackgroundInnerChannel {
  SendPort? portToBackground;
  final Completer<void> backgroundReady = Completer();
  @override
  Future<void> spawn(SendPort portToForeground) async {
    final portFromBackground = ReceivePort();
    portFromBackground.listen((message) {
      if (message is SendPort) {
        portToBackground = message;
        backgroundReady.complete();
      } else {
        portToForeground.send(message);
      }
    });
    String appVersion = await Util.getVersion();
    var isolate = await Isolate.spawn(BackgroundIsolateInternal().spawned,
        (portFromBackground.sendPort, RootIsolateToken.instance, appVersion));
    isolate.addErrorListener(portFromBackground.sendPort);
    portToForeground.send("ready");
  }

  @override
  Future<void> makeRequest(IsolateMessage message) async {
    await backgroundReady.future;
    portToBackground!.send(BackgroundTranslator.serialize(message));
  }
}

class BackgroundIsolateInternal with BackgroundChannelInternal {
  Future<void> spawned((SendPort, RootIsolateToken?, String) initArgs) async {
    SendPort portToForeground;
    RootIsolateToken token;
    String appVersion;
    (portToForeground, token!, appVersion) = initArgs;
    final portFromForeground = ReceivePort();
    portToForeground.send(portFromForeground.sendPort);
    BackgroundIsolateBinaryMessenger.ensureInitialized(token);
    await init(
        appVersion,
        (message) =>
            portToForeground.send(BackgroundTranslator.serialize(message)));
    portFromForeground.listen(handleRequestsToBackground);
  }
}
