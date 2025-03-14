/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

part of 'account_settings_cubit.dart';

@freezed
class AccountSettingsState with _$AccountSettingsState {
  const factory AccountSettingsState({
    required bool globalNotificationsEnabled,
    required AlertSourceData? source,
  }) = _AccountSettingsState;

  factory AccountSettingsState.init({
    required SettingsRepo settings,
    required AlertSourceData? source,
  }) {
    return AccountSettingsState(
      globalNotificationsEnabled: settings.notificationsEnabledUnsafe,
      source: source,
    );
  }
}
