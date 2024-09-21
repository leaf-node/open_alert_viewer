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
  pending(1, AlertType.hostPending),
  up(2, AlertType.up),
  down(4, AlertType.down),
  unreachable(8, AlertType.unreachable);

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

class NagAlerts extends AlertSource with NetworkFetch {
  NagAlerts({required super.sourceData})
      : epoch = DateTime.fromMillisecondsSinceEpoch(0);

  final DateTime epoch;

  @override
  Future<List<Alert>> fetchAlerts() async {
    Map<StatusType, String> queryParametersSet = {
      StatusType.hostStatus: "?query=hostlist&details=true",
      StatusType.serviceStatus: "?query=servicelist&details=true"
    };
    return fetchAndDecodeJSON(
        queryParametersSet: queryParametersSet.values.toList(),
        unstructuredDataToAlerts: (Map<String, dynamic> dataSet) {
          List<Alert> newAlerts = [];
          for (var statusType in queryParametersSet.keys) {
            String queryParams = queryParametersSet[statusType]!;
            var data = Util.mapConvert(dataSet[queryParams]);
            var dataMap = Util.mapConvert(data["data"]);
            if (statusType == StatusType.hostStatus) {
              var hostList = Util.mapConvert(dataMap["hostlist"]);
              for (var host in hostList.keys) {
                var hostData = Util.mapConvert(hostList[host]);
                newAlerts.add(alertHandler(hostData, false, host));
              }
            } else if (statusType == StatusType.serviceStatus) {
              var serviceHostList = Util.mapConvert(dataMap["servicelist"]);
              for (var host in serviceHostList.keys) {
                var serviceHostData = Util.mapConvert(serviceHostList[host]);
                for (var service in serviceHostData.keys) {
                  var serviceData = Util.mapConvert(serviceHostData[service]);
                  newAlerts.add(alertHandler(serviceData, true, host));
                }
              }
            }
          }
          return newAlerts;
        });
  }

  Alert alertHandler(
      Map<String, dynamic> alertsData, bool isService, String host) {
    NagAlertsData alertDatum =
        NagAlertsData.fromParsedJSON(Util.mapConvert(alertsData));
    AlertType kind;
    if (isService) {
      kind = ServiceStatus.values
          .firstWhere((v) => v.value == alertDatum.status)
          .alertType;
    } else {
      kind = HostStatus.values
          .firstWhere((v) => v.value == alertDatum.status)
          .alertType;
    }
    Duration age;
    if (kind == ServiceStatus.pending.alertType ||
        kind == HostStatus.pending.alertType) {
      age = Duration.zero;
    } else {
      DateTime startsAt = alertDatum.lastHardStateChange;
      age = (startsAt.difference(epoch) == Duration.zero)
          ? DateTime.now().difference(alertDatum.lastCheck)
          : DateTime.now().difference(startsAt);
      if (age == Duration.zero) {}
    }
    return Alert(
        source: sourceData.id!,
        kind: kind,
        hostname: host,
        service: alertDatum.description,
        message: alertDatum.pluginOutput,
        url: generateURL(host, "", ""),
        age: age);
  }
}

class NagAlertsData {
  const NagAlertsData(
      {required this.status,
      required this.description,
      required this.lastStateChange,
      required this.lastHardStateChange,
      required this.lastCheck,
      required this.pluginOutput});

  final int status;
  final String description;
  final DateTime lastStateChange;
  final DateTime lastHardStateChange;
  final DateTime lastCheck;
  final String pluginOutput;

  factory NagAlertsData.fromParsedJSON(Map<String, Object> parsed) {
    return NagAlertsData(
        status: parsed["status"] as int,
        description: parsed["description"] as String? ?? "Ping",
        lastStateChange: _dateTime(parsed["last_state_change"] as int),
        lastHardStateChange: _dateTime(parsed["last_hard_state_change"] as int),
        lastCheck: _dateTime(parsed["last_check"] as int),
        pluginOutput: parsed["plugin_output"] as String);
  }

  static DateTime _dateTime(int milliSeconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliSeconds);
  }
}
