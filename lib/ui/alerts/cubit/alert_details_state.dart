/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

part of 'alert_details_cubit.dart';

@freezed
abstract class AlertDetailsState with _$AlertDetailsState {
  const factory AlertDetailsState({required String sourceName}) =
      _AlertDetailsState;
  factory AlertDetailsState.initial() {
    return AlertDetailsState(sourceName: "Unknown");
  }
}
