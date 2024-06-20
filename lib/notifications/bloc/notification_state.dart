/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

part of 'notification_bloc.dart';

abstract class NotificationState {
  const NotificationState();
}

final class NotificationInitial extends NotificationState {}

final class NotificationShown extends NotificationState {}

final class NotificationRemoved extends NotificationState {}
