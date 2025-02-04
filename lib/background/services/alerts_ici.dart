/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/alerts.dart';
import '../../utils/utils.dart';
import 'alerts.dart';

part 'alerts_ici.freezed.dart';
part 'alerts_ici.g.dart';

enum StatusType { hostStatus, serviceStatus }

enum HostStatus {
  up(0, AlertType.up),
  down(1, AlertType.down),
  unreachable(2, AlertType.unreachable),
  unknown(-1, AlertType.unknown); // not upstream

  const HostStatus(this.value, this.alertType);
  final int value;
  final AlertType alertType;
}

enum ServiceStatus {
  okay(0, AlertType.okay),
  warning(1, AlertType.warning),
  critical(2, AlertType.error),
  unknown(3, AlertType.unknown);

  const ServiceStatus(this.value, this.alertType);
  final int value;
  final AlertType alertType;
}

class IciAlerts extends AlertSource {
  IciAlerts({required super.sourceData})
      : epoch = DateTime.fromMillisecondsSinceEpoch(0) {
    endpoints = {
      StatusType.hostStatus: "/v1/objects/hosts/?attrs=display_name"
          "&attrs=state&attrs=downtime_depth&attrs=acknowledgement"
          "&attrs=last_hard_state_change&attrs=last_state_change"
          "&attrs=last_check&attrs=last_check_result&attrs=state_type",
      StatusType.serviceStatus: "/v1/objects/services/?attrs=display_name"
          "&attrs=state&attrs=downtime_depth&attrs=acknowledgement"
          "&attrs=last_hard_state_change&attrs=last_state_change"
          "&attrs=last_check&attrs=last_check_result&attrs=state_type"
          "&joins=host.name&joins=host.address"
    };
  }

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
          throw Exception("Missing alert message after Icinga fetch error");
        } else {
          return errors;
        }
      }
      var data = Util.mapConvert(dataSet);
      var dataList = (data["results"] as List).cast<Object>();
      if (key == StatusType.hostStatus) {
        for (var entry in dataList) {
          var hostData = Util.mapConvert<Object>(entry as Map<String, dynamic>);
          newAlerts.add(alertHandler(hostData, false));
        }
      } else if (key == StatusType.serviceStatus) {
        for (var entry in dataList) {
          var serviceData =
              Util.mapConvert<Object>(entry as Map<String, dynamic>);
          newAlerts.add(alertHandler(serviceData, true));
        }
      }
    }
    return newAlerts;
  }

  Alert alertHandler(Map<String, Object> alertsData, bool isService) {
    IciAlertsData alertDatum = IciAlertsData.fromJson(alertsData);
    AlertType kind;
    String hostname;
    String service;
    if (isService) {
      kind = ServiceStatus.values
          .singleWhere((v) => v.value == alertDatum.attrs?.state?.floor(),
              orElse: () => ServiceStatus.unknown)
          .alertType;
      hostname = alertDatum.joins?.host?.name ?? "Unknown Host";
      service = alertDatum.attrs?.display_name ?? "Unknown";
    } else {
      kind = HostStatus.values
          .singleWhere((v) => v.value == alertDatum.attrs?.state?.floor(),
              orElse: () => HostStatus.unknown)
          .alertType;
      hostname = alertDatum.attrs?.display_name ?? "Unknown Host";
      service = "PING";
    }
    DateTime startsAt;
    bool active;
    if (alertDatum.attrs?.state_type?.floor() == 1) {
      startsAt = _dateTime(alertDatum.attrs?.last_hard_state_change ?? 0);
      active = true;
    } else if (alertDatum.attrs?.state_type?.floor() == 0) {
      startsAt = _dateTime(alertDatum.attrs?.last_state_change ?? 0);
      active = false;
    } else {
      startsAt = epoch;
      active = true;
    }
    Duration age;
    age = (startsAt.difference(epoch) == Duration.zero)
        ? (alertDatum.attrs == null || alertDatum.attrs!.last_check == null)
            ? Duration.zero
            : DateTime.now()
                .difference(_dateTime(alertDatum.attrs!.last_check!))
        : DateTime.now().difference(startsAt);
    return Alert(
        source: sourceData.id!,
        kind: kind,
        hostname: hostname,
        service: service,
        message: alertDatum.attrs?.last_check_result?.output ?? "...",
        url: generateURL(hostname, ""),
        age: age,
        silenced: Util.toBool(alertDatum.attrs?.acknowledgement?.floor() ?? 0),
        downtimeScheduled:
            ((alertDatum.attrs?.downtime_depth?.floor() ?? 0) > 0),
        active: active);
  }

  static DateTime _dateTime(num seconds) {
    return DateTime.fromMillisecondsSinceEpoch((seconds * 1000).floor());
  }
}

@freezed
class IciAlertsData with _$IciAlertsData {
  const factory IciAlertsData(
      // ignore: non_constant_identifier_names
      {AttrsData? attrs,
      JoinsData? joins}) = _IciAlertsData;

  factory IciAlertsData.fromJson(Map<String, dynamic> json) =>
      _$IciAlertsDataFromJson(json);
}

@freezed
class AttrsData with _$AttrsData {
  const factory AttrsData(
      // ignore: non_constant_identifier_names
      {String? display_name,
      num? state,
      // ignore: non_constant_identifier_names
      num? downtime_depth,
      num? acknowledgement,
      // ignore: non_constant_identifier_names
      num? last_state_change,
      // ignore: non_constant_identifier_names
      num? last_hard_state_change,
      // ignore: non_constant_identifier_names
      num? last_check,
      // ignore: non_constant_identifier_names
      LastCheckResultData? last_check_result,
      // ignore: non_constant_identifier_names
      num? state_type}) = _AttrsData;

  factory AttrsData.fromJson(Map<String, dynamic> json) =>
      _$AttrsDataFromJson(json);
}

@freezed
class LastCheckResultData with _$LastCheckResultData {
  const factory LastCheckResultData({String? output}) = _LastCheckResultData;

  factory LastCheckResultData.fromJson(Map<String, dynamic> json) =>
      _$LastCheckResultDataFromJson(json);
}

@freezed
class JoinsData with _$JoinsData {
  const factory JoinsData({HostsData? host}) = _JoinsData;

  factory JoinsData.fromJson(Map<String, dynamic> json) =>
      _$JoinsDataFromJson(json);
}

@freezed
class HostsData with _$HostsData {
  const factory HostsData({String? name}) = _HostsData;

  factory HostsData.fromJson(Map<String, dynamic> json) =>
      _$HostsDataFromJson(json);
}
