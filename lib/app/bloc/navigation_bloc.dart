/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import 'navigation_events.dart';
import 'navigation_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(const ShowSplashPage()) {
    on<OpenSplashPageEvent>(_openSplashPage);
    on<OpenAlertsPageEvent>(_openAlertsPage);
    on<OpenSettingsPageEvent>(_openSettingsPage);
  }

  void _openSplashPage(OpenSplashPageEvent event, Emitter<NavState> emit) {
    emit(const ShowSplashPage());
  }

  void _openAlertsPage(OpenAlertsPageEvent event, Emitter<NavState> emit) {
    emit(const ShowAlertsPage());
  }

  void _openSettingsPage(OpenSettingsPageEvent event, Emitter<NavState> emit) {
    emit(const ShowSettingsPage());
  }
}
