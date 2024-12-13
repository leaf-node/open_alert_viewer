/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/alerts.dart';
import '../../core/widgets/shared_widgets.dart';
import '../cubit/general_settings_cubit.dart';
import '../cubit/general_settings_state.dart';
import '../widgets/settings_widgets.dart';

class GeneralSettingsScreen extends StatelessWidget {
  const GeneralSettingsScreen(
      {super.key, required this.title, required this.cubit});

  final String title;
  final GeneralSettingsCubit cubit;

  static Route<void> route({required title, required cubit}) {
    return MaterialPageRoute<void>(
        builder: (_) => GeneralSettingsScreen(title: title, cubit: cubit));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SettingsHeader(title: title),
        body: GeneralSettingsList(cubit: cubit));
  }
}

class GeneralSettingsList extends StatelessWidget {
  const GeneralSettingsList({super.key, required this.cubit});
  final GeneralSettingsCubit cubit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralSettingsCubit, GeneralSettingsCubitState>(
        builder: (context, state) {
      return ListView(children: [
        MenuItem(
            icon: Icons.update,
            title: "Refresh Interval",
            subtitle: state.refreshIntervalSubtitle,
            onTap: () async {
              await cubit.onTapRefreshIntervalButton(
                  await settingsRadioDialogBuilder<int>(
                      context: context,
                      text: "Refresh Interval",
                      priorSetting: state.settings["refreshInterval"] as int,
                      valueListBuilder: listRefreshFrequencies));
            }),
        MenuItem(
            icon: Icons.timer_outlined,
            title: "Sync Timeout",
            subtitle: state.syncTimeoutSubtitle,
            onTap: () async {
              await cubit.onTapSyncTimeoutButton(
                  await settingsRadioDialogBuilder<int>(
                      context: context,
                      text: "Sync Timeout",
                      priorSetting: state.settings["syncTimeout"] as int,
                      valueListBuilder: listSyncTimeouts));
            }),
        MenuItem(
            icon: state.settings["notificationsEnabled"] as bool
                ? Icons.notifications_outlined
                : Icons.notifications_off,
            title: "Notifications",
            subtitle: state.notificationsEnabledSubtitle,
            onTap: () async {
              await cubit.onTapNotificationsEnabled(context);
            }),
        if (Platform.isAndroid &&
            state.settings["notificationsEnabled"] as bool)
          MenuItem(
              icon: Icons.tune,
              title: "System Settings",
              onTap: cubit.openAppSettings),
        if (state.settings["notificationsEnabled"] as bool)
          MenuItem(
              icon: state.settings["soundEnabled"] as bool
                  ? Icons.music_note_outlined
                  : Icons.music_off_outlined,
              title: "Play Sound",
              subtitle: state.soundEnabledSubtitle,
              onTap: cubit.onTapPlaySoundEnabled),
        MenuItem(
            icon: Icons.filter_alt_outlined,
            title: "Alerts Filter",
            onTap: () async {
              await settingsCheckBoxDialogBuilder<bool>(
                  context: context,
                  text: "Show Alert Types",
                  priorSetting: state.settings["alertFilter"] as List<bool>,
                  valueListBuilder: listFiltered);
            }),
        MenuItem(
            icon: Icons.bedtime_outlined,
            title: "Silence Filter",
            onTap: () async {
              await settingsCheckBoxDialogBuilder<bool>(
                  context: context,
                  text: "Show Silenced Alerts",
                  priorSetting: state.settings["silenceFilter"] as List<bool>,
                  valueListBuilder: listSilenceFilters);
            }),
        MenuItem(
            icon: Icons.contrast,
            title: "Dark Mode",
            subtitle: state.darkModeSubtitle,
            onTap: () async {
              await cubit.onTapDarkMode(await settingsRadioDialogBuilder<int>(
                  context: context,
                  text: "Dark Mode",
                  priorSetting: state.settings["darkMode"] as int,
                  valueListBuilder: listColorModes));
            }),
        if (Platform.isAndroid)
          Builder(builder: (BuildContext context) {
            return MenuItem(
                icon: Icons.battery_saver_outlined,
                title: "Battery Permission",
                subtitle: state.batteryPermissionSubtitle,
                onTap: () async {
                  await requestBatteryPermission(
                      context: context, askAgain: true);
                });
          }),
      ]);
    });
  }

  List<SettingsRadioEnumValue> listRefreshFrequencies<T>({T? priorSetting}) {
    return [
      for (var option in RefreshFrequencies.values)
        SettingsRadioEnumValue<T>(
            title: option.text,
            value: option.value as T,
            priorSetting: priorSetting)
    ];
  }

  List<SettingsRadioEnumValue> listSyncTimeouts<T>({T? priorSetting}) {
    return [
      for (var option in SyncTimeouts.values)
        SettingsRadioEnumValue<T>(
            title: option.text,
            value: option.value as T,
            priorSetting: priorSetting)
    ];
  }

  List<SettingsCheckBoxEnumValue> listFiltered(
      {required List<bool> priorSetting}) {
    return [
      for (var option in AlertType.values)
        SettingsCheckBoxEnumValue(
            title: option.name,
            value: priorSetting[option.index],
            index: option.index,
            callback: cubit.setAlertFilterAt)
    ];
  }

  List<SettingsCheckBoxEnumValue> listSilenceFilters(
      {required List<bool> priorSetting}) {
    return [
      for (var option in SilenceTypes.values)
        SettingsCheckBoxEnumValue(
            title: option.text,
            value: priorSetting[option.index],
            index: option.index,
            callback: cubit.setSilenceFilterAt)
    ];
  }

  List<SettingsRadioEnumValue> listColorModes<T>({T? priorSetting}) {
    return [
      for (var option in ColorModes.values)
        SettingsRadioEnumValue<T>(
            title: option.text,
            value: option.value as T,
            priorSetting: priorSetting)
    ];
  }
}
