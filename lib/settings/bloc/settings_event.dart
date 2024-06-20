/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

final class SettingsInitEvent extends SettingsEvent {
  const SettingsInitEvent();
}

final class SettingsPushEvent extends SettingsEvent {
  const SettingsPushEvent({required this.newSettings});

  final Map<String, Object> newSettings;

  @override
  List<Object> get props => [newSettings];
}
