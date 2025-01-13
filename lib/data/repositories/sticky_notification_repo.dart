/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

import 'settings_repo.dart';

class StickyNotificationRepo {
  StickyNotificationRepo({required SettingsRepo settings})
      : _settings = settings;

  final SettingsRepo _settings;

  static Future<bool> areNotificationsAllowed() async {
    if (Platform.isAndroid) {
      return await Permission.notification.isGranted;
    }
    return true;
  }

  Future<bool> requestAndEnableNotifications(
      {required bool askAgain,
      required void Function() callback,
      bool? isAppVisible}) async {
    if (Platform.isAndroid) {
      bool systemNotificationsGranted = await areNotificationsAllowed();
      bool result;
      if (!_settings.notificationsRequested ||
          askAgain ||
          (!systemNotificationsGranted &&
              _settings.notificationsEnabledUnsafe)) {
        result = await Permission.notification.request().isGranted;
        _settings.notificationsEnabled = result;
      }
    } else if (!_settings.notificationsRequested || askAgain) {
      _settings.notificationsRequested = true;
      _settings.notificationsEnabled = true;
    }
    callback();
    return await _settings.notificationsEnabledSafe;
  }
}
