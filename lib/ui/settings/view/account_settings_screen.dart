/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/account_repo.dart';
import '../../../data/repositories/settings_repo.dart';
import '../../../domain/navigation.dart';
import '../cubit/account_settings_cubit.dart';
import '../widgets/settings_widgets.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen(
      {super.key, required this.title, required this.sourceId});

  final String title;
  final int sourceId;

  static Route<void> route({required String title, required int sourceId}) {
    return MaterialPageRoute<void>(
        builder: (_) =>
            AccountSettingsScreen(title: title, sourceId: sourceId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AccountSettingsCubit(
            id: sourceId,
            settings: context.read<SettingsRepo>(),
            accountsRepo: context.read<AccountsRepo>()),
        child: BlocBuilder<AccountSettingsCubit, AccountSettingsState>(
            builder: (context, state) {
          final cubit = context.read<AccountSettingsCubit>();
          if (state.source == null) {
            Navigator.of(context).pop();
          }
          return Scaffold(
              appBar: SettingsHeader(title: title),
              body: ListView(children: [
                MenuItem(
                    title: "Edit Account Details",
                    icon: Icons.edit,
                    onTap: () => context
                        .read<Navigation>()
                        .goTo(Screens.accountEditing, state.source)),
                MenuItem(
                    title: "Account Visibility",
                    icon: (state.source?.visible ?? false)
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    subtitle:
                        (state.source?.visible ?? false) ? "Shown" : "Hidden",
                    onTap: () => cubit.switchVisibility()),
                MenuItem(
                    title: "Notifications",
                    icon: ((state.source?.notifications ?? false) &&
                            state.globalNotificationsEnabled)
                        ? Icons.notifications_outlined
                        : Icons.notifications_off,
                    subtitle: (state.source?.notifications ?? false)
                        ? ((state.globalNotificationsEnabled)
                            ? "On"
                            : "On (Globally Off)")
                        : "Off",
                    onTap: () => cubit.switchNotifications()),
              ]));
        }));
  }
}
