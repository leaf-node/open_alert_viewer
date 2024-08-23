/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boot_receiver/flutter_boot_receiver.dart';
import 'package:yaml/yaml.dart';

import 'app.dart';
import 'app/data_source/database.dart';
import 'background/background.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await BootReceiver.initialize(startApp);
  }
  await startApp();
}

@pragma('vm:entry-point')
Future<void> startApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = LocalDatabase();
  await db.migrate(showPath: true);
  String appVersion =
      loadYaml(await rootBundle.loadString("pubspec.yaml"))["version"];
  var bgWorker = BackgroundWorker();
  await bgWorker.spawn(appVersion: appVersion);
  runApp(OAVapp(db: db, bgWorker: bgWorker));
}
