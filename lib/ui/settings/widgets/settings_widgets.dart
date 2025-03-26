/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/alerts.dart';
import '../../core/widgets/shared_widgets.dart';
import '../cubit/root_settings_cubit.dart';
import '../view/account_editing_screen.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    this.leading,
    this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.enabled = true,
  });

  final Widget? leading;
  final IconData? icon;
  final String title;
  final String? subtitle;
  final void Function()? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final textWidget = (subtitle != null) ? Text(subtitle!) : null;
    return ListTile(
      leading:
          (leading != null)
              ? leading
              : (icon != null)
              ? Icon(icon)
              : null,
      title: Text(title),
      subtitle: textWidget,
      onTap: onTap,
      enabled: enabled,
    );
  }
}

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key, required this.title, required this.padding});

  final String title;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class MenuHeaderTile extends StatelessWidget {
  const MenuHeaderTile({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: MenuHeader(title: title, padding: 0));
  }
}

class GeneralHeader extends StatelessWidget implements PreferredSizeWidget {
  const GeneralHeader({super.key, required this.title, this.intercept});

  final String title;
  final Future<bool> Function()? intercept;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      leading: HeaderButton(
        icon: Icons.arrow_back,
        onPressed: () async {
          bool stay;
          if (intercept != null) {
            stay = await intercept!();
          } else {
            stay = false;
          }
          if (!stay && context.mounted) {
            Navigator.of(context).pop();
          }
        },
      ),
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

Future<T?> settingsRadioDialogBuilder<T>({
  required BuildContext context,
  required String? text,
  required T? priorSetting,
  required Function<T>({T? priorSetting}) valueListBuilder,
}) async {
  return await showDialog<T>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          width: 350,
          child: ListView(
            shrinkWrap: true,
            children: [
              if (text != null)
                ListTile(
                  title: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ...valueListBuilder(priorSetting: priorSetting),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> settingsCheckBoxDialogBuilder<T>({
  required BuildContext context,
  required String? text,
  required List<bool> priorSetting,
  required Function({required List<bool> priorSetting}) valueListBuilder,
}) async {
  await showDialog<T>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          width: 300,
          child: ListView(
            shrinkWrap: true,
            children: [
              if (text != null)
                ListTile(
                  title: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ...valueListBuilder(priorSetting: priorSetting),
            ],
          ),
        ),
      );
    },
  );
}

class SettingsRadioEnumValue<T> extends StatelessWidget {
  const SettingsRadioEnumValue({
    super.key,
    required this.title,
    required this.value,
    required this.priorSetting,
  });

  final String title;
  final T value;
  final T? priorSetting;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      title: Text(title),
      value: value,
      groupValue: priorSetting,
      onChanged: (T? value) {
        Navigator.of(context).pop(value);
      },
    );
  }
}

class SettingsCheckBoxEnumValue extends StatefulWidget {
  const SettingsCheckBoxEnumValue({
    super.key,
    required this.title,
    required this.value,
    required this.index,
    required this.callback,
  });

  final String title;
  final bool value;
  final int index;
  final Function(BuildContext, bool?, int) callback;

  @override
  State<SettingsCheckBoxEnumValue> createState() =>
      _SettingsCheckBoxEnumValueState();
}

class _SettingsCheckBoxEnumValueState extends State<SettingsCheckBoxEnumValue> {
  bool? value;

  @override
  Widget build(BuildContext context) {
    value = value ?? widget.value;
    return CheckboxListTile(
      title: Text(widget.title),
      value: value,
      onChanged: (bool? newValue) {
        if (newValue != null) {
          widget.callback(context, newValue, widget.index);
          setState(() {
            value = newValue;
          });
        }
      },
    );
  }
}

void openAccountEditor({
  required BuildContext context,
  required AlertSourceData? source,
}) {
  Navigator.of(context).push(AccountEditingScreen.route(source: source)).then((
    result,
  ) {
    if ((result as bool? ?? false) && context.mounted) {
      context.read<RootSettingsCubit>().accountUpdated();
    }
  });
}
