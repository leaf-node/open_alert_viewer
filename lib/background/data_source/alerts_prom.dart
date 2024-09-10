/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../alerts/model/alerts.dart';
import '../../app/data_source/network_fetch.dart';
import '../../app/util/util.dart';

class PromAlerts extends AlertSource with NetworkFetch {
  PromAlerts({
    required super.sourceData,
  }) : _alerts = [];

  List<Alert> _alerts;

  @override
  Future<List<Alert>> fetchAlerts() async {
    Response response;
    List<Alert> nextAlerts;
    PromAlertsData alertDatum;
    nextAlerts = [];
    try {
      response = await networkFetch(sourceData.baseURL, sourceData.path,
          sourceData.username, sourceData.password);
    } on SocketException catch (e) {
      nextAlerts = [
        Alert(
            source: sourceData.id!,
            kind: AlertType.syncFailure,
            hostname: sourceData.name,
            service: "OAV",
            message: "Error fetching alerts: ${e.message}",
            url: generateURL(sourceData.baseURL, sourceData.path),
            age: Duration.zero)
      ];
      _alerts = nextAlerts;
      return _alerts;
    }
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      for (var datum in data) {
        alertDatum = PromAlertsData.fromJSON(Util.mapConvert(datum));
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
        nextAlerts.add(Alert(
            source: sourceData.id!,
            kind: kind,
            hostname: alertDatum.labels['instance'] ?? "",
            service: alertDatum.labels['alertname'] ?? "",
            message: alertDatum.annotations['summary'] ?? "",
            url: alertDatum.generatorURL,
            age: DateTime.now()
                .difference(DateTime.parse(alertDatum.startsAt))));
      }
    } else {
      nextAlerts = [
        Alert(
            source: sourceData.id!,
            kind: AlertType.syncFailure,
            hostname: sourceData.name,
            service: "OAV",
            message: "Error fetching alerts: HTTP status code "
                "${response.statusCode}",
            url: generateURL(sourceData.baseURL, sourceData.path),
            age: Duration.zero)
      ];
    }
    _alerts = nextAlerts;
    return _alerts;
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

  factory PromAlertsData.fromJSON(Map<String, Object> parsed) {
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
