/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../domain/alerts.dart';
import '../../data/repositories/settings_repo.dart';
import '../../utils/utils.dart';
import '../domain/background.dart';

const stickyNotificationChannelId = "Open Alert Viewer Background Work";
const stickyNotificationChannelName = "Background Work";
const stickyNotificationChannelDescription =
    "Allow Fetching Alerts in Background";
const stickyNotificationId = 1;
const stickyNotificationTitle = "Periodically checking for new alerts";
const stickyNotificationContentStart = "Sync scheduled for every";

const alertsNotificationId = 2;
const alertsNotificationTitle = "Open Alert Viewer";
const alertsNotificationChannelId = "Open Alert Viewer";
const alertsNotificationChannelName = "Alerts";
const alertsNotificationChannelDescription = "Alert Notifications";

const notificationIcon = "@drawable/notification_icon";

class NotificationsBackgroundRepo {
  NotificationsBackgroundRepo({required SettingsRepo settings})
      : _settings = settings,
        _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin() {
    _stickyAndroidNotificationDetails = const AndroidNotificationDetails(
        stickyNotificationChannelId, stickyNotificationChannelName,
        icon: notificationIcon,
        channelDescription: stickyNotificationChannelDescription,
        ongoing: true,
        importance: Importance.low,
        priority: Priority.low,
        silent: true);
    updateAlertDetails();
  }

  final SettingsRepo _settings;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  late AndroidNotificationDetails _stickyAndroidNotificationDetails;
  late NotificationDetails _notificationDetails;

  Future<void> initializeAlertNotifications() async {
    if (Platform.isLinux) {
      var initializationSettingsLinux =
          const LinuxInitializationSettings(defaultActionName: "Launch app");
      var initializationSettings =
          InitializationSettings(linux: initializationSettingsLinux);
      await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    } else if (Platform.isAndroid) {
      const AndroidNotificationChannel stickyChannel =
          AndroidNotificationChannel(
              stickyNotificationChannelId, stickyNotificationChannelName,
              description: stickyNotificationChannelDescription,
              importance: Importance.low);
      const AndroidNotificationChannel alertChannel =
          AndroidNotificationChannel(
              alertsNotificationChannelId, alertsNotificationChannelName,
              description: alertsNotificationChannelDescription,
              importance: Importance.max);
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(stickyChannel);
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(alertChannel);
    } else {
      throw Exception("Unsupported platform for notifications.");
    }
  }

  Future<void> _showNotification({required String message}) async {
    if (!_settings.notificationsEnabled) {
      return;
    }
    await _flutterLocalNotificationsPlugin.show(alertsNotificationId,
        alertsNotificationTitle, message, _notificationDetails);
  }

  Future<void> _removeAlertNotification() async {
    await _flutterLocalNotificationsPlugin.cancel(alertsNotificationId);
  }

