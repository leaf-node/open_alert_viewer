/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

part of 'refresh_bloc.dart';

sealed class RefreshIconEvent {
  const RefreshIconEvent();
}

final class RefreshIconNow implements RefreshIconEvent {
  RefreshIconNow({required this.forceRefreshNow, this.alreadyFetching});

  final bool forceRefreshNow;
  final bool? alreadyFetching;
}

final class RefreshIconFinish implements RefreshIconEvent {
  RefreshIconFinish();
}

final class ListenForRefreshIcon implements RefreshIconEvent {
  ListenForRefreshIcon();
}
