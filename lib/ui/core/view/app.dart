/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_alert_viewer/data/repositories/alerts_repo.dart';

import '../../../background/background.dart';
import '../../../data/repositories/account_repo.dart';
import '../../../data/repositories/battery_repo.dart';
import '../../../data/services/database.dart';
import '../../../data/repositories/sticky_notification_repo.dart';
import '../../../data/repositories/settings_repo.dart';
import '../../../domain/navigation.dart';
import '../../alerts/cubit/alerts_cubit.dart';
import '../../alerts/view/alerts_screen.dart';
import '../../notifications/bloc/notification_bloc.dart';
import '../../settings/bloc/account_bloc.dart';
import '../../settings/cubit/general_settings_cubit.dart';
import '../../settings/cubit/root_settings_cubit.dart';
import '../../settings/view/about_screen.dart';
import '../../settings/view/account_settings_screen.dart';
import '../../settings/view/general_settings_screen.dart';
import '../../settings/view/licensing_screen.dart';
import '../../settings/view/privacy_screen.dart';
import '../../settings/view/root_settings_screen.dart';
import '../bloc/app_cubit.dart';
import '../bloc/app_state.dart';

class OAVapp extends StatelessWidget {
  const OAVapp(
      {super.key,
      required this.appVersion,
      required this.db,
      required this.bgChannel});

  final String appVersion;
  final LocalDatabase db;
  final BackgroundChannel bgChannel;

  @override
  Widget build(BuildContext context) {
    SettingsRepo.appVersion = appVersion;
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (context) => AlertsRepo(bgChannel: bgChannel)),
          RepositoryProvider(create: (context) => SettingsRepo(db: db)),
          RepositoryProvider(create: (context) => AccountsRepo(db: db)),
          RepositoryProvider(
              create: (context) => StickyNotificationRepo(
                  settings: context.read<SettingsRepo>())),
          RepositoryProvider(
              create: (context) => BatteryPermissionRepo(
                  settings: context.read<SettingsRepo>())),
          RepositoryProvider(create: (context) => Navigation()),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => AppCubit(
                  navigation: context.read<Navigation>(),
                  settings: context.read<SettingsRepo>())),
          BlocProvider(
              create: (context) => NotificationBloc(
                  notificationRepo: context.read<StickyNotificationRepo>(),
                  bgChannel: bgChannel)),
          BlocProvider(
              create: (context) => AlertsCubit(
                  bgChannel: bgChannel,
                  alertsRepo: context.read<AlertsRepo>(),
                  settings: context.read<SettingsRepo>(),
                  navigation: context.read<Navigation>())),
          BlocProvider(
              create: (context) => RootSettingsCubit(bgChannel: bgChannel)),
          BlocProvider(
              create: (context) => GeneralSettingsCubit(
                  settings: context.read<SettingsRepo>(),
                  bgChannel: bgChannel,
                  notificationBloc: context.read<NotificationBloc>(),
                  alertsRepo: context.read<AlertsRepo>())),
          BlocProvider(create: (context) => AccountBloc(bgChannel: bgChannel)),
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
              _navigator.push(SettingsScreen.route(title: "OAV Settings"));
            case Screens.generalSettings:
              _navigator.push(GeneralSettingsScreen.route(
                  title: "OAV General Settings",
                  cubit: context.read<GeneralSettingsCubit>()));
            case Screens.about:
              _navigator.push(AboutScreen.route(title: "About OAV"));
            case Screens.accountSettings:
              _navigator.push(AccountSettingsScreen.route(
                  title: "OAV Account Settings", source: state.source));
            case Screens.licensing:
              _navigator
                  .push(LicensingScreen.route(title: "License Information"));
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
