/*
 * SPDX-FileCopyrightText: 2024 okaycode.dev LLC and Open Alert Viewer Authors
 *
 * SPDX-License-Identifier: MIT
 */

abstract class SplashEvent {}

final class InitSplashEvent implements SplashEvent {}

final class RunningSplashEvent implements SplashEvent {}

final class CompleteSplashEvent implements SplashEvent {}
