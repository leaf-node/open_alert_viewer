/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:developer';

import 'package:open_alert_viewer/alerts/data_source/alerts_nag.dart';

import '../../alerts/data_source/alerts_random.dart';
import '../../alerts/model/alerts.dart';
import '../../app/data_source/database.dart';

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
        case 1:
          alertSource = NagAlerts.new;
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

  int addSource({required List<String> values}) {
    values = _getSourceTypeAndPath(values: values);
    return _db.addSource(values: values);
  }

  bool updateSource({required int id, required List<String> values}) {
    values = _getSourceTypeAndPath(values: values);
    return _db.updateSource(id: id, values: values);
  }

  void removeSource({required int id}) {
    _db.removeSource(id: id);
  }

  List<String> _getSourceTypeAndPath({required List<String> values}) {
    int type;
    var baseURL = values[2];
    if (baseURL == "demo") {
      type = 0; // random alerts
    } else {
      type = 1; // Nag alerts
    }
    values[1] = type.toString();
    return values;
  }
}
