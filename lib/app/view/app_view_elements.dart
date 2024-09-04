/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data_repository/settings_repository.dart';

class HeaderButton extends StatelessWidget {
  const HeaderButton({super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Ink(
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
        ),
        child: IconButton(icon: Icon(icon), onPressed: onPressed));
  }
}

Future textDialogBuilder(
    {required BuildContext context,
    required String text,
    required bool cancellable,
    bool? reverseColors,
    String? okayText}) async {
  return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        var dangerColor = Theme.of(context).colorScheme.error;
        var safeColor = Theme.of(context).colorScheme.secondary;
        return Dialog(
            child: SizedBox(
                width: 300,
                child: ListView(shrinkWrap: true, children: [
                  Column(mainAxisSize: MainAxisSize.min, children: [
                    Padding(
                        padding: const EdgeInsets.all(15), child: Text(text)),
                    Row(children: [
                      if (cancellable == true)
                        SettingsButton<bool>(
                            text: "Cancel",
                            retVal: false,
                            color: reverseColors ?? false
                                ? safeColor
                                : dangerColor),
                      SettingsButton<bool>(
                          text: okayText ?? "Okay",
                          retVal: true,
                          color:
                              reverseColors ?? false ? dangerColor : safeColor),
                    ]),
                    const Padding(padding: EdgeInsets.only(bottom: 15))
                  ])
                ])));
      });
}

class SettingsButton<T> extends StatelessWidget {
  const SettingsButton(
      {super.key,
      required this.text,
      required this.retVal,
      required this.color});

  final String text;
  final T retVal;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
            child: TextButton(
                onPressed: () => Navigator.of(context).pop(retVal),
                child: Text(text, style: TextStyle(color: color)))));
  }
}

Future<void> showLatestModal(BuildContext context) async {
  var settings = context.read<SettingsRepo>();
  if (settings.latestModalShown < 1) {
    textDialogBuilder(
        context: context,
        text: "Open Alert Viewer is an early access application, "
            "so you may run into a few coding errors. Please "
            "report any issues via the \"Online Support\" menu item "
            "in the app settings. Thank you!",
        cancellable: false);
    settings.latestModalShown = 1;
  }
}
