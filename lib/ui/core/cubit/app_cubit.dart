/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';

import '../../../data/repositories/settings_repo.dart';
import '../../../domain/navigation.dart';
import '../../../utils/utils.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required this.navigation, required this.settings})
      : ready = Completer(),
        super(AppState.init()) {
    _state = state;
    ready.complete();
    _setDarkMode();
    _listenForNavigation();
    _listenForSettings();
    _setAppVersion();
  }

  AppState? _state;
  Completer ready;
  final Navigation navigation;
  final SettingsRepo settings;

  Future<void> _listenForNavigation() async {
    await navigation.ready.future;
    await for (final tuple in navigation.stream!) {
      Screens screen;
      Object? data;
      (screen, data) = tuple;
      _state = _state!.copyWith(screen: screen, data: data);
      _state = _state!.copyWith(
          screenPushed: true, timestamp: DateTime.now().millisecondsSinceEpoch);
      emit(_state!);
    }
  }

  Future<void> _listenForSettings() async {
    await settings.ready.future;
    await for (String name in settings.stream!) {
      if (name == "dark_mode") {
        _setDarkMode();
      }
    }
  }

  void _setDarkMode() {
    bool? darkMode =
        switch (settings.darkMode) { 0 => false, 1 => true, _ => null };
    _state = _state!.copyWith(darkMode: darkMode);
    _state = _state!.copyWith(
        screenPushed: false, timestamp: DateTime.now().millisecondsSinceEpoch);
    emit(_state!);
  }

  bool getDarkMode(Brightness systemBrightness) {
    return _state!.darkMode ?? (systemBrightness == Brightness.dark);
  }

  Future<void> _setAppVersion() async {
    SettingsRepo.appVersion = await Util.getVersion();
  }
}
