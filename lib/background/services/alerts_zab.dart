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

enum StatusType { version, events6, events7 }

enum HostMonitored {
  monitored(0),
  unMonitored(1);

  const HostMonitored(this.value);
  final int value;
}

enum Severity {
  okay(-1, AlertType.okay),
  notClassified(0, AlertType.unknown),
  information(1, AlertType.okay),
  warning(2, AlertType.warning),
  average(3, AlertType.warning),
  high(4, AlertType.error),
  disaster(5, AlertType.error);

  const Severity(this.value, this.alertType);
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
    final queries = {
      StatusType.version: '''{
        "jsonrpc": "2.0",
        "method": "apiinfo.version",
        "params": [],
        "id": 1
      }''',
      StatusType.events6: '''{
        "jsonrpc": "2.0",
        "auth": "${sourceData.accessToken}",
        "method": "event.get",
        "params": {
          "output": ["name", "clock", "opdata",
            "severity", "suppressed", "acknowledged"],
          "selectHosts": ["name", "host"]
        },
        "id": 2
      }''',
      StatusType.events7: '''{
        "jsonrpc": "2.0",
        "method": "event.get",
        "params": {
          "output": ["name", "clock", "opdata",
            "severity", "suppressed", "acknowledged"],
          "selectHosts": ["name", "host"]
        },
        "id": 2
      }''',
    };
    List<Alert> newAlerts = [];
    for (StatusType key in queries.keys) {
      dynamic dataSet;
      List<Alert> errors;
      if (key == StatusType.version) {
        (dataSet, errors) = await fetchAndDecodeJSON(
          endpoint: endpoint,
          postBody: queries[key],
          authOverride: true,
          headers: {"Content-Type": "application/json-rpc"},
        );
        if (dataSet == null) {
          if (errors.isEmpty) {
            throw Exception("Missing version message after Zabbix error");
          } else {
            return errors;
          }
        }
        final data = ZabVersionData.fromJson(dataSet);
        baseVersion = int.parse(
          data.result?.substring(0, data.result?.indexOf('.')) ?? "0",
        );
      } else if ((key == StatusType.events6 && baseVersion == 6) ||
          (key == StatusType.events7 && (baseVersion ?? 0) >= 7)) {
        (dataSet, errors) = await fetchAndDecodeJSON(
          endpoint: endpoint,
          postBody: queries[key],
          authOverride: true,
          headers: {
            "Content-Type": "application/json-rpc",
            "Authorization": "Bearer ${sourceData.accessToken}",
          },
        );
        if (dataSet == null) {
          if (errors.isEmpty) {
            throw Exception("Missing alert message after Zabbix error");
          } else {
            return errors;
          }
        }
        final data = ZabAlertsData.fromJson(dataSet);
        if (data.error != null) {
          return errorFetchingAlerts(
            sourceData: sourceData,
            error: "${data.error?.message} - ${data.error?.data}",
            endpoint: endpoint,
          );
        }
        final dataList = data.result!;
        for (var entry in dataList) {
          newAlerts.add(alertHandler(entry));
        }
      }
    }
    return newAlerts;
  }

  Alert alertHandler(ZabAlertData alertData) {
    AlertType kind;
    final severity = int.parse(alertData.severity!);
    if (severity >= 4) {
      kind = AlertType.error;
    } else if (severity >= 2) {
      kind = AlertType.warning;
    } else if (severity >= 0) {
      kind = AlertType.okay;
    } else {
      kind = AlertType.unknown;
    }
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
