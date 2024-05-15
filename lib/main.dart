import 'package:flutter/material.dart';
import 'package:open_alert_viewer/alerts/model/db/migration.dart';

import 'app.dart';

Future<void> main() async {
  await migrateDatabase();
  runApp(const MyApp());
}
