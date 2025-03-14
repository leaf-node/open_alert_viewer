/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      appBar: AlertsHeader(title: title),
      body: const AlertsList(),
    );
  }
}

class AlertsHeader extends StatelessWidget implements PreferredSizeWidget {
  const AlertsHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AlertsCubit>();
    Widget visibilityStatusWidget;
    Widget notificationsStatusWidget;
    Widget soundStatusWidget;
    Widget filterStatusWidget;
    return BlocBuilder<AlertsCubit, AlertsCubitState>(
      builder: (context, state) {
        visibilityStatusWidget =
            state.showVisibilityStatusWidget
                ? HeaderButton(
                  icon: Icons.visibility_off,
                  onPressed: cubit.openRootSettings,
                )
                : Container();
        notificationsStatusWidget =
            state.showNotificationStatusWidget
                ? HeaderButton(
                  icon: Icons.notifications_off,
                  onPressed: cubit.openRootSettings,
                )
                : Container();
        soundStatusWidget =
            state.showSoundStatusWidget
                ? HeaderButton(
                  icon: Icons.music_off_outlined,
                  onPressed: cubit.openGeneralSettings,
                )
                : Container();
        filterStatusWidget =
            state.showFilterStatusWidget
                ? HeaderButton(
                  icon: Icons.filter_alt_off_outlined,
                  onPressed: cubit.openGeneralSettings,
                )
                : Container();
        return AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          leading: HeaderButton(
            icon: Icons.menu,
            onPressed: cubit.openRootSettings,
          ),
          title: Text(title),
          actions: [
            filterStatusWidget,
            soundStatusWidget,
            notificationsStatusWidget,
            visibilityStatusWidget,
            HeaderButton(
              icon: Icons.refresh,
              onPressed: () async => await cubit.onTapRefresh(),
            ),
          ],
        );
      },
    );
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<AlertsCubit>().updateLastSeen();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (ModalRoute.of(context)?.isCurrent ?? false) {
      context.read<AlertsCubit>().updateLastSeen();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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
            children:
                state.filteredAlerts
                    .map((alert) => AlertWidget(alert: alert))
                    .toList(),
          );
        } else if (state.status == FetchingStatus.init) {
          child = Container();
        } else {
          if (state.sources.isEmpty) {
            emptyIcon = Icons.login;
          } else {
            emptyIcon = Icons.check;
          }
          final bottomGap = (Platform.isAndroid) ? 40 : 0;
          // a scrollable for pull-to-refresh
          child = LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      maxWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight - bottomGap,
                      maxHeight: constraints.maxHeight - bottomGap,
                    ),
                    child: Center(
                      child: EmptyPane(
                        icon: emptyIcon,
                        text: state.emptyPaneMessage,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
        return RefreshIndicator(
          onRefresh: cubit.onRefresh,
          key: refreshKey,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          child: child,
        );
      },
    );
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
          Text(text, style: TextStyle(fontSize: 20, color: color)),
        ],
      ),
    );
  }
}
