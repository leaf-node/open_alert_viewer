/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../app/bloc/navigation_event.dart';
import '../../app/bloc/navigation_bloc.dart';

class Notifier {
  Notifier({required NavBloc navigator})
      : _navigator = navigator,
        _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(),
        _initializationSettingsLinux =
            const LinuxInitializationSettings(defaultActionName: 'Launch app');

  final NavBloc _navigator;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final LinuxInitializationSettings _initializationSettingsLinux;
  late InitializationSettings _initializationSettings;
  late NotificationDetails _notificationDetails;

  Future<void> initialize() async {
    _initializationSettings =
        InitializationSettings(linux: _initializationSettingsLinux);
    await _flutterLocalNotificationsPlugin.initialize(_initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);
    _notificationDetails =
        const NotificationDetails(linux: LinuxNotificationDetails());
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
}
