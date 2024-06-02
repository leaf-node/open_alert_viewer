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

  migrate() async {
    String sqlString;

    if (!_isOpen) {
      open();
    }
    sqlString = await rootBundle.loadString("lib/app/migrations/version_0.sql");
    _db.execute(sqlString);
  }

  // Generic querying methods

  List<Map<String, dynamic>> fetchFromTable(
      {required String query, required List<Object> values}) {
    return _db.select(query, values) as List<Map<String, dynamic>>;
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
    }
    _db.execute("COMMIT TRANSACTION;");
    return _db.lastInsertRowId;
  }

  void updateTable({required String query, required List<Object> values}) {
    _db.execute(query, values);
  }

  // App-specific queries

  List<Map<String, dynamic>> listSources() {
    return fetchFromTable(
        query: "SELECT id, name, type, url, username, password FROM sources;",
        values: []);
  }

  int addSource({required List<String> source}) {
    return insertIntoTable(query: '''
      INSERT INTO sources
        (name, type, url, username, password)
        VALUES (?, ?, ?, ?, ?);
    ''', values: [source]);
  }

  void removeSource({required int id}) {
    removeFromTable(query: "DELETE FROM sources WHERE id = ?;", values: [id]);
  }

  List<Map<String, dynamic>> fetchCachedAlerts() {
    return fetchFromTable(
        query: '''SELECT id, source, kind, hostname, service, message, age
            FROM alerts_cache;''', values: []);
  }

  void removeCachedAlerts() {
    removeFromTable(query: "DELETE FROM alerts_cache;", values: []);
  }

  void insertIntoAlertsCache({required List<List<Object>> alerts}) {
    insertIntoTable(query: '''
        INSERT INTO alerts_cache
          (source, kind, hostname, service, message, age)
          VALUES (?, ?, ?, ?, ?, ?);''', values: alerts);
  }

  List<String> listSettings() {
    List<String> settings = [];
    var results =
        fetchFromTable(query: "SELECT key from settings;", values: []);
    for (var row in results) {
      settings.add(row["key"] as String);
    }
    return settings;
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
