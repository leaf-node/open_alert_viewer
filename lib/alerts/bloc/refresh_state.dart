/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

part of 'refresh_bloc.dart';

sealed class RefreshIconState {
  const RefreshIconState();
}

final class RefresIconInitial extends RefreshIconState {
  RefresIconInitial();
}

final class RefreshIconTriggered extends RefreshIconState {
  RefreshIconTriggered(
      {required this.forceRefreshNow, required this.alreadyFetching});

  final bool forceRefreshNow;
  final bool alreadyFetching;
}

final class RefreshIconFinished extends RefreshIconState {
  RefreshIconFinished();
}
