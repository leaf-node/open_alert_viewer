import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/alerts.dart';
import '../model/alert.dart';
import '../model/alerts.dart';
import 'alert.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key, required this.title, required this.sources});

  final String title;
  final List<AlertSource> sources;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AlertsCubit(sources),
        child:
            Scaffold(appBar: Header(title: title), body: const AlertsList()));
  }
}

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(title),
        actions: [
          Ink(
              color: Colors.black,
              child: IconButton(
                  icon: const Icon(Icons.refresh),
                  color: Colors.white,
                  onPressed: () =>
                      context.read<AlertsCubit>().fetch(Duration.zero)))
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AlertsList extends StatelessWidget {
  const AlertsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlertsCubit, List<Alert>>(builder: (context, state) {
      List<Widget> alertWidgets = [];
      for (var alert in state) {
        alertWidgets.add(AlertWidget(alert: alert));
      }
      return Column(children: alertWidgets);
    });
  }
}
