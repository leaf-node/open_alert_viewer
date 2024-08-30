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

class PromAlerts with NetworkFetch implements AlertSource {
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
            age: Duration.zero)
      ];
      _alerts = nextAlerts;
      return _alerts;
    }
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
    } else {
      nextAlerts = [
        Alert(
            source: id,
            kind: AlertType.syncFailure,
            hostname: name,
            service: "OAV",
            message: "Error fetching alerts: ${response.body}",
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
        annotations: mapConvert(data["annotations"]),
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
