/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:sqlite3/sqlite3.dart';

import 'database.dart';

class Sources {
  Sources({required LocalDatabase localDatabase}) {
    _db = localDatabase.db;
  }

  late final Database _db;

  List<Map<String, Object?>> listSources() {
    return _db.select("SELECT * FROM sources;") as List<Map<String, Object?>>;
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
