---
name: Pre-release testing checklist
about: Steps for checking the app prior to publishing a new version
title: App testing checklist - version X.Y.Z
labels: testing
assignees: ''

---

## General and GUI / front end testing

* [ ] Alerts screen
    * [ ] Alerts show up
    * [ ] Pull to refresh works
    * [ ] Filtering alerts by type and silence filter types works
* [ ] Settings
    * [ ] Changing settings updates settings views and changes behavior
* [ ] Source / account editor
    * [ ] Add a demo alert source: `demo`
    * [ ] Add an alert source that points to a remote address
    * [ ] Edit an alert source
    * [ ] Invalid or HTTP-only addresses cannot be saved
    * [ ] Passwords can be shown and hidden
    * [ ] Trying to remove an account shows a warning dialog
    * [ ] Trying to discard entered text shows a warning dialog
* [ ] All screens load their data
* [ ] The app opens quickly after a force stop
* [ ] None of the text or dialogs have spelling errors
* [ ] Does the app catch and recover from all errors?

## Background Isolate testing

* [ ] Database
    * [ ] DB initializes without errors
    * [ ] DB migrates from an older version without errors
* [ ] Test all types of supported third party services
    * [ ] Test acknowledgement and scheduled downtime settings for all source types
    * [ ] Test new and old versions of all third party services
* [ ] Notifications
    * [ ] Notifications are generated when there are recent alerts
    * [ ] Sounds are played when enabled
* [ ] Does the app recover from or handle all errors gracefully?

## Android-specific

* [ ] App life cycle
    * [ ] The foreground service notification shows up in about 10 seconds when notifications are enabled
    * [ ] The app stays active for at least 6 hours without interacting with it
    * [ ] The app produces an error message when the foreground service times out
    * [ ] The foreground service notification is usually up to date, and not more than a few minutes out of date at any time
    * [ ] Is the app launched after restarting the phone when notifications were enabled?
* [ ] Previous bugs
    * [ ] Turning off notifications in app settings doesn't crash, freeze or blank out the app
    * [ ] ~App doesn't flicker when navigating through menus or scrolling~
* [ ] Test app on tablet, phone and foldable form-factors, test changing rotation and folding
* [ ] Permissions are requested after the user creates the first account, not when the app opens

## Linux-specific

* [ ] Trying to open a second running version of the app only launches a notification

