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
import 'background/domain/background.dart';
import 'background/domain/background_default.dart';
import 'background/domain/background_sticky_notification.dart';

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
      bgChannel = BackgroundStickyNotification();
    } else {
      bgChannel = BackgroundDefault();
    }
    await bgChannel!.spawn();
  }
}

Future<void> startForeground() async {
  while (bgChannel == null || db == null) {
    await Future.delayed(Duration(milliseconds: 100));
  }
  runApp(OAVapp(db: db!, bgChannel: bgChannel!));
}
