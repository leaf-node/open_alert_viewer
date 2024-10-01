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
    return fetchAndDecodeJSON(
        endpoints: [endpoint],
        unstructuredDataToAlerts: (Map<String, dynamic> dataSet) {
          List<Alert> newAlerts = [];
          for (var datum in dataSet[endpoint]) {
            PromAlertsData alertDatum =
                PromAlertsData.fromParsedJSON(Util.mapConvert(datum));
            var severity = alertDatum.labels['severity'] ?? "";
            var type = alertDatum.labels['oav_type'] ?? "";
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
                hostname: alertDatum.labels['instance'] ?? "",
                service: alertDatum.labels['alertname'] ?? "",
                message: alertDatum.annotations['summary'] ?? "",
                url: alertDatum.generatorURL,
                age: DateTime.now()
                    .difference(DateTime.parse(alertDatum.startsAt)),
                acknowledged: false,
                downtimeScheduled: false));
          }
          return newAlerts;
        });
  }
}

class PromAlertsData {
  const PromAlertsData(
      {required this.fingerprint,
      required this.startsAt,
      required this.updatedAt,
      required this.endsAt,
      required this.generatorURL,
      required this.annotations,
      required this.labels});

  factory PromAlertsData.fromParsedJSON(Map<String, Object> parsed) {
    return PromAlertsData(
        fingerprint: parsed["fingerprint"] as String,
        startsAt: parsed["startsAt"] as String,
        updatedAt: parsed["updatedAt"] as String,
        endsAt: parsed["endsAt"] as String,
        generatorURL: parsed["generatorURL"] as String,
        annotations:
            Util.mapConvert(parsed["annotations"] as Map<String, dynamic>),
        labels: Util.mapConvert(parsed["labels"] as Map<String, dynamic>));
  }

  final String fingerprint;
  final String startsAt;
  final String updatedAt;
  final String endsAt;
  final String generatorURL;
  final Map<String, String> annotations;
  final Map<String, String> labels;
}
