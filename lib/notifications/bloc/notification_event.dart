/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
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

final class UpdateLastCheckTime extends NotificationEvent {
  UpdateLastCheckTime();
}
