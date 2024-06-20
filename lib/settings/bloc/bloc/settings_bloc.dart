/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../app/data_repository/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required SettingsRepo repo})
      : _settingsRepo = repo,
        super(const SettingsInitial()) {
    on<SettingsPushEvent>(_pushSettings);

    add(const SettingsPushEvent(newSettings: {}));
  }

  final SettingsRepo _settingsRepo;

  void _pushSettings(SettingsPushEvent event, Emitter<SettingsState> emit) {
    for (var setting in event.newSettings.keys) {
      switch (setting) {
        case "refreshInterval":
          _settingsRepo.refreshInterval = event.newSettings[setting];
        case "syncTimeout":
          _settingsRepo.syncTimeout = event.newSettings[setting];
        case "notificationsRequested":
          _settingsRepo.notificationsRequested = event.newSettings[setting];
        case "notificationsGranted":
          _settingsRepo.notificationsGranted = event.newSettings[setting];
        case "notificationsEnabled":
          _settingsRepo.notificationsEnabled = event.newSettings[setting];
        case _:
          throw "Unsupported setting: $setting";
      }
    }
    emit(SettingsChanged(settings: {
      "refreshInterval": _settingsRepo.refreshInterval,
      "syncTimeout": _settingsRepo.syncTimeout,
      "notificationsRequested": _settingsRepo.notificationsRequested,
      "notificationsGranted": _settingsRepo.notificationsGranted,
      "notificationsEnabled": _settingsRepo.notificationsEnabled,
    }));
  }
}
