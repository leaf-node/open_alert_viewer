/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../alerts/model/alerts.dart';
import '../../app/data_source/network_fetch.dart';

class NagAlerts extends AlertSource with NetworkFetch {
  NagAlerts(
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
          message: "Placeholder Nag alert...",
          url: generateURL(baseURL, path),
          age: Duration.zero)
    ];
    _alerts = nextAlerts;
    return _alerts;
  }
}
