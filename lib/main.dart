/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:flutter/material.dart';

import 'background/domain/background_external.dart';
import 'data/services/database.dart';
import 'ui/core/view/app.dart';

LocalDatabase? db;
BackgroundChannel? bgChannel;

Future<void> main() async {
  await startBackground();
  await startForeground();
}

@pragma("vm:entry-point")
Future<void> startBackground() async {
  WidgetsFlutterBinding.ensureInitialized();
  bgChannel = BackgroundChannel();
  await bgChannel!.spawn();
  db = LocalDatabase();
  await bgChannel!.backgroundReady.future;
  await db!.open();
}

Future<void> startForeground() async {
  runApp(OAVapp(db: db!, bgChannel: bgChannel!));
}
