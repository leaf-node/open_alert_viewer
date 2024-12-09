/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../domain/alerts.dart';
import 'alerts.dart';

class NullAlerts extends AlertSource {
  NullAlerts({required super.sourceData});

  @override
  Future<List<Alert>> fetchAlerts() async {
    return alertForInvalidSource();
  }
}
