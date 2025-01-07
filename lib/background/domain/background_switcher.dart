/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:open_alert_viewer/background/domain/background_android_service.dart';

import 'background.dart';
import 'background_isolate.dart';

class BackgroundSwitcher extends BackgroundChannelExternal
    implements BackgroundExternalChannel {
  BackgroundInnerChannel? bgChannelChild;
  @override
  Future<void> spawn() async {
    final portFromBackground = ReceivePort();
    portFromBackground.listen((message) {
      if (message is String && message == "ready") {
        backgroundReady.complete();
      } else {
        handleResponsesFromBackground(message);
      }
    });
    if (Platform.isAndroid) {
      bgChannelChild = BackgroundAndroidService();
    } else {
      bgChannelChild = BackgroundIsolate();
    }
    await bgChannelChild!.spawn(portFromBackground.sendPort);
  }

  @override
  Future<void> makeRequest(IsolateMessage message) async {
    await backgroundReady.future;
    bgChannelChild!.makeRequest(message);
  }
}
