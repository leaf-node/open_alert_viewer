/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:developer';
import 'dart:isolate';
import 'dart:math' show Random;

import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../domain/alerts.dart';
import '../../schema/version_0_sql.dart';
import '../../utils/utils.dart';

class LocalDatabase {
  LocalDatabase() : _isOpen = false;

  bool _isOpen;
  late Database _db;
  final _migrationSetting = "migration_version";
  int openReattempts = 0;

  Future<void> open({bool? showPath}) async {
    if (_isOpen) {
      return;
    }
    final path = await getApplicationSupportDirectory();
    if (showPath ?? false) {
      log('App data directory: ${path.path}/');
    }
    int openReattempts = 0;
    Object? storedException;
    do {
      try {
        _db = sqlite3.open("${path.path}/oav_data.sqlite3");
        _db.execute("PRAGMA journal_mode=WAL;");
        _db.execute("PRAGMA busy_timeout = 5000;");
        return;
      } catch (e) {
        openReattempts += 1;
        await Future.delayed(Duration(
            milliseconds:
                Random(DateTime.now().microsecondsSinceEpoch).nextInt(500) +
                    500));
        storedException = e;
      }
    } while (openReattempts < 5);
    throw storedException;
  }

  void close() {
    _db.dispose();
    _isOpen = false;
  }

  Future<void> openAndMigrate({bool? showPath}) async {
    if (!_isOpen) {
      await open(showPath: showPath);
    }
    if (Isolate.current.debugName == "main") {
      throw Exception("Only the background isolate should migrate the DB.");
    }
    _db.execute("BEGIN TRANSACTION;");
    if (!_checkIfTableExists(name: "settings") ||
        getSetting(setting: _migrationSetting) == "") {
      _db.execute(version0sql);
      setSetting(setting: _migrationSetting, value: "0.0.0");
    }
    if (getSetting(setting: _migrationSetting) == "0.0.0") {
      setSetting(setting: _migrationSetting, value: "1.0.0");
    }
    _db.execute("COMMIT TRANSACTION;");
  }

  // Generic querying methods

  List<Map<String, Object>> _fetchFromTable(
      {required String query, required List<Object> values}) {
    final results = _db.select(query, values);
    return [for (var result in results) Util.mapConvert(result)];
  }

  void _removeFromTable({required String query, required List<Object> values}) {
    _db.execute(query, values);
  }

