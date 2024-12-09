/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../notifications/bloc/notification_bloc.dart';
import '../../../data/services/notification.dart';
import '../../../settings/cubit/battery_permission_cubit.dart';
import '../../../data/repositories/settings_repository.dart';

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

Future textDialogBuilder(
    {required BuildContext context,
    required String text,
    required bool cancellable,
    bool? reverseColors,
    String? okayText,
    String? cancelText}) async {
  return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        var dangerColor = Theme.of(context).colorScheme.error;
        var safeColor = Theme.of(context).colorScheme.secondary;
        return Dialog(
            child: SizedBox(
                width: 300,
                child: ListView(shrinkWrap: true, children: [
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    Padding(
                        padding: const EdgeInsets.all(15), child: Text(text)),
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
                          color:
                              reverseColors ?? false ? dangerColor : safeColor),
                    ]),
                    const Padding(padding: EdgeInsets.only(bottom: 15))
                  ])
                ])));
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
  final stickyRepo = context.read<StickyNotificationRepo>();
  final notificationBloc = context.read<NotificationBloc>();
  bool result;
  if (!(await stickyRepo.areNotificationsAllowed()) &&
      (!settings.notificationsRequested || askAgain) &&
      context.mounted) {
    result = await textDialogBuilder(
        context: context,
        text: "Please enable notifications to allow background data "
            "synchronization. Notifications can also be enabled later in "
            "the settings menu.",
        okayText: "Continue",
        cancellable: true);
  } else if (!askAgain && Platform.isAndroid) {
    result = false;
  } else {
    result = true;
  }
  if (result == true) {
    notificationBloc.add(RequestAndEnableNotificationEvent(
        askAgain: askAgain, callback: callback));
  }
}

Future<void> requestBatteryPermission(
    {required BuildContext context, required bool askAgain}) async {
  final settings = context.read<SettingsRepo>();
  final cubit = context.read<BatteryPermissionCubit>();
  bool shouldAsk = !settings.batteryPermissionRequested || askAgain;
  bool willAsk;
  await cubit.refreshState();
  if (Platform.isAndroid && !cubit.state.value.active) {
    if (shouldAsk && context.mounted) {
      willAsk = await textDialogBuilder(
          context: context,
          text: "Please disable battery optimizations to allow the "
              "app to run in the background. This permission can "
              "also be set later in the app's settings.",
          okayText: "Continue",
          cancellable: true);
    } else {
      willAsk = false;
    }
  } else {
    willAsk = false;
  }
  if (willAsk && context.mounted) {
    cubit.requestPermission();
  }
}
