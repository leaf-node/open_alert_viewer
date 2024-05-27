/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'database.dart';

class Sources {
  const Sources({required this.localDatabase});

  final LocalDatabase localDatabase;

  List<Map<String, Object?>> listSources() {
    return localDatabase.db.select("SELECT * FROM sources;")
        as List<Map<String, Object?>>;
  }

  int addSource({required List<String> source}) {
    localDatabase.db.execute('''
      INSERT INTO sources
        (name, url, username, password)
        VALUES (?, ?, ?, ?);
    ''', source);
    return localDatabase.db.lastInsertRowId;
  }

  removeSource({required int id}) {
    localDatabase.db.execute("DROP FROM sources WHERE id = ?;", [id]);
  }
}
