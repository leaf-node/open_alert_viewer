/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:open_alert_viewer/ui/alerts/view/alerts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../domain/alerts.dart';
import '../../settings/widgets/settings_widgets.dart';

class AlertDetailsScreen extends StatelessWidget {
  AlertDetailsScreen({super.key, required this.title, required this.alert})
      : _viewKind = alert.viewKind;

  final String title;
  final Alert alert;
  final AlertTypeView _viewKind;

  static Route<void> route({required String title, required Alert alert}) {
    return MaterialPageRoute<void>(
        builder: (_) => AlertDetailsScreen(title: title, alert: alert));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GeneralHeader(title: title),
        body: Container(
            color: HSLColor.fromColor(_viewKind.bgColor)
                .withLightness(_viewKind.bgbgLightness)
                .toColor(),
            child: Center(
                child: Container(
                    color: _viewKind.bgColor,
                    constraints: BoxConstraints(maxWidth: 600),
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    margin: EdgeInsets.all(20),
                    child: AlertDetails(alert: alert)))));
  }
}

class AlertDetails extends StatelessWidget {
  AlertDetails({super.key, required this.alert}) : _viewKind = alert.viewKind;

  final Alert alert;
  final AlertTypeView _viewKind;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      AlertWidget(alert: alert, linkable: false),
      UrlTile(url: alert.monitorUrl, textColor: _viewKind.fgColor),
      UrlTile(url: alert.serviceUrl, textColor: _viewKind.fgColor),
    ]);
  }
}

class UrlTile extends StatelessWidget {
  const UrlTile({super.key, required this.url, required this.textColor});

  final String url;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(url),
        textColor: textColor,
        leading: Icon(Icons.link_outlined, color: textColor),
        onTap: () async {
          try {
            var uri = Uri.parse(url);
            await launchUrl(uri);
          } catch (e) {
            log("Error launching URL: $url");
          }
        });
  }
}
