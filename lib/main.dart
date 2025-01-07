/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:flutter/material.dart';

import 'background/domain/background.dart';
import 'background/domain/background_switcher.dart';
import 'data/repositories/settings_repo.dart';
import 'data/services/database.dart';
import 'ui/core/view/app.dart';

LocalDatabase? db;
BackgroundExternalChannel? bgChannel;

Future<void> main() async {
  await startBackground();
  await startForeground();
}

@pragma("vm:entry-point")
Future<void> startBackground() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (db == null) {
    db = LocalDatabase();
    await db!.migrate(showPath: true);
  }
  if (bgChannel == null) {
    bgChannel = BackgroundSwitcher(SettingsRepo(db: db!));
    await bgChannel!.spawn();
  }
}

Future<void> startForeground() async {
  while (bgChannel == null || db == null) {
    await Future.delayed(Duration(milliseconds: 100));
  }
  runApp(OAVapp(db: db!, bgChannel: bgChannel!));
}
