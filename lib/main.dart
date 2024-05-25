/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';

import 'settings/model/database.dart';
import 'settings/model/sources.dart';
import 'app.dart';

Future<void> main() async {
  // demo code
  var db = LocalDatabase();
  await db.open();
  await db.migrateDatabase();
  var sources = Sources(localDB: db);

  runApp(const OAVapp());
}
