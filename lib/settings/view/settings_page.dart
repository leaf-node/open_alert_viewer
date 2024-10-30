/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_alert_viewer/alerts/bloc/refresh_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_settings/app_settings.dart';

import '../../alerts/bloc/alerts_bloc.dart';
import '../../alerts/bloc/alerts_state.dart';
import '../../alerts/model/alerts.dart';
import '../../app/view/app_view_elements.dart';
import '../../navigation/bloc/navigation_bloc.dart';
import '../../navigation/bloc/navigation_event.dart';
import '../../app/data_repository/settings_repository.dart';
import '../../notifications/bloc/notification_bloc.dart';
import '../bloc/settings_bloc.dart';
import 'settings_components.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  static Route<void> route({required title}) {
    return MaterialPageRoute<void>(builder: (_) => SettingsPage(title: title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SettingsHeader(title: title),
        body: BlocListener<AlertsBloc, AlertState>(
            listener: (context, state) {
              switch (state) {
                case SourcesUpdateError():
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("There was an unexpected error while "
                          "trying to modify your accounts.")));
              }
            },
            child: const SettingsList()));
  }
}

class GeneralSettingsPage extends StatelessWidget {
  const GeneralSettingsPage({super.key, required this.title});

  final String title;

  static Route<void> route({required title}) {
    return MaterialPageRoute<void>(
        builder: (_) => GeneralSettingsPage(title: title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SettingsHeader(title: title),
        body: const GeneralSettingsList());
  }
}

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlertsBloc, AlertState>(buildWhen: (previous, current) {
      if (current is SourcesChangedEvent || current is SourcesUpdateError) {
        return true;
      } else {
        return false;
      }
    }, builder: (context, state) {
      return ListView(children: [
        MenuItem(
            icon: Icons.settings,
            title: "General Settings",
            onTap: () =>
                context.read<NavBloc>().add(OpenGeneralSettingsPageEvent())),
        const MenuHeaderTile(title: "Accounts"),
        for (AlertSource account in state.sources)
          MenuItem(
              icon: Icons.manage_accounts,
              title: account.sourceData.name,
              onTap: () => context
                  .read<NavBloc>()
                  .add(OpenAccountSettingsPageEvent(source: account))),
        MenuItem(
            icon: Icons.add,
            title: "Add new account",
            onTap: () => context
                .read<NavBloc>()
                .add(OpenAccountSettingsPageEvent(source: null))),
      ]);
    });
  }
}

enum RefreshFrequencies {
  fifteenSeconds("Every 15 Seconds", 15),
  thirtySeconds("Every 30 Seconds", 30),
  oneMinute("Every Minute", 1 * 60),
  threeMinutes("Every 3 Minutes", 3 * 60),
  fiveMinutes("Every 5 Minutes", 5 * 60),
  fifteenMinutes("Every 15 Minutes", 15 * 60),
  thirtyMinutes("Every 30 Minutes", 30 * 60),
  oneHour("Every Hour", 60 * 60),
  twoHours("Every 2 Hours", 120 * 60),
  off("Off", -1);

  const RefreshFrequencies(this.text, this.value);

  final String text;
  final int value;
}

enum SyncTimeouts {
  fiveSeconds("5 Seconds", 5),
  tenSeconds("10 Seconds", 10),
  fifteenSeconds("15 Seconds", 15),
  thirtySeconds("30 Seconds", 30),
  fortyFiveSeconds("45 Seconds", 45),
  oneMinue("1 Minute", 60),
  twoMinutes("2 Minutes", 120),
  off("Off", -1);

  const SyncTimeouts(this.text, this.value);

  final String text;
  final int value;
}

enum ColorModes {
  auto("Auto", -1),
  lightMode("Light Mode", 0),
  darkMode("Dark Mode", 1);

  const ColorModes(this.text, this.value);

  final String text;
  final int value;
}

