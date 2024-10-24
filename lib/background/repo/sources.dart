/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../alerts/model/alerts.dart';
import '../../app/data_repository/settings_repository.dart';
import '../../app/data_source/database.dart';
import '../../app/data_source/network_fetch.dart';
import '../../app/util/util.dart';
import '../background.dart';
import '../data_source/alerts_ici.dart';
import '../data_source/alerts_nag.dart';
import '../data_source/alerts_null.dart';
import '../data_source/alerts_prom.dart';
import '../data_source/alerts_random.dart';
import '../data_source/alerts_zab.dart';

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
        case SourceTypes.ici:
          alertSource = IciAlerts.new;
        case SourceTypes.zab:
          alertSource = ZabAlerts.new;
          break;
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

  Future<AlertSourceData> getSourceType(
      {required AlertSourceData sourceData}) async {
    if ((sourceData.type == SourceTypes.demo.value ||
            sourceData.type == SourceTypes.autodetect.value) &&
        sourceData.baseURL == "demo") {
      sourceData.type = SourceTypes.demo.value;
      sourceData.isValid = true;
      return sourceData;
    } else if (sourceData.type == SourceTypes.demo.value &&
        sourceData.baseURL != "demo") {
      sourceData.isValid = false;
      sourceData.errorMessage = "Invalid demo configuration";
      return sourceData;
    }
    bool success;
    AlertSourceData newSourceData;
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
        trimRegex: r"(/v1/objects/services/?)$",
        apiEndpoint: "/v1/objects/services",
        fallbackPort: 5665);
    if (success || sourceData.type == SourceTypes.ici.value) {
      return newSourceData;
    }
    (success, newSourceData) = await checkSource(
        sourceType: SourceTypes.zab,
        sourceData: sourceData,
        trimRegex: r"(/api_jsonrpc.php/?)$",
        apiEndpoint: "/api_jsonrpc.php");
    if (success || sourceData.type == SourceTypes.zab.value) {
      return newSourceData;
    }
    sourceData.isValid = false;
    if (sourceData.type == SourceTypes.autodetect.value) {
      sourceData.errorMessage = "Choose a specific account type";
    }
    return sourceData;
  }

  Future<(bool, AlertSourceData)> checkSource(
      {required SourceTypes sourceType,
      required AlertSourceData sourceData,
      required String trimRegex,
      required String apiEndpoint,
      int? fallbackPort}) async {
    sourceData = sourceData.copy();
    if (sourceData.type == sourceType.value ||
        sourceData.type == SourceTypes.autodetect.value) {
      try {
        if (fallbackPort != null &&
            !sourceData.baseURL
                .contains(RegExp("^(https?://)?[^:/]+:[0-9]+(/.*)?"))) {
          sourceData.baseURL = sourceData.baseURL.replaceAllMapped(
              RegExp(r"^((https?://)?[^:/]+)(/.*)?"), (match) {
            return "${match.group(1)}:$fallbackPort${match.group(3) ?? ""}";
          });
        }
        var trimmedBaseURL =
            sourceData.baseURL.replaceFirst(RegExp(trimRegex), "");
        var response = await networkFetch(trimmedBaseURL, sourceData.username,
            sourceData.password, apiEndpoint);
        if (response.statusCode == 200) {
          sourceData.type = sourceType.value;
          sourceData.baseURL = trimmedBaseURL;
          sourceData.isValid = true;
          return (true, sourceData);
        } else if (sourceType.value == SourceTypes.zab.value &&
            response.statusCode == 412) {
          final zabLoginQuery = '{"jsonrpc":"2.0","method":"user.login",'
              '"params":{"username":"${sourceData.username}",'
              '"password":"${sourceData.password}"},"id":1}';
          final zabResponse = await networkFetch(
              sourceData.baseURL,
              sourceData.username,
              sourceData.password,
              apiEndpoint,
              zabLoginQuery,
              true,
              {"Content-Type": "application/json-rpc"});
          if (zabResponse.statusCode != 200) {
            sourceData.errorMessage =
                "${zabResponse.statusCode}: ${zabResponse.reasonPhrase ?? ""}";
            sourceData.isValid = false;
            return (false, sourceData);
          }
          final replyMap = Util.mapConvert(json.decode(zabResponse.body));
          if (replyMap.keys.contains("error")) {
            sourceData.errorMessage = replyMap["error"]["data"];
            return (false, sourceData);
          } else {
            sourceData.accessToken = replyMap["result"];
            sourceData.type = sourceType.value;
            sourceData.baseURL = trimmedBaseURL;
            sourceData.isValid = true;
            return (true, sourceData);
          }
        } else {
          sourceData.errorMessage =
              "${response.statusCode}: ${response.reasonPhrase ?? ""}";
        }
      } on SocketException catch (e) {
        sourceData.errorMessage = e.message;
      } on HandshakeException catch (e) {
        sourceData.errorMessage = e.message;
      } on FormatException catch (e) {
        sourceData.errorMessage = e.message;
      } on ClientException catch (e) {
        sourceData.errorMessage = e.message;
      } catch (e) {
        // fall through
      }
    }
    sourceData.isValid = false;
    return (false, sourceData);
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
