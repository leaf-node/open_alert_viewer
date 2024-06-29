/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import 'package:open_alert_viewer/app/data_repository/settings_repository.dart';

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
    on<UpdateLastCheckTime>(_updateLastCheckTime);
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
    var enabled = await _notifier.requestAndEnableNotifications(
        askAgain: event.askAgain, callback: event.callback);
    if (enabled) {
      emit(NotificationsEnabled());
    }
  }

  Future<void> _disableNotifications(
      DisableNotificationsEvent event, Emitter<NotificationState> emit) async {
    await _notifier.stopForegroundService();
    emit(NotificationsDisabled());
  }

  Future<void> _updateLastCheckTime(
      UpdateLastCheckTime event, Emitter<NotificationState> emit) async {
    _settings.userLastLooked = _settings.lastFetched;
  }
}
