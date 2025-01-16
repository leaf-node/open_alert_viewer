/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

package studio.okcode.open_alert_viewer

import android.content.Intent
import android.os.Bundle
import androidx.core.app.NotificationManagerCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "studio.okcode.open_alert_viewer/main"
    private var initText = "Initializing..."
    private var autostartForeground = false

    private fun conditionallyStartOAVForegroundService(engineId: String, force: Boolean) {
        if (!NotificationManagerCompat.from(context).areNotificationsEnabled()) {
            return
        }
        stopService(Intent(this, OAVForegroundService::class.java))
        val intent = Intent(this, OAVForegroundService::class.java)
        intent.putExtra("engineId", engineId)
        intent.putExtra("force", force)
        intent.putExtra("initText", initText)
        context.startForegroundService(intent)
    }

    override fun onCreate(bundle: Bundle?) {
        super.onCreate(bundle)
        FlutterEngineCache.getInstance().put("main", flutterEngine)
        CreateOrDestroyService(context, createService = false, force = false)
        MethodChannel(
            flutterEngine!!.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            if (call.method == "startForeground") {
                autostartForeground = true
                conditionallyStartOAVForegroundService("main", false)
                result.success("started")
            } else if (call.method == "updateNotificationInit") {
                initText = call.arguments<String>() ?: initText
                result.success("updated")
            } else if (call.method == "dontAutostartForeground") {
                autostartForeground = false
                result.success("set")
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onStart() {
        super.onStart()
        if (autostartForeground) {
            conditionallyStartOAVForegroundService("main", false)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        conditionallyStartOAVForegroundService("service", true)
    }
}
