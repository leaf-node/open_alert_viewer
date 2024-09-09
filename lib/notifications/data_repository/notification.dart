/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../app/data_repository/settings_repository.dart';

class StickyNotificationRepo {
  StickyNotificationRepo({required SettingsRepo settings})
      : _settings = settings,
        _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final SettingsRepo _settings;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  Future<bool> areNotificationsAllowed() async {
    if (Platform.isAndroid) {
      return await _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;
    }
    return true;
  }

  Future<bool> requestAndEnableNotifications(
      {required bool askAgain,
      required void Function() callback,
      bool? isAppVisible}) async {
    if (Platform.isAndroid) {
      bool systemNotificationsGranted = await areNotificationsAllowed();
      bool? result;
      if (!_settings.notificationsRequested ||
          askAgain ||
          (!systemNotificationsGranted && _settings.notificationsEnabled)) {
        result = await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
        _settings.notificationsRequested = true;
        if (result != null) {
          _settings.notificationsEnabled = result;
        }
      }
    } else if (!_settings.notificationsRequested || askAgain) {
      _settings.notificationsRequested = true;
      _settings.notificationsEnabled = true;
    }
    callback();
    return _settings.notificationsEnabled;
  }
}
