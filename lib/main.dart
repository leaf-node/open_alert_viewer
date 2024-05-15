import 'package:flutter/material.dart';

import 'alerts/model/database.dart';
import 'alerts/model/sources.dart';
import 'app.dart';

Future<void> main() async {
  // demo code
  var db = LocalDatabase();
  await db.open();
  var sources = Sources(localDB: db);
  await sources.migrateDatabase();

  runApp(const MyApp());
}
