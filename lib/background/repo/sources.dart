/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
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
    List<AlertSourceData> sourcesData = _db.listSources();
    AlertSource Function({required AlertSourceData sourceData}) alertSource;
    for (var source in sourcesData) {
      int type;
      try {
        type = source.type;
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
          sourceData: AlertSourceData(
              id: source.id,
              type: source.type,
              name: source.name,
              baseURL: source.baseURL,
              path: source.path,
              username: source.username,
              password: source.password)));
    }
    return sources;
  }

  Future<int> addSource({required AlertSourceData sourceData}) async {
    sourceData = await _getSourceTypeAndPath(sourcesData: sourceData);
    return _db.addSource(sourceData: sourceData);
  }

  Future<bool> updateSource({required AlertSourceData sourceData}) async {
    sourceData = await _getSourceTypeAndPath(sourcesData: sourceData);
    return _db.updateSource(sourceData: sourceData);
  }

  void removeSource({required int id}) {
    _db.removeSource(id: id);
  }

  Future<AlertSourceData> _getSourceTypeAndPath(
      {required AlertSourceData sourcesData}) async {
    if (sourcesData.baseURL == "") {
      sourcesData.type = SourceIntMap.invalid.val;
      sourcesData.path = "";
    } else if (sourcesData.baseURL == "demo") {
      sourcesData.type = SourceIntMap.demo.val;
      sourcesData.path = "";
    } else {
      try {
        var promBaseURL = sourcesData.baseURL
            .replaceFirst(RegExp(r"(/#/alerts/?|/api/v2/alerts/?)$"), "");
        var promPath = "/api/v2/alerts";
        var response = await networkFetch(
            promBaseURL, promPath, sourcesData.username, sourcesData.password);
        if (response.statusCode == 200) {
          sourcesData.type = SourceIntMap.prom.val;
          sourcesData.path = promPath;
          sourcesData.baseURL = promBaseURL;
        } else {
          sourcesData.type = SourceIntMap.invalid.val;
        }
      } catch (e) {
        sourcesData.type = SourceIntMap.invalid.val;
        sourcesData.path = "";
      }
    }
    return sourcesData;
  }
}
