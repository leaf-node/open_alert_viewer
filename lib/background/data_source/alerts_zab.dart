/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:developer';

import '../../alerts/model/alerts.dart';
import '../../app/data_source/network_fetch.dart';
import '../../app/util/util.dart';

enum StatusType { serviceStatus, serviceHistory, hostStatus, hostItems, alerts }

enum HostMonitored {
  monitored(0),
  unMonitored(1);

  const HostMonitored(this.value);
  final int value;
}

enum HostStatus {
  down(0, AlertType.down),
  up(1, AlertType.up);

  const HostStatus(this.value, this.alertType);
  final int value;
  final AlertType alertType;
}

enum ServiceStatus {
  okay(-1, AlertType.okay),
  notClassified(0, AlertType.unknown),
  information(1, AlertType.okay),
  warning(2, AlertType.warning),
  average(3, AlertType.warning),
  high(4, AlertType.error),
  disaster(5, AlertType.error);

  const ServiceStatus(this.value, this.alertType);
  final int value;
  final AlertType alertType;
}

int historyCutoffDays = 30;

class ZabAlerts extends AlertSource with NetworkFetch {
  ZabAlerts({required super.sourceData})
      : epoch = DateTime.fromMillisecondsSinceEpoch(0),
        endpoint = "/api_jsonrpc.php";

  final DateTime epoch;
  final String endpoint;

  @override
  Future<List<Alert>> fetchAlerts() async {
    final now = (DateTime.now().millisecondsSinceEpoch / 1000).floor();
    final old = (DateTime.now()
                .subtract(Duration(days: historyCutoffDays))
                .millisecondsSinceEpoch /
            1000)
        .floor();
    final queries = {
      StatusType.serviceStatus: '''{
          "jsonrpc": "2.0",
          "method": "service.get",
          "params": {
              "output": ["serviceid", "status", "name", "description", "created_at"]
          },
          "id": 2
        }''',
      StatusType.serviceHistory: '''{
          "jsonrpc": "2.0",
          "method": "service.get",
          "params": {
              "limit": 1,
              "selectStatusTimeline": [{"period_from": "$old",
                "period_to": "${now + 3600}"}],
              "serviceids": ["0"]
          },
          "id": 3
        }''',
      StatusType.hostStatus: '''{
          "jsonrpc": "2.0",
          "method": "host.get",
          "params": {
              "output": ["host", "status"]
          },
          "id": 4
        }''',
      StatusType.hostItems: '''{
          "jsonrpc": "2.0",
          "method": "item.get",
          "params": {
              "output": ["itemid", "hostid", "lastvalue"],
              "search": {"key_": "agent.ping"}
          },
          "id": 5
        }''',
      StatusType.alerts: '''{
          "jsonrpc": "2.0",
          "method": "alert.get",
          "params": {
              "output": "extend"
          },
          "id": 6
        }'''
    };
    List<Alert> newAlerts = [];
    List<(num, List<(num, num)>)> serviceAlarms = [];
    List<(num, String, num)> hostInfo = [];
    for (StatusType key in queries.keys) {
      dynamic dataSet;
      List<Alert> errors;
      (dataSet, errors) = await fetchAndDecodeJSON(
          endpoint: endpoint,
          postBody: queries[key],
          authOverride: true,
          headers: {
            "Content-Type": "application/json-rpc",
            "Authorization": "Bearer ${sourceData.accessToken}"
          });
      if (dataSet == null) {
        if (errors.isEmpty) {
          throw Exception("Missing alert message after Zabbix error");
        } else {
          return errors;
        }
      }
      var data = Util.mapConvert(dataSet);
      if (data.keys.contains("error")) {
        String error1 = data["error"]["data"];
        String error2 = data["error"]["message"];
        return errorFetchingAlerts(
            sourceData: sourceData,
            error: (error1.isNotEmpty) ? error1 : error2,
            endpoint: endpoint);
      }
      var dataList = (data["result"] as List).cast<Object>();
      log(dataList.toString());
      for (var entry in dataList) {
        var data = Util.mapConvert<Object>(entry as Map<String, dynamic>);
        if (key == StatusType.serviceHistory) {
          final serviceId = int.parse(data["serviceid"] as String);
          final alarms = data["serviceid"] as List<(num, num)>;
          serviceAlarms.add((serviceId, alarms));
        } else if (key == StatusType.serviceStatus) {
          final serviceId = int.parse(data["serviceid"] as String);
          final extraInfo =
              serviceAlarms.where((element) => element.$1 == serviceId);
          newAlerts.add(alertHandler(data, true, extraInfo.toList()));
        } else if (key == StatusType.hostStatus) {
          final hostId = int.parse(data["hostid"] as String);
          final hostName = data["host"] as String;
          final unMonitored = int.parse(data["status"] as String);
          hostInfo.add((hostId, hostName, unMonitored));
        } else if (key == StatusType.hostItems) {
          final hostId = int.parse(data["hostid"] as String);
          final extraInfo = hostInfo.where((element) => element.$1 == hostId);
          newAlerts.add(alertHandler(data, false, extraInfo.toList()));
        }
      }
    }
    return newAlerts;
  }

  Alert alertHandler(
      Map<String, Object> alertsData, bool isService, List<Object> extraInfo) {
    final datum = Util.mapConvert(alertsData);
    AlertType kind;
    String hostName;
    String service;
    String description;
    DateTime startsAt;
    if (isService) {
      kind = ServiceStatus.values
          .firstWhere((v) => v.value == int.parse(datum["status"]))
          .alertType;
      hostName = "";
      service = datum["name"];
      description = datum["description"];
      startsAt = _dateTime(int.parse(datum["created_at"]));
    } else {
      num monitorStatus;
      (_, hostName, monitorStatus) =
          extraInfo.lastOrNull as (num, String, num)? ??
              (-1, "(Unknown Host Name)", 1);
      if (monitorStatus == HostMonitored.unMonitored.value) {
        kind = AlertType.unknown;
        description = "Unmonitored";
      } else {
        int status = int.parse(datum["lastvalue"] as String);
        kind = HostStatus.values.firstWhere((v) => v.value == status).alertType;
        description = "";
      }
      startsAt = DateTime.now();
      service = "PING";
    }
    Duration age;
    age = (startsAt.difference(epoch) == Duration.zero)
        ? Duration(seconds: 0)
        : DateTime.now().difference(startsAt);
    return Alert(
        source: sourceData.id!,
        kind: kind,
        hostname: hostName,
        service: service,
        message: description,
        url: generateURL(hostName, ""),
        age: age,
        silenced: false,
        downtimeScheduled: false, // < ^ v FIXME
        active: true);
  }

  static DateTime _dateTime(num seconds) {
    return DateTime.fromMillisecondsSinceEpoch((seconds * 1000).floor());
  }
}
