/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';

import 'background.dart';

class BackgroundDesktop extends BackgroundChannelExternal
    implements BackgroundChannel {
  @override
  Future<void> spawn({required String appVersion}) async {
    final receivePort = ReceivePort();
    receivePort.listen(handleResponsesFromBackground);
    var isolate = await Isolate.spawn(BackgroundIsolate().spawned,
        (receivePort.sendPort, RootIsolateToken.instance, appVersion));
    isolate.addErrorListener(receivePort.sendPort);
  }

  @override
  Future<void> makeRequest(IsolateMessage message) async {
    await isolateReady.future;
    sendPort.send(serialize(message));
  }
}

class BackgroundIsolate extends BackgroundChannelInternal {
  Future<void> spawned((SendPort, RootIsolateToken?, String) initArgs) async {
    SendPort port;
    RootIsolateToken token;
    String appVersion;
    (port, token!, appVersion) = initArgs;
    final receivePort = ReceivePort();
    port.send(receivePort.sendPort);
    BackgroundIsolateBinaryMessenger.ensureInitialized(token);
    await init(appVersion, (message) => port.send(serialize(message)));
    receivePort.listen(handleRequestsToBackground);
  }
}
