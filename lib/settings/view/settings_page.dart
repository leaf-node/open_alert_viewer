/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/bloc/navigation_bloc.dart';
import '../../app/bloc/navigation_event.dart';
import '../../app/data_repository/settings_repository.dart';
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
        appBar: SettingsHeader(title: title), body: const SettingsList());
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
    return ListView(children: [
      MenuItem(
          icon: Icons.settings,
          title: "General Settings",
          function: () =>
              context.read<NavBloc>().add(OpenGeneralSettingsPageEvent())),
      const MenuHeader(title: "Accounts"),
      MenuItem(
          icon: Icons.manage_accounts, title: "Random", function: () => ()),
      MenuItem(icon: Icons.add, title: "Add new account", function: () => ()),
    ]);
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
  never("Never", null);

  const RefreshFrequencies(this.text, this.periodMinutes);

  final String text;
  final int? periodMinutes;
}

class GeneralSettingsList extends StatelessWidget {
  const GeneralSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      MenuItem(
          icon: Icons.update,
          title: "Refresh Interval",
          function: () async {
            var settings = context.read<SettingsRepo>();
            int? result = await _dialogBuilder(
                context: context,
                text: "Refresh Interval",
                priorSettingMinutes: settings.refreshInterval);
            settings.refreshInterval = result;
          }),
    ]);
  }
}

Future<int?> _dialogBuilder(
    {required BuildContext context,
    required String text,
    required int? priorSettingMinutes}) async {
  return await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            child: SizedBox(
                width: 300,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  for (var option in RefreshFrequencies.values)
                    RadioListTile<int?>(
                      title: Text(option.text),
                      value: option.periodMinutes,
                      groupValue: priorSettingMinutes,
                      onChanged: (int? value) {
                        Navigator.of(context).pop(value);
                      },
                    ),
                ])));
      });
}
