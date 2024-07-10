/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:flutter/material.dart';

import 'app.dart';
import 'app/data_source/database.dart';
import 'background/background.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = LocalDatabase();
  await db.migrate(showPath: true);
  var alertStream = StreamController<IsolateMessage>();
  var bgWorker = BackgroundWorker(alertStream: alertStream);
  await bgWorker.spawn();
  runApp(OAVapp(db: db, bgWorker: bgWorker, alertStream: alertStream));
}
