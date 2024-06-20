/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../alerts/model/alerts.dart';
import '../../app/bloc/navigation_bloc.dart';
import '../../app/data_repository/settings_repository.dart';
import '../model/notification.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc({required NavBloc navigator, required SettingsRepo settings})
      : _navigator = navigator,
        _settings = settings,
        super(NotificationInitial()) {
    _notifier = Notifier(navigator: _navigator, settings: _settings);

    on<ShowNotificationEvent>(_showNotification);
    on<RemoveNotificationEvent>(_removeNotification);
    on<ShowFilteredNotificationsEvent>(_showFilteredNotifications);
  }

  final NavBloc _navigator;
  final SettingsRepo _settings;
  late Notifier _notifier;

  Future<void> initialize() async {
    await _notifier.initialize();
    _notifier.requestNotificationPermission();
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
    int newDownCount = 0, newErrorCount = 0;
    for (var alert in event.alerts) {
      if (alert.age.compareTo(event.timeSincePrevFetch) >= 0) {
        continue;
      }
      if (alert.kind == AlertType.down || alert.kind == AlertType.unreachable) {
        newDownCount += 1;
      } else if (alert.kind == AlertType.error) {
        newErrorCount += 1;
      }
    }
    if (newDownCount > 0 || newErrorCount > 0) {
      add(ShowNotificationEvent(
          message:
              "$newDownCount Recently Down / Unreachable, $newErrorCount Recent Error${newErrorCount == 1 ? "" : "s"}"));
    } else {
      add(const RemoveNotificationEvent());
    }
  }
}
