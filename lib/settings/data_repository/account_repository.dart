/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../app/data_source/database.dart';

class AccountsRepo {
  AccountsRepo({required LocalDatabase db}) : _db = db;

  final LocalDatabase _db;

  bool checkUniqueSource({int? id, required String name}) {
    return _db.checkUniqueSource(id: id, name: name);
  }
}
