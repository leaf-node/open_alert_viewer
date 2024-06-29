/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer Authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../app/data_repository/settings_repository.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  TimerBloc({required SettingsRepo settings})
      : _settings = settings,
        super(TimerInitial()) {
    on<StartTimerIntervalEvent>(_startTimerInterval);
    on<RefreshTimerIntervalEvent>(_refreshTimerInterval);
  }

  final SettingsRepo _settings;
  Timer? _timer;

  void _startTimerInterval(
      StartTimerIntervalEvent event, Emitter<TimerState> emit) {
    if (_timer != null) {
      return;
    }
    var nextFetchIn = _settings.lastFetched
        .add(Duration(minutes: _settings.refreshInterval))
        .difference(DateTime.now());
    Future.delayed(nextFetchIn, () {
      add(RefreshTimerIntervalEvent(callback: event.callback));
    });
    emit(TimerIntervalStartedState());
  }

  void _refreshTimerInterval(
      RefreshTimerIntervalEvent event, Emitter<TimerState> emit) {
    _timer?.cancel();
    _timer = Timer.periodic(
        Duration(minutes: _settings.refreshInterval), event.callback);
    event.callback(_timer!);
    emit(TimerIntervalRefreshedState());
  }
}
