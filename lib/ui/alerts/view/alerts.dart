/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import '../../../utils/utils.dart';
import '../../../domain/alerts.dart';
import 'alert_details_screen.dart';

enum AlertTypeView {
  okay(
    icon: Icons.check,
    bgColor: Color(0xFF2E7D32), // green800
    fgColor: Colors.white,
    bgbgLightness: 0.4,
    title: "OKAY",
    numArgs: 3,
  ),
  warning(
    icon: Icons.warning_amber_outlined, // triangular icon
    bgColor: Color(0xFFF9A825), // yellow800
    fgColor: Colors.black,
    bgbgLightness: 0.45,
    title: "WARNING",
    numArgs: 3,
  ),
  error(
    icon: Icons.error_outline, // circular icon
    bgColor: Color(0xFFC62828), // red800
    fgColor: Colors.white,
    bgbgLightness: 0.4,
    title: "ERROR",
    numArgs: 3,
  ),
  pending(
    icon: Icons.more_horiz,
    bgColor: Color(0xFF444444), // dark gray
    fgColor: Color(0xFFBBBBBB), // light gray
    bgbgLightness: 0.45,
    title: "PENDING",
    numArgs: 2,
  ),
  unknown(
    icon: Icons.question_mark,
    bgColor: Color(0xFF114356), // blueish gray
    fgColor: Colors.white,
    bgbgLightness: 0.25,
    title: "UNKNOWN",
    numArgs: 3,
  ),
  up(
    icon: Icons.check,
    bgColor: Color(0xFF2E7D32), // green800
    fgColor: Colors.white,
    bgbgLightness: 0.4,
    title: "UP",
    numArgs: 1,
  ),
  unreachable(
    icon: Icons.close,
    bgColor: Color(0xFF222222), // dark gray
    fgColor: Colors.white,
    bgbgLightness: 0.2,
    title: "UNREACHABLE",
    numArgs: 1,
  ),
  down(
    icon: Icons.keyboard_double_arrow_down,
    bgColor: Color(0xFF111111), // darker gray
    fgColor: Colors.white,
    bgbgLightness: 0.2,
    title: "DOWN",
    numArgs: 1,
  ),
  hostPending(
    icon: Icons.more_horiz,
    bgColor: Color(0xFF444444), // dark gray
    fgColor: Color(0xFFBBBBBB), // light gray
    bgbgLightness: 0.45,
    title: "PENDING",
    numArgs: 1,
  ),
  syncFailure(
    icon: Icons.mobiledata_off,
    bgColor: Color(0xFF111111), // darker gray
    fgColor: Color(0xFFFBC02D), // yellow700
    bgbgLightness: 0.2,
    title: "SYNC FAILURE",
    numArgs: 3,
  );

  const AlertTypeView({
    required this.icon,
    required this.bgColor,
    required this.fgColor,
    required this.bgbgLightness,
    required this.title,
    required this.numArgs,
  });

  final IconData icon;
  final Color bgColor;
  final Color fgColor;
  final double bgbgLightness;
  final String title;
  final int numArgs;
}

extension AlertView on Alert {
  AlertTypeView get viewKind => switch (kind) {
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
}

class AlertWidget extends StatelessWidget {
  AlertWidget({super.key, required this.alert, this.linkable = true})
    : _viewKind = alert.viewKind;

  final Alert alert;
  final AlertTypeView _viewKind;
  final bool linkable;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: _viewKind.fgColor,
      textColor: _viewKind.fgColor,
      tileColor: _viewKind.bgColor,
      title: Text(_printMessage(_viewKind.title, _viewKind.numArgs)),
      subtitle: Text(Util.prettyPrintDuration(duration: alert.age)),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          Icon(_viewKind.icon),
          if (!alert.enabled)
            const Icon(Icons.do_not_disturb_outlined)
          else if (alert.downtimeScheduled)
            const Icon(Icons.bedtime_outlined)
          else if (alert.silenced)
            const Icon(Icons.flag_outlined)
          else if (!alert.active)
            const Icon(Icons.pending_outlined),
        ],
      ),
      onTap:
          !linkable
              ? null
              : () {
                if (context.mounted) {
                  Navigator.of(
                    context,
                  ).push(AlertDetailsScreen.route(alert: alert));
                }
              },
    );
  }

  String _printMessage(title, numArgs) {
    if (numArgs == 1) {
      return sprintf("$title: %s", [alert.hostname]);
    } else if (numArgs == 2) {
      return sprintf("$title [%s] %s", [alert.service, alert.hostname]);
    } else {
      return sprintf("$title [%s] %s: %s", [
        alert.service,
        alert.hostname,
        alert.message,
      ]);
    }
  }
}
