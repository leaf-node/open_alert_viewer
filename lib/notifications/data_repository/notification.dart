/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../app/data_repository/settings_repository.dart';

class NotificationRepo {
  NotificationRepo({required SettingsRepo settings})
      : _settings = settings,
        _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(),
        _initializationSettingsLinux =
            const LinuxInitializationSettings(defaultActionName: 'Launch app'),
        _initializationSettingsAndroid =
            const AndroidInitializationSettings('@mipmap/launcher_icon');

  final SettingsRepo _settings;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final LinuxInitializationSettings _initializationSettingsLinux;
  final AndroidInitializationSettings _initializationSettingsAndroid;
  late InitializationSettings _initializationSettings;
  late NotificationDetails _notificationDetails;

  Future<void> initialize() async {
    _initializationSettings = InitializationSettings(
        linux: _initializationSettingsLinux,
        android: _initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(_initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);
    const description = "Status Notifications";
    _notificationDetails = const NotificationDetails(
        linux: LinuxNotificationDetails(),
        android: AndroidNotificationDetails("Open Alert Viewer", "Alerts",
            channelDescription: description,
            importance: Importance.max,
            priority: Priority.high,
            ticker: description));
  }

  Future<void> showNotification({required String message}) async {
    await removeNotification();
    await _flutterLocalNotificationsPlugin.show(
        0, 'Open Alert Viewer', message, _notificationDetails,
        payload: 'Open alerts page');
  }

  Future<void> removeNotification() async {
    await _flutterLocalNotificationsPlugin.cancel(0);
  }

  void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) {
    // TODO: show alerts page
  }

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

  Future<void> requestAndEnableNotifications(
      {required bool askAgain, required void Function() callback}) async {
    if (Platform.isAndroid) {
      bool systemNotificationsGranted = await areNotificationsAllowed();
      if (!_settings.notificationsRequested ||
          askAgain ||
          (!systemNotificationsGranted && _settings.notificationsEnabled)) {
        bool? result = await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
        _settings.notificationsRequested = true;
        if (result != null) {
          _settings.notificationsEnabled = result;
        }
      }
    } else {
      if (!_settings.notificationsRequested || askAgain) {
        _settings.notificationsRequested = true;
        _settings.notificationsEnabled = true;
      }
    }
    callback();
  }
}
