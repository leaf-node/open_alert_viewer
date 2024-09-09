/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../alerts/model/alerts.dart';
import '../../app/data_source/network_fetch.dart';
import '../data_source/alerts_invalid.dart';
import '../data_source/alerts_nag.dart';
import '../data_source/alerts_prom.dart';
import '../data_source/alerts_random.dart';
import '../../app/data_source/database.dart';

enum SourceIntMap {
  invalid(-1),
  demo(0),
  nag(1),
  prom(2);

  const SourceIntMap(this.val);
  final int val;
}

class SourcesRepo with NetworkFetch {
  SourcesRepo({required LocalDatabase db}) : _db = db;

  final LocalDatabase _db;

  List<AlertSource> get alertSources {
    List<AlertSource> sources = [];
    List<Map<String, Object>> sourcesData = _db.listSources();
    Function alertSource;
    for (var source in sourcesData) {
      int type;
      try {
        type = source["type"] as int;
      } catch (e) {
        type = -1;
      }
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
          id: source["id"],
          type: type,
          name: source["name"],
          baseURL: source["base_url"],
          path: source["path"],
          username: source["username"],
          password: source["password"]));
    }
    return sources;
  }

  Future<int> addSource({required Map<String, Object> source}) async {
    source = await _getSourceTypeAndPath(source: source);
    return _db.addSource(source: source);
  }

  Future<bool> updateSource({required Map<String, Object> source}) async {
    source = await _getSourceTypeAndPath(source: source);
    return _db.updateSource(source: source);
  }

  void removeSource({required int id}) {
    _db.removeSource(id: id);
  }

  Future<Map<String, Object>> _getSourceTypeAndPath(
      {required Map<String, Object> source}) async {
    int type;
    var path = source["path"] as String;
    var baseURL = source["base_url"] as String;
    if (baseURL == "") {
      type = SourceIntMap.invalid.val;
      path = "";
    } else if (baseURL == "demo") {
      type = SourceIntMap.demo.val;
      path = "";
    } else {
      try {
        var promBaseURL = baseURL.replaceFirst(
            RegExp(r"(/#/alerts/?|/api/v2/alerts/?)$"), "");
        var promPath = "/api/v2/alerts";
        var response = await networkFetch(promBaseURL, promPath,
            source["username"] as String, source["password"] as String);
        if (response.statusCode == 200) {
          type = SourceIntMap.prom.val;
          path = promPath;
          baseURL = promBaseURL;
        } else {
          type = SourceIntMap.invalid.val;
        }
      } catch (e) {
        type = SourceIntMap.invalid.val;
        path = "";
      }
    }
    source["type"] = type;
    source["base_url"] = baseURL;
    source["path"] = path;
    return source;
  }
}
