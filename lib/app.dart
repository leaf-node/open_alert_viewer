/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'alerts/bloc/alerts_bloc.dart';
import 'alerts/bloc/refresh_bloc.dart';
import 'alerts/view/alerts_page.dart';
import 'app/data_source/database.dart';
import 'background/background.dart';
import 'navigation/bloc/navigation_bloc.dart';
import 'navigation/bloc/navigation_state.dart';
import 'app/data_repository/settings_repository.dart';
import 'notifications/bloc/notification_bloc.dart';
import 'notifications/data_repository/notification.dart';
import 'settings/bloc/settings_bloc.dart';
import 'settings/data_repository/account_repository.dart';
import 'settings/view/licensing_page.dart';
import 'settings/view/settings_account.dart';
import 'settings/view/settings_page.dart';

class OAVapp extends StatelessWidget {
  const OAVapp(
      {super.key,
      required this.appVersion,
      required this.db,
      required this.bgWorker});

  final String appVersion;
  final LocalDatabase db;
  final BackgroundWorker bgWorker;

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
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(create: (context) => NavBloc()),
          BlocProvider(
              create: (context) => NotificationBloc(
                  notificationRepo: context.read<StickyNotificationRepo>(),
                  settings: context.read<SettingsRepo>(),
                  bgWorker: bgWorker)),
          BlocProvider(
              create: (context) => RefreshIconBloc(bgWorker: bgWorker)),
          BlocProvider(create: (context) => AlertsBloc(bgWorker: bgWorker)),
          BlocProvider(
              create: (context) => SettingsBloc(
                  settings: context.read<SettingsRepo>(), bgWorker: bgWorker)),
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
                  case ShowAlertsPage():
                    _navigator.pushAndRemoveUntil(
                        AlertsPage.route(title: 'Open Alert Viewer'),
                        (_) => false);
                  case ShowSettingsPage():
                    _navigator.push(SettingsPage.route(title: "OAV Settings"));
                  case ShowGeneralSettingsPage():
                    _navigator.push(GeneralSettingsPage.route(
                        title: "OAV General Settings"));
                  case ShowAccountSettingsPage():
                    _navigator.push(AccountSettingsPage.route(
                        title: "OAV Account Settings", source: state.source));
                  case ShowLicensingPage():
                    _navigator.push(
                        LicensingPage.route(title: "License Information"));
                }
              },
              child: child);
        },
        onGenerateRoute: (_) => AlertsPage.route(title: 'Open Alert Viewer'),
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
