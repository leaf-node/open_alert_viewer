/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:convert';

import '../../alerts/model/alerts.dart';

class PromAlerts implements AlertSource {
  PromAlerts(
      {required this.id,
      required this.name,
      required this.type,
      required this.baseURL,
      required this.path,
      required this.username,
      required this.password})
      : _alerts = [];

  @override
  final int id;
  @override
  final String name;
  @override
  final int type;
  @override
  final String baseURL;
  @override
  final String path;
  @override
  final String username;
  @override
  final String password;
  List<Alert> _alerts;

  @override
  Future<List<Alert>> fetchAlerts() async {
    List<Alert> nextAlerts;
    PromAlertsData alertDatum;
    nextAlerts = [];
    try {
      var response =
          await AlertSource.fetchData(baseURL, path, username, password);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        for (var datum in data) {
          alertDatum = PromAlertsData.fromJSON(datum);
          nextAlerts.add(Alert(
              source: id,
              kind: AlertType.error,
              hostname: alertDatum.labels['instance']!,
              service: alertDatum.labels['alertname']!,
              message: alertDatum.annotations['summary']!,
              age: DateTime.now()
                  .difference(DateTime.parse(alertDatum.startsAt))));
        }
      } else if (response.statusCode == 408) {
        nextAlerts = [
          Alert(
              source: id,
              kind: AlertType.syncFailure,
              hostname: name,
              service: "OAV",
              message: "Timeout while trying to fetch alerts... check settings",
              age: Duration.zero)
        ];
      }
    } catch (e) {
      nextAlerts = [
        Alert(
            source: id,
            kind: AlertType.syncFailure,
            hostname: name,
            service: "OAV",
            message: "Error fetching alerts",
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

  factory PromAlertsData.fromJSON(Map<String, dynamic> data) {
    return PromAlertsData(
        fingerprint: data["fingerprint"],
        startsAt: data["startsAt"],
        updatedAt: data["updatedAt"],
        endsAt: data["endsAt"],
        generatorURL: data["generatorURL"],
        annotations: data["annotations"],
        labels: mapConvert(data["labels"]));
  }

  static Map<String, T> mapConvert<T>(Map<String, dynamic> data) {
    return {for (var MapEntry(:key, :value) in data.entries) key: value as T};
  }

  final String fingerprint;
  final String startsAt;
  final String updatedAt;
  final String endsAt;
  final String generatorURL;
  final Map<String, String> annotations;
  final Map<String, String> labels;
}
