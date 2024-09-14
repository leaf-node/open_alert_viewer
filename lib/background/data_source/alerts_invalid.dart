/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:open_alert_viewer/app/data_source/network_fetch.dart';

import '../../alerts/model/alerts.dart';

class InvalidAlerts extends AlertSource with NetworkFetch {
  InvalidAlerts({required super.sourceData}) : _alerts = [];

  List<Alert> _alerts;

  @override
  Future<List<Alert>> fetchAlerts() async {
    var errorMessage = sourceData.errorMessage;
    List<Alert> nextAlerts = [
      Alert(
          source: sourceData.id!,
          kind: AlertType.syncFailure,
          hostname: sourceData.name,
          service: "OAV",
          message: "Error connecting to your account. "
              "(${(errorMessage == "") ? "Unknown" : errorMessage}). "
              "Try editing your account details. ",
          url: generateURL(sourceData.baseURL, ""),
          age: Duration.zero)
    ];
    _alerts = nextAlerts;
    return _alerts;
  }
}