class GeneralSettingsList extends StatelessWidget {
  const GeneralSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
      var settings = context.read<SettingsRepo>();
      var settingsBloc = context.read<SettingsBloc>();
      var refreshIconBloc = context.read<RefreshIconBloc>();
      String refreshIntervalSubtitle = () {
        for (var option in RefreshFrequencies.values) {
          if (option.value == settings.refreshInterval) {
            return option.text;
          }
        }
        return "Every ${settings.refreshInterval} seconds";
      }();
      String syncTimeoutSubtitle = () {
        for (var option in SyncTimeouts.values) {
          if (option.value == settings.syncTimeout) {
            return option.text;
          }
        }
        return "Every ${settings.syncTimeout} seconds";
      }();
      String darkModeSubtitle = () {
        for (var option in ColorModes.values) {
          if (option.value == settings.darkMode) {
            return option.text;
          }
        }
        return "Unknown";
      }();
      return ListView(children: [
        MenuItem(
            icon: Icons.update,
            title: "Refresh Interval",
            subtitle: refreshIntervalSubtitle,
            onTap: () async {
              int? result = await settingsRadioDialogBuilder<int>(
                  context: context,
                  text: "Refresh Interval",
                  priorSetting: settings.refreshInterval,
                  valueListBuilder: listRefreshFrequencies);
              if (result != null) {
                settingsBloc.add(SettingsPushEvent(
                    newSettings: {"refreshInterval": result}));
              }
              if (result == -1) {
                settingsBloc.add(SettingsPushEvent(
                    newSettings: {"notificationsEnabled": false}));
              }
            }),
        MenuItem(
            icon: Icons.timer_outlined,
            title: "Sync Timeout",
            subtitle: syncTimeoutSubtitle,
            onTap: () async {
              int? result = await settingsRadioDialogBuilder<int>(
                  context: context,
                  text: "Sync Timeout",
                  priorSetting: settings.syncTimeout,
                  valueListBuilder: listSyncTimeouts);
              if (result != null) {
                settingsBloc.add(
                    SettingsPushEvent(newSettings: {"syncTimeout": result}));
                refreshIconBloc.add(RefreshIconNow(forceRefreshNow: true));
              }
            }),
        MenuItem(
            icon: settings.notificationsEnabled
                ? Icons.notifications_outlined
                : Icons.notifications_off,
            title: "Notifications",
            subtitle: settings.notificationsEnabled
                ? "Enabled within app"
                : "Disabled",
            onTap: () async {
              if (settings.notificationsEnabled) {
                settingsBloc.add(SettingsPushEvent(
                    newSettings: {"notificationsEnabled": false}));
                context
                    .read<NotificationBloc>()
                    .add(DisableNotificationsEvent());
              } else {
                requestAndEnableNotifications(
                    askAgain: true,
                    context: context,
                    callback: () {
                      if (settings.refreshInterval == -1) {
                        final interval = RefreshFrequencies.oneMinute.value;
                        settings.refreshInterval = interval;
                        settingsBloc.add(SettingsPushEvent(
                            newSettings: {"refreshInterval": interval}));
                      }
                      settingsBloc.add(SettingsPushEvent(newSettings: {
                        "notificationsEnabled": settings.notificationsEnabled
                      }));
                    });
              }
            }),
        if (Platform.isAndroid && settings.notificationsEnabled)
          MenuItem(
              icon: Icons.tune,
              title: "System Settings",
              onTap: () async {
                AppSettings.openAppSettings(type: AppSettingsType.notification);
              }),
        if (settings.notificationsEnabled)
          MenuItem(
              icon: settings.soundEnabled
                  ? Icons.music_note_outlined
                  : Icons.music_off_outlined,
              title: "Play Sound",
              subtitle:
                  settings.soundEnabled ? "Enabled within app" : "Disabled",
              onTap: () async {
                settingsBloc.add(SettingsPushEvent(
                    newSettings: {"soundEnabled": !settings.soundEnabled}));
                context.read<NotificationBloc>().add(ToggleSounds());
              }),
        MenuItem(
            icon: Icons.filter_alt_outlined,
            title: "Alerts Filter",
            onTap: () async {
              await settingsCheckBoxDialogBuilder<bool>(
                  context: context,
                  text: "Alerts Filter",
                  priorSetting: settings.alertFilter,
                  valueListBuilder: listFiltered);
            }),
        MenuItem(
            icon: Icons.contrast,
            title: "Dark Mode",
            subtitle: darkModeSubtitle,
            onTap: () async {
              int? result = await settingsRadioDialogBuilder<int>(
                  context: context,
                  text: "Dark Mode",
                  priorSetting: settings.darkMode,
                  valueListBuilder: listColorModes);
              if (result != null) {
                settingsBloc
                    .add(SettingsPushEvent(newSettings: {"darkMode": result}));
              }
            }),
        MenuItem(
            icon: Icons.article_outlined,
            title: "App and License Info",
            onTap: () async {
              context.read<NavBloc>().add(OpenLicensingPageEvent());
            }),
        MenuItem(
            icon: Icons.person_search_outlined,
            title: "Privacy Policy",
            onTap: () async {
              context.read<NavBloc>().add(OpenPrivacyPageEvent());
            }),
        MenuItem(
            icon: Icons.support_outlined,
            title: "Online Support",
            onTap: () async {
              var link = "https://github.com/okcode-studio/open_alert_viewer";
              var uri = Uri.parse(link);
              try {
                await launchUrl(uri);
              } catch (e) {
                log("Error launching URL: $link");
              }
            }),
        MenuItem(
            icon: Icons.volunteer_activism_outlined,
            title: "Donate",
            onTap: () async {
              var link = "https://buymeacoffee.com/okcode.studio";
              var uri = Uri.parse(link);
              try {
                await launchUrl(uri);
              } catch (e) {
                log("Error launching URL: $link");
              }
            }),
      ]);
    });
  }
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
          callback: (BuildContext context, bool? newValue, int index) {
            context.read<SettingsBloc>().add(SettingsPushEvent(
                newSettings: {"setAlertFilterAt": (newValue, index)}));
          })
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
