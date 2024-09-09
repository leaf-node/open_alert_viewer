/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:open_alert_viewer/app/data_source/network_fetch.dart';

import '../../alerts/model/alerts.dart';

class InvalidAlerts extends AlertSource with NetworkFetch {
  InvalidAlerts(
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
    List<Alert> nextAlerts = [
      Alert(
          source: id,
          kind: AlertType.syncFailure,
          hostname: name,
          service: "OAV",
          message: "Error finding / connecting to a compatible account. "
              "Try editing your account details.",
          url: generateURL(baseURL, ""),
          age: Duration.zero)
    ];
    _alerts = nextAlerts;
    return _alerts;
  }
}
