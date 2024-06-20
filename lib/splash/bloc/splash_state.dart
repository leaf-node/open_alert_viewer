/*
 * SPDX-FileCopyrightText: 2024 Andrew Engelbrecht <andrew@sourceflow.dev>
 *
 * SPDX-License-Identifier: MIT
 */

abstract class SplashState {
  const SplashState();
}

final class SplashInit extends SplashState {
  SplashInit();
}

final class SplashRunning extends SplashState {
  SplashRunning();
}

final class SplashComplete extends SplashState {
  SplashComplete();
}
