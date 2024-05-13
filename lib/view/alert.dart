import 'package:flutter/material.dart';

import '../model/alert.dart';

enum AlertTypeView {
  okay(
      icon: Icons.check,
      bgColor: Color(0xFF2E7D32), // green800
      fgColor: Colors.white),
  warning(
      icon: Icons.error_outline, // circular icon
      bgColor: Color(0xFFF9A825), // yellow800
      fgColor: Colors.black),
  error(
      icon: Icons.warning_amber_outlined, // triangular icon
      bgColor: Color(0xFFC62828), // red800
      fgColor: Colors.white),
  unreachable(
      icon: Icons.close,
      bgColor: Color(0xFF222222), // dark gray
      fgColor: Colors.white),
  down(
      icon: Icons.keyboard_double_arrow_down,
      bgColor: Color(0xFF111111), // darker gray
      fgColor: Colors.white),
  unknown(
      icon: Icons.question_mark,
      bgColor: Color(0xFF4F2723), // modified brown900
      fgColor: Colors.white);

  const AlertTypeView(
      {required this.icon, required this.bgColor, required this.fgColor});

  final IconData icon;
  final Color bgColor;
  final Color fgColor;
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
      AlertType.unreachable => AlertTypeView.unreachable,
      AlertType.down => AlertTypeView.down,
      AlertType.unknown => AlertTypeView.unknown,
    };

    return ListTile(
        iconColor: viewKind.fgColor,
        textColor: viewKind.fgColor,
        tileColor: viewKind.bgColor,
        title: Text(alert.message),
        subtitle: Text(_prettyPrintAge()),
        leading: Icon(viewKind.icon));
  }

  String _prettyPrintAge() {
    String fmtStr;

    int seconds = alert.age.inSeconds.floor() % 60;
    int minutes = alert.age.inMinutes.floor() % 60;
    int hours = alert.age.inHours.floor() % 24;
    int days = alert.age.inDays.floor();

    fmtStr = (days > 0) ? "${days}d " : "";
    fmtStr += (days > 0 || hours > 0) ? "${hours}h " : "";
    fmtStr += (days > 0 || hours > 0 || minutes > 0) ? "${minutes}m " : "";
    fmtStr += "${seconds}s";

    return fmtStr;
  }
}
