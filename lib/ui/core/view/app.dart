/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../background/domain/background_external.dart';
import '../../../data/repositories/account_repo.dart';
import '../../../data/repositories/alerts_repo.dart';
import '../../../data/repositories/battery_repo.dart';
import '../../../data/services/database.dart';
import '../../../data/repositories/settings_repo.dart';
import '../../alerts/cubit/alerts_cubit.dart';
import '../../alerts/view/alerts_screen.dart';
import '../../../data/repositories/notifications_repo.dart';
import '../../settings/cubit/account_editing_cubit.dart';
import '../../settings/cubit/general_settings_cubit.dart';
import '../../settings/cubit/root_settings_cubit.dart';
import '../cubit/app_cubit.dart';
import '../cubit/app_state.dart';

class OAVapp extends StatelessWidget {
  const OAVapp({super.key, required this.db, required this.bgChannel});

  final LocalDatabase db;
  final BackgroundChannel bgChannel;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          lazy: false,
          create: (context) => AlertsRepo(bgChannel: bgChannel),
        ),
        RepositoryProvider(
          lazy: false,
          create: (context) => SettingsRepo(db: db),
        ),
        RepositoryProvider(
          lazy: false,
          create: (context) => AccountsRepo(db: db, bgChannel: bgChannel),
        ),
        RepositoryProvider(
          lazy: false,
          create:
              (context) =>
                  BatteryPermissionRepo(settings: context.read<SettingsRepo>()),
        ),
        RepositoryProvider(
          lazy: false,
          create:
              (context) => NotificationsRepo(
                settings: context.read<SettingsRepo>(),
                accounts: context.read<AccountsRepo>(),
                bgChannel: bgChannel,
              ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => AppCubit(settings: context.read<SettingsRepo>()),
          ),
          BlocProvider(
            create:
                (context) => AlertsCubit(
                  bgChannel: bgChannel,
                  alertsRepo: context.read<AlertsRepo>(),
                  accounts: context.read<AccountsRepo>(),
                  settings: context.read<SettingsRepo>(),
                ),
          ),
          BlocProvider(
            create:
                (context) => RootSettingsCubit(
                  bgChannel: bgChannel,
                  accountsRepo: context.read<AccountsRepo>(),
                ),
          ),
          BlocProvider(
            create:
                (context) => GeneralSettingsCubit(
                  settings: context.read<SettingsRepo>(),
                  bgChannel: bgChannel,
                  notificationsRepo: context.read<NotificationsRepo>(),
                  alertsRepo: context.read<AlertsRepo>(),
                ),
          ),
          BlocProvider(
            create:
                (context) => AccountEditingCubit(
                  bgChannel: bgChannel,
                  accountsRepo: context.read<AccountsRepo>(),
                ),
          ),
        ],
        child: const OAVappView(),
      ),
    );
  }
}

class OAVappView extends StatelessWidget {
  const OAVappView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    return BlocBuilder<AppCubit, AppState>(
      buildWhen: (previous, current) {
        return previous.darkMode != current.darkMode;
      },
      builder: (context, state) {
        return MaterialApp(
          title: 'Open Alert Viewer',
          onGenerateRoute: (_) => AlertsScreen.route(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.lightBlue,
              secondary: const Color(0xFF224488),
              onSurface: const Color(0xFF444444),
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF224488),
              onPrimary: Colors.white,
              secondary: Color(0xFF66AAFF),
              onSurface: Color(0xFFBBBBBB),
            ),
            brightness: Brightness.dark,
            useMaterial3: true,
          ),
          themeMode:
              cubit.getDarkMode(MediaQuery.of(context).platformBrightness)
                  ? ThemeMode.dark
                  : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          scrollBehavior: CustomScrollBehavior(),
        );
      },
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}
