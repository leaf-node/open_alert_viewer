/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

part of 'timer_bloc.dart';

abstract class TimerEvent {
  const TimerEvent();
}

final class StartTimerIntervalEvent extends TimerEvent {
  StartTimerIntervalEvent({required this.callback});

  final void Function(Timer) callback;
}

final class RefreshTimerIntervalEvent extends TimerEvent {
  RefreshTimerIntervalEvent({required this.callback});

  final void Function(Timer) callback;
}
