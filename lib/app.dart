/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_alert_viewer/app/data_repository/settings_repository.dart';
import 'dart:ui';

import 'alerts/bloc/alerts_bloc.dart';
import 'alerts/view/alerts_page.dart';
import 'app/bloc/navigation_bloc.dart';
import 'app/bloc/navigation_state.dart';
import 'app/data_source/database.dart';
import 'app/data_repository/app_repository.dart';
import 'settings/view/settings_page.dart';
import 'splash/view/splash_page.dart';

class OAVapp extends StatelessWidget {
  const OAVapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => LocalDatabase()),
          RepositoryProvider(
              create: (context) =>
                  SettingsRepo(db: context.read<LocalDatabase>())),
          RepositoryProvider(
              create: (context) => AppRepo(
                  db: context.read<LocalDatabase>(),
                  settings: context.read<SettingsRepo>())),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(create: (context) => NavBloc()),
          BlocProvider(
              create: (context) => AlertsBloc(repo: context.read<AppRepo>()))
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
                  _navigator.push(
                      GeneralSettingsPage.route(title: "OAV General Settings"));
                case ShowAccountSettingsPage():
                  _navigator.push(AccountSettingsPage.route(
                      title: "OAV Account Settings", source: state.source));
              }
            },
            child: child);
      },
      onGenerateRoute: (_) => SplashPage.route(title: 'Open Alert Viewer'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.lightBlue, secondary: const Color(0xFF224488)),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(
            primary: Color(0xFF224488),
            onPrimary: Colors.white,
            secondary: Color(0xFF66AAFF)),
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehavior(),
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
