/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

part of 'notification_bloc.dart';

sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

final class InitializeNotificationEvent extends NotificationEvent {
  const InitializeNotificationEvent(
      {required this.askAgain, required this.callback});

  final bool askAgain;
  final void Function() callback;

  @override
  List<Object> get props => [askAgain, callback];
}

final class ShowNotificationEvent extends NotificationEvent {
  const ShowNotificationEvent({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

final class RemoveNotificationEvent extends NotificationEvent {
  const RemoveNotificationEvent();
}

final class ShowFilteredNotificationsEvent extends NotificationEvent {
  const ShowFilteredNotificationsEvent(
      {required this.timeSincePrevFetch, required this.alerts});

  final Duration timeSincePrevFetch;
  final List<Alert> alerts;

  @override
  List<Object> get props => [timeSincePrevFetch, ...alerts];
}
