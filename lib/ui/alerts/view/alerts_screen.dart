/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/settings_repository.dart';
import '../../core/widgets/shared_widgets.dart';
import '../cubit/alerts_cubit.dart';
import '../cubit/alerts_state.dart';
import '../bloc/refresh_bloc.dart';
import '../../../domain/alerts.dart';
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
                icon: Icons.refresh,
                onPressed: () {
                  cubit.updateLastSeen();
                  context
                      .read<RefreshIconBloc>()
                      .add(RefreshIconNow(forceRefreshNow: true));
                })
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
    await requestAndEnableNotifications(
        askAgain: false, context: context, callback: () {});
    if (context.mounted) {
      await requestBatteryPermission(context: context, askAgain: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RefreshIconBloc, RefreshIconState>(
        listener: (context, state) {
      if (state is RefreshIconTriggered) {
        refreshKey.currentState?.show();
      }
    }, child: Builder(builder: (context) {
      final state = context.watch<AlertsCubit>().state;
      final cubit = context.read<AlertsCubit>();
      List<Widget> alertWidgets = [];
      Widget child;
      List<bool> filter = _settings.alertFilter;
      List<bool> silenceFilter = _settings.silenceFilter;
      for (var alert in state.alerts) {
        if (filter[alert.kind.index]) {
          if ((alert.downtimeScheduled &&
                  !silenceFilter[SilenceTypes.downtimeScheduled.id]) ||
              (alert.silenced &&
                  !silenceFilter[SilenceTypes.acknowledged.id]) ||
              (!alert.active && !silenceFilter[SilenceTypes.inactive.id])) {
            continue;
          }
          alertWidgets.add(AlertWidget(alert: alert));
        }
      }
      // this goes first to show any error messages even if `sources` is empty
      if (alertWidgets.isNotEmpty) {
        child = ListView(children: alertWidgets);
      } else if (state.status == FetchingStatus.init) {
        child = Container();
      } else if (state.sources.isEmpty) {
        child = const EmptyPane(
            icon: Icons.login, text: "Please configure an account");
      } else {
        String caveat = " ";
        if (state.alerts
            .where((v) => v.kind != AlertType.okay && v.kind != AlertType.up)
            .isNotEmpty) {
          caveat = " (filtered) ";
        }
        child = EmptyPane(icon: Icons.check, text: "No${caveat}alerts here!");
      }
      return RefreshIndicator(
          onRefresh: () async {
            var refreshIconState = context.read<RefreshIconBloc>().state;
            bool forceRefreshNow = true;
            bool alreadyFetching = false;
            if (refreshIconState is RefreshIconTriggered) {
              forceRefreshNow = refreshIconState.forceRefreshNow;
              alreadyFetching = refreshIconState.alreadyFetching;
            }
            if (!alreadyFetching) {
              cubit.fetchAlerts(forceRefreshNow: forceRefreshNow);
              await Future.delayed(const Duration(milliseconds: 100));
            }
            while (true) {
              if (context.mounted &&
                  state.refreshStatus == RefreshIconStatus.fetchingNow) {
                await Future.delayed(const Duration(milliseconds: 100));
              } else {
                break;
              }
            }
            if (context.mounted) {
              context.read<RefreshIconBloc>().add(RefreshIconFinish());
            }
          },
          key: refreshKey,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          child: child);
    }));
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
