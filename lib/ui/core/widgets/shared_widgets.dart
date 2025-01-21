/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/battery_repo.dart';
import '../../../data/repositories/settings_repo.dart';
import '../../../data/repositories/sticky_notification_repo.dart';
import '../../../data/repositories/notifications_repo.dart';

class HeaderButton extends StatelessWidget {
  const HeaderButton({super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Ink(
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
        ),
        child: IconButton(icon: Icon(icon), onPressed: onPressed));
  }
}

Future<bool?> textDialogBuilder(
    {required BuildContext context,
    required String text,
    required bool cancellable,
    bool? reverseColors,
    String? okayText,
    String? cancelText,
    bool popToCancel = false,
    bool popValue = false}) async {
  return await showDialog<bool?>(
      context: context,
      builder: (BuildContext context) {
        var dangerColor = Theme.of(context).colorScheme.error;
        var safeColor = Theme.of(context).colorScheme.secondary;
        return PopScope(
            canPop: !popToCancel,
            onPopInvokedWithResult: (bool didPop, dynamic result) async {
              if (!didPop) {
                return Navigator.of(context).pop(popValue);
              }
            },
            child: Dialog(
                child: SizedBox(
                    width: 300,
                    child: ListView(shrinkWrap: true, children: [
                      Column(mainAxisSize: MainAxisSize.min, children: [
                        Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(text)),
                        Row(children: [
                          if (cancellable == true)
                            SettingsButton<bool>(
                                text: cancelText ?? "Cancel",
                                retVal: false,
                                color: reverseColors ?? false
                                    ? safeColor
                                    : dangerColor),
                          SettingsButton<bool>(
                              text: okayText ?? "Okay",
                              retVal: true,
                              color: reverseColors ?? false
                                  ? dangerColor
                                  : safeColor),
                        ]),
                        const Padding(padding: EdgeInsets.only(bottom: 15))
                      ])
                    ]))));
      });
}

class SettingsButton<T> extends StatelessWidget {
  const SettingsButton(
      {super.key,
      required this.text,
      required this.retVal,
      required this.color});

  final String text;
  final T retVal;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
            child: TextButton(
                onPressed: () => Navigator.of(context).pop(retVal),
                child: Text(text, style: TextStyle(color: color)))));
  }
}

Future<void> requestAndEnableNotifications(
    {required BuildContext context,
    required bool askAgain,
    required Function() callback}) async {
  final settings = context.read<SettingsRepo>();
  final notificationsRepo = context.read<NotificationsRepo>();
  bool result;
  if (!(await StickyNotificationRepo.areNotificationsAllowed()) &&
      (!settings.notificationsRequested || askAgain) &&
      context.mounted) {
    result = await textDialogBuilder(
            context: context,
            text: "Enable notifications? This allows fetching alerts "
                "in the background, but uses more battery power.\n\n"
                "You can also turn it on or off later.",
            okayText: "Continue",
            cancellable: true) ??
        false;
  } else if (!askAgain && Platform.isAndroid) {
    result = false;
  } else {
    result = true;
  }
  if (result == true) {
    await notificationsRepo.requestAndEnableNotifications(
        askAgain: askAgain, callback: callback);
  } else {
    callback();
  }
  settings.notificationsRequested = true;
}

Future<BatterySetting> requestBatteryPermission(
    {required BuildContext context, required bool askAgain}) async {
  final settings = context.read<SettingsRepo>();
  final repo = context.read<BatteryPermissionRepo>();
  bool shouldAsk = !settings.batteryPermissionRequested || askAgain;
  bool willAsk;
  if (Platform.isAndroid && !(await BatteryPermissionRepo.getStatus()).active) {
    if (shouldAsk && context.mounted) {
      willAsk = await textDialogBuilder(
              context: context,
              text: "Disable battery optimizations? This allows the "
                  "app to stay active, but uses more battery power.\n\n"
                  "You can also turn it on later.",
              okayText: "Continue",
              cancellable: true) ??
          false;
    } else {
      willAsk = false;
    }
  } else {
    willAsk = false;
  }
  if (willAsk && context.mounted) {
    return repo.requestBatteryPermission();
  } else {
    settings.batteryPermissionRequested = true;
    return BatteryPermissionRepo.getStatus();
  }
}
