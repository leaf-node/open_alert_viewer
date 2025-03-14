/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/alerts.dart';

part 'root_settings_state.freezed.dart';

@freezed
abstract class RootSettingsCubitState with _$RootSettingsCubitState {
  const factory RootSettingsCubitState({
    required List<AlertSourceData> sources,
    required bool? accountUpdated,
  }) = _RootSettingsState;

  factory RootSettingsCubitState.init() {
    return RootSettingsCubitState(sources: [], accountUpdated: null);
  }
}
