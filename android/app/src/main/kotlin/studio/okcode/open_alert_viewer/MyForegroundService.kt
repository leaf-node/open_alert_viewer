/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

package studio.okcode.open_alert_viewer

import android.app.Service
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.app.ServiceCompat
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel

class MyForegroundService: Service() {
    // must match lib/background/repositories/notifications_bg_repo.dart
    private val stickyNotificationChannelId = "Open Alert Viewer Background Work"
    private val stickyNotificationId = 1
    private val channel = "studio.okcode.open_alert_viewer/service"

    override fun onStartCommand(intent: Intent, flags: Int, startId: Int) : Int {
        if (!NotificationManagerCompat.from(this).areNotificationsEnabled()) {
            stopSelf()
            return START_NOT_STICKY
        }
        var engineId = intent.getStringExtra("engineId") ?: "service"
        if (FlutterEngineCache.getInstance().get("main") == null) {
            engineId = "service"
        }
        if (engineId == "service" && FlutterEngineCache.getInstance().get(engineId) == null) {
            CreateOrDestroyService(baseContext, true)
        }
        val flutterEngine = FlutterEngineCache.getInstance().get(engineId)!!
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            if (call.method == "stopForeground") {
                stopSelf()
                result.success("stopped")
            } else {
                result.notImplemented()
            }
        }
        try {
            val notification = NotificationCompat.Builder(this, stickyNotificationChannelId)
                .build()
            val serviceInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                ServiceInfo.FOREGROUND_SERVICE_TYPE_DATA_SYNC
            } else {
                0
            }
            ServiceCompat.startForeground(
                this, stickyNotificationId, notification, serviceInfo)
        } catch (e: Exception) {
            throw e
        }
        return START_REDELIVER_INTENT
    }

    override fun onBind(intent: Intent) : IBinder? {
        return null
    }

    override fun onTimeout(p0: Int) {
        stopSelf()
    }
}