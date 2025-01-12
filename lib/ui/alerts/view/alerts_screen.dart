/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/settings_repo.dart';
import '../../core/widgets/shared_widgets.dart';
import '../cubit/alerts_cubit.dart';
import '../cubit/alerts_state.dart';
import 'alerts.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key, required this.title});

  final String title;

  static Route<void> route({required title}) {
    return MaterialPageRoute<void>(builder: (_) => AlertsScreen(title: title));
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
    var cubit = context.read<AlertsCubit>();
    Widget notificationsStatusWidget;
    Widget soundStatusWidget;
    Widget filterStatusWidget;
    return BlocBuilder<AlertsCubit, AlertsCubitState>(
        builder: (context, state) {
      notificationsStatusWidget = state.showNotificationStatusWidget
          ? HeaderButton(
              icon: Icons.notifications_off,
              onPressed: cubit.openGeneralSettings)
          : Container();
      soundStatusWidget = state.showSoundStatusWidget
          ? HeaderButton(
              icon: Icons.music_off_outlined,
              onPressed: cubit.openGeneralSettings)
          : Container();
      filterStatusWidget = state.showFilterStatusWidget
          ? HeaderButton(
              icon: Icons.filter_alt_off_outlined,
              onPressed: cubit.openGeneralSettings)
          : Container();
      return AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          leading:
              HeaderButton(icon: Icons.menu, onPressed: cubit.openRootSettings),
          title: Text(title),
          actions: [
            filterStatusWidget,
            soundStatusWidget,
            notificationsStatusWidget,
            HeaderButton(
                icon: Icons.refresh, onPressed: () => cubit.onTapRefresh())
          ]);
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AlertsList extends StatefulWidget {
  const AlertsList({super.key});

  @override
  State<AlertsList> createState() => _AlertsListState();
}

class _AlertsListState extends State<AlertsList> with WidgetsBindingObserver {
  _AlertsListState() : refreshKey = GlobalKey<RefreshIndicatorState>();

  final GlobalKey<RefreshIndicatorState> refreshKey;
  late SettingsRepo _settings;

  @override
  void initState() {
    super.initState();
    _settings = context.read<SettingsRepo>();
    WidgetsBinding.instance.addObserver(this);
    context.read<AlertsCubit>().updateLastSeen();
    _requestPermissions(context);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (ModalRoute.of(context)?.isCurrent ?? false) {
      context.read<AlertsCubit>().updateLastSeen();
    }
    if (state == AppLifecycleState.resumed && _settings.notificationsEnabled) {
      requestAndEnableNotifications(
          askAgain: false, context: context, callback: () {});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _requestPermissions(BuildContext context) async {
    Completer notificationsRequested = Completer();
    await requestAndEnableNotifications(
        askAgain: false,
        context: context,
        callback: notificationsRequested.complete);
    await notificationsRequested.future;
    await Future.delayed(Duration(milliseconds: 500));
    if (context.mounted) {
      await requestBatteryPermission(context: context, askAgain: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AlertsCubit>();
    return BlocBuilder<AlertsCubit, AlertsCubitState>(
        builder: (context, state) {
      if (state.refresh.status == RefreshIconStatus.triggeredOrRunning) {
        refreshKey.currentState?.show();
      }
      Widget child;
      IconData emptyIcon;
      if (state.filteredAlerts.isNotEmpty) {
        child = ListView(
            children: state.filteredAlerts
                .map((alert) => AlertWidget(alert: alert))
                .toList());
      } else if (state.status == FetchingStatus.init) {
        child = Container();
      } else {
        if (state.sources.isEmpty) {
          emptyIcon = Icons.login;
        } else {
          emptyIcon = Icons.check;
        }
        child = EmptyPane(icon: emptyIcon, text: state.emptyPaneMessage);
      }
      return RefreshIndicator(
          onRefresh: cubit.onRefresh,
          key: refreshKey,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          child: child);
    });
  }
}

class EmptyPane extends StatelessWidget {
  const EmptyPane({super.key, required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).colorScheme.onSurface;
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Icon(icon, size: 100, color: color),
          const SizedBox(height: 10),
          Text(text, style: TextStyle(fontSize: 20, color: color))
        ]));
  }
}
