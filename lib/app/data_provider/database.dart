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

  // Generic querying methods

  List<Map<String, dynamic>> fetchFromTable({required String query}) {
    return _db.select(query) as List<Map<String, dynamic>>;
  }

  void removeFromTable({required String query, required List<Object> values}) {
    _db.execute(query, values);
  }

  int insertIntoTable(
      {required String query, required List<List<String>> values}) {
    try {
      for (var value in values) {
        _db.execute(query, value);
      }
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

  // App-specific queries

  List<Map<String, dynamic>> listSources() {
    return fetchFromTable(
        query: "SELECT id, name, type, url, username, password FROM sources;");
  }

  int addSource({required List<String> source}) {
    return insertIntoTable(query: '''
      INSERT INTO sources
        (name, type, url, username, password)
        VALUES (?, ?, ?, ?, ?);
    ''', values: [source]);
  }

  void removeSource({required int id}) {
    removeFromTable(query: "DROP FROM sources WHERE id = ?;", values: [id]);
  }
}
