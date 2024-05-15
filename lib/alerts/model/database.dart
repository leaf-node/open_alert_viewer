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
}
