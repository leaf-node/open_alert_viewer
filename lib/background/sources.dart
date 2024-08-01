/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:developer';

import '../alerts/data_source/alerts_random.dart';
import '../alerts/model/alerts.dart';
import '../app/data_source/database.dart';

class SourcesRepo {
  SourcesRepo({required LocalDatabase db}) : _db = db;

  final LocalDatabase _db;

  List<AlertSource> get alertSources {
    List<AlertSource> sources = [];
    List<Map<String, dynamic>> sourcesData = _db.listSources();
    Function alertSource;
    for (var source in sourcesData) {
      List<dynamic> values = source.values.toList();
      var id = values[0] as int;
      var name = values[1] as String;
      int type;
      try {
        type = values[2] as int;
      } catch (e) {
        log("Unsupported source id: '${values[2]}'. Removing source.");
        removeSource(id: id);
        continue;
      }
      var baseURL = values[3] as String;
      var path = values[4] as String;
      var username = values[5] as String;
      var password = values[6] as String;

      switch (type) {
        case 0:
          alertSource = RandomAlerts.new;
        default:
          throw "Unsupported source id: $type";
      }
      sources.add(alertSource(
          id: id,
          type: type,
          name: name,
          baseURL: baseURL,
          path: path,
          username: username,
          password: password));
    }
    return sources;
  }

  int addSource({required List<String> source}) {
    return _db.addSource(source: source);
  }

  bool updateSource({required int id, required List<Object> values}) {
    return _db.updateSource(id: id, values: values);
  }

  void removeSource({required int id}) {
    _db.removeSource(id: id);
  }
}
