/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../alerts/model/alerts.dart';
import '../../app/data_source/network_fetch.dart';
import '../../app/util/util.dart';

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
    List<String> queryParametersSet = [
      "?query=hostlist&details=true",
      //"?query=servicelist&details=true"
    ];
    return fetchAndDecodeJSON(
        queryParametersSet: queryParametersSet,
        unstructuredDataToAlerts: (Map<String, dynamic> dataSet) {
          List<Alert> newAlerts = [];
          for (var queryParams in dataSet.keys) {
            var data = Util.mapConvert(dataSet[queryParams]);
            var dataMap = Util.mapConvert(data["data"]);
            var hostList = Util.mapConvert(dataMap["hostlist"]);
            for (var host in hostList.keys) {
              var hostData = Util.mapConvert(hostList[host]);
              NagHostAlertsData alertDatum =
                  NagHostAlertsData.fromParsedJSON(Util.mapConvert(hostData));
              AlertType kind = HostStatus.values
                  .firstWhere((v) => v.value == alertDatum.status)
                  .alertType;
              Duration age;
              if (kind == HostStatus.pending.alertType) {
                age = Duration.zero;
              } else {
                DateTime startsAt =
                    (alertDatum.lastHardStateChange.difference(epoch) ==
                            Duration.zero)
                        ? alertDatum.lastStateChange
                        : alertDatum.lastHardStateChange;
                age = DateTime.now().difference(startsAt);
              }
              newAlerts.add(Alert(
                  source: sourceData.id!,
                  kind: kind,
                  hostname: host,
                  service: "Ping",
                  message: alertDatum.pluginOutput,
                  url: generateURL(host, "", ""),
                  age: age));
            }
          }
          return newAlerts;
        });
  }
}

class NagHostAlertsData {
  const NagHostAlertsData(
      {required this.status,
      required this.lastStateChange,
      required this.lastHardStateChange,
      required this.lastTimeUp,
      required this.lastTimeDown,
      required this.lastTimeUnreachable,
      required this.pluginOutput});

  final int status;
  final DateTime lastStateChange;
  final DateTime lastHardStateChange;
  final DateTime lastTimeUp;
  final DateTime lastTimeDown;
  final DateTime lastTimeUnreachable;
  final String pluginOutput;

  factory NagHostAlertsData.fromParsedJSON(Map<String, Object> parsed) {
    return NagHostAlertsData(
        status: parsed["status"] as int,
        lastStateChange: _dateTime(parsed["last_state_change"] as int),
        lastHardStateChange: _dateTime(parsed["last_hard_state_change"] as int),
        lastTimeUp: _dateTime(parsed["last_time_up"] as int),
        lastTimeDown: _dateTime(parsed["last_time_down"] as int),
        lastTimeUnreachable: _dateTime(parsed["last_time_unreachable"] as int),
        pluginOutput: parsed["plugin_output"] as String);
  }

  static DateTime _dateTime(int milliSeconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliSeconds);
  }
}

class NagserviceAlertsData {
  const NagserviceAlertsData({required this.status});

  factory NagserviceAlertsData.fromJSON(Map<String, Object> parsed) {
    return NagserviceAlertsData(status: parsed["fingerprint"] as String);
  }

  final String status;
}
