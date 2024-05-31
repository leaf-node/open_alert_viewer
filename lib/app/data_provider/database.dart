/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class LocalDatabase {
  LocalDatabase() : _isOpen = false;

  bool _isOpen;
  late Database _db;

  open() async {
    if (!_isOpen) {
      final path = await getApplicationSupportDirectory();
      log('App data directory: ${path.path}/');

      _db = sqlite3.open("${path.path}/oav_data.sqlite3");
      _isOpen = true;
    }
  }

  void close() {
    _db.dispose();
    _isOpen = false;
  }

  migrateDatabase() async {
    String sqlString;

    if (!_isOpen) {
      open();
    }
    sqlString = await rootBundle.loadString("lib/app/migrations/version_0.sql");
    _db.execute(sqlString);
  }

  List<Map<String, dynamic>> listSources() {
    var results = _db.select(
            "SELECT id, name, type, url, username, password FROM sources;")
        as Iterable<Map<String, dynamic>>;
    return results.toList();
  }

  int addSource({required List<String> source}) {
    try {
      _db.execute('''
      INSERT INTO sources
        (name, type, url, username, password)
        VALUES (?, ?, ?, ?, ?);
    ''', source);
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 2067) {
        // already in database
        return -1;
      } else {
        rethrow;
      }
    }
    return _db.lastInsertRowId;
  }

  void removeSource({required int id}) {
    _db.execute("DROP FROM sources WHERE id = ?;", [id]);
  }
}
