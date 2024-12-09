/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

part of 'notification_bloc.dart';

abstract class NotificationState {
  const NotificationState();
}

final class NotificationInitial extends NotificationState {}

final class NotificationsEnabled extends NotificationState {}

final class NotificationsDisabled extends NotificationState {}

final class SoundsToggled extends NotificationState {}
