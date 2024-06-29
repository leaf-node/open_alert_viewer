/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer Authors
 *
 * SPDX-License-Identifier: MIT
 */

part of 'settings_bloc.dart';

abstract class SettingsEvent {
  const SettingsEvent();
}

final class SettingsInitEvent extends SettingsEvent {}

final class SettingsPushEvent extends SettingsEvent {
  SettingsPushEvent({required this.newSettings});

  final Map<String, Object> newSettings;
}
