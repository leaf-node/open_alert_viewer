/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../domain/alerts.dart';
import '../../../domain/navigation.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc({required this.navigation}) : super(ShowAlertsScreen()) {
    on<ListenForScreens>(_listenForNavigation);
    add(ListenForScreens());
  }

  final Navigation navigation;

  Future<void> _listenForNavigation(
      ListenForScreens event, Emitter<NavState> emit) async {
    await navigation.ready.future;
    await for (final tuple in navigation.stream!) {
      Screens screen;
      Object? data;
      (screen, data) = tuple;
      switch (screen) {
        case Screens.alerts:
          emit(ShowAlertsScreen());
        case Screens.settings:
          emit(ShowSettingsScreen());
        case Screens.generalSettings:
          emit(ShowGeneralSettingsScreen());
        case Screens.about:
          emit(ShowAboutScreen());
        case Screens.accountSettings:
          emit(ShowAccountSettingsScreen(source: data as AlertSourceData?));
        case Screens.licensing:
          emit(ShowLicensingScreen());
        case Screens.privacy:
          emit(ShowPrivacyScreen());
      }
    }
  }
}
