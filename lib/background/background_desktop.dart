/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';

import 'background.dart';

class BackgroundDesktop extends BackgroundChannelResponse
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
    sendPort.send(message);
  }
}

class BackgroundIsolate extends BackgroundChannelReceiver {
  Future<void> spawned((SendPort, RootIsolateToken?, String) initArgs) async {
    SendPort port;
    RootIsolateToken token;
    String appVersion;
    (port, token!, appVersion) = initArgs;
    final receivePort = ReceivePort();
    port.send(receivePort.sendPort);
    BackgroundIsolateBinaryMessenger.ensureInitialized(token);
    StreamController<IsolateMessage> outboundStream = await init(appVersion);
    outboundStream.stream.listen((event) {
      if (event.destination == null) {
        throw Exception(
            "Background worker sending message without destination");
      }
      port.send(event);
    });
    receivePort.listen(handleRequestsToBackground);
  }
}
