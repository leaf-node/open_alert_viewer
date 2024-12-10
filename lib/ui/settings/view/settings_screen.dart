/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../alerts/bloc/alerts_bloc.dart';
import '../../alerts/bloc/alerts_state.dart';
import '../../../domain/alerts.dart';
import '../../core/bloc/navigation_bloc.dart';
import '../../core/bloc/navigation_event.dart';
import '../widgets/settings_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.title});

  final String title;

  static Route<void> route({required title}) {
    return MaterialPageRoute<void>(
        builder: (_) => SettingsScreen(title: title));
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
                context.read<NavBloc>().add(OpenGeneralSettingsScreenEvent())),
        MenuItem(
            icon: Icons.info_outline,
            title: "About App",
            onTap: () => context.read<NavBloc>().add(OpenAboutScreenEvent())),
        const MenuHeaderTile(title: "Accounts"),
        for (AlertSourceData account in state.sources)
          MenuItem(
              icon: Icons.manage_accounts,
              title: account.name,
              onTap: () => context
                  .read<NavBloc>()
                  .add(OpenAccountSettingsScreenEvent(source: account))),
        MenuItem(
            icon: Icons.add,
            title: "Add new account",
            onTap: () => context
                .read<NavBloc>()
                .add(OpenAccountSettingsScreenEvent(source: null))),
      ]);
    });
  }
}
