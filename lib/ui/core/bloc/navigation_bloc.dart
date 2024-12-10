/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(ShowAlertsScreen()) {
    on<OpenAlertsScreenEvent>(_openAlertsScreen);
    on<OpenSettingsScreenEvent>(_openSettingsScreen);
    on<OpenGeneralSettingsScreenEvent>(_openGeneralSettingsScreen);
    on<OpenAboutScreenEvent>(_openAboutScreen);
    on<OpenAccountSettingsScreenEvent>(_openAccountSettingsScreen);
    on<OpenLicensingScreenEvent>(_openLicensingScreen);
    on<OpenPrivacyScreenEvent>(_openPrivacyScreen);
  }

  void _openAlertsScreen(OpenAlertsScreenEvent event, Emitter<NavState> emit) {
    emit(ShowAlertsScreen());
  }

  void _openSettingsScreen(
      OpenSettingsScreenEvent event, Emitter<NavState> emit) {
    emit(ShowSettingsScreen());
  }

  void _openGeneralSettingsScreen(
      OpenGeneralSettingsScreenEvent event, Emitter<NavState> emit) {
    emit(ShowGeneralSettingsScreen());
  }

  void _openAboutScreen(OpenAboutScreenEvent event, Emitter<NavState> emit) {
    emit(ShowAboutScreen());
  }

  void _openAccountSettingsScreen(
      OpenAccountSettingsScreenEvent event, Emitter<NavState> emit) {
    emit(ShowAccountSettingsScreen(source: event.source));
  }

  void _openLicensingScreen(
      OpenLicensingScreenEvent event, Emitter<NavState> emit) {
    emit(ShowLicensingScreen());
  }

  void _openPrivacyScreen(
      OpenPrivacyScreenEvent event, Emitter<NavState> emit) {
    emit(ShowPrivacyScreen());
  }
}
