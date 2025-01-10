/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:developer';

import 'package:flutter/services.dart';

class PlatformChannel {
  PlatformChannel()
      : _platformMain = MethodChannel(_channelMain),
        _platformForeground = MethodChannel(_channelForeground);

  static const _channelMain = "studio.okcode.open_alert_viewer/main";
  static const _channelForeground = "studio.okcode.open_alert_viewer/service";
  final MethodChannel _platformMain;
  final MethodChannel _platformForeground;

  void startForegroundService() {
    try {
      _platformMain.invokeMethod<String>("startForeground");
    } catch (e) {
      log("$e");
    }
  }

  void stopForegroundService() {
    try {
      _platformForeground.invokeMethod<String>("stopForeground");
    } catch (e) {
      log("$e");
    }
  }
}
