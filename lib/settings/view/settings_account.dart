/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../alerts/bloc/alerts_bloc.dart';
import '../../alerts/bloc/alerts_event.dart';
import '../../alerts/model/alerts.dart';
import '../../app/view/app_view_elements.dart';
import '../data_repository/account_repository.dart';
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
  final baseURLController = TextEditingController();
  final pathController = TextEditingController();
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.source == null) {
      nameController.text = "";
      typeController.text = "0";
      baseURLController.text = "";
      pathController.text = "";
      userController.text = "";
      passwordController.text = "";
    } else {
      nameController.text = widget.source!.name;
      typeController.text = widget.source!.type.toString();
      baseURLController.text = widget.source!.baseURL;
      pathController.text = widget.source!.path;
      userController.text = widget.source!.username;
      passwordController.text = widget.source!.password;
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    typeController.dispose();
    baseURLController.dispose();
    pathController.dispose();
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
                AccountField(
                    title: "Account Name",
                    controller: nameController,
                    validator: (String? value) {
                      int? id;
                      id = widget.source?.id;
                      if (value == null || value == "") {
                        return "Please enter a name";
                      }
                      return context
                              .read<AccountsRepo>()
                              .checkUniqueSource(id: id, name: value)
                          ? null
                          : "Name already used";
                    }),
                AccountField(title: "Base URL", controller: baseURLController),
                AccountField(title: "User Name", controller: userController),
                AccountField(
                    title: "Password",
                    controller: passwordController,
                    passwordField: true),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                      child: Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                if (widget.source != null) {
                                  bool result = await textDialogBuilder(
                                      context: context,
                                      text:
                                          "Are you sure you want to remove this account?",
                                      okayText: "Remove",
                                      cancellable: true,
                                      reverseColors: true);
                                  if (context.mounted && result) {
                                    context.read<AlertsBloc>().add(
                                        RemoveAlertSource(
                                            id: widget.source!.id));
                                    Navigator.of(context).pop();
                                  }
                                }
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
                                          baseURLController.text,
                                          pathController.text,
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
                                              baseURLController.text,
                                              pathController.text,
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

class AccountField extends StatefulWidget {
  const AccountField(
      {super.key,
      required this.title,
      required this.controller,
      this.validator,
      this.passwordField});

  final String title;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool? passwordField;

  @override
  State<AccountField> createState() => _AccountFieldState();
}

class _AccountFieldState extends State<AccountField> {
  late bool _textVisible;

  @override
  void initState() {
    super.initState();
    _textVisible = !(widget.passwordField ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: Alignment.topCenter,
            child: TextFormField(
                controller: widget.controller,
                onSaved: (String? value) {},
                decoration: InputDecoration(
                  labelText: widget.title,
                  suffixIcon: widget.passwordField ?? false
                      ? IconButton(
                          icon: Icon(_textVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() => _textVisible = !_textVisible);
                          },
                        )
                      : null,
                ),
                obscureText: !_textVisible,
                validator: widget.validator)));
  }
}
