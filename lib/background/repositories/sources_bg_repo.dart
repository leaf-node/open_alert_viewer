/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../domain/alerts.dart';
import '../../data/repositories/settings_repo.dart';
import '../../data/services/database.dart';
import '../../data/services/network_fetch.dart';
import '../../utils/utils.dart';
import '../domain/background_shared.dart';
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
        _outboundStream = outboundStream {
    initSources();
  }

  final LocalDatabase _db;
  final SettingsRepo _settings;
  final StreamController<IsolateMessage> _outboundStream;
  final DateTime epoch = DateTime.fromMillisecondsSinceEpoch(0);

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
      case SourceTypes.zab:
        alertSource = NullAlerts.new;
    }
    return alertSource(sourceData: sourceData);
  }

  void initSources() {
    _outboundStream.add(IsolateMessage(
        name: MessageName.initSources,
        destination: MessageDestination.sourceSettings));
  }

  AlertSourceData? getSource(id) {
    final matches = _db.listSources().where((e) => e.id == id);
    if (matches.isEmpty) {
      return null;
    } else {
      return matches.first;
    }
  }

  void addSource({required AlertSourceDataUpdate sourceData}) {
    final newSource = AlertSourceData(
        id: sourceData.id,
        name: sourceData.name,
        type: sourceData.type,
        authType: sourceData.authType,
        baseURL: sourceData.baseURL,
        username: sourceData.username,
        password: sourceData.password,
        failing: false,
        lastSeen: epoch,
        priorFetch: epoch,
        lastFetch: epoch,
        errorMessage: "",
        accessToken: sourceData.accessToken,
        visible: true,
        notifications: true);
    var result = _db.addSource(sourceData: newSource);
    _sourcesChangeResult(_outboundStream, alertSources, (result >= 0));
  }

  void updateSource(
      {required AlertSourceDataUpdate sourceData, bool? updateUIandRefresh}) {
    final updatedSource = getSource(sourceData.id)?.copyWith(
      id: sourceData.id,
      name: sourceData.name,
      type: sourceData.type,
      authType: sourceData.authType,
      baseURL: sourceData.baseURL,
      username: sourceData.username,
      password: sourceData.password,
      accessToken: sourceData.accessToken,
    );
    if (updatedSource != null) {
      final result = _updateSource(sourceData: updatedSource);
      if (updateUIandRefresh ?? false) {
        _sourcesChangeResult(_outboundStream, alertSources, result);
      }
    }
  }

  // should only be run right after `sourceData = getSource(sourceData.id)`
  bool _updateSource({required AlertSourceData sourceData}) {
    return _db.updateSource(sourceData: sourceData);
  }

  void removeSource({required int id}) {
    _db.removeSource(id: id);
    _sourcesChangeResult(_outboundStream, alertSources, true);
  }

  void setFailingStatus({required int id, required bool failing}) {
    final sourceData = getSource(id)?.copyWith(failing: true);
    if (sourceData != null) {
      _updateSource(sourceData: sourceData);
    }
  }

  void setLastAndPriorFetch({required int id, required DateTime lastFetch}) {
    AlertSourceData? sourceData = getSource(id);
    sourceData = sourceData?.copyWith(
        priorFetch: sourceData.lastFetch, lastFetch: lastFetch);
    if (sourceData != null) {
      _updateSource(sourceData: sourceData);
    }
  }

  void updateLastSeen() {
    _settings.lastSeen = _settings.lastFetched;
    for (var source in alertSources) {
      if (!source.failing) {
        var sourceData = source.copyWith(lastSeen: _settings.lastFetched);
        _updateSource(sourceData: sourceData);
      }
    }
  }

  Future<void> confirmSource(IsolateMessage message) async {
    var result = await _getConfirmedType(sourceData: message.sourceData!);
    _outboundStream.add(IsolateMessage(
        name: MessageName.confirmSourcesReply,
        destination: MessageDestination.accountEditing,
        sourceData: result));
  }

  Future<AlertSourceDataUpdate> _getConfirmedType(
      {required AlertSourceDataUpdate sourceData}) async {
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
    AlertSourceDataUpdate newSourceData;
    AlertSourceDataUpdate prevNewSourceData;
    sourceData = sourceData.copyWith(
        baseURL: sourceData.baseURL.replaceAll(RegExp(r"[?&].*$"), ""));
    (success, newSourceData) = await checkSource(
        sourceType: SourceTypes.prom,
        sourceData: sourceData,
        trimRegex: r"(/#/alerts/?|/api/v2/alerts/?)$",
        apiEndpoint: "/api/v2/alerts");
    if (!success && sourceData.type == SourceTypes.prom.value) {
      newSourceData = newSourceData.copyWith(
          errorMessage: "${newSourceData.errorMessage}\n\n"
              "FYI: Alertmanager may be on another port or "
              "base URL than Prometheus.");
    }
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
    (success, newSourceData) = await checkSource(
        sourceType: SourceTypes.zab,
        sourceData: sourceData,
        trimRegex: r"(/api_jsonrpc.php/?)$",
        apiEndpoint: "/api_jsonrpc.php");
    if (success || sourceData.type == SourceTypes.zab.value) {
      return newSourceData;
    }
    sourceData = sourceData.copyWith(isValid: false);
    if (sourceData.type == SourceTypes.autodetect.value) {
      sourceData =
          sourceData.copyWith(errorMessage: "Choose account type for details");
    }
    return sourceData;
  }

  Future<(bool, AlertSourceDataUpdate)> checkSource(
      {required SourceTypes sourceType,
      required AlertSourceDataUpdate sourceData,
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
        } else if (response.statusCode == 412 &&
            sourceType.value == SourceTypes.zab.value) {
          final zabLoginQuery = '{"jsonrpc":"2.0","method":"user.login",'
              '"params":{"username":"${sourceData.username}",'
              '"password":"${sourceData.password}"},"id":1}';
          final zabResponse = await networkFetch(sourceData.baseURL,
              sourceData.username, sourceData.password, apiEndpoint,
              postBody: zabLoginQuery,
              authOverride: true,
              headers: {"Content-Type": "application/json-rpc"});
          if (zabResponse.statusCode != 200) {
            sourceData = sourceData.copyWith(
                errorMessage:
                    "${zabResponse.statusCode}: ${zabResponse.reasonPhrase ?? ""}",
                isValid: false);
            return (false, sourceData);
          }
          final replyMap = Util.mapConvert(json.decode(zabResponse.body));
          if (replyMap.keys.contains("error")) {
            sourceData = sourceData.copyWith(
                errorMessage: replyMap["error"]["data"], isValid: false);
            return (false, sourceData);
          } else {
            sourceData = sourceData.copyWith(
                accessToken: replyMap["result"],
                type: sourceType.value,
                baseURL: trimmedBaseURL,
                isValid: true);
            return (true, sourceData);
          }
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
          destination: MessageDestination.sourceSettings));
    } else {
      stream.add(IsolateMessage(
          name: MessageName.sourcesFailure,
          destination: MessageDestination.sourceSettings));
    }
  }
}
