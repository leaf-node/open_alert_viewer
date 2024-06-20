/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../app/bloc/navigation_event.dart';
import '../../app/bloc/navigation_bloc.dart';
import '../../app/data_repository/settings_repository.dart';

class Notifier {
  Notifier({required NavBloc navigator, required SettingsRepo settings})
      : _navigator = navigator,
        _settings = settings,
        _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(),
        _initializationSettingsLinux =
            const LinuxInitializationSettings(defaultActionName: 'Launch app'),
        _initializationSettingsAndroid =
            const AndroidInitializationSettings('@mipmap/launcher_icon');

  final NavBloc _navigator;
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
    await _flutterLocalNotificationsPlugin.show(
        0, 'Open Alert Viewer', message, _notificationDetails,
        payload: 'Open alerts page');
  }

  Future<void> removeNotification() async {
    await _flutterLocalNotificationsPlugin.cancel(0);
  }

  void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) {
    _navigator.add(OpenAlertsPageEvent());
  }

  void requestNotificationPermission({required bool askAgain}) async {
    if (Platform.isAndroid) {
      if (!_settings.notificationsRequested ||
          (askAgain && !_settings.notificationsGranted)) {
        bool? result = await _flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
        _settings.notificationsRequested = true;
        if (result != null) {
          _settings.notificationsGranted = result;
          _settings.notificationsEnabled = result;
        }
      }
    }
  }
}
