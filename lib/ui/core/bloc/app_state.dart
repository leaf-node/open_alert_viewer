/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/alerts.dart';
import '../../../domain/navigation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState(
      {required Screens screen,
      AlertSourceData? source,
      bool? darkMode}) = _AppState;

  factory AppState.init() {
    return AppState(screen: Screens.none, source: null, darkMode: null);
  }
}
