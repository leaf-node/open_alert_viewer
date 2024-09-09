/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
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
  PromAlerts(
      {required super.id,
      required super.name,
      required super.type,
      required super.baseURL,
      required super.path,
      required super.username,
      required super.password})
      : _alerts = [];

  List<Alert> _alerts;

  @override
  Future<List<Alert>> fetchAlerts() async {
    Response response;
    List<Alert> nextAlerts;
    PromAlertsData alertDatum;
    nextAlerts = [];
    try {
      response = await networkFetch(baseURL, path, username, password);
    } on SocketException catch (e) {
      nextAlerts = [
        Alert(
            source: id,
            kind: AlertType.syncFailure,
            hostname: name,
            service: "OAV",
            message: "Error fetching alerts: ${e.message}",
            url: generateURL(baseURL, path),
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
            source: id,
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
            source: id,
            kind: AlertType.syncFailure,
            hostname: name,
            service: "OAV",
            message: "Error fetching alerts: HTTP status code "
                "${response.statusCode}",
            url: generateURL(baseURL, path),
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

  factory PromAlertsData.fromJSON(Map<String, Object> data) {
    return PromAlertsData(
        fingerprint: data["fingerprint"] as String,
        startsAt: data["startsAt"] as String,
        updatedAt: data["updatedAt"] as String,
        endsAt: data["endsAt"] as String,
        generatorURL: data["generatorURL"] as String,
        annotations:
            Util.mapConvert(data["annotations"] as Map<String, dynamic>),
        labels: Util.mapConvert(data["labels"] as Map<String, dynamic>));
  }

  final String fingerprint;
  final String startsAt;
  final String updatedAt;
  final String endsAt;
  final String generatorURL;
  final Map<String, String> annotations;
  final Map<String, String> labels;
}
