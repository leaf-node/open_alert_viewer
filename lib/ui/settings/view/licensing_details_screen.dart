/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';

import '../../../oss_licenses.dart';
import '../widgets/settings_widgets.dart';

class LicensingDetailsScreen extends StatelessWidget {
  const LicensingDetailsScreen({super.key, required this.dependency});

  final Package dependency;

  static Route<void> route({required Package dependency}) {
    return MaterialPageRoute<void>(
        builder: (_) => LicensingDetailsScreen(dependency: dependency));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SettingsHeader(title: "License of ${dependency.name}"),
        body: ListView(children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(32),
              child: Text(
                  "Package name: ${dependency.name}\n\n"
                  "Version: ${dependency.version}\n\n"
                  "${dependency.license}",
                  style: TextStyle(fontFamily: "monospace")))
        ]));
  }
}
