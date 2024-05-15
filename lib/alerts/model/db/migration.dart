import 'dart:developer';
import 'package:sqlite3/sqlite3.dart';
import 'package:path_provider/path_provider.dart';

Future<void> migrateDatabase() async {
  final path = await getApplicationSupportDirectory();

  log('Storing app data in: ${path.path}/');
  final db = sqlite3.open("${path.path}/oav_data.sqlite3");

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
