/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../background/domain/background_external.dart';
import '../../background/domain/background_shared.dart';
import '../../domain/settings.dart';
import '../repositories/account_repo.dart';
import '../repositories/settings_repo.dart';

class NotificationsRepo {
  NotificationsRepo(
      {required AccountsRepo accounts,
      required SettingsRepo settings,
      required BackgroundChannel bgChannel})
      : _accounts = accounts,
        _settings = settings,
        _bgChannel = bgChannel {
    if (!Platform.isAndroid && !Platform.isIOS) {
      player = AudioPlayer();
    }
    _listenForNotificationEvents();
  }

  final AccountsRepo _accounts;
  final SettingsRepo _settings;
  final BackgroundChannel _bgChannel;
  late AudioPlayer? player;

  Future<void> requestAndEnableNotifications({required bool askAgain}) async {
    final result = await requestNotificationPermission(askAgain: askAgain);
    _settings.notificationsRequested = true;
    if (await _settings.notificationsEnabledSafe &&
        _settings.refreshInterval == -1) {
      _settings.refreshInterval = RefreshFrequencies.oneMinute.value;
      _bgChannel
          .makeRequest(const IsolateMessage(name: MessageName.refreshTimer));
    }
    await enableOrDisableNotifications(result);
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

  static Future<bool> areNotificationsAllowed() async {
    if (Platform.isAndroid) {
      return await Permission.notification.isGranted;
    }
    return true;
  }

  Future<bool?> requestNotificationPermission(
      {required bool askAgain, bool? isAppVisible}) async {
    bool? result;
    if (Platform.isAndroid) {
      bool systemNotificationsGranted = await areNotificationsAllowed();
      if (!_settings.notificationsRequested ||
          askAgain ||
          (!systemNotificationsGranted &&
              _settings.notificationsEnabledUnsafe)) {
        result = await Permission.notification.request().isGranted;
      }
    }
    return result;
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
