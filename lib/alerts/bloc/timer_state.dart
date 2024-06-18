/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

part of 'timer_bloc.dart';

abstract class TimerState {
  const TimerState();

  @override
  int get hashCode =>
      Object.hash("TimerState", DateTime.now().microsecondsSinceEpoch);

  @override
  bool operator ==(Object other) {
    return false;
  }
}

final class TimerInitial extends TimerState {}

final class TimerIntervalRefreshedState extends TimerState {}

final class TimerIntervalStartedState extends TimerState {}
