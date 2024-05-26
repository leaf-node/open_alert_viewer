/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

import 'alerts/view/alerts_list.dart';
import 'app/bloc/navigation_bloc.dart';
import 'app/bloc/navigation_state.dart';
import 'app/repository/database.dart';
import 'app/repository/sources.dart';
import 'settings/view/settings_page.dart';
import 'splash/view/splash_page.dart';

class OAVapp extends StatefulWidget {
  const OAVapp({super.key});

  @override
  State<OAVapp> createState() => _OAVappState();
}

class _OAVappState extends State<OAVapp> {
  late final Sources sources;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (_) => LocalDatabase(),
        child:
            BlocProvider(create: (_) => NavBloc(), child: const OAVappView()));
  }
}

class OAVappView extends StatefulWidget {
  const OAVappView({super.key});

  @override
  State<OAVappView> createState() => _OAVappViewState();
}

class _OAVappViewState extends State<OAVappView> {
  late final _navigatorKey = GlobalKey<NavigatorState>();

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
                  _navigator.push(AlertsPage.route(title: 'Open Alert Viewer'));
                case ShowSettingsPage():
                  _navigator.push(SettingsPage.route(title: "OAV Settings"));
              }
            },
            child: child);
      },
      onGenerateRoute: (_) => SplashPage.route(
          title: 'Open Alert Viewer',
          localDatabase: context.read<LocalDatabase>()),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
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
