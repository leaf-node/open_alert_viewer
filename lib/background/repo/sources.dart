/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:io';

import '../../alerts/model/alerts.dart';
import '../../app/data_repository/settings_repository.dart';
import '../../app/data_source/network_fetch.dart';
import '../background.dart';
import '../data_source/alerts_nag.dart';
import '../data_source/alerts_null.dart';
import '../data_source/alerts_prom.dart';
import '../data_source/alerts_random.dart';
import '../../app/data_source/database.dart';

class SourcesRepo with NetworkFetch {
  SourcesRepo(
      {required LocalDatabase db,
      required SettingsRepo settings,
      required StreamController<IsolateMessage> outboundStream})
      : _db = db,
        _settings = settings,
        _outboundStream = outboundStream;

  final LocalDatabase _db;
  final SettingsRepo _settings;
  final StreamController<IsolateMessage> _outboundStream;

  List<AlertSource> get alertSources {
    List<AlertSource> sources = [];
    List<AlertSourceData> sourceDataArray = _db.listSources();
    AlertSource Function({required AlertSourceData sourceData}) alertSource;
    for (var sourceData in sourceDataArray) {
      var enumType =
          SourceTypes.values.singleWhere((e) => e.value == sourceData.type);
      switch (enumType) {
        case SourceTypes.nullType:
          alertSource = NullAlerts.new;
        case SourceTypes.autodetect:
          alertSource = NullAlerts.new;
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

  void addSource({required AlertSourceData sourceData}) {
    var result = _db.addSource(sourceData: sourceData);
    _sourcesChangeResult(_outboundStream, alertSources, (result >= 0));
  }

  void updateSource(
      {required AlertSourceData sourceData, bool? updateUIandRefresh}) {
    var result = _db.updateSource(sourceData: sourceData);
    if (updateUIandRefresh ?? false) {
      _sourcesChangeResult(_outboundStream, alertSources, result);
    }
  }

  void removeSource({required int id}) {
    _db.removeSource(id: id);
    _sourcesChangeResult(_outboundStream, alertSources, true);
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

  Future<AlertSourceData> getSourceTypeAndPath(
      {required AlertSourceData sourceData}) async {
    if ((sourceData.type == SourceTypes.demo.value ||
            sourceData.type == SourceTypes.autodetect.value) &&
        sourceData.baseURL == "demo") {
      sourceData.type = SourceTypes.demo.value;
      sourceData.path = "";
      sourceData.isValid = true;
      return sourceData;
    } else if (sourceData.type == SourceTypes.demo.value &&
        sourceData.baseURL != "demo") {
      sourceData.isValid = false;
      sourceData.errorMessage = "Invalid demo configuration";
      return sourceData;
    }
    if (sourceData.type == SourceTypes.prom.value ||
        sourceData.type == SourceTypes.autodetect.value) {
      try {
        var promBaseURL = sourceData.baseURL
            .replaceFirst(RegExp(r"(/#/alerts/?|/api/v2/alerts/?)$"), "");
        var promPath = "/api/v2/alerts";
        var response = await networkFetch(
            promBaseURL, promPath, sourceData.username, sourceData.password);
        if (response.statusCode == 200) {
          sourceData.type = SourceTypes.prom.value;
          sourceData.path = promPath;
          sourceData.baseURL = promBaseURL;
          sourceData.isValid = true;
          return sourceData;
        } else {
          sourceData.errorMessage =
              "${response.statusCode}: ${response.reasonPhrase ?? ""}";
        }
      } on SocketException catch (e) {
        sourceData.errorMessage = e.message;
      } catch (e) {
        // fall through
      }
      if (sourceData.type != SourceTypes.autodetect.value) {
        sourceData.isValid = false;
        return sourceData;
      }
    }
    sourceData.isValid = false;
    return sourceData;
  }

  static void _sourcesChangeResult(StreamController<IsolateMessage> stream,
      List<AlertSource> sources, bool success) {
    if (success) {
      stream.add(IsolateMessage(
          name: MessageName.sourcesChanged,
          sources: sources,
          destination: MessageDestination.alerts));
    } else {
      stream.add(IsolateMessage(
          name: MessageName.sourcesFailure,
          sources: sources,
          destination: MessageDestination.alerts));
    }
  }
}
