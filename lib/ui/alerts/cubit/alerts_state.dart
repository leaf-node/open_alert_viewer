/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/alerts.dart';

part 'alerts_state.freezed.dart';

enum FetchingStatus {
  init,
  fetching,
  fetched,
}

enum RefreshIconStatus {
  init,
  fetchingNow,
  stopped,
}

@freezed
class AlertsCubitState with _$AlertsCubitState {
  const factory AlertsCubitState(
      {required Map<String, Object> settings,
      required FetchingStatus status,
      required RefreshIconStatus refreshStatus,
      required List<Alert> alerts,
      required List<AlertSourceData> sources,
      required bool showNotificationStatusWidget,
      required bool showSoundStatusWidget,
      required bool showFilterStatusWidget}) = _AlertsState;

  factory AlertsCubitState.init() {
    return AlertsCubitState(
        settings: {},
        status: FetchingStatus.init,
        refreshStatus: RefreshIconStatus.init,
        alerts: [],
        sources: [],
        showNotificationStatusWidget: false,
        showSoundStatusWidget: false,
        showFilterStatusWidget: false);
  }
}
