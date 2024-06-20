/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

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
    const description = "Open Alert Viewer Notifications";
    _notificationDetails = const NotificationDetails(
        linux: LinuxNotificationDetails(),
        android: AndroidNotificationDetails("open_alert_viewer", "main",
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

  void requestNotificationPermission() async {
    if (!_settings.notificationsRequested) {
      bool? result = await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      if (result != null) {
        _settings.notificationsRequested = result;
        _settings.notificationsEnabled = result;
      }
    }
  }
}
