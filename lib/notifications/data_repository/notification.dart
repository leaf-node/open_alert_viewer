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
    const androidNotificationDetails = AndroidNotificationDetails(
        "Open Alert Viewer", "Alerts",
        channelDescription: description,
        importance: Importance.max,
        priority: Priority.high,
        ticker: description);
    _notificationDetails = const NotificationDetails(
        linux: LinuxNotificationDetails(), android: androidNotificationDetails);
  }

  Future<void> showNotification({required String message}) async {
    await _flutterLocalNotificationsPlugin.show(
        0, 'Open Alert Viewer', message, _notificationDetails,
        payload: 'Open alerts page');
  }

  Future<void> removeNotification() async {
    await _flutterLocalNotificationsPlugin.cancel(0);
  }

  void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) {}

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

  Future<void> _startForegroundService({required bool isAppVisible}) async {
    if (Platform.isAndroid && _settings.notificationsEnabled && isAppVisible) {
      var activeAlerts = await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.getActiveNotifications();
      if ((activeAlerts?.where((alert) => alert.id == 1).isEmpty ?? true)) {
        const androidNotificationDetails = AndroidNotificationDetails(
            "Open Alert Viewer Sticky Alerts", "Sticky Alerts",
            channelDescription: "Foreground Service Notification",
            importance: Importance.max,
            priority: Priority.high,
            silent: true,
            ticker: "Sticky Alerts");
        await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.startForegroundService(
                1, 'Open Alerts Viewer', 'Periodically checking alerts',
                notificationDetails: androidNotificationDetails,
                foregroundServiceTypes: {
              AndroidServiceForegroundType.foregroundServiceTypeDataSync
            });
      }
    }
  }

  Future<void> stopForegroundService() async {
    if (Platform.isAndroid) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.stopForegroundService();
    }
  }

  Future<void> requestAndEnableNotifications(
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
      if (_settings.notificationsEnabled) {
        await _startForegroundService(
            isAppVisible: isAppVisible ?? (result != null));
      }
    } else if (!_settings.notificationsRequested || askAgain) {
      _settings.notificationsRequested = true;
      _settings.notificationsEnabled = true;
    }
    callback();
  }
}
