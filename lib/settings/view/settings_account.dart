/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../alerts/bloc/alerts_bloc.dart';
import '../../alerts/bloc/alerts_event.dart';
import '../../alerts/model/alerts.dart';
import '../../app/view/app_view_elements.dart';
import '../../settings/bloc/account_bloc.dart';
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
  _AccountFormState()
      : nameController = TextEditingController(),
        typeController = TextEditingController(),
        baseURLController = TextEditingController(),
        userController = TextEditingController(),
        passwordController = TextEditingController(),
        epoch = DateTime.fromMillisecondsSinceEpoch(0),
        systemIsUpdatingValues = false;

  final TextEditingController nameController;
  final TextEditingController typeController;
  final TextEditingController baseURLController;
  final TextEditingController userController;
  final TextEditingController passwordController;
  final DateTime epoch;
  late final AccountBloc accountBloc;
  bool systemIsUpdatingValues;

  AlertSourceData get newSourceData {
    if (widget.source == null) {
      return AlertSourceData(
        id: null,
        name: nameController.text,
        type: int.parse(typeController.text),
        authType: AuthTypes.basicAuth.value,
        baseURL: baseURLController.text,
        username: userController.text,
        password: passwordController.text,
        failing: false,
        lastSeen: epoch,
        priorFetch: epoch,
        lastFetch: epoch,
        errorMessage: "",
      );
    } else {
      return AlertSourceData(
        id: widget.source!.sourceData.id,
        name: nameController.text,
        type: int.parse(typeController.text),
        authType: AuthTypes.basicAuth.value,
        baseURL: baseURLController.text,
        username: userController.text,
        password: passwordController.text,
        failing: widget.source?.sourceData.failing ?? false,
        lastSeen: widget.source?.sourceData.lastSeen ?? epoch,
        priorFetch: widget.source?.sourceData.priorFetch ?? epoch,
        lastFetch: widget.source?.sourceData.lastFetch ?? epoch,
        errorMessage: "",
      );
    }
  }

  void setNewSourceData({required AlertSourceData sourceData}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      systemIsUpdatingValues = true;
      nameController.text = sourceData.name;
      typeController.text = sourceData.type.toString();
      baseURLController.text = sourceData.baseURL;
      userController.text = sourceData.username;
      passwordController.text = sourceData.password;
      systemIsUpdatingValues = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.source == null) {
      nameController.text = "";
      typeController.text = "0";
      baseURLController.text = "";
      userController.text = "";
      passwordController.text = "";
    } else {
      nameController.text = widget.source!.sourceData.name;
      typeController.text = widget.source!.sourceData.type.toString();
      baseURLController.text = widget.source!.sourceData.baseURL;
      userController.text = widget.source!.sourceData.username;
      passwordController.text = widget.source!.sourceData.password;
      if (typeController.text == "-1") {
        typeController.text = "0";
      }
    }
    accountBloc = context.read<AccountBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    typeController.dispose();
    baseURLController.dispose();
    userController.dispose();
    passwordController.dispose();
    accountBloc.add(CleanOutAccountEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.always,
        onChanged: setNeedsCheck,
        child: SizedBox(
            width: 400,
            child: BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
              String status;
              IconData? icon;
              if (state.responded) {
                setNewSourceData(sourceData: state.sourceData!);
                if (state.sourceData!.isValid ?? false) {
                  status = "Found API endpoint";
                  icon = Icons.check_outlined;
                } else {
                  var error = state.sourceData!.errorMessage;
                  if (error == "") {
                    error = "Unkown Error";
                  }
                  status = "Error: $error";
                  icon = Icons.close_outlined;
                }
              } else if (state.needsCheck) {
                status = "";
                icon = null;
              } else {
                status = "Checking...";
                icon = Icons.sync_outlined;
              }
              return ListView(children: [
                const SizedBox(height: 20),
                const MenuHeader(title: "Account Details", padding: 8.0),
                AccountRadioField(
                    title: "Third-Party Account",
                    initialValue: typeController.text,
                    onTap: () async {
                      String? result = await settingsRadioDialogBuilder<String>(
                          context: context,
                          text: "Source Type",
                          priorSetting: typeController.text,
                          valueListBuilder: listSourceTypes);
                      if (result != null && result != typeController.text) {
                        typeController.text = result;
                      }
                      return result;
                    }),
                AccountField(
                    title: "Account Name",
                    controller: nameController,
                    validator: (String? value) {
                      int? id;
                      id = widget.source?.sourceData.id;
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
                const SizedBox(height: 10),
                ListTile(
                    leading: Icon(icon),
                    title: Text(status),
                    contentPadding: const EdgeInsets.all(8)),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  cancelButton(context),
                  acceptButton(
                      context: context,
                      needsCheck: state.needsCheck,
                      isValid: state.sourceData?.isValid ?? false,
                      responded: state.responded),
                ]),
                const SizedBox(height: 40),
              ]);
            })));
  }

  Widget cancelButton(BuildContext context) {
    return Expanded(
        child: Center(
            child: ElevatedButton(
                onPressed: () async {
                  if (widget.source != null) {
                    bool result = await textDialogBuilder(
                        context: context,
                        text: "Are you sure you want to remove this account?",
                        okayText: "Remove",
                        cancellable: true,
                        reverseColors: true);
                    if (context.mounted && result) {
                      context.read<AlertsBloc>().add(
                          RemoveAlertSource(id: widget.source!.sourceData.id!));
                      Navigator.of(context).pop();
                    }
                  } else {
                    if (context.mounted) {
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
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold)))));
  }

  Widget acceptButton(
      {required BuildContext context,
      required bool needsCheck,
      required bool isValid,
      required bool responded}) {
    bool allowClick;
    if (needsCheck || responded) {
      allowClick = true;
    } else {
      allowClick = false;
    }
    String status;
    if (needsCheck) {
      status = "Check Account";
    } else if (responded) {
      if (isValid) {
        if (widget.source == null) {
          status = "Add Account";
        } else {
          status = "Update Account";
        }
      } else {
        status = "Try Again";
      }
    } else {
      status = "Checking...";
    }
    return Expanded(
        child: Center(
            child: ElevatedButton(
                onPressed: (!allowClick)
                    ? null
                    : () {
                        if (Form.of(context).validate()) {
                          if (needsCheck || !isValid) {
                            context.read<AccountBloc>().add(ConfirmAccountEvent(
                                sourceData: newSourceData,
                                needsCheck: false,
                                checkNow: true));
                          } else {
                            if (widget.source == null) {
                              context.read<AlertsBloc>().add(
                                  AddAlertSource(sourceData: newSourceData));
                            } else {
                              context.read<AlertsBloc>().add(
                                  UpdateAlertSource(sourceData: newSourceData));
                            }
                            Navigator.of(context).pop();
                          }
                        }
                      },
                child: Text(status,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold)))));
  }

  void setNeedsCheck() {
    if (!systemIsUpdatingValues) {
      context.read<AccountBloc>().add(
          ConfirmAccountEvent(sourceData: newSourceData, needsCheck: true));
    }
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
                autocorrect: false,
                enableSuggestions: false,
                obscureText: !_textVisible,
                validator: widget.validator)));
  }
}

