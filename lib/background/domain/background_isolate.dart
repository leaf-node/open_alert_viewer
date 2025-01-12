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

class BackgroundIsolate extends BackgroundChannelExternal
    implements BackgroundChannel {
  SendPort? _portToBackground;
  final Completer<void> _backgroundReady = Completer();
  @override
  Future<void> spawn() async {
    final portFromBackground = ReceivePort();
    portFromBackground.listen((message) {
      if (message is SendPort) {
        _portToBackground = message;
        _backgroundReady.complete();
      } else {
        handleResponsesFromBackground(message);
      }
    });
    String appVersion = await Util.getVersion();
    var isolate = await Isolate.spawn(BackgroundIsolateInternal().spawned,
        (portFromBackground.sendPort, RootIsolateToken.instance, appVersion));
    isolate.addErrorListener(portFromBackground.sendPort);
  }

  @override
  Future<void> makeRequest(IsolateMessage message) async {
    await _backgroundReady.future;
    _portToBackground!.send(BackgroundTranslator.serialize(message));
  }
}

class BackgroundIsolateInternal with BackgroundChannelInternal {
  Future<void> spawned((SendPort, RootIsolateToken?, String) initArgs) async {
    SendPort portToForeground;
    RootIsolateToken? token;
    String appVersion;
    (portToForeground, token, appVersion) = initArgs;
    BackgroundIsolateBinaryMessenger.ensureInitialized(token!);
    final portFromForeground = ReceivePort();
    portToForeground.send(portFromForeground.sendPort);
    await init(
        appVersion,
        (message) =>
            portToForeground.send(BackgroundTranslator.serialize(message)));
    portFromForeground.listen(handleRequestsToBackground);
  }
}
