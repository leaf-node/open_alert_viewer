# Open Alert Viewer

Open Alert Viewer is a libre, open source app for system administrators that
displays server and network alerts on Android phones and Linux desktops. It
requires access to a compatible third party back end service that monitors your
network.

Currently this project is in its early stages, with the goal of adding
support for additional back end alerting services.

## Back end support

### Alert services

* Prometheus Alertmanager ([configuration](#prometheus))
* Demo data (set base URL to `demo`)
* (More planned)

### Authentication

* Basic Authentication
* (More planned)

## Build instructions

### Dependencies

* [Flutter](https://docs.flutter.dev/get-started/install)
* OpenJDK ~17 (or similar)
* Gstreamer and headers (for Linux)

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

### Prometheus

Prometheus doesn't seem to have a strict standard for categorization of alert
types, so this app depends on a couple configurations on your server:

1. In files imported by the Prometheus `rule_files` directive, ensure that
   warning alerts have the label `severity:` set to `warning`, and the rest are
   set to `page`, `critical` or `error` (the default) for critical service and
   down host checks.

1. For down host checks, you should also make sure that alerts are labeled with
   the custom label: `oav_type:` `ping` or `icmp`.

The parsing of both of these labels in this app is case sensitive.

When setting up your account in the app, enter the base address of your
Alertmanager service, not Prometheus itself.

## License

License: MIT

