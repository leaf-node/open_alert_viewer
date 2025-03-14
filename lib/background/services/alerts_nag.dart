/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/alerts.dart';
import '../../utils/utils.dart';
import 'alerts.dart';

part 'alerts_nag.freezed.dart';
part 'alerts_nag.g.dart';

enum StatusType { hostStatus, serviceStatus }

enum HostStatus {
  pending(1, AlertType.hostPending),
  up(2, AlertType.up),
  down(4, AlertType.down),
  unreachable(8, AlertType.unreachable),
  unknown(-1, AlertType.unknown); // not upstream

  const HostStatus(this.value, this.alertType);
  final int value;
  final AlertType alertType;
}

enum ServiceStatus {
  pending(1, AlertType.pending),
  okay(2, AlertType.okay),
  warning(4, AlertType.warning),
  unknown(8, AlertType.unknown),
  critical(16, AlertType.error);

  const ServiceStatus(this.value, this.alertType);
  final int value;
  final AlertType alertType;
}

class NagAlerts extends AlertSource {
  NagAlerts({required super.sourceData})
    : epoch = DateTime.fromMillisecondsSinceEpoch(0),
      apiPath = "/cgi-bin/statusjson.cgi" {
    endpoints = {
      StatusType.hostStatus: "$apiPath?query=hostlist&details=true",
      StatusType.serviceStatus: "$apiPath?query=servicelist&details=true",
    };
  }

  final String apiPath;
  late Map<StatusType, String> endpoints;
  final DateTime epoch;

  @override
  Future<List<Alert>> fetchAlerts() async {
    List<Alert> newAlerts = [];
    for (StatusType key in endpoints.keys) {
      dynamic dataSet;
      List<Alert> errors;
      (dataSet, errors) = await fetchAndDecodeJSON(endpoint: endpoints[key]!);
      if (dataSet == null) {
        if (errors.isEmpty) {
          throw Exception("Missing alert message after Nagios fetch error");
        } else {
          return errors;
        }
      }
      final data = NagAlertsData.fromJson(dataSet).data!;
      if (key == StatusType.hostStatus) {
        final hostMap = data.hostlist!;
        for (final host in hostMap.keys) {
          final entry = hostMap[host]!;
          newAlerts.add(alertHandler(entry, false, host));
        }
      } else if (key == StatusType.serviceStatus) {
        final hostServiceMap = data.servicelist!;
        for (final host in hostServiceMap.keys) {
          final hostServiceData = hostServiceMap[host]!;
          for (final service in hostServiceData.keys) {
            final entry = hostServiceData[service]!;
            newAlerts.add(alertHandler(entry, true, host));
          }
        }
      }
    }
    return newAlerts;
  }

  Alert alertHandler(NagAlertData alertDatum, bool isService, String host) {
    AlertType kind;
    if (isService) {
      kind =
          ServiceStatus.values
              .singleWhere(
                (v) => v.value == alertDatum.status,
                orElse: () => ServiceStatus.unknown,
              )
              .alertType;
    } else {
      kind =
          HostStatus.values
              .singleWhere(
                (v) => v.value == alertDatum.status,
                orElse: () => HostStatus.unknown,
              )
              .alertType;
    }
    Duration age;
    bool active;
    DateTime startsAt;
    if (kind == ServiceStatus.pending.alertType ||
        kind == HostStatus.pending.alertType) {
      age = Duration.zero;
      active = true;
    } else {
      if (alertDatum.state_type == 1) {
        startsAt = _dateTime(alertDatum.last_hard_state_change ?? 0);
        active = true;
      } else {
        startsAt = _dateTime(alertDatum.last_state_change ?? 0);
        active = false;
      }
      age =
          (startsAt.difference(epoch) == Duration.zero)
              ? (alertDatum.last_check == null)
                  ? Duration.zero
                  : DateTime.now().difference(_dateTime(alertDatum.last_check!))
              : DateTime.now().difference(startsAt);
    }
    return Alert(
      source: sourceData.id!,
      kind: kind,
      hostname: host,
      service: alertDatum.description ?? "Unknown",
      message: alertDatum.plugin_output ?? "...",
      serviceUrl: generateURL(host, ""),
      monitorUrl: generateURL(sourceData.baseURL, ""),
      age: age,
      silenced: alertDatum.problem_has_been_acknowledged ?? false,
      downtimeScheduled: Util.toBool(alertDatum.scheduled_downtime_depth ?? 0),
      active: active,
    );
  }

  static DateTime _dateTime(int milliSeconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliSeconds);
  }
}

@freezed
abstract class NagAlertsData with _$NagAlertsData {
  const factory NagAlertsData({NagDataSection? data}) = _NagAlertsData;

  factory NagAlertsData.fromJson(Map<String, dynamic> json) =>
      _$NagAlertsDataFromJson(json);
}

@freezed
abstract class NagDataSection with _$NagDataSection {
  const factory NagDataSection({
    Map<String, NagAlertData?>? hostlist,
    Map<String, Map<String, NagAlertData?>?>? servicelist,
  }) = _NagDataSection;

  factory NagDataSection.fromJson(Map<String, dynamic> json) =>
      _$NagDataSectionFromJson(json);
}

@freezed
abstract class NagAlertData with _$NagAlertData {
  const factory NagAlertData({
    String? description,
    int? status,
    // ignore: non_constant_identifier_names
    int? scheduled_downtime_depth,
    // ignore: non_constant_identifier_names
    bool? problem_has_been_acknowledged,
    // ignore: non_constant_identifier_names
    int? last_state_change,
    // ignore: non_constant_identifier_names
    int? last_hard_state_change,
    // ignore: non_constant_identifier_names
    int? last_check,
    // ignore: non_constant_identifier_names
    int? state_type,
    // ignore: non_constant_identifier_names
    String? plugin_output,
  }) = _NagAlertData;

  factory NagAlertData.fromJson(Map<String, dynamic> json) =>
      _$NagAlertDataFromJson(json);
}
