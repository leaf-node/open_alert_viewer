/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer Authors
 *
 * SPDX-License-Identifier: MIT
 */

part of 'timer_bloc.dart';

abstract class TimerState {
  const TimerState();
}

final class TimerInitial extends TimerState {}

final class TimerIntervalRefreshedState extends TimerState {}

final class TimerIntervalStartedState extends TimerState {}
