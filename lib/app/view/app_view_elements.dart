/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';

class HeaderButton extends StatelessWidget {
  const HeaderButton({super.key, required this.icon, required this.function});

  final IconData icon;
  final void Function() function;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Ink(
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
          ),
          child: IconButton(
              icon: Icon(icon), color: Colors.white, onPressed: function)),
      const SizedBox(width: 10)
    ]);
  }
}
