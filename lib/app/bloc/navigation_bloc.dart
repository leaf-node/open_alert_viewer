/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(ShowSplashPage()) {
    on<OpenSplashPageEvent>(_openSplashPage);
    on<OpenAlertsPageEvent>(_openAlertsPage);
    on<OpenSettingsPageEvent>(_openSettingsPage);
    on<OpenGeneralSettingsPageEvent>(_openGeneralSettingsPage);
    on<OpenAccountSettingsPageEvent>(_openAccountSettingsPage);
  }

  void _openSplashPage(OpenSplashPageEvent event, Emitter<NavState> emit) {
    emit(ShowSplashPage());
  }

  void _openAlertsPage(OpenAlertsPageEvent event, Emitter<NavState> emit) {
    emit(ShowAlertsPage());
  }

  void _openSettingsPage(OpenSettingsPageEvent event, Emitter<NavState> emit) {
    emit(ShowSettingsPage());
  }

  void _openGeneralSettingsPage(
      OpenGeneralSettingsPageEvent event, Emitter<NavState> emit) {
    emit(ShowGeneralSettingsPage());
  }

  void _openAccountSettingsPage(
      OpenAccountSettingsPageEvent event, Emitter<NavState> emit) {
    emit(ShowAccountSettingsPage(source: event.source));
  }
}