  int _insertIntoTable(
      {required String query,
      required List<List<Object>> values,
      bool transaction = true}) {
    if (transaction) {
      _db.execute("BEGIN TRANSACTION;");
    }
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
      if (transaction) {
        _db.execute("COMMIT TRANSACTION;");
      }
    }
    return _db.lastInsertRowId;
  }

  bool _updateTable({required String query, required List<Object> values}) {
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

  List<AlertSourceData> listSources() {
    List<Map<String, Object>> valuesArray = _fetchFromTable(query: '''
      SELECT
        id, name, type, auth_type, base_url, username, password, failing,
          last_seen, prior_fetch, last_fetch, error_message, is_valid,
          access_token
      FROM sources;
    ''', values: []);
    var sources = <AlertSourceData>[];
    for (var values in valuesArray) {
      int type = values["type"] as int;
      type = SourceTypes.values
          .singleWhere((e) => e.value == type,
              orElse: () => SourceTypes.nullType)
          .value;
      sources.add(AlertSourceData(
        id: values["id"] as int,
        name: values["name"] as String,
        type: type,
        authType: values["auth_type"] as int,
        baseURL: values["base_url"] as String,
        username: values["username"] as String,
        password: values["password"] as String,
        failing: Util.toBool(values["failing"]!),
        lastSeen:
            DateTime.fromMillisecondsSinceEpoch(values["last_seen"] as int),
        priorFetch:
            DateTime.fromMillisecondsSinceEpoch(values["prior_fetch"] as int),
        lastFetch:
            DateTime.fromMillisecondsSinceEpoch(values["last_fetch"] as int),
        errorMessage: values["error_message"] as String,
        isValid: Util.toBool(values["is_valid"]!),
        accessToken: values["access_token"] as String,
      ));
    }
    return sources;
  }

  int addSource({required AlertSourceData sourceData}) {
    return _insertIntoTable(query: '''
      INSERT INTO sources
        (name, type, auth_type, base_url, username, password, failing,
          last_seen, prior_fetch, last_fetch, error_message, is_valid,
          access_token)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
    ''', values: [
      [
        sourceData.name,
        sourceData.type,
        sourceData.authType,
        sourceData.baseURL,
        sourceData.username,
        sourceData.password,
        sourceData.failing,
        sourceData.lastSeen.millisecondsSinceEpoch,
        sourceData.priorFetch.millisecondsSinceEpoch,
        sourceData.lastFetch.millisecondsSinceEpoch,
        sourceData.errorMessage,
        sourceData.isValid ?? "NULL",
        sourceData.accessToken
      ]
    ]);
  }

  bool updateSource({required AlertSourceData sourceData}) {
    return _updateTable(query: '''
      UPDATE sources SET
        (name, type, auth_type, base_url, username, password, failing,
          last_seen, prior_fetch, last_fetch, error_message, is_valid,
          access_token)
        = (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) WHERE id = ?;
    ''', values: [
      sourceData.name,
      sourceData.type,
      sourceData.authType,
      sourceData.baseURL,
      sourceData.username,
      sourceData.password,
      sourceData.failing,
      sourceData.lastSeen.millisecondsSinceEpoch,
      sourceData.priorFetch.millisecondsSinceEpoch,
      sourceData.lastFetch.millisecondsSinceEpoch,
      sourceData.errorMessage,
      sourceData.isValid ?? "NULL",
      sourceData.accessToken,
      sourceData.id!,
    ]);
  }

  void removeSource({required int id}) {
    _removeFromTable(query: "DELETE FROM sources WHERE id = ?;", values: [id]);
  }

  bool checkUniqueSource({int? id, required String name}) {
    var rows =
        _fetchFromTable(query: "SELECT id, name FROM sources;", values: []);
    for (var row in rows) {
      var rowid = row["id"] as int;
      if (id != rowid && name == row["name"] as String) {
        return false;
      }
    }
    return true;
  }

  List<Alert> fetchCachedAlerts() {
    List<Map<String, Object>> alerts = _fetchFromTable(
        query: '''SELECT id, source, kind, hostname, service, message, url, age,
          silenced, downtime_scheduled, active
            FROM alerts_cache;''', values: []);
    return [
      for (var alert in alerts)
        Alert(
            source: alert["source"] as int,
            kind: AlertType.values[alert["kind"] as int],
            message: alert["message"] as String,
            url: alert["url"] as String,
            hostname: alert["hostname"] as String,
            service: alert["service"] as String,
            age: Duration(seconds: alert["age"] as int),
            silenced: Util.toBool(alert["silenced"]!),
            downtimeScheduled: Util.toBool(alert["downtime_scheduled"]!),
            active: Util.toBool(alert["active"]!))
    ];
  }

  void removeCachedAlerts() {
    _removeFromTable(query: "DELETE FROM alerts_cache;", values: []);
  }

  void insertIntoAlertsCache({required List<Alert> alerts}) {
    _insertIntoTable(query: '''
        INSERT INTO alerts_cache
          (source, kind, hostname, service, message, url, age, silenced,
            downtime_scheduled, active)
          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);''', values: [
      for (var alert in alerts)
        [
          alert.source,
          alert.kind.index,
          alert.hostname,
          alert.service,
          alert.message,
          alert.url,
          alert.age.inSeconds,
          alert.silenced,
          alert.downtimeScheduled,
          alert.active,
        ]
    ]);
  }

  String getSetting({required String setting}) {
    List<Map<String, Object>> results;
    try {
      results = _fetchFromTable(
          query: "SELECT value from settings where key = ?;",
          values: [setting]);
    } catch (_) {
      // Database is broken. Allow basic functions of app to continue
      results = [];
    }
    return switch (results.length) {
      0 => "",
      _ => results[0]["value"] as String,
    };
  }

  void setSetting({required String setting, required String value}) {
    List<Map<String, Object>> results;
    try {
      results = _fetchFromTable(
          query: "SELECT value from settings WHERE key = ?;",
          values: [setting]);
    } catch (_) {
      // Database is broken. Allow basic functions of app to continue
      return;
    }
    if (results.isEmpty) {
      _insertIntoTable(
          query: "INSERT INTO settings (key, value) VALUES (?, ?);",
          values: [
            [setting, value]
          ],
          transaction: false);
    } else {
      _updateTable(
          query: "UPDATE settings SET value = ? WHERE key = ?;",
          values: [value, setting]);
    }
  }
}
