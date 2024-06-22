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
    on<ShowNotificationEvent>(_showNotification);
    on<RemoveNotificationEvent>(_removeNotification);
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
        askAgain: event.askAgain, callback: event.callback);
  }

  Future<void> _showNotification(
      ShowNotificationEvent event, Emitter<NotificationState> emit) async {
    if (_settings.notificationsEnabled) {
      await _notifier.showNotification(message: event.message);
      emit(NotificationShown());
    }
  }

  Future<void> _removeNotification(
      RemoveNotificationEvent event, Emitter<NotificationState> emit) async {
    if (_settings.notificationsEnabled) {
      await _notifier.removeNotification();
      emit(NotificationRemoved());
    }
  }

  Future<void> _showFilteredNotifications(ShowFilteredNotificationsEvent event,
      Emitter<NotificationState> emit) async {
    int newSyncFailureCount = 0, newDownCount = 0, newErrorCount = 0;
    List<String> messages = [];
    for (var alert in event.alerts) {
      if (alert.age.compareTo(event.timeSince) >= 0) {
        continue;
      }
      if (alert.kind == AlertType.syncFailure) {
        newSyncFailureCount += 1;
      } else if (alert.kind == AlertType.down ||
          alert.kind == AlertType.unreachable) {
        newDownCount += 1;
      } else if (alert.kind == AlertType.error) {
        newErrorCount += 1;
      }
    }
    if (newSyncFailureCount > 0) {
      messages.add("$newSyncFailureCount Sync Failures");
    }
    if (newDownCount > 0) {
      messages.add("$newDownCount Newly Down");
    }
    if (newErrorCount > 0) {
      messages.add("$newErrorCount New Error${newErrorCount == 1 ? "" : "s"}");
    }

    if (messages.isNotEmpty) {
      add(ShowNotificationEvent(message: messages.join(", ")));
    } else {
      add(RemoveNotificationEvent());
    }
  }
}
