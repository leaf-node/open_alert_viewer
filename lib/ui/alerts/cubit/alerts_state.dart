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
  triggeredOrRunning,
  stopped,
}

@freezed
class RefreshIconState with _$RefreshIconState {
  const factory RefreshIconState(
      {required RefreshIconStatus status,
      required bool alreadyFetching,
      required bool forceRefreshNow}) = _RefreshIconState;
}

@freezed
class AlertsCubitState with _$AlertsCubitState {
  const factory AlertsCubitState(
      {required Map<String, Object> settings,
      required FetchingStatus status,
      required RefreshIconState refresh,
      required List<Alert> alerts,
      required List<Alert> filteredAlerts,
      required List<AlertSourceData> sources,
      required bool showNotificationStatusWidget,
      required bool showVisibilityStatusWidget,
      required bool showSoundStatusWidget,
      required bool showFilterStatusWidget,
      required String emptyPaneMessage}) = _AlertsCubitState;

  factory AlertsCubitState.init() {
    return AlertsCubitState(
        settings: {},
        status: FetchingStatus.init,
        refresh: RefreshIconState(
            status: RefreshIconStatus.init,
            alreadyFetching: false,
            forceRefreshNow: false),
        alerts: [],
        filteredAlerts: [],
        sources: [],
        showNotificationStatusWidget: false,
        showVisibilityStatusWidget: false,
        showSoundStatusWidget: false,
        showFilterStatusWidget: false,
        emptyPaneMessage: "");
  }
}
