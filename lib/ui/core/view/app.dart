/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_alert_viewer/ui/settings/view/account_settings_screen.dart';

import '../../../background/domain/background_external.dart';
import '../../../data/repositories/account_repo.dart';
import '../../../data/repositories/alerts_repo.dart';
import '../../../data/repositories/battery_repo.dart';
import '../../../data/services/database.dart';
import '../../../data/repositories/settings_repo.dart';
import '../../../domain/alerts.dart';
import '../../../domain/navigation.dart';
import '../../../oss_licenses.dart';
import '../../alerts/cubit/alerts_cubit.dart';
import '../../alerts/view/alerts_screen.dart';
import '../../../data/repositories/notifications_repo.dart';
import '../../settings/cubit/account_editing_cubit.dart';
import '../../settings/cubit/general_settings_cubit.dart';
import '../../settings/cubit/root_settings_cubit.dart';
import '../../settings/view/about_screen.dart';
import '../../settings/view/account_editing_screen.dart';
import '../../settings/view/general_settings_screen.dart';
import '../../settings/view/licensing_details_screen.dart';
import '../../settings/view/licensing_screen.dart';
import '../../settings/view/privacy_screen.dart';
import '../../settings/view/root_settings_screen.dart';
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
              create: (context) => AlertsRepo(bgChannel: bgChannel)),
          RepositoryProvider(
              lazy: false, create: (context) => SettingsRepo(db: db)),
          RepositoryProvider(
              lazy: false,
              create: (context) => AccountsRepo(db: db, bgChannel: bgChannel)),
          RepositoryProvider(
              lazy: false,
              create: (context) => BatteryPermissionRepo(
                  settings: context.read<SettingsRepo>())),
          RepositoryProvider(lazy: false, create: (context) => Navigation()),
          RepositoryProvider(
              lazy: false,
              create: (context) => NotificationsRepo(
                  settings: context.read<SettingsRepo>(),
                  accounts: context.read<AccountsRepo>(),
                  bgChannel: bgChannel)),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => AppCubit(
                  navigation: context.read<Navigation>(),
                  settings: context.read<SettingsRepo>())),
          BlocProvider(
              create: (context) => AlertsCubit(
                  bgChannel: bgChannel,
                  alertsRepo: context.read<AlertsRepo>(),
                  accounts: context.read<AccountsRepo>(),
                  settings: context.read<SettingsRepo>(),
                  navigation: context.read<Navigation>())),
          BlocProvider(
              create: (context) => RootSettingsCubit(bgChannel: bgChannel)),
          BlocProvider(
              create: (context) => GeneralSettingsCubit(
                  settings: context.read<SettingsRepo>(),
                  bgChannel: bgChannel,
                  notificationsRepo: context.read<NotificationsRepo>(),
                  alertsRepo: context.read<AlertsRepo>())),
          BlocProvider(
              create: (context) => AccountEditingCubit(
                  bgChannel: bgChannel,
                  accountsRepo: context.read<AccountsRepo>()))
        ], child: const OAVappView()));
  }
}

class OAVappView extends StatefulWidget {
  const OAVappView({super.key});

  @override
  State<OAVappView> createState() => _OAVappViewState();
}

class _OAVappViewState extends State<OAVappView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AppCubit>();
    return BlocListener<AppCubit, AppState>(
        listenWhen: (previous, current) {
          return current.screenPushed;
        },
        listener: (context, state) {
          switch (state.screen) {
            case Screens.none:
              ;
            case Screens.alerts:
              _navigator.pushAndRemoveUntil(
                  AlertsScreen.route(title: 'Open Alert Viewer'), (_) => false);
            case Screens.rootSettings:
              _navigator.push(SettingsScreen.route(title: "Settings"));
            case Screens.generalSettings:
              _navigator.push(GeneralSettingsScreen.route(
                  title: "General Settings",
                  cubit: context.read<GeneralSettingsCubit>()));
            case Screens.about:
              _navigator
                  .push(AboutScreen.route(title: "About Open Alert Viewer"));
            case Screens.accountEditing:
              _navigator
                  .push(AccountEditingScreen.route(
                      title: "Edit Account",
                      source: state.data as AlertSourceData?))
                  .then((result) {
                if ((result as bool? ?? false) && context.mounted) {
                  context.read<RootSettingsCubit>().accountUpdated();
                }
              });
            case Screens.accountSettings:
              _navigator.push(AccountSettingsScreen.route(
                  title: "Account Settings", sourceId: state.data as int));
            case Screens.licensing:
              _navigator
                  .push(LicensingScreen.route(title: "License Information"));
            case Screens.licensingDetails:
              _navigator.push(LicensingDetailsScreen.route(
                  dependency: state.data as Package));
            case Screens.privacy:
              _navigator.push(PrivacyScreen.route(title: "Privacy Policy"));
          }
        },
        child: BlocBuilder<AppCubit, AppState>(buildWhen: (previous, current) {
          return previous.darkMode != current.darkMode;
        }, builder: (context, state) {
          return MaterialApp(
            title: 'Open Alert Viewer',
            navigatorKey: _navigatorKey,
            onGenerateRoute: (_) =>
                AlertsScreen.route(title: 'Open Alert Viewer'),
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
                  onSurface: Color(0xFFBBBBBB)),
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
        }));
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
