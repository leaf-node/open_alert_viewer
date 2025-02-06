/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

import '../../../data/repositories/sticky_notification_repo.dart';
import '../../background/domain/background_external.dart';
import '../../background/domain/background_shared.dart';
import '../repositories/account_repo.dart';
import '../repositories/settings_repo.dart';

class NotificationsRepo {
  NotificationsRepo(
      {required StickyNotificationRepo stickyNotificationRepo,
      required AccountsRepo accounts,
      required SettingsRepo settings,
      required BackgroundChannel bgChannel})
      : _stickyNotificationRepo = stickyNotificationRepo,
        _accounts = accounts,
        _settings = settings,
        _bgChannel = bgChannel {
    if (!Platform.isAndroid && !Platform.isIOS) {
      player = AudioPlayer();
    }
    _listenForNotificationEvents();
  }

  final StickyNotificationRepo _stickyNotificationRepo;
  final AccountsRepo _accounts;
  final SettingsRepo _settings;
  final BackgroundChannel _bgChannel;
  late AudioPlayer? player;

  Future<void> requestAndEnableNotifications(
      {required bool askAgain, required Function() callback}) async {
    await _stickyNotificationRepo.requestAndEnableNotifications(
        askAgain: askAgain, callback: callback);
    await enableOrDisableNotifications();
  }

  Future<void> enableOrDisableNotifications([bool? newValue]) async {
    if (newValue != null) {
      _settings.notificationsEnabled = newValue;
    }
    bool allDisabled;
    if (_accounts.listSources().where((e) => e.notifications == true).isEmpty) {
      allDisabled = true;
    } else {
      allDisabled = false;
    }
    if (await _settings.notificationsEnabledSafe && !allDisabled) {
      await _bgChannel.makeRequest(
          const IsolateMessage(name: MessageName.enableNotifications));
    } else {
      await _bgChannel.makeRequest(
          const IsolateMessage(name: MessageName.disableNotifications));
    }
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
