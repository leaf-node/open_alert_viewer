/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import '../../background/domain/background.dart';

class AlertsRepo {
  AlertsRepo({required BackgroundChannel bgChannel}) : _bgChannel = bgChannel;

  final BackgroundChannel _bgChannel;

  void fetchAlerts({bool? forceRefreshNow}) {
    _bgChannel.makeRequest(IsolateMessage(
        name: MessageName.fetchAlerts, forceRefreshNow: forceRefreshNow));
  }

  void updateLastSeen() {
    _bgChannel
        .makeRequest(const IsolateMessage(name: MessageName.updateLastSeen));
  }

  void refreshTimer() {
    _bgChannel
        .makeRequest(const IsolateMessage(name: MessageName.refreshTimer));
  }
}
