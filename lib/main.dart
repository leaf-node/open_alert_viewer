/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'app/data_source/database.dart';

import 'app.dart';

Future<void> main() async {
  var db = LocalDatabase();
  await db.migrate();
  runApp(OAVapp(database: db));
}
