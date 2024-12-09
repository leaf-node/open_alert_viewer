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

import '../widgets/settings_widgets.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key, required this.title});

  final String title;

  static Route<void> route({required String title}) {
    return MaterialPageRoute<void>(builder: (_) => PrivacyScreen(title: title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SettingsHeader(title: title),
        body: const Center(child: PrivacyInfo()));
  }
}

class PrivacyInfo extends StatefulWidget {
  const PrivacyInfo({super.key});

  @override
  State<PrivacyInfo> createState() => _PrivacyInfoState();
}

class _PrivacyInfoState extends State<PrivacyInfo> {
  late String _text;
  late Future<String> _licenseString;
  final String _errorMessage = "Error loading privacy policy. "
      "Please check the project source code or website.";

  @override
  void initState() {
    super.initState();
    _licenseString = rootBundle.loadString("PRIVACY.md");
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
                  data: _text,
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
