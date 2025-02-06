/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/navigation.dart';
import '../widgets/settings_widgets.dart';
import '../../../oss_licenses.dart';

class LicensingScreen extends StatelessWidget {
  const LicensingScreen({super.key, required this.title});

  final String title;

  static Route<void> route({required String title}) {
    return MaterialPageRoute<void>(
        builder: (_) => LicensingScreen(title: title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GeneralHeader(title: title),
        body: const Center(child: LicensingInfo()));
  }
}

class LicensingInfo extends StatefulWidget {
  const LicensingInfo({super.key});

  @override
  State<LicensingInfo> createState() => _LicensingInfoState();
}

class _LicensingInfoState extends State<LicensingInfo> {
  late String _text;
  late Future<String> _licenseString;
  final String _errorMessage =
      "Error loading licensing info. Please check the project source code.";

  @override
  void initState() {
    super.initState();
    _licenseString = rootBundle.loadString("LICENSE.md");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _licenseString,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            _text = snapshot.data ?? _errorMessage;
          } else {
            _text = _errorMessage;
          }
          return Padding(
              padding: const EdgeInsets.all(15),
              child: ListView(children: [
                MarkdownBody(
                    data: _text,
                    onTapLink: (_, href, __) async {
                      try {
                        var uri = Uri.parse(href ?? "");
                        await launchUrl(uri);
                      } catch (e) {
                        log("Error launching URL: $href");
                      }
                    }),
                SectionHeader(title: "Direct Dependencies"),
                for (Package dependency in dependencies)
                  LicenseTitle(dependency: dependency),
                SectionHeader(title: "Dev Dependencies"),
                for (Package dependency in devDependencies)
                  LicenseTitle(dependency: dependency),
                SectionHeader(title: "Recursive Dependencies"),
                for (Package dependency in allDependencies)
                  if (!dependencies.contains(dependency) &&
                      !devDependencies.contains(dependency))
                    LicenseTitle(dependency: dependency)
              ]));
        });
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 32, 0, 8),
        child: Text(title, style: Theme.of(context).textTheme.headlineSmall));
  }
}

class LicenseTitle extends StatelessWidget {
  const LicenseTitle({
    super.key,
    required this.dependency,
  });

  final Package dependency;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Icons.link_outlined),
        title: Text(dependency.name),
        onTap: () => context
            .read<Navigation>()
            .goTo(Screens.licensingDetails, dependency));
  }
}
