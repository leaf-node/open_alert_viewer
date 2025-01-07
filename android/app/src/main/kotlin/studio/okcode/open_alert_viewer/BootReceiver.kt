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
        if (intent.action.equals("android.intent.action.BOOT_COMPLETED") ||
            intent.action.equals("android.intent.action.QUICKBOOT_POWERON") ||
            intent.action.equals("com.htc.intent.action.QUICKBOOT_POWERON") ||
            intent.action.equals("android.intent.action.MY_PACKAGE_REPLACED")) {

            CreateOrDestroyService(context, true)
        }
    }
}

