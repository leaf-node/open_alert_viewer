import 'package:flutter/material.dart';
import 'package:sprintf/sprintf.dart';

import '../model/alerts.dart';

enum AlertTypeView {
  up(
      icon: Icons.check,
      bgColor: Color(0xFF2E7D32), // green800
      fgColor: Colors.white,
      template: "%s: UP",
      numArgs: 1),
  okay(
      icon: Icons.check,
      bgColor: Color(0xFF2E7D32), // green800
      fgColor: Colors.white,
      template: "%s: OKAY: %s",
      numArgs: 2),
  warning(
      icon: Icons.error_outline, // circular icon
      bgColor: Color(0xFFF9A825), // yellow800
      fgColor: Colors.black,
      template: "%s: WARNING: %s",
      numArgs: 2),
  error(
      icon: Icons.warning_amber_outlined, // triangular icon
      bgColor: Color(0xFFC62828), // red800
      fgColor: Colors.white,
      template: "%s: ERROR: %s",
      numArgs: 2),
  unreachable(
      icon: Icons.close,
      bgColor: Color(0xFF222222), // dark gray
      fgColor: Colors.white,
      template: "%s is UNREACHABLE",
      numArgs: 1),
  down(
      icon: Icons.keyboard_double_arrow_down,
      bgColor: Color(0xFF111111), // darker gray
      fgColor: Colors.white,
      template: "%s is DOWN",
      numArgs: 1),
  unknown(
      icon: Icons.question_mark,
      bgColor: Color(0xFF3C111A), // dark red
      fgColor: Colors.white,
      template: "%s is UNKNOWN: %s",
      numArgs: 2),
  pending(
      icon: Icons.pending_outlined,
      bgColor: Color(0xFF999999), // dark red
      fgColor: Colors.black,
      template: "%s is PENDING",
      numArgs: 1);

  const AlertTypeView(
      {required this.icon,
      required this.bgColor,
      required this.fgColor,
      required this.template,
      required this.numArgs});

  final IconData icon;
  final Color bgColor;
  final Color fgColor;
  final String template;
  final int numArgs;
}

class AlertWidget extends StatelessWidget {
  const AlertWidget({super.key, required this.alert});

  final Alert alert;

  @override
  Widget build(BuildContext context) {
    final viewKind = switch (alert.kind) {
      AlertType.up => AlertTypeView.up,
      AlertType.okay => AlertTypeView.okay,
      AlertType.warning => AlertTypeView.warning,
      AlertType.error => AlertTypeView.error,
      AlertType.unreachable => AlertTypeView.unreachable,
      AlertType.down => AlertTypeView.down,
      AlertType.unknown => AlertTypeView.unknown,
      AlertType.pending => AlertTypeView.pending,
    };

    return ListTile(
        iconColor: viewKind.fgColor,
        textColor: viewKind.fgColor,
        tileColor: viewKind.bgColor,
        title: Text(_printMessage(viewKind.template, viewKind.numArgs)),
        subtitle: Text(_prettyPrintAge()),
        leading: Icon(viewKind.icon));
  }

  String _printMessage(template, numArgs) {
    if (numArgs == 1) {
      return sprintf(template, [alert.hostname]);
    } else {
      return sprintf(template, [alert.hostname, alert.message]);
    }
  }

  String _prettyPrintAge() {
    String ageStr;

    int seconds = alert.age.inSeconds.floor() % 60;
    int minutes = alert.age.inMinutes.floor() % 60;
    int hours = alert.age.inHours.floor() % 24;
    int days = alert.age.inDays.floor();

    ageStr = (days > 0) ? "${days}d " : "";
    ageStr += (days > 0 || hours > 0) ? "${hours}h " : "";
    ageStr += (days > 0 || hours > 0 || minutes > 0) ? "${minutes}m " : "";
    ageStr += "${seconds}s";

    return ageStr;
  }
}
