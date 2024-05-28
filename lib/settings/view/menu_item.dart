/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: Icon(icon), title: Text(title));
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
