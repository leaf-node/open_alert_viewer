/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';

import '../../app/data_repository/settings_repository.dart';
import '../../app/data_repository/app_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required SettingsRepo settings, required AppRepo repo})
      : _settingsRepo = settings,
        _repo = repo,
        super(SettingsInitial()) {
    on<SettingsPushEvent>(_pushSettings);

    add(SettingsPushEvent(newSettings: {}));
  }

  final SettingsRepo _settingsRepo;
  final AppRepo _repo;

  void _pushSettings(SettingsPushEvent event, Emitter<SettingsState> emit) {
    for (var setting in event.newSettings.keys) {
      var newSetting = event.newSettings[setting];
      switch (setting) {
        case "refreshInterval":
          _settingsRepo.refreshInterval = newSetting;
          _repo.refreshTimer();
        case "syncTimeout":
          _settingsRepo.syncTimeout = newSetting;
        case "notificationsRequested":
          _settingsRepo.notificationsRequested = newSetting;
        case "notificationsEnabled":
          _settingsRepo.notificationsEnabled = newSetting;
        case "alertFilter":
          _settingsRepo.alertFilter = newSetting;
        case "setAlertFilterAt":
          bool value;
          int index;
          (value, index) = newSetting as (bool, int);
          _settingsRepo.setAlertFilterAt(value, index);
        case "darkMode":
          _settingsRepo.darkMode = newSetting;
        case _:
          throw "Unsupported setting: $setting";
      }
    }
    emit(SettingsChanged(settings: {
      "refreshInterval": _settingsRepo.refreshInterval,
      "syncTimeout": _settingsRepo.syncTimeout,
      "notificationsRequested": _settingsRepo.notificationsRequested,
      "notificationsEnabled": _settingsRepo.notificationsEnabled,
      "alertFilter": _settingsRepo.alertFilter,
      "darkMode": _settingsRepo.darkMode,
    }));
  }
}
