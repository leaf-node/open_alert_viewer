/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

import '../../background/domain/background_external.dart';
import '../../background/domain/background_shared.dart';
import '../../../data/repositories/sticky_notification_repo.dart';

class NotificationsRepo {
  NotificationsRepo(
      {required StickyNotificationRepo stickyNotificationRepo,
      required BackgroundChannel bgChannel})
      : _stickyNotificationRepo = stickyNotificationRepo,
        _bgChannel = bgChannel {
    if (!Platform.isAndroid && !Platform.isIOS) {
      player = AudioPlayer();
    }
    _listenForNotificationEvents();
  }

  final StickyNotificationRepo _stickyNotificationRepo;
  final BackgroundChannel _bgChannel;
  late AudioPlayer? player;

  Future<void> requestAndEnableNotifications(
      {required bool askAgain, required Function() callback}) async {
    var enabled = await _stickyNotificationRepo.requestAndEnableNotifications(
        askAgain: askAgain, callback: callback);
    if (enabled) {
      await enableNotifications();
    }
  }

  Future<void> disableNotifications() async {
    await _bgChannel.makeRequest(
        const IsolateMessage(name: MessageName.disableNotifications));
  }

  Future<void> enableNotifications() async {
    await _bgChannel.makeRequest(
        const IsolateMessage(name: MessageName.enableNotifications));
  }

  Future<void> _listenForNotificationEvents() async {
    await for (final message in _bgChannel
        .isolateStreams[MessageDestination.notifications]!.stream) {
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
