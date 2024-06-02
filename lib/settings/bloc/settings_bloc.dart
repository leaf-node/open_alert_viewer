/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../app/repository/app_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required appRepo})
      : _appRepo = appRepo,
        super(SettingsInitial()) {
    on<InitSettings>(_initSettings);
    on<LoadSetting>(_loadSetting);
    on<SetSetting>(_setSetting);

    add(const InitSettings());
  }

  final AppRepo _appRepo;

  Future<void> _loadSetting(
      LoadSetting event, Emitter<SettingsState> emit) async {
    String value = _appRepo.getSetting(setting: event.setting);
    emit(SettingUpdatedOrLoaded(setting: event.setting, value: value));
  }

  Future<void> _initSettings(
      InitSettings event, Emitter<SettingsState> emit) async {
    List<String> settings = _appRepo.listSettings();
    for (var setting in settings) {
      add(LoadSetting(setting: setting));
    }
  }

  Future<void> _setSetting(
      SetSetting event, Emitter<SettingsState> emit) async {
    emit(SettingUpdatedOrLoaded(setting: event.setting, value: event.value));
  }
}
