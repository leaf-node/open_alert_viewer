/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/alerts.dart';
import 'alerts.dart';

part 'alerts_zab.freezed.dart';
part 'alerts_zab.g.dart';

enum HostMonitored {
  monitored(0),
  unMonitored(1);

  const HostMonitored(this.value);
  final int value;
}

enum ZabSeverity {
  okay(-1, AlertType.okay),
  notClassified(0, AlertType.unknown),
  information(1, AlertType.okay),
  warning(2, AlertType.warning),
  average(3, AlertType.warning),
  high(4, AlertType.error),
  disaster(5, AlertType.error);

  const ZabSeverity(this.value, this.alertType);
  final int value;
  final AlertType alertType;
}

class ZabAlerts extends AlertSource {
  ZabAlerts({required super.sourceData})
    : epoch = DateTime.fromMillisecondsSinceEpoch(0),
      endpoint = "/api_jsonrpc.php";

  final DateTime epoch;
  final String endpoint;
  int? baseVersion;

  @override
  Future<List<Alert>> fetchAlerts() async {
    List<Alert>? errors = await _getVersion();
    if (errors?.isNotEmpty ?? false) {
      return errors!;
    }
    List<int>? events;
    (events, errors) = await _getProblems();
    if (errors?.isNotEmpty ?? false) {
      return errors!;
    }
    return _getAlerts(events!);
  }

  Future<List<Alert>?> _getVersion() async {
    final query = '''{
        "jsonrpc": "2.0",
        "method": "apiinfo.version",
        "params": [],
        "id": 1
      }''';
    dynamic dataSet;
    List<Alert> errors;
    (dataSet, errors) = await fetchAndDecodeJSON(
      endpoint: endpoint,
      postBody: query,
      authOverride: true,
      headers: {"Content-Type": "application/json-rpc"},
    );
    if (errors.isNotEmpty) {
      return errors;
    }
    final data = ZabVersionData.fromJson(dataSet);
    baseVersion = int.parse(
      data.result?.substring(0, data.result?.indexOf('.')) ?? "0",
    );
    return [];
  }

  Future<(List<int>?, List<Alert>?)> _getProblems() async {
    final query = '''{
      "jsonrpc": "2.0",
      ${(baseVersion! < 7) ? "\"auth\": \"${sourceData.accessToken}\"," : ""}
      "method": "problem.get",
      "params": {
          "output": ["eventid"]
      },
      "id": 2
    }''';
    dynamic dataSet;
    List<Alert> errors;
    (dataSet, errors) = await fetchAndDecodeJSON(
      endpoint: endpoint,
      postBody: query,
      authOverride: true,
      headers: {
        "Content-Type": "application/json-rpc",
        "Authorization": "Bearer ${sourceData.accessToken}",
      },
    );
    if (errors.isNotEmpty) {
      return (null, errors);
    }
    final data = ZabProblemsData.fromJson(dataSet);
    if (data.error != null) {
      return (
        null,
        errorFetchingAlerts(
          sourceData: sourceData,
          error: "${data.error?.message} - ${data.error?.data}",
          endpoint: endpoint,
        ),
      );
    }
    List<int> problemEvents = [];
    for (var entry in data.result!) {
      if (entry.eventid != null) {
        problemEvents.add(int.parse(entry.eventid!));
      }
    }
    return (problemEvents, null);
  }

  Future<List<Alert>> _getAlerts(List<int> eventIDs) async {
    final query = '''{
      "jsonrpc": "2.0",
      ${(baseVersion! < 7) ? "\"auth\": \"${sourceData.accessToken}\"," : ""}
      "method": "event.get",
      "params": {
        "eventids": $eventIDs,
        "output": ["name", "clock", "opdata",
          "severity", "suppressed", "acknowledged"],
        "selectHosts": ["name", "host"]
      },
      "id": 3
    }''';
    dynamic dataSet;
    List<Alert> errors;
    List<Alert> newAlerts = [];
    (dataSet, errors) = await fetchAndDecodeJSON(
      endpoint: endpoint,
      postBody: query,
      authOverride: true,
      headers: {
        "Content-Type": "application/json-rpc",
        "Authorization": "Bearer ${sourceData.accessToken}",
      },
    );
    if (errors.isNotEmpty) {
      return errors;
    }
    final data = ZabAlertsData.fromJson(dataSet);
    if (data.error != null) {
      return errorFetchingAlerts(
        sourceData: sourceData,
        error: "${data.error?.message} - ${data.error?.data}",
        endpoint: endpoint,
      );
    }
    for (var entry in data.result!) {
      newAlerts.add(alertHandler(entry));
    }
    return newAlerts;
  }

