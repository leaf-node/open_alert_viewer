/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/alerts/bloc/alerts_bloc.dart';
import 'ui/alerts/bloc/refresh_bloc.dart';
import 'ui/alerts/view/alerts_screen.dart';
import 'data/services/database.dart';
import 'background/background.dart';
import 'ui/navigation/bloc/navigation_bloc.dart';
import 'ui/navigation/bloc/navigation_state.dart';
import 'data/repositories/settings_repository.dart';
import 'ui/notifications/bloc/notification_bloc.dart';
import 'data/services/notification.dart';
import 'ui/settings/bloc/account_bloc.dart';
import 'ui/settings/bloc/settings_bloc.dart';
import 'ui/settings/cubit/battery_permission_cubit.dart';
import 'data/repositories/account_repository.dart';
import 'data/repositories/battery_repository.dart';
import 'ui/settings/view/about_screen.dart';
import 'ui/settings/view/licensing_screen.dart';
import 'ui/settings/view/privacy_screen.dart';
import 'ui/settings/view/account_settings_screen.dart';
import 'ui/settings/view/general_settings_screen.dart';
import 'ui/settings/view/settings_screen.dart';

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
          RepositoryProvider(create: (context) => SettingsRepo(db: db)),
          RepositoryProvider(create: (context) => AccountsRepo(db: db)),
          RepositoryProvider(
              create: (context) => StickyNotificationRepo(
                  settings: context.read<SettingsRepo>())),
          RepositoryProvider(
              create: (context) => BatteryPermissionRepo(
                  settings: context.read<SettingsRepo>())),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(create: (context) => NavBloc()),
          BlocProvider(
              create: (context) => NotificationBloc(
                  notificationRepo: context.read<StickyNotificationRepo>(),
                  bgChannel: bgChannel)),
          BlocProvider(
              create: (context) => RefreshIconBloc(bgChannel: bgChannel)),
          BlocProvider(create: (context) => AlertsBloc(bgChannel: bgChannel)),
          BlocProvider(
              create: (context) => SettingsBloc(
                  settings: context.read<SettingsRepo>(),
                  bgChannel: bgChannel)),
          BlocProvider(create: (context) => AccountBloc(bgChannel: bgChannel)),
          BlocProvider(
              create: (context) => BatteryPermissionCubit(
                  context.read<BatteryPermissionRepo>())),
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
    return BlocBuilder<SettingsBloc, SettingsState>(
        buildWhen: (oldState, state) {
      if (oldState is! SettingsChanged ||
          (state is SettingsChanged &&
              (state.settings["darkMode"] != oldState.settings["darkMoode"]))) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      int darkModeSetting;
      if (state is SettingsChanged) {
        darkModeSetting = state.settings["darkMode"] as int;
      } else {
        darkModeSetting = 1;
      }
      var systemBrightness = MediaQuery.of(context).platformBrightness;
      bool darkMode = switch (darkModeSetting) {
        0 => false,
        1 => true,
        _ => (systemBrightness == Brightness.dark)
      };
      return MaterialApp(
        title: 'Open Alert Viewer',
        navigatorKey: _navigatorKey,
        builder: (context, child) {
          return BlocListener<NavBloc, NavState>(
              listener: (context, state) {
                switch (state) {
                  case ShowAlertsScreen():
                    _navigator.pushAndRemoveUntil(
                        AlertsScreen.route(title: 'Open Alert Viewer'),
                        (_) => false);
                  case ShowSettingsScreen():
                    _navigator
                        .push(SettingsScreen.route(title: "OAV Settings"));
                  case ShowGeneralSettingsScreen():
                    _navigator.push(GeneralSettingsScreen.route(
                        title: "OAV General Settings"));
                  case ShowAboutScreen():
                    _navigator.push(AboutScreen.route(title: "About OAV"));
                  case ShowAccountSettingsScreen():
                    _navigator.push(AccountSettingsScreen.route(
                        title: "OAV Account Settings", source: state.source));
                  case ShowLicensingScreen():
                    _navigator.push(
                        LicensingScreen.route(title: "License Information"));
                  case ShowPrivacyScreen():
                    _navigator
                        .push(PrivacyScreen.route(title: "Privacy Policy"));
                }
              },
              child: child);
        },
        onGenerateRoute: (_) => AlertsScreen.route(title: 'Open Alert Viewer'),
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
        themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        scrollBehavior: CustomScrollBehavior(),
      );
    });
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
