/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../domain/alerts.dart';
import '../../data/services/network_fetch.dart';

class NullAlerts extends AlertSource with NetworkFetch {
  NullAlerts({required super.sourceData});

  @override
  Future<List<Alert>> fetchAlerts() async {
    return alertForInvalidSource(sourceData);
  }
}
