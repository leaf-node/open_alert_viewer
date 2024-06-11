/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../alerts/bloc/alerts_bloc.dart';
import '../../alerts/bloc/alerts_event.dart';
import '../../alerts/bloc/alerts_state.dart';
import '../../alerts/model/alerts.dart';
import '../../app/bloc/navigation_bloc.dart';
import '../../app/bloc/navigation_event.dart';
import '../../app/data_repository/app_repository.dart';
import '../../app/data_repository/settings_repository.dart';
import 'settings_components.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  static Route<void> route({required title}) {
    return MaterialPageRoute<void>(builder: (_) => SettingsPage(title: title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SettingsHeader(title: title), body: const SettingsList());
  }
}

class GeneralSettingsPage extends StatelessWidget {
  const GeneralSettingsPage({super.key, required this.title});

  final String title;

  static Route<void> route({required title}) {
    return MaterialPageRoute<void>(
        builder: (_) => GeneralSettingsPage(title: title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SettingsHeader(title: title),
        body: const GeneralSettingsList());
  }
}

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlertsBloc, AlertState>(builder: (context, state) {
      return ListView(children: [
        MenuItem(
            icon: Icons.settings,
            title: "General Settings",
            function: () =>
                context.read<NavBloc>().add(OpenGeneralSettingsPageEvent())),
        const MenuHeaderTile(title: "Accounts"),
        for (AlertSource account in state.sources)
          MenuItem(
              icon: Icons.manage_accounts,
              title: account.name,
              function: () => context
                  .read<NavBloc>()
                  .add(OpenAccountSettingsPageEvent(source: account))),
        MenuItem(
            icon: Icons.add,
            title: "Add new account",
            function: () => context.read<AlertsBloc>().add(
                const AddAlertSource(source: ["Random", "0", "", "", ""]))),
      ]);
    });
  }
}

enum RefreshFrequencies {
  oneMinute("Every Minute", 1),
  threeMinutes("Every 3 Minutes", 3),
  fiveMinutes("Every 5 Minutes", 5),
  fifteenMinutes("Every 15 Minutes", 15),
  thirtyMinutes("Every 30 Minutes", 30),
  oneHour("Every Hour", 60),
  twoHours("Every 2 Hours", 120),
  never("Never", -1);

  const RefreshFrequencies(this.text, this.periodMinutes);

  final String text;
  final int? periodMinutes;
}

class GeneralSettingsList extends StatelessWidget {
  const GeneralSettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      MenuItem(
          icon: Icons.update,
          title: "Refresh Interval",
          function: () async {
            var settings = context.read<SettingsRepo>();
            int? result = await _frequencyDialogBuilder(
                context: context,
                text: "Refresh Interval",
                priorSettingMinutes: settings.refreshInterval ?? -1);
            result ??= settings.refreshInterval;
            settings.refreshInterval = result;
          }),
    ]);
  }
}

Future<int?> _frequencyDialogBuilder(
    {required BuildContext context,
    required String text,
    required int? priorSettingMinutes}) async {
  return await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            child: SizedBox(
                width: 300,
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  for (var option in RefreshFrequencies.values)
                    RadioListTile<int?>(
                      title: Text(option.text),
                      value: option.periodMinutes,
                      groupValue: priorSettingMinutes,
                      onChanged: (int? value) {
                        Navigator.of(context).pop(value);
                      },
                    ),
                ])));
      });
}

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage(
      {super.key, required this.title, required this.source});

  final String title;
  final AlertSource source;

  static Route<void> route(
      {required String title, required AlertSource source}) {
    return MaterialPageRoute<void>(
        builder: (_) => AccountSettingsPage(title: title, source: source));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SettingsHeader(title: title),
        body: Center(child: AccountForm(source: source)));
  }
}

class AccountForm extends StatefulWidget {
  const AccountForm({super.key, required this.source});

  final AlertSource source;

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final nameController = TextEditingController();
  final urlController = TextEditingController();
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.source.name;
    urlController.text = widget.source.url;
    userController.text = widget.source.username;
    passwordController.text = widget.source.password;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    urlController.dispose();
    userController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.always,
        onChanged: () => (),
        child: SizedBox(
            width: 400,
            child: Builder(builder: (context) {
              nameController.value;
              return ListView(children: [
                const SizedBox(height: 20),
                const MenuHeader(title: "Account Details", padding: 8.0),
                AccountField(title: "Account Name", controller: nameController),
                AccountField(title: "Base URL", controller: urlController),
                AccountField(title: "User Name", controller: userController),
                AccountField(title: "Password", controller: passwordController),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      if (Form.of(context).validate()) {
                        context
                            .read<AppRepo>()
                            .updateSource(id: widget.source.id, values: [
                          nameController.text,
                          widget.source.type,
                          urlController.text,
                          userController.text,
                          passwordController.text
                        ]);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("Submit",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold)))
              ]);
            })));
  }
}

class AccountField extends StatelessWidget {
  const AccountField(
      {super.key, required this.title, required this.controller});

  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: Alignment.topCenter,
            child: TextFormField(
                controller: controller,
                onSaved: (String? value) {},
                decoration: InputDecoration(labelText: title))));
  }
}
