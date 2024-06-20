/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {
  const SettingsInitial();
}

final class SettingsChanged extends SettingsState {
  const SettingsChanged({required this.settings});

  final Map<String, Object> settings;

  @override
  List<Object> get props => [settings];
}
