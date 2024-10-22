/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../alerts/model/alerts.dart';
import '../../app/data_source/network_fetch.dart';
import '../../app/util/util.dart';

class PromAlerts extends AlertSource with NetworkFetch {
  PromAlerts({required super.sourceData});

  static const endpoint = "/api/v2/alerts";

  @override
  Future<List<Alert>> fetchAlerts() async {
    dynamic dataSet;
    List<Alert> errors;
    (dataSet, errors) = await fetchAndDecodeJSON(endpoint: endpoint);
    if (dataSet == null) {
      if (errors.isEmpty) {
        throw Exception("Missing alert message after Zabbix error");
      } else {
        return errors;
      }
    }
    List<Alert> newAlerts = [];
    for (Map<String, dynamic> datum in dataSet as List) {
      PromAlertsData alertDatum =
          PromAlertsData.fromParsedJSON(Util.mapConvert(datum));
      var severity = alertDatum.severity;
      var type = alertDatum.oavType;
      AlertType kind;
      if (RegExp(r"^(error|page|critical)$").hasMatch(severity)) {
        kind = RegExp(r"^(ping|icmp)$").hasMatch(type)
            ? AlertType.down
            : AlertType.error;
      } else if (RegExp(r"^(warning)$").hasMatch(severity)) {
        kind = AlertType.warning;
      } else {
        kind = AlertType.unknown;
      }
      newAlerts.add(Alert(
          source: sourceData.id!,
          kind: kind,
          hostname: alertDatum.instance,
          service: alertDatum.alertName,
          message: alertDatum.summary,
          url: alertDatum.generatorURL,
          age: DateTime.now().difference(DateTime.parse(alertDatum.startsAt)),
          silenced: alertDatum.silenced,
          downtimeScheduled: false,
          active: true));
    }
    return newAlerts;
  }
}

class PromAlertsData {
  const PromAlertsData({
    required this.fingerprint,
    required this.severity,
    required this.oavType,
    required this.instance,
    required this.alertName,
    required this.summary,
    required this.startsAt,
    required this.updatedAt,
    required this.endsAt,
    required this.generatorURL,
    required this.silenced,
  });

  factory PromAlertsData.fromParsedJSON(Map<String, Object> parsed) {
    var annotations =
        Util.mapConvert<String>(parsed["annotations"] as Map<String, dynamic>);
    var labels =
        Util.mapConvert<String>(parsed["labels"] as Map<String, dynamic>);
    var status =
        Util.mapConvert<Object>(parsed["status"] as Map<String, dynamic>);
    return PromAlertsData(
        fingerprint: parsed["fingerprint"] as String,
        severity: labels["severity"] ?? "",
        oavType: labels["oav_type"] ?? "",
        instance: labels["instance"] ?? "",
        alertName: labels["alertname"] ?? "",
        summary: annotations["summary"] ?? "",
        startsAt: parsed["startsAt"] as String,
        updatedAt: parsed["updatedAt"] as String,
        endsAt: parsed["endsAt"] as String,
        generatorURL: parsed["generatorURL"] as String,
        silenced: (status["silencedBy"] as List).isNotEmpty);
  }

  final String fingerprint;
  final String severity;
  final String oavType;
  final String instance;
  final String alertName;
  final String summary;
  final String startsAt;
  final String updatedAt;
  final String endsAt;
  final String generatorURL;
  final bool silenced;
}
