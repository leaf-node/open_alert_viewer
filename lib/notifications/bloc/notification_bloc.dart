/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../app/data_repository/settings_repository.dart';
import '../../background/background.dart';
import '../data_repository/notification.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(
      {required StickyNotificationRepo notifier,
      required SettingsRepo settings,
      required BackgroundWorker bgWorker})
      : _notifier = notifier,
        _settings = settings,
        _bgWorker = bgWorker,
        super(NotificationInitial()) {
    on<RequestAndEnableNotificationEvent>(_requestAndEnableNotifications,
        transformer: droppable());
    on<DisableNotificationsEvent>(_disableNotifications);
    on<ToggleSounds>(_toggleIntegratedAlertSounds);
    on<UpdateLastCheckTime>(_updateLastCheckTime);
  }

  final StickyNotificationRepo _notifier;
  final SettingsRepo _settings;
  final BackgroundWorker _bgWorker;

  Future<void> _requestAndEnableNotifications(
      RequestAndEnableNotificationEvent event,
      Emitter<NotificationState> emit) async {
    var enabled = await _notifier.requestAndEnableNotifications(
        askAgain: event.askAgain, callback: event.callback);
    if (enabled) {
      await _bgWorker.makeRequest(
          const IsolateMessage(name: MessageName.enableNotifications));
      emit(NotificationsEnabled());
    }
  }

  void _disableNotifications(
      DisableNotificationsEvent event, Emitter<NotificationState> emit) async {
    await _bgWorker.makeRequest(
        const IsolateMessage(name: MessageName.disableNotifications));
    emit(NotificationsDisabled());
  }

  void _toggleIntegratedAlertSounds(
      ToggleSounds event, Emitter<NotificationState> emit) async {
    await _bgWorker
        .makeRequest(const IsolateMessage(name: MessageName.toggleSounds));
    emit(SoundsToggled());
  }

  Future<void> _updateLastCheckTime(
      UpdateLastCheckTime event, Emitter<NotificationState> emit) async {
    _settings.userLastLooked = _settings.lastFetched;
  }
}
