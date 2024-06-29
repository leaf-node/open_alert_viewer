/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer Authors
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
