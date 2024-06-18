/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

part of 'timer_bloc.dart';

abstract class TimerEvent {
  const TimerEvent();
}

final class StartTimerIntervalEvent extends TimerEvent {
  const StartTimerIntervalEvent({required this.callback});

  final void Function(Timer) callback;
}

final class RefreshTimerIntervalEvent extends TimerEvent {
  const RefreshTimerIntervalEvent({required this.callback});

  final void Function(Timer) callback;
}
