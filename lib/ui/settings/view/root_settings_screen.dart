/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_alert_viewer/ui/settings/cubit/general_settings_cubit.dart';
import 'package:open_alert_viewer/ui/settings/view/general_settings_screen.dart';

import '../../../domain/alerts.dart';
import '../../core/widgets/shared_widgets.dart';
import '../cubit/root_settings_cubit.dart';
import '../cubit/root_settings_state.dart';
import '../widgets/settings_widgets.dart';
import 'about_screen.dart';
import 'account_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  final String title = "Settings";

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => SettingsScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralHeader(title: title),
      body: BlocListener<RootSettingsCubit, RootSettingsCubitState>(
        listenWhen:
            (previous, current) =>
                previous.accountUpdated != current.accountUpdated,
        listener: (context, state) {
          if (state.accountUpdated ?? false) {
            _requestPermissions(context);
          }
        },
        child: const SettingsList(),
      ),
    );
  }

  void _requestPermissions(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 500));
    if (context.mounted) {
      await requestAndEnableNotifications(askAgain: false, context: context);
    }
    await Future.delayed(Duration(milliseconds: 500));
    if (context.mounted) {
      await requestBatteryPermission(context: context, askAgain: false);
    }
  }
}

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootSettingsCubit, RootSettingsCubitState>(
      builder: (context, state) {
        return ListView(
          children: [
            MenuItem(
              icon: Icons.settings,
              title: "General Settings",
              onTap:
                  () => Navigator.of(context).push(
                    GeneralSettingsScreen.route(
                      cubit: context.read<GeneralSettingsCubit>(),
                    ),
                  ),
            ),
            MenuItem(
              icon: Icons.info_outline,
              title: "About App",
              onTap: () => Navigator.of(context).push(AboutScreen.route()),
            ),
            const MenuHeaderTile(title: "Accounts"),
            for (AlertSourceData account in state.sources)
              MenuItem(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 10,
                  children: [
                    Icon(Icons.manage_accounts),
                    if (!account.visible) Icon(Icons.visibility_off),
                    if (!account.notifications) Icon(Icons.notifications_off),
                  ],
                ),
                title: account.name,
                onTap:
                    () => Navigator.of(
                      context,
                    ).push(AccountSettingsScreen.route(sourceId: account.id!)),
              ),
            MenuItem(
              icon: Icons.add,
              title: "Add new account",
              onTap:
                  () => openAccountEditor(
                    context: context,
                    sourceID: null,
                    popAgainOnRemoval: false,
                  ),
            ),
          ],
        );
      },
    );
  }
}
