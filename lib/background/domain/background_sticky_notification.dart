/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../utils/utils.dart';
import 'background.dart';

// must match here: lib/background/repositories/notifications_bg_repo.dart
const stickyNotificationChannelId = "Open Alert Viewer Background Work";
const stickyNotificationChannelName = "Background Work";
const stickyNotificationChannelDescription =
    "Allow Fetching Alerts in Background";
const stickyNotificationId = 1;

class BackgroundStickyNotification extends BackgroundChannelExternal
    implements BackgroundChannel {
  FlutterBackgroundService? _service;
  @override
  Future<void> spawn() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidNotificationChannel stickyChannel = AndroidNotificationChannel(
        stickyNotificationChannelId, stickyNotificationChannelName,
        description: stickyNotificationChannelDescription,
        importance: Importance.low);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(stickyChannel);
    _service = FlutterBackgroundService();
    await _service?.configure(
        androidConfiguration: AndroidConfiguration(
          onStart: onStartService,
          autoStart: true,
          autoStartOnBoot: false,
          isForegroundMode: true,
          notificationChannelId: stickyNotificationChannelId,
          initialNotificationTitle: "Preparing Notification",
          initialNotificationContent: "...",
          foregroundServiceNotificationId: stickyNotificationId,
        ),
        iosConfiguration: IosConfiguration());
    String appVersion = await Util.getVersion();
    _service?.on("fgInit").listen((_) {
      backgroundReady.complete();
    });
    _service?.invoke("bgInit", {"version": appVersion});
    _service?.on("outbound").listen((data) {
      handleResponsesFromBackground(data!["message"]!);
    });
  }

  @override
  Future<void> makeRequest(IsolateMessage message) async {
    await backgroundReady.future;
    _service?.invoke(
        "inbound", {"message": BackgroundTranslator.serialize(message)});
  }
}

@pragma('vm:entry-point')
Future<void> onStartService(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    final bg = BackgroundService();
    bg.spawned(service);
  } else {
    throw Exception("iOS not supported by Open Alert Viewer");
  }
}

class BackgroundService with BackgroundChannelInternal {
  ServiceInstance? _service;
  Future<void> spawned(service) async {
    _service = service;
    _service?.on("bgInit").listen(_initChannel);
    _service?.on("inbound").listen((data) {
      handleRequestsToBackground(data!["message"]);
    });
  }

  Future<void> _initChannel(Map<String, dynamic>? data) async {
    await init(data!["version"]!, (message) {
      _service?.invoke(
          "outbound", {"message": BackgroundTranslator.serialize(message)});
    });
    _service?.invoke("fgInit", {});
  }
}
