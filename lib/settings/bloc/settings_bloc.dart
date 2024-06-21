/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';

import '../../app/data_repository/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required SettingsRepo repo})
      : _settingsRepo = repo,
        super(SettingsInitial()) {
    on<SettingsPushEvent>(_pushSettings);

    add(SettingsPushEvent(newSettings: {}));
  }

  final SettingsRepo _settingsRepo;

  void _pushSettings(SettingsPushEvent event, Emitter<SettingsState> emit) {
    for (var setting in event.newSettings.keys) {
      var newSetting = event.newSettings[setting];
      switch (setting) {
        case "refreshInterval":
          _settingsRepo.refreshInterval = newSetting;
        case "syncTimeout":
          _settingsRepo.syncTimeout = newSetting;
        case "notificationsRequested":
          _settingsRepo.notificationsRequested = newSetting;
        case "notificationsEnabled":
          _settingsRepo.notificationsEnabled = newSetting;
        case _:
          throw "Unsupported setting: $setting";
      }
    }
    emit(SettingsChanged(settings: {
      "refreshInterval": _settingsRepo.refreshInterval,
      "syncTimeout": _settingsRepo.syncTimeout,
      "notificationsRequested": _settingsRepo.notificationsRequested,
      "notificationsEnabled": _settingsRepo.notificationsEnabled,
    }));
  }
}
