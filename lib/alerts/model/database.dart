import 'dart:developer';

import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class LocalDatabase {
  LocalDatabase() {
    isOpen = false;
  }

  late bool isOpen;
  late Database db;

  open() async {
    if (!isOpen) {
      final path = await getApplicationSupportDirectory();
      log('App data directory: ${path.path}/');

      db = sqlite3.open("${path.path}/oav_data.sqlite3");
      isOpen = true;
    }
  }

  void close() {
    db.dispose();
    isOpen = false;
  }

  migrateDatabase() async {
    if (!isOpen) {
      open();
    }

    db.execute('''
      CREATE TABLE IF NOT EXISTS sources (
        id INTEGER NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        url TEXT NOT NULL,
        username TEXT NOT NULL,
        password TEXT NOT NULL
      );
    ''');
  }
}
