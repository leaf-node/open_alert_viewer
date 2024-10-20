/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../alerts/model/alerts.dart';
import '../../app/data_source/network_fetch.dart';
import '../../app/util/util.dart';

enum StatusType { hostStatus, serviceStatus }

enum HostStatus {
  up(0, AlertType.up),
  warning(1, AlertType.warning),
  down(2, AlertType.down),
  unknown(3, AlertType.unknown);

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

class IciAlerts extends AlertSource with NetworkFetch {
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
      newAlerts.addAll(await fetchAndDecodeJSON(
          endpoint: endpoints[key]!,
          unstructuredDataToAlerts: (dynamic dataSet) {
            List<Alert> someAlerts = [];
            var data = Util.mapConvert(dataSet);
            var dataList = (data["results"] as List).cast<Object>();
            if (key == StatusType.hostStatus) {
              for (var entry in dataList) {
                var hostData =
                    Util.mapConvert<Object>(entry as Map<String, dynamic>);
                someAlerts.add(alertHandler(hostData, false));
              }
            } else if (key == StatusType.serviceStatus) {
              for (var entry in dataList) {
                var serviceData =
                    Util.mapConvert<Object>(entry as Map<String, dynamic>);
                someAlerts.add(alertHandler(serviceData, true));
              }
            }
            return someAlerts;
          }));
    }
    return newAlerts;
  }

  Alert alertHandler(Map<String, Object> alertsData, bool isService) {
    IciAlertsData alertDatum =
        IciAlertsData.fromParsedJSON(Util.mapConvert(alertsData));
    AlertType kind;
    String hostname;
    String service;
    if (isService) {
      kind = ServiceStatus.values
          .firstWhere((v) => v.value == alertDatum.state)
          .alertType;
      hostname = alertDatum.hostname;
      service = alertDatum.name;
    } else {
      kind = HostStatus.values
          .firstWhere((v) => v.value == alertDatum.state)
          .alertType;
      hostname = alertDatum.name;
      service = "PING";
    }
    DateTime startsAt;
    bool active;
    if (alertDatum.stateType == 1) {
      startsAt = alertDatum.lastHardStateChange;
      active = true;
    } else {
      startsAt = alertDatum.lastStateChange;
      active = false;
    }
    Duration age;
    age = (startsAt.difference(epoch) == Duration.zero)
        ? DateTime.now().difference(alertDatum.lastCheck)
        : DateTime.now().difference(startsAt);
    return Alert(
        source: sourceData.id!,
        kind: kind,
        hostname: hostname,
        service: service,
        message: alertDatum.message,
        url: generateURL(hostname, ""),
        age: age,
        silenced: Util.toBool(alertDatum.acknowledged),
        downtimeScheduled: (alertDatum.downtimeDepth > 0),
        active: active);
  }
}

class IciAlertsData {
  const IciAlertsData(
      {required this.name,
      required this.hostname,
      required this.message,
      required this.state,
      required this.downtimeDepth,
      required this.acknowledged,
      required this.lastStateChange,
      required this.lastHardStateChange,
      required this.lastCheck,
      required this.lastCheckResult,
      required this.stateType});

  final String name;
  final String hostname;
  final String message;
  final int state;
  final int downtimeDepth;
  final int acknowledged;
  final DateTime lastStateChange;
  final DateTime lastHardStateChange;
  final DateTime lastCheck;
  final Map<String, Object> lastCheckResult;
  final int stateType;

  factory IciAlertsData.fromParsedJSON(Map<String, Object> parsed) {
    var attrs =
        Util.mapConvert<Object>(parsed["attrs"] as Map<String, dynamic>);
    var joins =
        Util.mapConvert<Object>(parsed["joins"] as Map<String, dynamic>);
    var host =
        Util.mapConvert<Object>(joins["host"] as Map<String, dynamic>? ?? {});
    var result = Util.mapConvert<Object>(
        parsed["last_check_result"] as Map<String, dynamic>? ?? {});
    return IciAlertsData(
        name: attrs["display_name"] as String,
        hostname: host["name"] as String? ?? "",
        message: (attrs["last_check_result"] as Map<String, dynamic>)["output"]
            as String,
        state: attrs["state"] as int,
        downtimeDepth: attrs["downtime_depth"] as int,
        acknowledged: attrs["acknowledgement"] as int,
        lastStateChange: _dateTime(attrs["last_state_change"] as num),
        lastHardStateChange: _dateTime(attrs["last_hard_state_change"] as num),
        lastCheck: _dateTime(attrs["last_check"] as num),
        lastCheckResult: Util.mapConvert<Object>(result),
        stateType: attrs["state_type"] as int);
  }

  static DateTime _dateTime(num milliSeconds) {
    return DateTime.fromMillisecondsSinceEpoch((milliSeconds * 1000).floor());
  }
}
