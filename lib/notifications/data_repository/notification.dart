/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../alerts/model/alerts.dart';
import '../../app/data_repository/settings_repository.dart';

class NotificationRepo {
  NotificationRepo({required SettingsRepo settings})
      : _settings = settings,
        _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(),
        _initializationSettingsLinux =
            const LinuxInitializationSettings(defaultActionName: 'Launch app'),
        _initializationSettingsAndroid =
            const AndroidInitializationSettings('@drawable/notification_icon');

  final SettingsRepo _settings;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final LinuxInitializationSettings _initializationSettingsLinux;
  final AndroidInitializationSettings _initializationSettingsAndroid;
  late InitializationSettings _initializationSettings;
  late NotificationDetails _notificationDetails;
  final List<int> activeNotificationIds = [];
  final int idForStiky = 1;
  final int startingId = 2;

  Future<void> initialize() async {
    _initializationSettings = InitializationSettings(
        linux: _initializationSettingsLinux,
        android: _initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(_initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);
    const description = "Status Notifications";
    const androidNotificationDetails = AndroidNotificationDetails(
        "Open Alert Viewer", "Alerts",
        icon: "@drawable/notification_icon",
        channelDescription: description,
        importance: Importance.max,
        priority: Priority.high,
        ticker: description);
    _notificationDetails = const NotificationDetails(
        linux: LinuxNotificationDetails(), android: androidNotificationDetails);
  }

  Future<void> _showNotification({required String message}) async {
    await _removeLastNotification();
    int newId = activeNotificationIds.lastOrNull ?? startingId;
    await _flutterLocalNotificationsPlugin.show(
        newId, 'Open Alert Viewer', message, _notificationDetails,
        payload: 'Open alerts page');
    activeNotificationIds.add(newId);
  }

  Future<void> _removeLastNotification() async {
    int? latestId = activeNotificationIds.lastOrNull;
    if (latestId != null) {
      await _flutterLocalNotificationsPlugin.cancel(latestId);
      activeNotificationIds.removeLast();
    }
  }

  Future<void> showFilteredNotifications(
      {required List<Alert> alerts, required Duration timeSince}) async {
    int newSyncFailureCount = 0, newDownCount = 0, newErrorCount = 0;
    List<String> messages = [];
    for (var alert in alerts) {
      if (alert.age.compareTo(timeSince) >= 0) {
        continue;
      }
      if (alert.kind == AlertType.syncFailure) {
        newSyncFailureCount += 1;
      } else if (alert.kind == AlertType.down ||
          alert.kind == AlertType.unreachable) {
        newDownCount += 1;
      } else if (alert.kind == AlertType.error) {
        newErrorCount += 1;
      }
    }
    if (newSyncFailureCount > 0) {
      messages.add(
          "$newSyncFailureCount New Sync Failure${newSyncFailureCount == 1 ? "" : "s"}");
    }
    if (newDownCount > 0) {
      messages.add("$newDownCount Recently Down");
    }
    if (newErrorCount > 0) {
      messages.add("$newErrorCount New Error${newErrorCount == 1 ? "" : "s"}");
    }

    if (messages.isNotEmpty) {
      await _showNotification(message: messages.join(", "));
    } else {
      await _removeLastNotification();
    }
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

  Future<void> _startForegroundService() async {
    if (Platform.isAndroid && _settings.notificationsEnabled) {
      var activeAlerts = await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.getActiveNotifications();
      if ((activeAlerts?.where((alert) => alert.id == idForStiky).isEmpty ??
          true)) {
        const androidNotificationDetails = AndroidNotificationDetails(
            "Open Alert Viewer Sticky Alerts", "Sticky Alerts",
            icon: "@drawable/notification_icon",
            channelDescription: "Foreground Service Notification",
            importance: Importance.min,
            priority: Priority.min,
            silent: true,
            ticker: "Sticky Alerts");
        try {
          await _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.startForegroundService(
                  1,
                  'Periodically checking for new alerts',
                  'Running at configured interval',
                  notificationDetails: androidNotificationDetails,
                  foregroundServiceTypes: {
                AndroidServiceForegroundType.foregroundServiceTypeDataSync
              });
        } on PlatformException catch (e) {
          log(e.message.toString());
        }
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
    await _removeLastNotification();
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
      if (_settings.notificationsEnabled) {
        await _startForegroundService();
      }
    } else if (!_settings.notificationsRequested || askAgain) {
      _settings.notificationsRequested = true;
      _settings.notificationsEnabled = true;
    }
    callback();
    return _settings.notificationsEnabled;
  }
}
