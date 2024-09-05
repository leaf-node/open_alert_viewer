/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:open_alert_viewer/app/data_source/network_fetch.dart';

import '../../alerts/model/alerts.dart';

class InvalidAlerts with NetworkFetch implements AlertSource {
  InvalidAlerts(
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
    List<Alert> nextAlerts = [
      Alert(
          source: id,
          kind: AlertType.syncFailure,
          hostname: name,
          service: "OAV",
          message: "Error finding / connecting to a compatible account. "
              "Try editing your account details.",
          url: generateURL(baseURL, path),
          age: Duration.zero)
    ];
    _alerts = nextAlerts;
    return _alerts;
  }
}
