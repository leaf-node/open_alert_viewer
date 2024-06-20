/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

part of 'settings_bloc.dart';

abstract class SettingsEvent {
  const SettingsEvent();
}

final class SettingsInitEvent extends SettingsEvent {
  const SettingsInitEvent();
}

final class SettingsPushEvent extends SettingsEvent {
  const SettingsPushEvent({required this.newSettings});

  final Map<String, Object> newSettings;
}
