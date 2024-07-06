/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:flutter/material.dart';

import 'app.dart';
import 'app/data_repository/app_repository.dart';
import 'app/data_repository/settings_repository.dart';
import 'app/data_source/database.dart';
import 'notifications/data_repository/notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = LocalDatabase();
  await db.migrate();
  var settings = SettingsRepo(db: db);
  var notifier = NotificationRepo(settings: settings);
  var controller = StreamController<AlertsAndStatus>();
  var appRepo = AppRepo(
      db: db, settings: settings, notifier: notifier, controller: controller);
  await notifier.initializeAlertNotifications();
  await notifier.requestAndEnableNotifications(
      askAgain: false, callback: () {});
  await appRepo.startTimer();
  runApp(OAVapp(
      settings: settings,
      repo: appRepo,
      notifier: notifier,
      controller: controller));
}
