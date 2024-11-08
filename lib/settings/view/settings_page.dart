/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../alerts/bloc/alerts_bloc.dart';
import '../../alerts/bloc/alerts_state.dart';
import '../../alerts/model/alerts.dart';
import '../../navigation/bloc/navigation_bloc.dart';
import '../../navigation/bloc/navigation_event.dart';
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
