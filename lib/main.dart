import 'package:flutter/material.dart';

import 'alerts/model/database.dart';
import 'alerts/model/sources.dart';
import 'app.dart';

Future<void> main() async {
  // demo code
  var db = LocalDatabase();
  await db.open();
  await db.migrateDatabase();
  var sources = Sources(localDB: db);

  runApp(const MyApp());
}
