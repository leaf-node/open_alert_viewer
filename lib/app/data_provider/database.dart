/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:developer';

import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class LocalDatabase {
  LocalDatabase() : _isOpen = false;

  bool _isOpen;
  late Database db;

  open() async {
    if (!_isOpen) {
      final path = await getApplicationSupportDirectory();
      log('App data directory: ${path.path}/');

      db = sqlite3.open("${path.path}/oav_data.sqlite3");
      _isOpen = true;
    }
  }

  void close() {
    db.dispose();
    _isOpen = false;
  }

  migrateDatabase() async {
    if (!_isOpen) {
      open();
    }

    db.execute('''
      CREATE TABLE IF NOT EXISTS sources (
        id INTEGER NOT NULL PRIMARY KEY,
        name TEXT NOT NULL UNIQUE,
        type INTEGER NOT NULL,
        url TEXT NOT NULL,
        username TEXT NOT NULL,
        password TEXT NOT NULL,

        UNIQUE(type, url, username, password)
      );

      CREATE TABLE IF NOT EXISTS settings (
        id INTEGER NOT NULL PRIMARY KEY,
        key TEXT NOT NULL UNIQUE,
        value TEXT NOT NULL
      );

      CREATE TABLE IF NOT EXISTS alerts_cache (
        id INTEGER NOT NULL PRIMARY KEY,
        source INTEGER NOT NULL,
        kind INTEGER NOT NULL,
        hostname TEXT NOT NULL,
        service TEXT NOT NULL,
        message TEXT NOT NULL,
        age INTEGER NOT NULL
      );
    ''');
  }
}
