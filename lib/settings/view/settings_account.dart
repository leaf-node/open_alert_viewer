/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../alerts/bloc/alerts_bloc.dart';
import '../../alerts/bloc/alerts_event.dart';
import '../../alerts/model/alerts.dart';
import 'settings_components.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage(
      {super.key, required this.title, required this.source});

  final String title;
  final AlertSource? source;

  static Route<void> route(
      {required String title, required AlertSource? source}) {
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

  final AlertSource? source;

  @override
  State<AccountForm> createState() => _AccountFormState();
}

class _AccountFormState extends State<AccountForm> {
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final urlController = TextEditingController();
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.source == null) {
      nameController.text = "";
      typeController.text = "0";
      urlController.text = "";
      userController.text = "";
      passwordController.text = "";
    } else {
      nameController.text = widget.source!.name;
      typeController.text = widget.source!.type.toString();
      urlController.text = widget.source!.url;
      userController.text = widget.source!.username;
      passwordController.text = widget.source!.password;
    }
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
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                      child: Center(
                          child: ElevatedButton(
                              onPressed: () {
                                if (widget.source != null) {
                                  context.read<AlertsBloc>().add(
                                      RemoveAlertSource(id: widget.source!.id));
                                }
                                Navigator.of(context).pop();
                              },
                              child: Text(() {
                                if (widget.source == null) {
                                  return "Cancel";
                                } else {
                                  return "Remove Account";
                                }
                              }(),
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      fontWeight: FontWeight.bold))))),
                  Expanded(
                      child: Center(
                          child: ElevatedButton(
                              onPressed: () {
                                if (Form.of(context).validate()) {
                                  if (widget.source == null) {
                                    context
                                        .read<AlertsBloc>()
                                        .add(AddAlertSource(source: [
                                          nameController.text,
                                          typeController.text,
                                          urlController.text,
                                          userController.text,
                                          passwordController.text
                                        ]));
                                  } else {
                                    context.read<AlertsBloc>().add(
                                            UpdateAlertSource(
                                                id: widget.source!.id,
                                                source: [
                                              nameController.text,
                                              typeController.text,
                                              urlController.text,
                                              userController.text,
                                              passwordController.text
                                            ]));
                                  }
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text(() {
                                if (widget.source == null) {
                                  return "Add Account";
                                } else {
                                  return "Update Account";
                                }
                              }(),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.bold)))))
                ])
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
