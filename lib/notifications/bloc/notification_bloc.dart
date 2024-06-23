/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';

import '../../alerts/model/alerts.dart';
import '../../app/data_repository/settings_repository.dart';
import '../data_repository/notification.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(
      {required NotificationRepo notifier, required SettingsRepo settings})
      : _notifier = notifier,
        _settings = settings,
        super(NotificationInitial()) {
    on<InitializeNotificationEvent>(_initialize);
    on<RequestAndEnableNotificationEvent>(_requestAndEnableNotifications);
    on<DisableNotificationsEvent>(_disableNotifications);
    on<ShowFilteredNotificationsEvent>(_showFilteredNotifications);
  }

  final NotificationRepo _notifier;
  final SettingsRepo _settings;

  Future<void> _initialize(InitializeNotificationEvent event,
      Emitter<NotificationState> emit) async {
    await _notifier.initialize();
  }

  Future<void> _requestAndEnableNotifications(
      RequestAndEnableNotificationEvent event,
      Emitter<NotificationState> emit) async {
    await _notifier.requestAndEnableNotifications(
        askAgain: event.askAgain,
        callback: event.callback,
        isAppVisible: event.isAppVisible);
  }

  Future<void> _disableNotifications(
      DisableNotificationsEvent event, Emitter<NotificationState> emit) async {
    if (_settings.notificationsEnabled) {
      await _notifier.stopForegroundService();
      emit(NotificationsDisabled());
    }
  }

  Future<void> _showFilteredNotifications(ShowFilteredNotificationsEvent event,
      Emitter<NotificationState> emit) async {
    await _notifier.showFilteredNotifications(
        alerts: event.alerts, timeSince: event.timeSince);
    emit(NotificationsUpdated());
  }
}
