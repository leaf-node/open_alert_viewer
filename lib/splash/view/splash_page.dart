/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/bloc/navigation_bloc.dart';
import '../../app/bloc/navigation_events.dart';
import '../../app/repository/database.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage(
      {super.key, required this.title, required this.localDatabase});

  final String title;
  final LocalDatabase localDatabase;

  static Route<void> route({required title, required localDatabase}) {
    return MaterialPageRoute<void>(
        builder: (_) => SplashPage(title: title, localDatabase: localDatabase));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SplashBloc(localDatabase: localDatabase),
        child: BlocListener<SplashBloc, SplashState>(
            listener: (context, state) {
              switch (state) {
                case SplashComplete():
                  context.read<NavBloc>().add(OpenAlertsPageEvent());
              }
            },
            child: const Scaffold(
                backgroundColor: Colors.black,
                body: Align(
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            color: Colors.white,
                            size: 96,
                            Icons.swap_calls,
                          ),
                          Text(
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                              textAlign: TextAlign.center,
                              "Open Alert Viewer"),
                        ])))));
  }
}