List<SettingsRadioEnumValue> listSourceTypes<T>({T? priorSetting}) {
  return [
    for (var option in SourceTypes.values)
      if (option.value >= 0)
        SettingsRadioEnumValue<T>(
            title: option.text,
            value: option.value.toString() as T,
            priorSetting: priorSetting)
  ];
}

class AccountRadioField<T> extends StatelessWidget {
  const AccountRadioField(
      {super.key,
      required this.title,
      required this.initialValue,
      this.validator,
      required this.onTap});

  final String title;
  final T initialValue;
  final FormFieldValidator<T>? validator;
  final Future<T> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment: Alignment.topCenter,
            child: RadioDialogFormField(
                title: title,
                initialValue: initialValue,
                onSaved: (T? value) {},
                validator: validator,
                onTap: onTap)));
  }
}

class RadioDialogFormField<T> extends FormField<T> {
  RadioDialogFormField(
      {super.key,
      required title,
      required super.initialValue,
      required super.onSaved,
      required super.validator,
      required Future<T> Function() onTap})
      : super(builder: (FormFieldState<T> state) {
          return RadioDialogWidget(state: state, title: title, onTap: onTap);
        });
}

class RadioDialogWidget<T> extends StatelessWidget {
  const RadioDialogWidget(
      {super.key,
      required this.state,
      required this.title,
      required this.onTap});

  final FormFieldState<T> state;
  final String title;
  final Future<T> Function() onTap;

  @override
  build(BuildContext context) {
    return Row(children: [
      Text("$title: "),
      TextButton(
          onPressed: () async {
            var result = await onTap();
            if (result != null) {
              state.didChange(result);
            }
          },
          child: Text(
              SourceTypes.values
                  .firstWhere((sourceType) =>
                      sourceType.value.toString() == state.value)
                  .text,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold)))
    ]);
  }
}
