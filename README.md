# Open Alert Viewer

A server and network alert client that will be able to display active alerts on
your Android phone or Linux desktop, with the opportunity for wider support in
the future.

Currently this project is under development, with the goal of building an MVP
and incrementally growing the number of compatible back end alerting services.

License: MIT

## Prometheus configuration

Prometheus doesn't seem to have a strict standard for categorization of alert
types, so this app depends on a couple configurations on your server.

1. In files imported by the Prometheus `rule_files` directive, ensure that
   warning alerts have the label `severity:` set to `warning`, and the rest are
   set to `page`, `critical` or `error` (the default) for critical service and
   down host checks.

1. For down host checks, you also need to make sure that alerts are labeled
   with the custom label: `oav_type:` `ping` or `icmp`.

The parsing of both of these labels in this app is case *sensitive*.

When setting up your account in the app, enter the base address of your
Alertmanager service, not Prometheus itself.

