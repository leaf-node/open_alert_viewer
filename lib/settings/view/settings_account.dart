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
                        context.read<AlertsBloc>().add(UpdateAlertSource(
                                id: widget.source.id,
                                source: [
                                  nameController.text,
                                  widget.source.type.toString(),
                                  urlController.text,
                                  userController.text,
                                  passwordController.text
                                ]));
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
