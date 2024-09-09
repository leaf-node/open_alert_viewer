/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
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

  Future<void> open({bool? showPath}) async {
    if (!_isOpen) {
      final path = await getApplicationSupportDirectory();
      if (showPath ?? false) {
        log('App data directory: ${path.path}/');
      }

      _db = sqlite3.open("${path.path}/oav_data.sqlite3");
      _db.execute("PRAGMA journal_mode=WAL;");
      _db.execute("PRAGMA busy_timeout = 5000;");
      _isOpen = true;
    }
  }

  void close() {
    _db.dispose();
    _isOpen = false;
  }

  Future<void> migrate({bool? showPath}) async {
    if (!_isOpen) {
      await open(showPath: showPath);
    }
    if (!_checkIfTableExists(name: "settings") ||
        getSetting(setting: "migration_version") == "") {
      var sqlString =
          await rootBundle.loadString("lib/app/db_migrations/version_0.sql");
      _db.execute(sqlString);
      setSetting(setting: "migration_version", value: "0.0.0");
    }
  }

  // Generic querying methods

  List<Map<String, Object>> fetchFromTable(
      {required String query, required List<Object> values}) {
    return _db.select(query, values) as List<Map<String, Object>>;
  }

  void removeFromTable({required String query, required List<Object> values}) {
    _db.execute(query, values);
  }

  int insertIntoTable(
      {required String query, required List<List<Object>> values}) {
    _db.execute("BEGIN TRANSACTION;");
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
    } finally {
      _db.execute("COMMIT TRANSACTION;");
    }
    return _db.lastInsertRowId;
  }

  bool updateTable({required String query, required List<Object> values}) {
    try {
      _db.execute(query, values);
    } on SqliteException catch (e) {
      if (e.extendedResultCode == 2067) {
        // already in database
        return false;
      } else {
        rethrow;
      }
    }
    return true;
  }

  bool _checkIfTableExists({required String name}) {
    var result = _db.select(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$name'");
    if (result.isEmpty) {
      return false;
    }
    return true;
  }

  // App-specific queries

  List<Map<String, Object>> listSources() {
    return fetchFromTable(
        query:
            "SELECT id, name, type, base_url, path, username, password FROM sources;",
        values: []);
  }

  int addSource({required Map<String, Object> source}) {
    return insertIntoTable(query: '''
      INSERT INTO sources
        (name, type, base_url, path, username, password)
        VALUES (?, ?, ?, ?, ?, ?);
    ''', values: [
      [
        source["name"]!,
        source["type"]!,
        source["base_url"]!,
        source["path"]!,
        source["username"]!,
        source["password"]!,
      ]
    ]);
  }

  bool updateSource({required Map<String, Object> source}) {
    return updateTable(query: '''
      UPDATE sources SET
        (name, type, base_url, path, username, password)
        = (?, ?, ?, ?, ?, ?) WHERE id = ?;
    ''', values: [
      source["name"]!,
      source["type"]!,
      source["base_url"]!,
      source["path"]!,
      source["username"]!,
      source["password"]!,
      source["id"]!
    ]);
  }

  void removeSource({required int id}) {
    removeFromTable(query: "DELETE FROM sources WHERE id = ?;", values: [id]);
  }

  bool checkUniqueSource({int? id, required String name}) {
    var rows =
        fetchFromTable(query: "SELECT id, name FROM sources;", values: []);
    for (var row in rows) {
      var rowid = row["id"] as int;
      if (id != rowid && name == row["name"] as String) {
        return false;
      }
    }
    return true;
  }

  List<Map<String, Object>> fetchCachedAlerts() {
    return fetchFromTable(
        query: '''SELECT id, source, kind, hostname, service, message, url, age
            FROM alerts_cache;''', values: []);
  }

  void removeCachedAlerts() {
    removeFromTable(query: "DELETE FROM alerts_cache;", values: []);
  }

  void insertIntoAlertsCache({required List<List<Object>> alerts}) {
    insertIntoTable(query: '''
        INSERT INTO alerts_cache
          (source, kind, hostname, service, message, url, age)
          VALUES (?, ?, ?, ?, ?, ?, ?);''', values: alerts);
  }

  String getSetting({required String setting}) {
    var results = fetchFromTable(
        query: "SELECT value from settings where key = ?;", values: [setting]);
    return switch (results.length) {
      0 => "",
      _ => results[0]["value"] as String,
    };
  }

  void setSetting({required String setting, required String value}) {
    var results = fetchFromTable(
        query: "SELECT value from settings WHERE key = ?;", values: [setting]);
    if (results.isEmpty) {
      insertIntoTable(
          query: "INSERT INTO settings (key, value) VALUES (?, ?);",
          values: [
            [setting, value]
          ]);
    } else {
      updateTable(
          query: "UPDATE settings SET value = ? WHERE key = ?;",
          values: [value, setting]);
    }
  }
}
