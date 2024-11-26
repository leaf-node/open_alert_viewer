/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../background/background.dart';
import '../data_repository/notification.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc(
      {required StickyNotificationRepo notificationRepo,
      required BackgroundWorker bgWorker})
      : _notificationRepo = notificationRepo,
        _bgWorker = bgWorker,
        super(NotificationInitial()) {
    on<RequestAndEnableNotificationEvent>(_requestAndEnableNotifications,
        transformer: droppable());
    on<DisableNotificationsEvent>(_disableNotifications);
    on<EnableNotificationsEvent>(_enableNotifications);
    on<ToggleSounds>(_toggleIntegratedAlertSounds);
    on<ListenForNotificationEvents>(_listenForNotificationEvents);
    if (!Platform.isAndroid && !Platform.isIOS) {
      player = AudioPlayer();
    }
    add(ListenForNotificationEvents());
  }

  final StickyNotificationRepo _notificationRepo;
  final BackgroundWorker _bgWorker;
  late AudioPlayer? player;

  Future<void> _requestAndEnableNotifications(
      RequestAndEnableNotificationEvent event,
      Emitter<NotificationState> emit) async {
    var enabled = await _notificationRepo.requestAndEnableNotifications(
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

  void _enableNotifications(
      EnableNotificationsEvent event, Emitter<NotificationState> emit) async {
    await _bgWorker.makeRequest(
        const IsolateMessage(name: MessageName.enableNotifications));
    emit(NotificationsEnabled());
  }

  void _toggleIntegratedAlertSounds(
      ToggleSounds event, Emitter<NotificationState> emit) async {
    await _bgWorker
        .makeRequest(const IsolateMessage(name: MessageName.toggleSounds));
    emit(SoundsToggled());
  }

  Future<void> _listenForNotificationEvents(ListenForNotificationEvents event,
      Emitter<NotificationState> emit) async {
    await for (final message
        in _bgWorker.isolateStreams[MessageDestination.notifications]!.stream) {
      if (message.name == MessageName.playDesktopSound) {
        if (!Platform.isAndroid && !Platform.isIOS) {
          player?.play(AssetSource("sound/alarm.ogg"));
        }
      } else {
        throw Exception(
            "OAV Invalid 'notifications' stream message name: ${message.name}");
      }
    }
  }
}
