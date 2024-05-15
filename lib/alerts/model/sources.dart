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

  migrateDatabase() async {
    localDB.db.execute('''
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
