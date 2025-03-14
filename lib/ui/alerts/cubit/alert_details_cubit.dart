/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/repositories/account_repo.dart';
import '../../../domain/alerts.dart';

part 'alert_details_state.dart';
part 'alert_details_cubit.freezed.dart';

class AlertDetailsCubit extends Cubit<AlertDetailsState> {
  AlertDetailsCubit({required AccountsRepo accounts, required this.alert})
    : _accounts = accounts,
      super(AlertDetailsState.initial()) {
    final newState = AlertDetailsState(
      sourceName: _accounts.getSource(alert.source)?.name ?? "Unknown",
    );
    emit(newState);
  }

  final AccountsRepo _accounts;
  final Alert alert;
}
