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

enum ZabSeverity {
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
    if (sourceData.authType != AuthTypes.zabDefault.value) {
      return errorFetchingAlerts(
        sourceData: sourceData,
        error:
            "Outdated Zabbix account configuration... "
            "Please re-confirm and save the alert source.",
        endpoint: endpoint,
      );
    }
    List<Alert>? errors = await _getVersion();
    if (errors?.isNotEmpty ?? false) {
      return errors!;
    }
    List<ZabProblemData>? problemsData;
    (problemsData, errors) = await _getProblems();
    if (errors?.isNotEmpty ?? false) {
      return errors!;
    }
    List<ZabEventData>? eventsData;
    (eventsData, errors) = await _getEvents(problemsData!);
    if (errors?.isNotEmpty ?? false) {
      return errors!;
    }
    List<ZabTriggerData>? triggersData;
    (triggersData, errors) = await _getTriggers(eventsData!);
    if (errors?.isNotEmpty ?? false) {
      return errors!;
    }
    return _alertHandler(eventsData, triggersData!);
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

  Future<(List<ZabProblemData>?, List<Alert>?)> _getProblems() async {
    final query = '''{
      "jsonrpc": "2.0",
      ${(baseVersion! < 7) ? "\"auth\": \"${sourceData.accessToken}\"," : ""}
      "method": "problem.get",
      "params": {
          "output": ["objectid", "eventid"]
      },
      "id": 2
    }''';
    dynamic dataSet;
    List<Alert> errors;
    (dataSet, errors) = await _fetchData(query);
    if (errors.isNotEmpty) {
      return (null, errors);
    }
    final data = ZabProblemsData.fromJson(dataSet);
    errors = _checkForError(data.error);
    if (errors.isNotEmpty) {
      return (null, errors);
    }
    return (data.result!, null);
  }

  Future<(List<ZabEventData>?, List<Alert>?)> _getEvents(
    List<ZabProblemData> problemsData,
  ) async {
    final eventIDs = problemsData.map((e) => e.eventid).toList();
    final query = '''{
      "jsonrpc": "2.0",
      ${(baseVersion! < 7) ? "\"auth\": \"${sourceData.accessToken}\"," : ""}
      "method": "event.get",
      "params": {
        "eventids": $eventIDs,
        "output": ["name", "clock", "opdata",
          "severity", "suppressed", "acknowledged", "objectid"],
        "selectHosts": ["name", "host", "status"]
      },
      "id": 3
    }''';
    dynamic dataSet;
    List<Alert> errors;
    (dataSet, errors) = await _fetchData(query);
    if (errors.isNotEmpty) {
      return (null, errors);
    }
    final data = ZabEventsData.fromJson(dataSet);
    errors = _checkForError(data.error);
    if (errors.isNotEmpty) {
      return (null, errors);
    }
    return (data.result!, null);
  }

  Future<(List<ZabTriggerData>?, List<Alert>?)> _getTriggers(
    List<ZabEventData> eventsData,
  ) async {
    final triggerIDs = eventsData.map((e) => e.objectid).toList();
    final query = '''{
      "jsonrpc": "2.0",
      ${(baseVersion! < 7) ? "\"auth\": \"${sourceData.accessToken}\"," : ""}
      "method": "trigger.get",
      "params": {
          "triggerids": $triggerIDs,
          "output": ["triggerid", "status"]
      },
      "id": 4
    }''';
    dynamic dataSet;
    List<Alert> errors;
    (dataSet, errors) = await _fetchData(query);
    if (errors.isNotEmpty) {
      return (null, errors);
    }
    final data = ZabTriggersData.fromJson(dataSet);
    errors = _checkForError(data.error);
    if (errors.isNotEmpty) {
      return (null, errors);
    }
    return (data.result!, null);
  }

