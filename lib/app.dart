/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

import 'alerts/bloc/alerts_bloc.dart';
import 'alerts/view/alerts_page.dart';
import 'app/bloc/navigation_bloc.dart';
import 'app/bloc/navigation_state.dart';
import 'app/data_provider/database.dart';
import 'app/repository/app_repository.dart';
import 'settings/view/settings_page.dart';
import 'splash/view/splash_page.dart';

class OAVapp extends StatelessWidget {
  const OAVapp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (_) => LocalDatabase(),
        child: MultiBlocProvider(providers: [
          BlocProvider(create: (_) => NavBloc()),
          BlocProvider(
              create: (context) => AlertsBloc(
                  repo: AppRepo(db: context.read<LocalDatabase>()),
                  refreshFrequencySeconds: 60))
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
                case PopPage():
                  _navigator.pop();
                case ShowAlertsPage():
                  _navigator.pushAndRemoveUntil(
                      AlertsPage.route(title: 'Open Alert Viewer'),
                      (_) => false);
                case ShowSettingsPage():
                  _navigator.push(SettingsPage.route(title: "OAV Settings"));
                case ShowGeneralSettingsPage():
                  _navigator.push(
                      GeneralSettingsPage.route(title: "OAV General Settings"));
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
