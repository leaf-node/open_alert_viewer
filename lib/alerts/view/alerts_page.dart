/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/bloc/navigation_bloc.dart';
import '../../app/bloc/navigation_event.dart';
import '../../app/view/app_view_elements.dart';
import '../bloc/alerts_event.dart';
import '../bloc/alerts_state.dart';
import '../bloc/alerts_bloc.dart';
import 'alerts.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key, required this.title});

  final String title;

  static Route<void> route({required title}) {
    return MaterialPageRoute<void>(builder: (_) => AlertsPage(title: title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AlertsHeader(title: title), body: const AlertsList());
  }
}

class AlertsHeader extends StatelessWidget implements PreferredSizeWidget {
  const AlertsHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: HeaderButton(
            icon: Icons.menu,
            function: () =>
                context.read<NavBloc>().add(OpenSettingsPageEvent())),
        title: Text(title),
        actions: [
          HeaderButton(
              icon: Icons.add,
              function: () => context.read<AlertsBloc>().add(
                  const AddAlertSource(source: ["Random", "0", "", "", ""]))),
          HeaderButton(
              icon: Icons.refresh,
              function: () => context
                  .read<AlertsBloc>()
                  .add(const FetchAlerts(maxCacheAge: Duration.zero))),
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AlertsList extends StatefulWidget {
  const AlertsList({super.key});

  @override
  State<AlertsList> createState() => _AlertsListState();
}

class _AlertsListState extends State<AlertsList> {
  _AlertsListState() : refreshKey = GlobalKey<RefreshIndicatorState>();

  final GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          context
              .read<AlertsBloc>()
              .add(const FetchAlerts(maxCacheAge: Duration.zero));
          await context.read<AlertsBloc>().stream.firstWhere(
                (state) => state is! AlertsFetching,
              );
        },
        key: refreshKey,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        child: BlocBuilder<AlertsBloc, AlertState>(builder: (context, state) {
          List<Widget> alertWidgets = [];
          if (state is AlertsFetching) {
            refreshKey.currentState?.show();
          }
          for (var alert in state.alerts) {
            alertWidgets.add(AlertWidget(alert: alert));
          }
          return ListView(children: alertWidgets);
        }));
  }
}
