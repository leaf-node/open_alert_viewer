/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

part of 'account_bloc.dart';

sealed class AccountEvent {}

final class ConfirmAccountEvent extends AccountEvent {
  ConfirmAccountEvent(
      {required this.sourceData, this.needsCheck, this.checkNow});

  final AlertSourceData sourceData;
  final bool? needsCheck;
  final bool? checkNow;
}

final class ListenForAccountConfirmations extends AccountEvent {}

final class CleanOutAccountEvent extends AccountEvent {}
