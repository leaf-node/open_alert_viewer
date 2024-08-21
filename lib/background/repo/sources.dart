/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:http/http.dart' as http;

import '../../alerts/data_source/alerts_invalid.dart';
import '../../alerts/data_source/alerts_nag.dart';
import '../../alerts/data_source/alerts_prom.dart';
import '../../alerts/data_source/alerts_random.dart';
import '../../alerts/model/alerts.dart';
import '../../app/data_source/database.dart';

enum SourceIntMap {
  invalid(-1),
  demo(0),
  nag(1),
  prom(2);

  const SourceIntMap(this.val);
  final int val;
}

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
        type = -1;
      }
      var baseURL = values[3] as String;
      var path = values[4] as String;
      var username = values[5] as String;
      var password = values[6] as String;

      var enumType = SourceIntMap.values.singleWhere((e) => e.val == type);
      switch (enumType) {
        case SourceIntMap.demo:
          alertSource = RandomAlerts.new;
        case SourceIntMap.nag:
          alertSource = NagAlerts.new;
        case SourceIntMap.prom:
          alertSource = PromAlerts.new;
        case SourceIntMap.invalid:
          alertSource = InvalidAlerts.new;
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

  Future<int> addSource({required List<String> values}) async {
    values = await _getSourceTypeAndPath(values: values);
    return _db.addSource(values: values);
  }

  Future<bool> updateSource(
      {required int id, required List<String> values}) async {
    values = await _getSourceTypeAndPath(values: values);
    return _db.updateSource(id: id, values: values);
  }

  void removeSource({required int id}) {
    _db.removeSource(id: id);
  }

  Future<List<String>> _getSourceTypeAndPath(
      {required List<String> values}) async {
    late Function uriBuilder;
    int type;
    var baseURL = values[2];
    var path = values[3];
    if (baseURL == "") {
      type = SourceIntMap.invalid.val;
      path = "";
    } else if (baseURL == "demo") {
      type = SourceIntMap.demo.val;
      path = "";
    } else {
      if (RegExp(r"^https?://").hasMatch(baseURL)) {
        uriBuilder = _simpleParse;
      } else if (RegExp(r"^localhost(:[^@:]*|/)").hasMatch(baseURL)) {
        uriBuilder = Uri.http;
      } else {
        uriBuilder = Uri.https;
      }
      try {
        var promPath = "/api/v2/alerts";
        var response = await http.get(uriBuilder(baseURL, promPath));
        if (response.statusCode == 200) {
          type = SourceIntMap.prom.val;
          path = promPath;
        } else {
          type = SourceIntMap.nag.val;
        }
      } catch (e) {
        type = SourceIntMap.invalid.val;
        path = "";
      }
    }
    values[1] = type.toString();
    values[3] = path.toString();
    return values;
  }

  Uri _simpleParse(String base, String path) {
    return Uri.parse(base + path);
  }
}
