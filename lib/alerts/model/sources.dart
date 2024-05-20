/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'database.dart';

class Sources {
  const Sources({required this.localDB});

  final LocalDatabase localDB;

  List<Map<String, Object?>> listSources() {
    return localDB.db.select("SELECT * FROM sources;")
        as List<Map<String, Object?>>;
  }

  int addSource(List<String> source) {
    localDB.db.execute('''
      INSERT INTO sources
        (name, url, username, password)
        VALUES (?, ?, ?, ?);
    ''', source);
    return localDB.db.lastInsertRowId;
  }

  removeSource(int id) {
    localDB.db.execute("DROP FROM sources WHERE id = ?;", [id]);
  }
}
