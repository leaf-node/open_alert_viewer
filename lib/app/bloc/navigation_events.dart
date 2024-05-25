/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

abstract class NavEvent {}

final class OpenSplashPageEvent implements NavEvent {}

final class OpenAlertsPageEvent implements NavEvent {}

final class OpenSettingsPageEvent implements NavEvent {}
