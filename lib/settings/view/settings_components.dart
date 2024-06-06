/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';

import '../../app/view/app_view_elements.dart';

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.function});

  final IconData icon;
  final String title;
  final void Function() function;

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: function);
  }
}

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
      title,
      style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.bold),
    ));
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
            function: () => Navigator.of(context).pop()),
        title: Text(title));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
