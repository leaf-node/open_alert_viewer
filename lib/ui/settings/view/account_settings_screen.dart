/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/account_repo.dart';
import '../../../data/repositories/notifications_repo.dart';
import '../../../data/repositories/settings_repo.dart';
import '../cubit/account_settings_cubit.dart';
import '../widgets/settings_widgets.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key, required this.sourceId});

  final String title = "Account Settings";
  final int sourceId;

  static Route<void> route({required int sourceId}) {
    return MaterialPageRoute<void>(
      builder: (_) => AccountSettingsScreen(sourceId: sourceId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => AccountSettingsCubit(
            id: sourceId,
            settings: context.read<SettingsRepo>(),
            accountsRepo: context.read<AccountsRepo>(),
            notificationRepo: context.read<NotificationsRepo>(),
          ),
      child: BlocBuilder<AccountSettingsCubit, AccountSettingsState>(
        builder: (context, state) {
          final cubit = context.read<AccountSettingsCubit>();
          if (state.source == null) {
            Navigator.of(context).pop();
          }
          return Scaffold(
            appBar: GeneralHeader(title: title),
            body: ListView(
              children: [
                MenuItem(
                  title: "Edit Account Details",
                  icon: Icons.edit,
                  onTap:
                      () => openAccountEditor(
                        context: context,
                        sourceID: state.source!.id,
                        popAgainOnRemoval: true,
                      ),
                ),
                MenuItem(
                  title: "Account Visibility",
                  icon:
                      (state.source?.visible ?? false)
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                  subtitle:
                      (state.source?.visible ?? false) ? "Shown" : "Hidden",
                  onTap: () => cubit.switchVisibility(),
                ),
                MenuItem(
                  title: "Notifications",
                  icon:
                      ((state.source?.notifications ?? false) &&
                              state.globalNotificationsEnabled)
                          ? Icons.notifications_outlined
                          : Icons.notifications_off,
                  subtitle:
                      (state.source?.notifications ?? false)
                          ? ((state.globalNotificationsEnabled)
                              ? "On"
                              : "On (Globally Off)")
                          : "Off",
                  onTap: () => cubit.switchNotifications(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
