/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../alerts/model/alerts.dart';
import '../../app/data_source/network_fetch.dart';

class NagAlerts extends AlertSource with NetworkFetch {
  NagAlerts({required super.sourceData}) : _alerts = [];

  List<Alert> _alerts;

  @override
  Future<List<Alert>> fetchAlerts() async {
    if (!(sourceData.isValid ?? false)) {
      return alertForInvalidSource(sourceData);
    }
    List<Alert> nextAlerts = [
      Alert(
          source: sourceData.id!,
          kind: AlertType.syncFailure,
          hostname: sourceData.name,
          service: "OAV",
          message: "Placeholder Nag alert...",
          url: generateURL(sourceData.baseURL, sourceData.path),
          age: Duration.zero)
    ];
    _alerts = nextAlerts;
    return _alerts;
  }
}
