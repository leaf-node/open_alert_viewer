/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'ui/core/view/app.dart';
import 'data/services/database.dart';
import 'background/background.dart';
import 'background/background_desktop.dart';
import 'background/background_mobile.dart';
import 'utils/utils.dart';

LocalDatabase? db;
BackgroundChannel? bgChannel;

Future<void> main() async {
  await startBackground();
  await startForeground();
}

Future<void> startBackground() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (db == null) {
    db = LocalDatabase();
    await db!.migrate(showPath: true);
  }
  if (bgChannel == null) {
    if (Platform.isAndroid) {
      bgChannel = BackgroundMobile();
    } else {
      bgChannel = BackgroundDesktop();
    }
    await bgChannel!.spawn(appVersion: await Util.getVersion());
  }
}

Future<void> startForeground() async {
  while (bgChannel == null || db == null) {
    await Future.delayed(Duration(milliseconds: 100));
  }
  runApp(OAVapp(
      appVersion: await Util.getVersion(), db: db!, bgChannel: bgChannel!));
}