  Future<void> showFilteredNotifications(
      {required List<Alert> alerts,
      required List<AlertSourceData> allSources,
      StreamController<IsolateMessage>? alertStream}) async {
    Map<int, Duration> sinceLookedPerSource = {};
    for (var sourceData in allSources) {
      sinceLookedPerSource[sourceData.id!] =
          sourceData.lastFetch.difference(sourceData.lastSeen);
    }
    Map<int, Duration> sincePriorFetchPerSource = {};
    for (var sourceData in allSources) {
      sincePriorFetchPerSource[sourceData.id!] =
          sourceData.lastFetch.difference(sourceData.priorFetch);
    }
    Duration globalSinceLooked =
        _settings.lastFetched.difference(_settings.lastSeen);
    Duration globalSincePriorFetch =
        _settings.lastFetched.difference(_settings.priorFetch);
    Duration sinceLooked;
    Duration sincePriorFetch;
    int newSyncFailureCount = 0, newDownCount = 0, newErrorCount = 0;
    int brandNew = 0, brandNewInc = 0;
    List<String> messages = [];
    for (var alert in alerts) {
      if (alert.kind == AlertType.syncFailure) {
        sinceLooked = globalSinceLooked;
        sincePriorFetch = globalSincePriorFetch;
      } else {
        sinceLooked = sinceLookedPerSource[alert.source]!;
        sincePriorFetch = sincePriorFetchPerSource[alert.source]!;
      }
      if (alert.age.compareTo(sinceLooked) > 0) {
        continue;
      }
      if (alert.silenced || alert.downtimeScheduled || !alert.active) {
        continue;
      }
      brandNewInc = (alert.age.compareTo(sincePriorFetch) <= 0) ? 1 : 0;
      if (alert.kind == AlertType.syncFailure) {
        newSyncFailureCount += 1;
        brandNew += brandNewInc;
      } else if (alert.kind == AlertType.down ||
          alert.kind == AlertType.unreachable) {
        newDownCount += 1;
        brandNew += brandNewInc;
      } else if (alert.kind == AlertType.error) {
        newErrorCount += 1;
        brandNew += brandNewInc;
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

    if (brandNew > 0) {
      await _showNotification(message: messages.join(", "));
      if (_settings.notificationsEnabled &&
          _settings.soundEnabled &&
          !Platform.isAndroid &&
          !Platform.isIOS) {
        alertStream?.add(const IsolateMessage(
            name: MessageName.playDesktopSound,
            destination: MessageDestination.notifications));
      }
    } else if (messages.isEmpty) {
      await _removeAlertNotification();
    }
  }

  Future<void> startAnroidStickyNotification() async {
    if (!Platform.isAndroid ||
        !_settings.notificationsEnabled ||
        _settings.refreshInterval == -1) {
      return;
    }
    if (await _stickyAlreadyExists()) {
      return;
    }
    var duration = Util.prettyPrintDuration(
        duration: Duration(seconds: _settings.refreshInterval),
        longForm: true,
        stripLeadingOne: true);
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.startForegroundService(stickyNotificationId, stickyNotificationTitle,
            "$stickyNotificationContentStart $duration",
            notificationDetails: _stickyAndroidNotificationDetails,
            startType: AndroidServiceStartType.startRedeliverIntent,
            foregroundServiceTypes: {
          AndroidServiceForegroundType.foregroundServiceTypeDataSync
        });
  }

  Future<void> updateAnroidStickyNotification() async {
    if (!Platform.isAndroid ||
        !_settings.notificationsEnabled ||
        _settings.refreshInterval == -1) {
      return;
    }
    if (!(await _stickyAlreadyExists())) {
      startAnroidStickyNotification();
      return;
    }
    var duration = Util.prettyPrintDuration(
        duration: Duration(seconds: _settings.refreshInterval),
        longForm: true,
        stripLeadingOne: true);
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.show(stickyNotificationId, stickyNotificationTitle,
            "$stickyNotificationContentStart $duration",
            notificationDetails: _stickyAndroidNotificationDetails);
  }

  Future<bool> _stickyAlreadyExists() async {
    var activeAlerts = await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();
    final exists = activeAlerts
            ?.where((alert) => alert.id == stickyNotificationId)
            .isNotEmpty ??
        false;
    return exists;
  }

  Future<void> disableNotifications() async {
    if (Platform.isAndroid) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.stopForegroundService();
    }
    await _removeAlertNotification();
  }

  Future<void> updateAlertDetails() async {
    const linuxNotificationDetails = LinuxNotificationDetails();
    var androidNotificationDetails = AndroidNotificationDetails(
        alertsNotificationChannelId, alertsNotificationChannelName,
        icon: notificationIcon,
        channelDescription: alertsNotificationChannelDescription,
        importance: Importance.max,
        priority: Priority.high,
        silent: !_settings.soundEnabled);
    _notificationDetails = NotificationDetails(
        linux: linuxNotificationDetails, android: androidNotificationDetails);
  }
}
