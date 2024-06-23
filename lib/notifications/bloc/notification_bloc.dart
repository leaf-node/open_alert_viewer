/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';

import '../data_repository/notification.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({required NotificationRepo notifier})
      : _notifier = notifier,
        super(NotificationInitial()) {
    on<InitializeNotificationEvent>(_initialize);
    on<RequestAndEnableNotificationEvent>(_requestAndEnableNotifications);
    on<DisableNotificationsEvent>(_disableNotifications);
  }

  final NotificationRepo _notifier;

  Future<void> _initialize(InitializeNotificationEvent event,
      Emitter<NotificationState> emit) async {
    await _notifier.initialize();
  }

  Future<void> _requestAndEnableNotifications(
      RequestAndEnableNotificationEvent event,
      Emitter<NotificationState> emit) async {
    var enabled = await _notifier.requestAndEnableNotifications(
        askAgain: event.askAgain,
        callback: event.callback,
        isAppVisible: event.isAppVisible);
    if (enabled) {
      emit(NotificationsEnabled());
    }
  }

  Future<void> _disableNotifications(
      DisableNotificationsEvent event, Emitter<NotificationState> emit) async {
    await _notifier.stopForegroundService();
    emit(NotificationsDisabled());
  }
}
