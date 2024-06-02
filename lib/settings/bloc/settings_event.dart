/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class InitSettings extends SettingsEvent {
  const InitSettings();
}

class LoadSetting extends SettingsEvent {
  const LoadSetting({required this.setting});

  final String setting;
}

class SetSetting extends SettingsEvent {
  const SetSetting({required this.setting, required this.value});

  final String setting;
  final String value;

  @override
  List<Object> get props => [setting, value];
}
