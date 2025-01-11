/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

package studio.okcode.open_alert_viewer

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.app.ServiceCompat
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel

class OAVForegroundService : Service() {
    private val channel = "studio.okcode.open_alert_viewer/service"
    private val stickyNotificationChannelId = "Open Alert Viewer Background Work"
    private val stickyNotificationChannelName = "Background Work"
    private val stickyNotificationChannelDescription = "Allow Fetching Alerts in Background"
    private val stickyNotificationId = 1
    private val stickyNotificationTitle = "Periodically check for new alerts"
    private var notificationManager: NotificationManager? = null
    private var notification: NotificationCompat.Builder? = null
    
    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        try {
            if (!NotificationManagerCompat.from(this).areNotificationsEnabled()) {
                stopForeground(STOP_FOREGROUND_REMOVE)
                stopSelf()
                return START_NOT_STICKY
            }
            createChannel()
            notification = NotificationCompat.Builder(this, stickyNotificationChannelId)
            notification?.setSmallIcon(R.drawable.notification_icon)
                ?.setContentTitle(stickyNotificationTitle)
                ?.setContentText("Initializing...")
            val serviceInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                ServiceInfo.FOREGROUND_SERVICE_TYPE_DATA_SYNC
            } else {
                0
            }
            ServiceCompat.startForeground(
                this, stickyNotificationId, notification!!.build(), serviceInfo
            )
            var engineId = intent.getStringExtra("engineId") ?: "service"
            val force = intent.getBooleanExtra("force", false)
            if (FlutterEngineCache.getInstance().get("main") == null || engineId == "service" || force) {
                engineId = "service"
                CreateOrDestroyService(baseContext, true, force)
            }
            val flutterEngine = FlutterEngineCache.getInstance().get(engineId)!!
            MethodChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                channel
            ).setMethodCallHandler { call, result ->
                if (call.method == "stopForeground") {
                    stopForeground(STOP_FOREGROUND_REMOVE)
                    stopSelf()
                    result.success("stopped")
                }
                if (call.method == "updateNotification") {
                    notification?.setContentText(call.arguments<String>())
                    notificationManager?.notify(stickyNotificationId, notification!!.build())
                } else {
                    result.notImplemented()
                }
            }
        } catch (e: Exception) {
            Log.d("open_alert_viewer", e.toString())
            stopForeground(STOP_FOREGROUND_REMOVE)
            stopSelf()
            return START_NOT_STICKY
        }
        return START_REDELIVER_INTENT
    }

    private fun createChannel() {
        val mChannel = NotificationChannel(
            stickyNotificationChannelId,
            stickyNotificationChannelName, NotificationManager.IMPORTANCE_LOW
        )
        mChannel.description = stickyNotificationChannelDescription
        notificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        notificationManager?.createNotificationChannel(mChannel)
    }

    override fun onBind(intent: Intent): IBinder? {
        return null
    }

    override fun onTimeout(p0: Int) {
        super.onTimeout(p0)
        stopForeground(STOP_FOREGROUND_REMOVE)
        stopSelf()
    }

    override fun onDestroy() {
        super.onDestroy()
        stopForeground(STOP_FOREGROUND_REMOVE)
        stopSelf()
    }
}