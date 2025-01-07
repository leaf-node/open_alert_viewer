/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import '../../background/domain/background_android_service.dart';
import '../../data/repositories/settings_repo.dart';
import 'background.dart';
import 'background_isolate.dart';

class BackgroundSwitcher extends BackgroundChannelExternal
    implements BackgroundExternalChannel {
  BackgroundInnerChannel? bgChannelChild;
  @override
  Future<void> spawn(SettingsRepo settings) async {
    backgroundReady = Completer();
    final portFromBackground = ReceivePort();
    portFromBackground.listen((message) {
      if (message is String && message == "ready") {
        backgroundReady?.complete();
      } else {
        handleResponsesFromBackground(message);
      }
    });
    if (Platform.isAndroid && (settings.notificationsEnabled)) {
      bgChannelChild = BackgroundAndroidService();
    } else {
      bgChannelChild = BackgroundIsolate();
    }
    await bgChannelChild!.spawn(portFromBackground.sendPort);
  }

  @override
  Future<void> makeRequest(IsolateMessage message) async {
    await backgroundReady?.future;
    bgChannelChild!.makeRequest(message);
  }
}
