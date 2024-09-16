/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

part of 'account_bloc.dart';

sealed class AccountState {
  AccountState(
      {this.sourceData,
      required this.needsCheck,
      required this.checkingNow,
      required this.responded});

  final AlertSourceData? sourceData;
  final bool needsCheck;
  final bool checkingNow;
  final bool responded;
}

final class AccountInitial extends AccountState {
  AccountInitial(
      {super.sourceData,
      required super.needsCheck,
      required super.checkingNow,
      required super.responded});
}

final class AccountConfirmSourceState extends AccountState {
  AccountConfirmSourceState(
      {super.sourceData,
      required super.needsCheck,
      required super.checkingNow,
      required super.responded});
}