  List<Alert> _alertHandler(
    List<ZabEventData> eventsData,
    List<ZabTriggerData> triggersData,
  ) {
    List<Alert> newAlerts = [];
    for (final event in eventsData) {
      final severity = int.parse(event.severity!);
      AlertType kind =
          ZabSeverity.values
              .where((e) => e.value == severity)
              .firstOrNull
              ?.alertType ??
          AlertType.unknown;
      final triggerEnabled = switch (triggersData
          .where((e) => e.triggerid == event.objectid)
          .firstOrNull
          ?.status) {
        "0" => true,
        "1" => false,
        _ => true,
      };
      ZabHostData host;
      for (host in event.hosts ?? []) {
        String hostDomain = host.host ?? host.name ?? "";
        String hostName = host.name ?? host.host ?? "";
        String? opData = (event.opdata == "") ? "..." : event.opdata;
        final hostEnabled = switch (host.status) {
          "0" => true,
          "1" => false,
          _ => true,
        };
        newAlerts.add(
          Alert(
            source: sourceData.id!,
            kind: kind,
            hostname: hostName,
            service: event.name!,
            message: opData ?? "...",
            serviceUrl: generateURL(hostDomain, ""),
            monitorUrl: generateURL(sourceData.baseURL, ""),
            age: DateTime.now().difference(_dateTime(event.clock!)),
            silenced: (event.acknowledged == "0") ? false : true,
            downtimeScheduled: (event.suppressed == "0") ? false : true,
            active: true,
            enabled: triggerEnabled && hostEnabled,
          ),
        );
      }
    }
    return newAlerts;
  }

  static DateTime _dateTime(String seconds) {
    return DateTime.fromMillisecondsSinceEpoch(
      (int.parse(seconds) * 1000).floor(),
    );
  }

  Future<(Object?, List<Alert>)> _fetchData<T>(String query) async {
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
    return (dataSet, <Alert>[]);
  }

  List<Alert> _checkForError<T>(ZabErrorData? error) {
    if (error != null) {
      return errorFetchingAlerts(
        sourceData: sourceData,
        error: "${error.message} - ${error.data}",
        endpoint: endpoint,
      );
    }
    return <Alert>[];
  }
}

@freezed
abstract class ZabEventsData with _$ZabEventsData {
  const factory ZabEventsData({
    List<ZabEventData>? result,
    ZabErrorData? error,
  }) = _ZabEventsData;

  factory ZabEventsData.fromJson(Map<String, dynamic> json) =>
      _$ZabEventsDataFromJson(json);
}

@freezed
abstract class ZabEventData with _$ZabEventData {
  const factory ZabEventData({
    String? name,
    String? clock,
    String? opdata,
    String? severity,
    String? objectid,
    String? suppressed,
    String? acknowledged,
    List<ZabHostData>? hosts,
  }) = _ZabEventData;

  factory ZabEventData.fromJson(Map<String, dynamic> json) =>
      _$ZabEventDataFromJson(json);
}

@freezed
abstract class ZabHostData with _$ZabHostData {
  const factory ZabHostData({String? host, String? name, String? status}) =
      _ZabHostData;

  factory ZabHostData.fromJson(Map<String, dynamic> json) =>
      _$ZabHostDataFromJson(json);
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
  const factory ZabProblemData({String? eventid, String? objectid}) =
      _ZabProblemData;

  factory ZabProblemData.fromJson(Map<String, dynamic> json) =>
      _$ZabProblemDataFromJson(json);
}

@freezed
abstract class ZabTriggersData with _$ZabTriggersData {
  const factory ZabTriggersData({
    List<ZabTriggerData>? result,
    ZabErrorData? error,
  }) = _ZabTriggersData;

  factory ZabTriggersData.fromJson(Map<String, dynamic> json) =>
      _$ZabTriggersDataFromJson(json);
}

@freezed
abstract class ZabTriggerData with _$ZabTriggerData {
  const factory ZabTriggerData({String? triggerid, String? status}) =
      _ZabTriggerData;

  factory ZabTriggerData.fromJson(Map<String, dynamic> json) =>
      _$ZabTriggerDataFromJson(json);
}
