/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/settings.dart';

part 'general_settings_state.freezed.dart';

String placeholder = "Pending...";

@freezed
class GeneralSettingsCubitState with _$GeneralSettingsCubitState {
  const factory GeneralSettingsCubitState({
    required Map<String, Object> settings,
    required String refreshIntervalSubtitle,
    required String syncTimeoutSubtitle,
    required String darkModeSubtitle,
    required String notificationsEnabledSubtitle,
    required String batteryPermissionSubtitle,
    required String soundEnabledSubtitle,
  }) = _GeneralSettingsCubitState;

  factory GeneralSettingsCubitState.init() {
    return GeneralSettingsCubitState.withSettings({
      "refreshInterval": RefreshFrequencies.off,
      "syncTimeout": SyncTimeouts.off,
      "notificationsEnabled": false,
      "soundEnabled": false,
      "alertFilter": [],
      "silenceFilter": [],
      "darkMode": ColorModes.auto,
    });
  }

  factory GeneralSettingsCubitState.withSettings(Map<String, Object> settings) {
    return GeneralSettingsCubitState(
      settings: settings,
      refreshIntervalSubtitle: placeholder,
      syncTimeoutSubtitle: placeholder,
      darkModeSubtitle: placeholder,
      notificationsEnabledSubtitle: placeholder,
      batteryPermissionSubtitle: placeholder,
      soundEnabledSubtitle: placeholder,
    );
  }
}
