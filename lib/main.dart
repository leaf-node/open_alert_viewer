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
  var bgWorker = BackgroundWorker();
  String appVersion = await getVersion();
  await bgWorker.spawn(appVersion: appVersion);
  runApp(OAVapp(appVersion: appVersion, db: db, bgWorker: bgWorker));
}

Future<String> getVersion() async {
  String gitVersion;
  final pubspecVersion =
      loadYaml(await rootBundle.loadString("pubspec.yaml"))["version"];
  var head = await rootBundle.loadString('.git/HEAD');
  if (head.startsWith('ref: ')) {
    final branchName = head.split('ref: refs/heads/').last.trim();
    gitVersion = await rootBundle.loadString('.git/refs/heads/$branchName');
  } else {
    gitVersion = head;
  }
  return "$pubspecVersion-${gitVersion.substring(0, 8)}";
}
