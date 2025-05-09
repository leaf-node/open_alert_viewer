/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/alerts.dart';

part 'account_editing_state.freezed.dart';

enum CheckStatus { needsCheck, checkingNow, responded }

enum IconType { checking, invalid, valid }

@freezed
abstract class AccountEditingState with _$AccountEditingState {
  const factory AccountEditingState({
    required AlertSourceDataUpdate? sourceData,
    required CheckStatus status,
    required String statusText,
    required IconType? statusIcon,
    required bool allowClickAccept,
    required String acceptButtonText,
  }) = _AccountEditingState;

  factory AccountEditingState.init() {
    return AccountEditingState(
      sourceData: null,
      status: CheckStatus.needsCheck,
      statusText: "",
      statusIcon: null,
      allowClickAccept: true,
      acceptButtonText: "Pending...",
    );
  }
}
