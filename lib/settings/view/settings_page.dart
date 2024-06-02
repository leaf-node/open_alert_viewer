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
import 'menu_item.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  static Route<void> route({required title}) {
    return MaterialPageRoute<void>(builder: (_) => SettingsPage(title: title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SettingsHeader(title: title), body: const SettingsList());
  }
}

class GeneralSettingsPage extends StatelessWidget {
  const GeneralSettingsPage({super.key, required this.title});

  final String title;

  static Route<void> route({required title}) {
    return MaterialPageRoute<void>(
        builder: (_) => GeneralSettingsPage(title: title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SettingsHeader(title: title),
        body: const GeneralSettingsList());
  }
}

class SettingsHeader extends StatelessWidget implements PreferredSizeWidget {
  const SettingsHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: HeaderButton(
            icon: Icons.arrow_back,
            function: () => context.read<NavBloc>().add(PopPageEvent())),
        title: Text(title));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      MenuItem(
          icon: Icons.settings,
          title: "General Settings",
          function: () =>
              context.read<NavBloc>().add(OpenGeneralSettingsPageEvent())),
      const MenuHeader(title: "Accounts"),
      MenuItem(
          icon: Icons.manage_accounts, title: "Random", function: () => ()),
      MenuItem(icon: Icons.add, title: "Add new account", function: () => ()),
    ]);
  }
}

class GeneralSettingsList extends StatelessWidget {
  const GeneralSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      MenuItem(
          icon: Icons.update, title: "Refresh Interval", function: () => ()),
    ]);
  }
}
