/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:io';

import '../../alerts/model/alerts.dart';
import '../../app/data_repository/settings_repository.dart';
import '../../app/data_source/network_fetch.dart';
import '../data_source/alerts_invalid.dart';
import '../data_source/alerts_nag.dart';
import '../data_source/alerts_prom.dart';
import '../data_source/alerts_random.dart';
import '../../app/data_source/database.dart';

class SourcesRepo with NetworkFetch {
  SourcesRepo({required LocalDatabase db, required SettingsRepo settings})
      : _db = db,
        _settings = settings;

  final LocalDatabase _db;
  final SettingsRepo _settings;

  List<AlertSource> get alertSources {
    List<AlertSource> sources = [];
    List<AlertSourceData> sourceDataArray = _db.listSources();
    AlertSource Function({required AlertSourceData sourceData}) alertSource;
    for (var sourceData in sourceDataArray) {
      var enumType =
          SourceTypes.values.singleWhere((e) => e.value == sourceData.type);
      switch (enumType) {
        case SourceTypes.invalid:
          alertSource = InvalidAlerts.new;
        case SourceTypes.autodetect:
          alertSource = InvalidAlerts.new;
        case SourceTypes.demo:
          alertSource = RandomAlerts.new;
        case SourceTypes.prom:
          alertSource = PromAlerts.new;
        case SourceTypes.nag:
          alertSource = NagAlerts.new;
      }
      sources.add(alertSource(sourceData: sourceData));
    }
    return sources;
  }

  Future<int> addSource({required AlertSourceData sourceData}) async {
    sourceData = await _getSourceTypeAndPath(sourcesData: sourceData);
    return _db.addSource(sourceData: sourceData);
  }

  Future<bool> updateSource(
      {required AlertSourceData sourceData, bool? reIntialize}) async {
    if (reIntialize ?? false) {
      sourceData = await _getSourceTypeAndPath(sourcesData: sourceData);
    }
    return _db.updateSource(sourceData: sourceData);
  }

  void removeSource({required int id}) {
    _db.removeSource(id: id);
  }

  void updateLastSeen() {
    _settings.lastSeen = _settings.lastFetched;
    for (var source in alertSources) {
      if (!source.sourceData.failing) {
        source.sourceData.lastSeen = _settings.lastFetched;
        updateSource(sourceData: source.sourceData);
      }
    }
  }

  Future<AlertSourceData> _getSourceTypeAndPath(
      {required AlertSourceData sourcesData}) async {
    if (sourcesData.type == SourceTypes.demo.value ||
        (sourcesData.type == SourceTypes.autodetect.value &&
            sourcesData.baseURL == "demo")) {
      sourcesData.type = SourceTypes.demo.value;
      sourcesData.path = "";
      return sourcesData;
    }
    if (sourcesData.type == SourceTypes.prom.value ||
        sourcesData.type == SourceTypes.autodetect.value) {
      try {
        var promBaseURL = sourcesData.baseURL
            .replaceFirst(RegExp(r"(/#/alerts/?|/api/v2/alerts/?)$"), "");
        var promPath = "/api/v2/alerts";
        var response = await networkFetch(
            promBaseURL, promPath, sourcesData.username, sourcesData.password);
        if (response.statusCode == 200) {
          sourcesData.type = SourceTypes.prom.value;
          sourcesData.path = promPath;
          sourcesData.baseURL = promBaseURL;
          return sourcesData;
        } else {
          sourcesData.errorMessage =
              "${response.statusCode}: ${response.reasonPhrase ?? ""}";
        }
      } on SocketException catch (e) {
        sourcesData.errorMessage = e.message;
      } catch (e) {
        // fall through
      }
      if (sourcesData.type == SourceTypes.prom.value) {
        sourcesData.type = SourceTypes.invalid.value;
        return sourcesData;
      }
    }
    sourcesData.type = SourceTypes.invalid.value;
    return sourcesData;
  }
}
