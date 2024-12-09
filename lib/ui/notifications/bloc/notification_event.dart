/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

part of 'notification_bloc.dart';

abstract class NotificationEvent {
  const NotificationEvent();
}

final class RequestAndEnableNotificationEvent extends NotificationEvent {
  RequestAndEnableNotificationEvent(
      {required this.askAgain, required this.callback});

  final bool askAgain;
  final void Function() callback;
}

final class DisableNotificationsEvent extends NotificationEvent {
  DisableNotificationsEvent();
}

final class EnableNotificationsEvent extends NotificationEvent {
  EnableNotificationsEvent();
}

final class ToggleSounds extends NotificationEvent {
  ToggleSounds();
}

final class ListenForNotificationEvents extends NotificationEvent {
  ListenForNotificationEvents();
}
