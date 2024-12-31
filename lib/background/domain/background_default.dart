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

class BackgroundDefault extends BackgroundChannelExternal
    implements BackgroundChannel {
  @override
  Future<void> spawn() async {
    String appVersion = await Util.getVersion();
    final portFromBackground = ReceivePort();
    portFromBackground.listen(handleResponsesFromBackground);
    var isolate = await Isolate.spawn(BackgroundIsolate().spawned,
        (portFromBackground.sendPort, RootIsolateToken.instance, appVersion));
    isolate.addErrorListener(portFromBackground.sendPort);
  }

  @override
  Future<void> makeRequest(IsolateMessage message) async {
    await backgroundReady.future;
    portToBackground!.send(BackgroundTranslator.serialize(message));
  }
}

class BackgroundIsolate with BackgroundChannelInternal {
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