  Alert alertHandler(ZabAlertData alertData) {
    final severity = int.parse(alertData.severity!);
    AlertType kind =
        ZabSeverity.values
            .where((e) => e.value == severity)
            .firstOrNull
            ?.alertType ??
        AlertType.unknown;
    ZabHostsData? host = alertData.hosts?.firstOrNull;
    String hostDomain = host?.host ?? host?.name ?? "";
    String hostName = host?.name ?? host?.host ?? "";
    String? opData = (alertData.opdata == "") ? "..." : alertData.opdata;
    return Alert(
      source: sourceData.id!,
      kind: kind,
      hostname: hostName,
      service: alertData.name!,
      message: opData ?? "...",
      serviceUrl: generateURL(hostDomain, ""),
      monitorUrl: generateURL(sourceData.baseURL, ""),
      age: DateTime.now().difference(_dateTime(alertData.clock!)),
      silenced: (alertData.acknowledged == "0") ? false : true,
      downtimeScheduled: (alertData.suppressed == "0") ? false : true,
      active: true,
    );
  }

  static DateTime _dateTime(String seconds) {
    return DateTime.fromMillisecondsSinceEpoch(
      (int.parse(seconds) * 1000).floor(),
    );
  }
}

@freezed
abstract class ZabAlertsData with _$ZabAlertsData {
  const factory ZabAlertsData({
    List<ZabAlertData>? result,
    ZabErrorData? error,
  }) = _ZabAlertsData;

  factory ZabAlertsData.fromJson(Map<String, dynamic> json) =>
      _$ZabAlertsDataFromJson(json);
}

@freezed
abstract class ZabAlertData with _$ZabAlertData {
  const factory ZabAlertData({
    String? name,
    String? clock,
    String? opdata,
    String? severity,
    String? suppressed,
    String? acknowledged,
    List<ZabHostsData>? hosts,
  }) = _ZabAlertData;

  factory ZabAlertData.fromJson(Map<String, dynamic> json) =>
      _$ZabAlertDataFromJson(json);
}

@freezed
abstract class ZabHostsData with _$ZabHostsData {
  const factory ZabHostsData({String? host, String? name}) = _ZabHostsData;

  factory ZabHostsData.fromJson(Map<String, dynamic> json) =>
      _$ZabHostsDataFromJson(json);
}

@freezed
abstract class ZabErrorData with _$ZabErrorData {
  const factory ZabErrorData({String? message, String? data}) = _ZabErrorData;

  factory ZabErrorData.fromJson(Map<String, dynamic> json) =>
      _$ZabErrorDataFromJson(json);
}

@freezed
abstract class ZabVersionData with _$ZabVersionData {
  const factory ZabVersionData({String? result}) = _ZabVersionData;

  factory ZabVersionData.fromJson(Map<String, dynamic> json) =>
      _$ZabVersionDataFromJson(json);
}

@freezed
abstract class ZabProblemsData with _$ZabProblemsData {
  const factory ZabProblemsData({
    List<ZabProblemData>? result,
    ZabErrorData? error,
  }) = _ZabProblemsData;

  factory ZabProblemsData.fromJson(Map<String, dynamic> json) =>
      _$ZabProblemsDataFromJson(json);
}

@freezed
abstract class ZabProblemData with _$ZabProblemData {
  const factory ZabProblemData({String? eventid}) = _ZabProblemData;

  factory ZabProblemData.fromJson(Map<String, dynamic> json) =>
      _$ZabProblemDataFromJson(json);
}
