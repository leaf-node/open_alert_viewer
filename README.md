
<img width="100%" src="https://okcode.studio/assets/img/open-alert-viewer-feature-graphic.png">

# Open Alert Viewer

Open Alert Viewer is a libre / open source app that displays server and network
alerts to system administrators and SREs. It requires access to a server
running [Prometheus](https://prometheus.io/), [Nagios](https://www.nagios.org/)
or [Icinga](https://icinga.com/).

Prometheus v0.16.0+, Nagios Core 4.x and Icinga 2.12.0+ are supported, with
Basic Authentication.

## Screenshots

<table>
  <tr>
    <td><a href="https://okcode.studio/assets/img/screenshots/oav/phone-alerts.png">
        <img alt="1" width="200px" height="auto" src="https://okcode.studio/assets/img/screenshots/oav/phone-alerts.png"></a></td>
    <td><a href="https://okcode.studio/assets/img/screenshots/oav/phone-account.png">
        <img alt="2" width="200px" height="auto" src="https://okcode.studio/assets/img/screenshots/oav/phone-account.png"></a></td>
    <td><a href="https://okcode.studio/assets/img/screenshots/oav/phone-general-settings.png">
        <img alt="3" width="200px" height="auto" src="https://okcode.studio/assets/img/screenshots/oav/phone-general-settings.png"></a></td>
    <td><a href="https://okcode.studio/assets/img/screenshots/oav/phone-alerts-filter.png">
        <img alt="4" width="200px" height="auto" src="https://okcode.studio/assets/img/screenshots/oav/phone-alerts-filter.png"></a></td>
  </tr>
</table>

## Install

<p align="center">
    <a href='https://flathub.org/apps/studio.okcode.open_alert_viewer'>
        <img width='240' height='80' style='display: inline-block' alt='Get it on Flathub' src='https://flathub.org/api/badge?svg&locale=en&light'/></a>
</p>

## Back end compatibility

### Compatible third-party alert services

* [Prometheus Alertmanager](https://prometheus.io/docs/alerting/latest/alertmanager/)
  v0.16.0 or later ([configuration](#prometheus))
* [Nagios Core](https://www.nagios.org/projects/nagios-core/) 4.x
* [Icinga](https://icinga.com/) 2.12.0 or later
* (More planned)

### Authentication

* Basic Authentication
* (More planned)

### Target platforms

* Android 12.1+
    * Submitted to F-Droid (status pending)
    * Submitted Google Play Store (status pending)
* Linux (x86)
    * [Flathub](https://flathub.org/apps/studio.okcode.open_alert_viewer)
* (More planned)

## Build instructions

### Dependencies

* [Flutter](https://docs.flutter.dev/get-started/install)
* OpenJDK 17 (or similar, for Android)
* Gstreamer and headers (for Linux)

### Pre-build

```
cd open_alert_viewer
flutter pub get
dart run build_runner build
dart run flutter_oss_licenses:generate
```

### Android

```
cd open_alert_viewer
flutter build apk
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Linux

```
sudo apt install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev

cd open_alert_viewer
flutter build linux
./build/linux/x64/release/bundle/open_alert_viewer
```

You can move or copy the `bundle` directory anywhere on your file system, but
internal structure should remain the same. If you want to put the binary in
your path, make a symlink.

## Back end configuration

### Prometheus Alertmanager

When setting up your account in the app, enter the base address of your
Alertmanager service, not Prometheus. Alertmanager may be listening on port
`9093`, but it needs to be wrapped in HTTPS, so it might be on another port, or
under a separate base URL.

Prometheus doesn't seem to have a strict standard for categorization of alert
types, so this app depends on a couple configurations on your server:

1. In files imported by the Prometheus `rule_files` directive, ensure that
   warning alerts have the label `severity:` set to `warning`, and the rest are
   set to `page`, `critical` or `error` (the default) for critical service and
   down host checks.

1. For down host checks, you should also make sure that alerts are labeled with
   the custom label: `oav_type:` `ping` or `icmp`.

This app parses any labels set by Prometheus in a case-sensitive way.

## Debugging

To view debug alerts, create an account with the base URL set to `demo`.

## Support

* [Issue tracker](https://github.com/okcode-studio/open_alert_viewer/issues)
* Discuss on [Matrix](https://matrix.to/#/#ok-code-studio-llc:matrix.org)

## License

License: MIT

Other dependencies use a variety of permissive licenses. See the licensing tab
in the app for a list of them.

Aside from Open Alert Viewer itself, neither Open Alert Viewer nor OK Code
Studio LLC are endorsed by, nor affiliated with, the creators of the software
referenced in this app, this app's source code, nor its documentation. While
these may nominatively reference the names and logos of third party software,
they are trademarked by their respective owners.

