/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

enum RefreshFrequencies {
  fifteenSeconds("Every 15 Seconds", 15),
  thirtySeconds("Every 30 Seconds", 30),
  oneMinute("Every Minute", 1 * 60),
  threeMinutes("Every 3 Minutes", 3 * 60),
  fiveMinutes("Every 5 Minutes", 5 * 60),
  fifteenMinutes("Every 15 Minutes", 15 * 60),
  thirtyMinutes("Every 30 Minutes", 30 * 60),
  oneHour("Every Hour", 60 * 60),
  twoHours("Every 2 Hours", 120 * 60),
  off("Off", -1);

  const RefreshFrequencies(this.text, this.value);

  final String text;
  final int value;
}

enum SyncTimeouts {
  fiveSeconds("5 Seconds", 5),
  tenSeconds("10 Seconds", 10),
  fifteenSeconds("15 Seconds", 15),
  thirtySeconds("30 Seconds", 30),
  fortyFiveSeconds("45 Seconds", 45),
  oneMinue("1 Minute", 60),
  twoMinutes("2 Minutes", 120),
  off("Off", -1);

  const SyncTimeouts(this.text, this.value);

  final String text;
  final int value;
}

enum ColorModes {
  auto("Auto", -1),
  lightMode("Light Mode", 0),
  darkMode("Dark Mode", 1);

  const ColorModes(this.text, this.value);

  final String text;
  final int value;
}
