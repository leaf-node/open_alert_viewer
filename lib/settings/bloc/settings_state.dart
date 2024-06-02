/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class SettingUpdatedOrLoaded extends SettingsState {
  const SettingUpdatedOrLoaded({required this.setting, required this.value});

  final String setting;
  final String value;

  @override
  List<Object> get props => [setting, value];
}
