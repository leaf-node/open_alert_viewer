/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/util/util.dart';
import '../model/alerts.dart';

enum AlertTypeView {
  okay(
      icon: Icons.check,
      bgColor: Color(0xFF2E7D32), // green800
      fgColor: Colors.white,
      title: "OKAY",
      numArgs: 3),
  warning(
      icon: Icons.warning_amber_outlined, // triangular icon
      bgColor: Color(0xFFF9A825), // yellow800
      fgColor: Colors.black,
      title: "WARNING",
      numArgs: 3),
  error(
      icon: Icons.error_outline, // circular icon
      bgColor: Color(0xFFC62828), // red800
      fgColor: Colors.white,
      title: "ERROR",
      numArgs: 3),
  pending(
      icon: Icons.more_horiz,
      bgColor: Color(0xFF444444), // dark gray
      fgColor: Color(0xFFBBBBBB), // light gray
      title: "PENDING",
      numArgs: 2),
  unknown(
      icon: Icons.question_mark,
      bgColor: Color(0xFF3C111A), // dark red
      fgColor: Colors.white,
      title: "UNKNOWN",
      numArgs: 3),
  up(
      icon: Icons.check,
      bgColor: Color(0xFF2E7D32), // green800
      fgColor: Colors.white,
      title: "UP",
      numArgs: 1),
  unreachable(
      icon: Icons.close,
      bgColor: Color(0xFF222222), // dark gray
      fgColor: Colors.white,
      title: "UNREACHABLE",
      numArgs: 1),
  down(
      icon: Icons.keyboard_double_arrow_down,
      bgColor: Color(0xFF111111), // darker gray
      fgColor: Colors.white,
      title: "DOWN",
      numArgs: 1),
  hostPending(
      icon: Icons.more_horiz,
      bgColor: Color(0xFF444444), // dark gray
      fgColor: Color(0xFFBBBBBB), // light gray
      title: "PENDING",
      numArgs: 1),
  syncFailure(
      icon: Icons.mobiledata_off,
      bgColor: Color(0xFF111111), // darker gray
      fgColor: Color(0xFFFBC02D), // yellow700
      title: "SYNC FAILURE",
      numArgs: 3);

  const AlertTypeView(
      {required this.icon,
      required this.bgColor,
      required this.fgColor,
      required this.title,
      required this.numArgs});

  final IconData icon;
  final Color bgColor;
  final Color fgColor;
  final String title;
  final int numArgs;
}

class AlertWidget extends StatelessWidget {
  const AlertWidget({super.key, required this.alert});

  final Alert alert;

  @override
  Widget build(BuildContext context) {
    final viewKind = switch (alert.kind) {
      AlertType.okay => AlertTypeView.okay,
      AlertType.warning => AlertTypeView.warning,
      AlertType.error => AlertTypeView.error,
      AlertType.pending => AlertTypeView.pending,
      AlertType.up => AlertTypeView.up,
      AlertType.unreachable => AlertTypeView.unreachable,
      AlertType.down => AlertTypeView.down,
      AlertType.unknown => AlertTypeView.unknown,
      AlertType.hostPending => AlertTypeView.hostPending,
      AlertType.syncFailure => AlertTypeView.syncFailure,
    };

    return ListTile(
      iconColor: viewKind.fgColor,
      textColor: viewKind.fgColor,
      tileColor: viewKind.bgColor,
      title: Text(_printMessage(viewKind.title, viewKind.numArgs)),
      subtitle: Text(Util.prettyPrintDuration(duration: alert.age)),
      leading: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
            icon: const Icon(Icons.link_outlined),
            onPressed: () async {
              var uri = Uri.parse(alert.url);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              } else {
                log("Error launching URL: ${alert.url}");
              }
            }),
        Icon(viewKind.icon),
        if (alert.silenced || alert.downtimeScheduled)
          const Icon(Icons.music_off_outlined)
      ]),
    );
  }

  String _printMessage(title, numArgs) {
    if (numArgs == 1) {
      return sprintf("$title: %s", [alert.hostname]);
    } else if (numArgs == 2) {
      return sprintf("$title [%s] %s", [alert.service, alert.hostname]);
    } else {
      return sprintf(
          "$title [%s] %s: %s", [alert.service, alert.hostname, alert.message]);
    }
  }
}
