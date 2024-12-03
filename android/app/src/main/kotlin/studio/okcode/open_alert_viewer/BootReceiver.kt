/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

package studio.okcode.open_alert_viewer

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class BootReceiver : BroadcastReceiver() {
    override fun onReceive(context : Context, intent : Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {
            StartFlutterOnce(context, true)
        }
    }
}

