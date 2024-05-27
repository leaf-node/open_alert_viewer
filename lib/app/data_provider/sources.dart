/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:sqlite3/sqlite3.dart';

import 'database.dart';

class SourcesDBwrapper {
  SourcesDBwrapper({required LocalDatabase localDatabase}) {
    _db = localDatabase.db;
  }

  late final Database _db;

  List<Map<String, dynamic>> listSources() {
    var results = _db.select(
            "SELECT id, name, type, url, username, password FROM sources;")
        as Iterable<Map<String, dynamic>>;
    return results.toList();
  }

  int addSource({required List<String> source}) {
    _db.execute('''
      INSERT INTO sources
        (name, type, url, username, password)
        VALUES (?, ?, ?, ?, ?);
    ''', source);
    return _db.lastInsertRowId;
  }

  removeSource({required int id}) {
    _db.execute("DROP FROM sources WHERE id = ?;", [id]);
  }
}
