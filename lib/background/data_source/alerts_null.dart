/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../alerts/model/alerts.dart';
import '../../app/data_source/network_fetch.dart';

class NullAlerts extends AlertSource with NetworkFetch {
  NullAlerts({required super.sourceData});

  @override
  Future<List<Alert>> fetchAlerts() async {
    return alertForInvalidSource(sourceData);
  }
}
