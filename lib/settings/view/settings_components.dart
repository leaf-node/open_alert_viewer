/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
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
      this.subtitle,
      required this.onTap});

  final IconData icon;
  final String title;
  final String? subtitle;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    if (subtitle == null) {
      return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
    } else {
      return ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(subtitle!),
          onTap: onTap);
    }
  }
}

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key, required this.title, required this.padding});

  final String title;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(padding),
        child: Text(
          title,
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold),
        ));
  }
}

class MenuHeaderTile extends StatelessWidget {
  const MenuHeaderTile({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: MenuHeader(title: title, padding: 0));
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
            onPressed: () => Navigator.of(context).pop()),
        title: Text(title));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
