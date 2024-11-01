/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:developer';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/data_repository/settings_repository.dart';
import 'settings_components.dart';

class LicensingPage extends StatelessWidget {
  const LicensingPage({super.key, required this.title});

  final String title;

  static Route<void> route({required String title}) {
    return MaterialPageRoute<void>(builder: (_) => LicensingPage(title: title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SettingsHeader(title: title),
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
              child: Markdown(
                  data: "# Open Alert Viewer\n\nversion: "
                      "${SettingsRepo.appVersion}\n$_text",
                  onTapLink: (_, href, __) async {
                    try {
                      var uri = Uri.parse(href ?? "");
                      await launchUrl(uri);
                    } catch (e) {
                      log("Error launching URL: $href");
                    }
                  }));
        });
  }
}
