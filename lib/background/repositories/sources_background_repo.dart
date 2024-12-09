/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:io';

import 'package:http/http.dart';

import '../../domain/alerts.dart';
import '../../data/repositories/settings_repository.dart';
import '../../data/services/database.dart';
import '../../data/services/network_fetch.dart';
import '../background.dart';
import '../services/alerts.dart';
import '../services/alerts_ici.dart';
import '../services/alerts_nag.dart';
import '../services/alerts_null.dart';
import '../services/alerts_prom.dart';
import '../services/alerts_random.dart';

class SourcesBackgroundRepo with NetworkFetch {
  SourcesBackgroundRepo(
      {required LocalDatabase db,
      required SettingsRepo settings,
      required StreamController<IsolateMessage> outboundStream})
      : _db = db,
        _settings = settings,
        _outboundStream = outboundStream;

  final LocalDatabase _db;
  final SettingsRepo _settings;
  final StreamController<IsolateMessage> _outboundStream;

  List<AlertSourceData> get alertSources => _db.listSources();

  AlertSource getClassedSource(AlertSourceData sourceData) {
    AlertSource Function({required AlertSourceData sourceData}) alertSource;
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
      case SourceTypes.ici:
        alertSource = IciAlerts.new;
    }
    return alertSource(sourceData: sourceData);
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
      if (!source.failing) {
        var sourceData = source.copyWith(lastSeen: _settings.lastFetched);
        updateSource(sourceData: sourceData);
      }
    }
  }

  Future<void> confirmSource(IsolateMessage message) async {
    var result = await _getSourceType(sourceData: message.sourceData!);
    _outboundStream.add(IsolateMessage(
        name: MessageName.confirmSourcesReply,
        destination: MessageDestination.accountSettings,
        sourceData: result));
  }

  Future<AlertSourceData> _getSourceType(
      {required AlertSourceData sourceData}) async {
    if ((sourceData.type == SourceTypes.demo.value ||
            sourceData.type == SourceTypes.autodetect.value) &&
        sourceData.baseURL == "demo") {
      sourceData =
          sourceData.copyWith(type: SourceTypes.demo.value, isValid: true);
      return sourceData;
    } else if (sourceData.type == SourceTypes.demo.value &&
        sourceData.baseURL != "demo") {
      sourceData = sourceData.copyWith(
          isValid: false, errorMessage: "Invalid demo configuration");
      return sourceData;
    }
    bool success;
    AlertSourceData newSourceData;
    AlertSourceData prevNewSourceData;
    sourceData = sourceData.copyWith(
        baseURL: sourceData.baseURL.replaceAll(RegExp(r"[?&].*$"), ""));
    (success, newSourceData) = await checkSource(
        sourceType: SourceTypes.prom,
        sourceData: sourceData,
        trimRegex: r"(/#/alerts/?|/api/v2/alerts/?)$",
        apiEndpoint: "/api/v2/alerts");
    if (success || sourceData.type == SourceTypes.prom.value) {
      return newSourceData;
    }
    (success, newSourceData) = await checkSource(
        sourceType: SourceTypes.nag,
        sourceData: sourceData,
        trimRegex: r"(/cgi-bin/statusjson.cgi/?)$",
        apiEndpoint: "/cgi-bin/statusjson.cgi");
    if (success || sourceData.type == SourceTypes.nag.value) {
      return newSourceData;
    }
    (success, newSourceData) = await checkSource(
        sourceType: SourceTypes.ici,
        sourceData: sourceData,
        trimRegex: r"(/+(v1/objects/services/?)?)$",
        apiEndpoint: "/v1/objects/services");
    if (success) {
      return newSourceData;
    } else {
      prevNewSourceData = newSourceData;
    }
    (success, newSourceData) = await checkSource(
        sourceType: SourceTypes.ici,
        sourceData: sourceData,
        trimRegex: r"(/+(v1/objects/services/?)?)$",
        apiEndpoint: "/v1/objects/services",
        fallbackPort: 5665);
    if (success) {
      return newSourceData;
    } else if (sourceData.type == SourceTypes.ici.value) {
      return prevNewSourceData;
    }
    sourceData = sourceData.copyWith(isValid: false);
    if (sourceData.type == SourceTypes.autodetect.value) {
      sourceData =
          sourceData.copyWith(errorMessage: "Choose account type for details");
    }
    return sourceData;
  }

  Future<(bool, AlertSourceData)> checkSource(
      {required SourceTypes sourceType,
      required AlertSourceData sourceData,
      required String trimRegex,
      required String apiEndpoint,
      int? fallbackPort}) async {
    if (sourceData.type == sourceType.value ||
        sourceData.type == SourceTypes.autodetect.value) {
      try {
        if (fallbackPort != null &&
            !sourceData.baseURL
                .contains(RegExp("^(https?://)?[^:/]+:[0-9]+(/.*)?"))) {
          sourceData = sourceData.copyWith(
              baseURL: sourceData.baseURL.replaceAllMapped(
                  RegExp(r"^((https?://)?[^:/]+)(/.*)?"), (match) {
            return "${match.group(1)}:$fallbackPort${match.group(3) ?? ""}";
          }));
        }
        var trimmedBaseURL =
            sourceData.baseURL.replaceFirst(RegExp(trimRegex), "");
        var response = await networkFetch(trimmedBaseURL, sourceData.username,
            sourceData.password, apiEndpoint,
            maxTimeout: 5);
        if (response.statusCode == 200) {
          sourceData = sourceData.copyWith(
              type: sourceType.value, baseURL: trimmedBaseURL, isValid: true);
          return (true, sourceData);
        } else {
          sourceData = sourceData.copyWith(
              errorMessage:
                  "${response.statusCode}: ${response.reasonPhrase ?? ""}");
        }
      } on SocketException catch (e) {
        sourceData = sourceData.copyWith(errorMessage: e.message);
      } on HandshakeException catch (e) {
        sourceData = sourceData.copyWith(errorMessage: e.message);
      } on FormatException catch (e) {
        sourceData = sourceData.copyWith(errorMessage: e.message);
      } on ClientException catch (e) {
        sourceData = sourceData.copyWith(errorMessage: e.message);
      } catch (e) {
        // fall through
      }
    }
    sourceData = sourceData.copyWith(isValid: false);
    return (false, sourceData);
  }

  static void _sourcesChangeResult(StreamController<IsolateMessage> stream,
      List<AlertSourceData> sources, bool success) {
    if (success) {
      stream.add(IsolateMessage(
          name: MessageName.sourcesChanged,
          allSources: sources,
          destination: MessageDestination.alerts));
    } else {
      stream.add(IsolateMessage(
          name: MessageName.sourcesFailure,
          allSources: sources,
          destination: MessageDestination.alerts));
    }
  }
}
