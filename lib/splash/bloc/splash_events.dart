/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

abstract class SplashEvent {}

final class InitSplashEvent implements SplashEvent {}

final class RunningSplashEvent implements SplashEvent {}

final class CompleteSplashEvent implements SplashEvent {}
