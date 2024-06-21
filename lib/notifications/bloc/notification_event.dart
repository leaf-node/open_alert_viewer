/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

part of 'notification_bloc.dart';

abstract class NotificationEvent {
  const NotificationEvent();
}

final class InitializeNotificationEvent extends NotificationEvent {
  InitializeNotificationEvent();
}

final class RequestAndEnableNotificationEvent extends NotificationEvent {
  RequestAndEnableNotificationEvent(
      {required this.askAgain, required this.callback});

  final bool askAgain;
  final void Function() callback;
}

final class ShowNotificationEvent extends NotificationEvent {
  ShowNotificationEvent({required this.message});

  final String message;
}

final class RemoveNotificationEvent extends NotificationEvent {
  RemoveNotificationEvent();
}

final class ShowFilteredNotificationsEvent extends NotificationEvent {
  ShowFilteredNotificationsEvent(
      {required this.timeSincePrevFetch, required this.alerts});

  final Duration timeSincePrevFetch;
  final List<Alert> alerts;
}
