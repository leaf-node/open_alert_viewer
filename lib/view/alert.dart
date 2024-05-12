import 'package:flutter/material.dart';

import '../model/alert.dart';

enum AlertView {
  okay(
      kind: Alert.okay,
      icon: Icons.check,
      bgColor: Color(0xFF2E7D32), // green800
      fgColor: Colors.white),
  warning(
      kind: Alert.warning,
      icon: Icons.error_outline, // circular icon
      bgColor: Color(0xFFF9A825), // yellow800
      fgColor: Colors.black),
  error(
      kind: Alert.error,
      icon: Icons.warning_amber_outlined, // triangular icon
      bgColor: Color(0xFFC62828), // red800
      fgColor: Colors.white),
  unreachable(
      kind: Alert.unreachable,
      icon: Icons.close,
      bgColor: Color(0xFF222222),
      fgColor: Colors.white),
  down(
      kind: Alert.down,
      icon: Icons.keyboard_double_arrow_down,
      bgColor: Color(0xFF111111),
      fgColor: Colors.white),
  unknown(
      kind: Alert.unknown,
      icon: Icons.question_mark,
      bgColor: Color(0xFF4F2723), // modified brown900
      fgColor: Colors.white);

  const AlertView(
      {required this.kind,
      required this.icon,
      required this.bgColor,
      required this.fgColor});

  final Alert kind;
  final IconData icon;
  final Color bgColor;
  final Color fgColor;
}
