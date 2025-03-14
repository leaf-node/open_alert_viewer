/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/repositories/account_repo.dart';
import '../../../domain/alerts.dart';
import '../../../utils/utils.dart';
import '../../settings/widgets/settings_widgets.dart';
import '../cubit/alert_details_cubit.dart';
import 'alerts.dart';

class AlertDetailsScreen extends StatelessWidget {
  AlertDetailsScreen({super.key, required this.title, required this.alert})
    : _viewKind = alert.viewKind;

  final String title;
  final Alert alert;
  final AlertTypeView _viewKind;

  static Route<void> route({required String title, required Alert alert}) {
    return MaterialPageRoute<void>(
      builder: (_) => AlertDetailsScreen(title: title, alert: alert),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralHeader(title: title),
      body: Container(
        color:
            HSLColor.fromColor(
              _viewKind.bgColor,
            ).withLightness(_viewKind.bgbgLightness).toColor(),
        child: Center(
          child: Container(
            color: _viewKind.bgColor,
            constraints: BoxConstraints(maxWidth: 600),
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            margin: EdgeInsets.all(20),
            child: AlertDetails(alert: alert),
          ),
        ),
      ),
    );
  }
}

class AlertDetails extends StatelessWidget {
  AlertDetails({super.key, required this.alert}) : _viewKind = alert.viewKind;

  final Alert alert;
  final AlertTypeView _viewKind;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => AlertDetailsCubit(
            accounts: context.read<AccountsRepo>(),
            alert: alert,
          ),
      child: BlocBuilder<AlertDetailsCubit, AlertDetailsState>(
        builder: (context, state) {
          return ListView(
            children: [
              ListTile(
                title: Text(
                  alert.kind.name,
                  style: TextStyle(
                    color: _viewKind.fgColor,
                    fontSize:
                        Theme.of(context).textTheme.headlineLarge?.fontSize,
                  ),
                ),
              ),
              ColorTile(
                Icons.person_outlined,
                "Account: ${state.sourceName}",
                _viewKind.fgColor,
              ),
              ColorTile(
                Icons.widgets_outlined,
                "Service: ${alert.service}",
                _viewKind.fgColor,
              ),
              ColorTile(
                Icons.sms_outlined,
                "Status: ${alert.message}",
                _viewKind.fgColor,
              ),
              ColorTile(
                Icons.timer_outlined,
                "Age: ${Util.prettyPrintDuration(duration: alert.age)}",
                _viewKind.fgColor,
              ),
              UrlTile(
                url: alert.serviceUrl,
                textColor: _viewKind.fgColor,
                icon: Icons.public_outlined,
              ),
              UrlTile(url: alert.monitorUrl, textColor: _viewKind.fgColor),
              if (!alert.active)
                ColorTile(Icons.pending_outlined, "Pending", _viewKind.fgColor),
              if (alert.silenced)
                ColorTile(Icons.music_off, "Silenced", _viewKind.fgColor),
              if (alert.downtimeScheduled)
                ColorTile(
                  Icons.bedtime_outlined,
                  "Downtime Scheduled",
                  _viewKind.fgColor,
                ),
            ],
          );
        },
      ),
    );
  }
}

class ColorTile extends StatelessWidget {
  const ColorTile(this.icon, this.text, this.color, {super.key});

  final String text;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
    );
  }
}

class UrlTile extends StatelessWidget {
  const UrlTile({
    super.key,
    required this.url,
    required this.textColor,
    this.icon,
  });

  final String url;
  final Color textColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (url == "") {
      return Container();
    }
    return ListTile(
      title: Text(url),
      textColor: textColor,
      leading: Icon(
        (icon != null) ? icon : Icons.link_outlined,
        color: textColor,
      ),
      onTap: () async {
        try {
          var uri = Uri.parse(url);
          await launchUrl(uri);
        } catch (e) {
          log("Error launching URL: $url");
        }
      },
    );
  }
}
