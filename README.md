
<img width="100%" src="https://sandpiper.codes/assets/img/open-alert-viewer-feature-graphic.png">

# Open Alert Viewer

<p align="center">
    <a href='https://github.com/sandpiper-codes/open_alert_viewer/releases'>
        <img height="20" src="https://img.shields.io/github/release/sandpiper-codes/open_alert_viewer.svg?logo=github"></a>
    <a href='https://f-droid.org/en/packages/studio.okcode.open_alert_viewer/'>
        <img height="20" src="https://img.shields.io/f-droid/v/studio.okcode.open_alert_viewer.svg?logo=F-Droid"></a>
    <a href='https://flathub.org/apps/studio.okcode.open_alert_viewer'>
        <img height="20" src="https://img.shields.io/flathub/v/studio.okcode.open_alert_viewer.svg?logo=Flathub"></a>
    <a href="https://matrix.to/#/#sandpiper-codes:matrix.org" rel="noopener" target="_blank">
        <img src="https://matrix.to/img/matrix-badge.svg" alt="Chat on Matrix"></a>
</p>

Display server and network alerts from servers running Prometheus, Nagios,
Icinga or Zabbix. For Linux and Android.

Prometheus v0.16.0+, Nagios Core 4.x and Icinga 2.12.0+ are supported with
Basic Authentication; partial support and default authentication for Zabbix 6.x
and 7.x.

## Screenshots

<table>
  <tr>
    <td><a href="https://sandpiper.codes/assets/img/screenshots/oav/phone-alerts.png">
        <img alt="1" width="200px" height="auto" src="https://sandpiper.codes/assets/img/screenshots/oav/phone-alerts.png"></a></td>
    <td><a href="https://sandpiper.codes/assets/img/screenshots/oav/phone-account.png">
        <img alt="2" width="200px" height="auto" src="https://sandpiper.codes/assets/img/screenshots/oav/phone-account.png"></a></td>
    <td><a href="https://sandpiper.codes/assets/img/screenshots/oav/phone-general-settings.png">
        <img alt="3" width="200px" height="auto" src="https://sandpiper.codes/assets/img/screenshots/oav/phone-general-settings.png"></a></td>
    <td><a href="https://sandpiper.codes/assets/img/screenshots/oav/phone-alerts-filter.png">
        <img alt="4" width="200px" height="auto" src="https://sandpiper.codes/assets/img/screenshots/oav/phone-alerts-filter.png"></a></td>
  </tr>
</table>

## Install

<p align="center">
    <a href='https://f-droid.org/en/packages/studio.okcode.open_alert_viewer/'>
        <img width='289' height='100' style='display: inline-block' alt='Get it on F-Droid' src='https://sandpiper.codes/assets/img/f-droid-badge-border.png'/></a>
    <a href='https://flathub.org/apps/studio.okcode.open_alert_viewer'>
        <img width='260' height='100' style='display: inline-block' alt='Get it on Flathub' src='https://sandpiper.codes/assets/img/flathub-badge-border.png'/></a>
    <a href='https://github.com/sandpiper-codes/open_alert_viewer/releases'>
        <img width='260' height='100' style='display: inline-block' alt='Get *.tar.gz and *.deb' src='https://sandpiper.codes/assets/img/generic-badge-border.svg'/></a>
    <a href='https://play.google.com/store/apps/details?id=studio.okcode.open_alert_viewer'>
        <img width='290' height='100' style='display: inline-block' alt='Get it on Google Play' src='https://sandpiper.codes/assets/img/Google-Play-badge-border.png'/></a>
</p>

## Back end compatibility

### Compatible third-party alert services

* [Prometheus Alertmanager](https://prometheus.io/docs/alerting/latest/alertmanager/)
  v0.16.0 or later ([configuration](#prometheus))
* [Nagios Core](https://www.nagios.org/projects/nagios-core/) 4.x
* [Icinga](https://icinga.com/) 2.12.0 or later
* [Zabbix](https://zabbix.com/) 6.x and 7.x (partial support)

### Authentication

* Basic Authentication
* Zabbix: default authentication only

### Target platforms

* Android 12.1+
    * [F-Droid](https://f-droid.org/en/packages/studio.okcode.open_alert_viewer/)
    * [Google Play](https://play.google.com/store/apps/details?id=studio.okcode.open_alert_viewer)
* Linux (`x86_64`, `aarch64`)
    * [Flathub](https://flathub.org/apps/studio.okcode.open_alert_viewer)
    * [.deb and .tar.gz](https://github.com/sandpiper-codes/open_alert_viewer/releases)
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
lic_ck check-licenses --config lic_ck.yaml
dart run flutter_oss_licenses:generate
```

### Android

```
cd open_alert_viewer
flutter build apk --debug
adb install build/app/outputs/flutter-apk/app-debug.apk
```
- or -
```
cd open_alert_viewer
vim android/key.properties
flutter build apk
adb install build/app/outputs/flutter-apk/app-release.apk
```

Where `android/key.properties` is something like:

```
storePassword=my_first_password
keyPassword=my_second_password
keyAlias=key0
storeFile=/home/andrew/.android-keystore/upload-keystore.jks
```

### Linux

```
sudo apt install curl git unzip xz-utils zip libglu1-mesa imagemagick \
    clang cmake git ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev \
    libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libunwind-dev

cd open_alert_viewer
flutter build linux
./build/linux/x64/release/bundle/open_alert_viewer
```

You can move or copy the `bundle` directory anywhere on your file system, but
internal structure should remain the same. If you want to put the binary in
your path, make a symlink.

If you want to build a simple .deb file, check your version of `libgtk-3-0...`
and run the following script with something like:

```
./linux/oav-custom/compile x64 "libgtk-3-0t64 (>= 3.24.41)"
```

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

* [Issue tracker](https://github.com/sandpiper-codes/open_alert_viewer/issues)
* [![Chat on Matrix](https://matrix.to/img/matrix-badge.svg)](https://matrix.to/#/#sandpiper-codes:matrix.org)


## License

License: MIT

Other dependencies use a variety of permissive licenses. See the licensing tab
in the app for a list of them.

Aside from Open Alert Viewer itself, neither Open Alert Viewer nor Sandpiper
Codes are endorsed by, nor affiliated with, the creators of the software
referenced in this app, this app's source code, nor its documentation. While
these may nominatively reference the names and logos of third party software,
they are trademarked by their respective owners.

