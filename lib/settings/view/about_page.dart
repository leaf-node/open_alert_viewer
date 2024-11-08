/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../navigation/bloc/navigation_bloc.dart';
import '../../navigation/bloc/navigation_event.dart';
import 'settings_components.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key, required this.title});

  final String title;

  static Route<void> route({required title}) {
    return MaterialPageRoute<void>(builder: (_) => AboutPage(title: title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SettingsHeader(title: title), body: const AboutList());
  }
}

class AboutList extends StatelessWidget {
  const AboutList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      MenuItem(
          icon: Icons.article_outlined,
          title: "App and License Info",
          onTap: () async {
            context.read<NavBloc>().add(OpenLicensingPageEvent());
          }),
      MenuItem(
          icon: Icons.person_search_outlined,
          title: "Privacy Policy",
          onTap: () async {
            context.read<NavBloc>().add(OpenPrivacyPageEvent());
          }),
      MenuItem(
          icon: Icons.support_outlined,
          title: "Online Support",
          onTap: () async {
            var link = "https://github.com/okcode-studio/open_alert_viewer";
            try {
              var uri = Uri.parse(link);
              await launchUrl(uri);
            } catch (e) {
              log("Error launching URL: $link");
            }
          }),
      MenuItem(
          icon: Icons.volunteer_activism_outlined,
          title: "Donate",
          onTap: () async {
            var link = "https://buymeacoffee.com/okcode.studio";
            try {
              var uri = Uri.parse(link);
              await launchUrl(uri);
            } catch (e) {
              log("Error launching URL: $link");
            }
          }),
    ]);
  }
}
