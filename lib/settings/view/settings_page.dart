/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../alerts/bloc/alerts_bloc.dart';
import '../../alerts/bloc/alerts_event.dart';
import '../../alerts/bloc/alerts_state.dart';
import '../../alerts/bloc/timer_bloc.dart';
import '../../alerts/model/alerts.dart';
import '../../app/bloc/navigation_bloc.dart';
import '../../app/bloc/navigation_event.dart';
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
                case SourcesListUpdateError():
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text("Ignoring duplicate of existing alert source")));
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
    return BlocBuilder<AlertsBloc, AlertState>(builder: (context, state) {
      return ListView(children: [
        MenuItem(
            icon: Icons.settings,
            title: "General Settings",
            function: () =>
                context.read<NavBloc>().add(OpenGeneralSettingsPageEvent())),
        const MenuHeaderTile(title: "Accounts"),
        for (AlertSource account in state.sources)
          MenuItem(
              icon: Icons.manage_accounts,
              title: account.name,
              function: () => context
                  .read<NavBloc>()
                  .add(OpenAccountSettingsPageEvent(source: account))),
        MenuItem(
            icon: Icons.add,
            title: "Add new account",
            function: () => context
                .read<NavBloc>()
                .add(OpenAccountSettingsPageEvent(source: null))),
      ]);
    });
  }
}

enum RefreshFrequencies {
  oneMinute("Every Minute", 1),
  threeMinutes("Every 3 Minutes", 3),
  fiveMinutes("Every 5 Minutes", 5),
  fifteenMinutes("Every 15 Minutes", 15),
  thirtyMinutes("Every 30 Minutes", 30),
  oneHour("Every Hour", 60),
  twoHours("Every 2 Hours", 120),
  off("Off", -1);

  const RefreshFrequencies(this.text, this.value);

  final String text;
  final int value;
}

enum SyncTimeouts {
  oneMinute("5 Seconds", 5),
  threeMinutes("10 Seconds", 10),
  fiveMinutes("15 Seconds", 15),
  fifteenMinutes("30 Seconds", 30),
  thirtyMinutes("45 Seconds", 45),
  oneHour("1 Minute", 60),
  twoHours("2 Minutes", 120),
  off("Off", -1);

  const SyncTimeouts(this.text, this.value);

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
      var alertsBloc = context.read<AlertsBloc>();
      var timerBloc = context.read<TimerBloc>();
      String refreshIntervalSubtitle = () {
        for (var option in RefreshFrequencies.values) {
          if (option.value == settings.refreshInterval) {
            return option.text;
          }
        }
        return "Every ${settings.refreshInterval} minutes";
      }();
      String syncTimeoutSubtitle = () {
        for (var option in SyncTimeouts.values) {
          if (option.value == settings.syncTimeout) {
            return option.text;
          }
        }
        return "Every ${settings.syncTimeout} seconds";
      }();
      String notificationsEnabledSubtitle = () {
        return settings.notificationsEnabled ? "Enabled" : "Disabled";
      }();
      return ListView(children: [
        MenuItem(
            icon: Icons.update,
            title: "Refresh Interval",
            subtitle: refreshIntervalSubtitle,
            function: () async {
              int? result = await _settingsDialogBuilder<int>(
                  context: context,
                  text: "Refresh Interval",
                  priorSetting: settings.refreshInterval,
                  valueListBuilder: listRefreshFrequencies);
              if (result != null) {
                settingsBloc.add(SettingsPushEvent(
                    newSettings: {"refreshInterval": result}));
                timerBloc.add(RefreshTimerIntervalEvent(callback: (timer) {
                  alertsBloc.add(FetchAlerts(forceRefreshNow: true));
                }));
              }
            }),
        MenuItem(
            icon: Icons.timer_outlined,
            title: "Sync Timeout",
            subtitle: syncTimeoutSubtitle,
            function: () async {
              int? result = await _settingsDialogBuilder<int>(
                  context: context,
                  text: "Sync Timeout",
                  priorSetting: settings.syncTimeout,
                  valueListBuilder: listSyncTimeouts);
              if (result != null) {
                settingsBloc.add(
                    SettingsPushEvent(newSettings: {"syncTimeout": result}));
                alertsBloc.add(FetchAlerts(forceRefreshNow: true));
              }
            }),
        MenuItem(
            icon: Icons.notifications_outlined,
            title: "Notifications",
            subtitle: notificationsEnabledSubtitle,
            function: () async {
              if (settings.notificationsEnabled) {
                settingsBloc.add(SettingsPushEvent(
                    newSettings: {"notificationsEnabled": false}));
              } else if (settings.notificationsGranted) {
                settingsBloc.add(SettingsPushEvent(
                    newSettings: {"notificationsEnabled": true}));
              } else {
                context
                    .read<NotificationBloc>()
                    .add(InitializeNotificationEvent(
                        askAgain: true,
                        callback: () {
                          settingsBloc.add(SettingsPushEvent(newSettings: {
                            "notificationsEnabled":
                                settings.notificationsEnabled
                          }));
                        }));
              }
            })
      ]);
    });
  }
}

Future _settingsDialogBuilder<T>(
    {required BuildContext context,
    required String text,
    required T? priorSetting,
    required Function<T>({T? priorSetting}) valueListBuilder}) async {
  return await showDialog<T>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            child: SizedBox(
                width: 300,
                child: ListView(shrinkWrap: true, children: [
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      children: valueListBuilder<T>(priorSetting: priorSetting))
                ])));
      });
}

List<SettingsEnumValue> listRefreshFrequencies<T>({T? priorSetting}) {
  return [
    for (var option in RefreshFrequencies.values)
      SettingsEnumValue<T>(
          title: option.text,
          value: option.value as T,
          priorSetting: priorSetting)
  ];
}

List<SettingsEnumValue> listSyncTimeouts<T>({T? priorSetting}) {
  return [
    for (var option in SyncTimeouts.values)
      SettingsEnumValue<T>(
          title: option.text,
          value: option.value as T,
          priorSetting: priorSetting)
  ];
}

class SettingsEnumValue<T> extends StatelessWidget {
  const SettingsEnumValue(
      {super.key,
      required this.title,
      required this.value,
      required this.priorSetting});

  final String title;
  final T value;
  final T? priorSetting;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
        title: Text(title),
        value: value,
        groupValue: priorSetting,
        onChanged: (T? value) {
          Navigator.of(context).pop(value);
        });
  }
}
