/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

package studio.okcode.open_alert_viewer

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.app.ServiceCompat
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel

class OAVForegroundService : Service() {
    private val channel = "studio.okcode.open_alert_viewer/service"
    private var methodChannel: MethodChannel? = null
    private val stickyNotificationChannelId = "Open Alert Viewer Background Work"
    private val stickyNotificationChannelName = "Background Work"
    private val stickyNotificationChannelDescription = "Allow Fetching Alerts in Background"
    private val stickyNotificationId = 1
    private val stickyNotificationTitle = "Periodically check for new alerts"
    private var stickyNotificationText = "Initializing..."
    private var stickyNotificationManager: NotificationManager? = null
    private var stickyNotification: NotificationCompat.Builder? = null
    private val appErrorNotificationChannelId = "Open Alert Viewer Error"
    private val appErrorNotificationChannelName = "App Error"
    private val appErrorNotificationChannelDescription = "Notifications About App Errors"
    private val appErrorNotificationId = 0
    private val appErrorNotificationTitleTimeout = "App timed out due to inactivity"
    private val appErrorNotificationTitleError = "App stopped due to an error"
    private val appErrorNotificationText = "Tap to resume"
    private var appErrorNotificationManager: NotificationManager? = null
    private var appErrorNotification: NotificationCompat.Builder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        super.onStartCommand(intent, flags, startId)
        try {
            if (!NotificationManagerCompat.from(this).areNotificationsEnabled()) {
                stopOAVService(timedOut = false, error = false)
                return START_NOT_STICKY
            }
            initAppErrorNotificationChannel()
            initStickyNotificationChannel()
            closeAppErrorNotification()
            showStickyNotificationAndStart(intent)
            listenToDart(intent)
        } catch (e: Exception) {
            Log.d("open_alert_viewer", e.toString())
            stopOAVService(timedOut = false, error = true)
            return START_NOT_STICKY
        }
        return START_STICKY
    }

    private fun listenToDart(intent: Intent?) {
        val flutterEngine = selectEngine(intent)
        methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        )
        methodChannel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "stopForeground" -> {
                    stopOAVService(timedOut = false, error = false)
                    result.success("stopped")
                }

                "updateNotification" -> {
                    stickyNotificationText = call.arguments<String>() ?: stickyNotificationText
                    stickyNotification?.setContentText(stickyNotificationText)
                    stickyNotificationManager?.notify(
                        stickyNotificationId,
                        stickyNotification!!.build()
                    )
                    result.success("updated")
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun initStickyNotificationChannel() {
        val mChannel = NotificationChannel(
            stickyNotificationChannelId,
            stickyNotificationChannelName, NotificationManager.IMPORTANCE_LOW
        )
        mChannel.description = stickyNotificationChannelDescription
        stickyNotificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        stickyNotificationManager?.createNotificationChannel(mChannel)
    }

    private fun showStickyNotificationAndStart(intent: Intent?) {
        stickyNotificationText = intent?.getStringExtra("initText") ?: stickyNotificationText
        val onClickNotificationIntent = PendingIntent.getActivity(
            this, 0,
            Intent(this, MainActivity::class.java), PendingIntent.FLAG_IMMUTABLE
        )
        stickyNotification = NotificationCompat.Builder(this, stickyNotificationChannelId)
        stickyNotification?.setSmallIcon(R.drawable.notification_icon)
            ?.setContentTitle(stickyNotificationTitle)
            ?.setContentText(stickyNotificationText)
            ?.setContentIntent(onClickNotificationIntent)
        val serviceInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            ServiceInfo.FOREGROUND_SERVICE_TYPE_DATA_SYNC
        } else {
            0
        }
        ServiceCompat.startForeground(
            this, stickyNotificationId, stickyNotification!!.build(), serviceInfo
        )
    }

    private fun initAppErrorNotificationChannel() {
        val mChannel = NotificationChannel(
            appErrorNotificationChannelId,
            appErrorNotificationChannelName, NotificationManager.IMPORTANCE_HIGH
        )
        mChannel.description = appErrorNotificationChannelDescription
        appErrorNotificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        appErrorNotificationManager?.createNotificationChannel(mChannel)
    }

    private fun showAppErrorNotification(error: Boolean) {
        val onClickNotificationIntent = PendingIntent.getActivity(
            this, 0,
            Intent(this, MainActivity::class.java), PendingIntent.FLAG_IMMUTABLE
        )
        appErrorNotification = NotificationCompat.Builder(this, appErrorNotificationChannelId)
        appErrorNotification?.setSmallIcon(R.drawable.notification_icon)
            ?.setContentText(appErrorNotificationText)
            ?.setContentIntent(onClickNotificationIntent)
        if (error) {
            appErrorNotification?.setContentTitle(appErrorNotificationTitleError)
        } else {
            appErrorNotification?.setContentTitle(appErrorNotificationTitleTimeout)
        }
        appErrorNotificationManager!!.notify(appErrorNotificationId, appErrorNotification!!.build())
    }

    private fun closeAppErrorNotification() {
        appErrorNotificationManager!!.cancel(appErrorNotificationId)
    }

    private fun selectEngine(intent: Intent?): FlutterEngine {
        val engineId = intent?.getStringExtra("engineId") ?: "service"
        val force = intent?.getBooleanExtra("force", false) ?: false
        if (engineId == "service") {
            CreateOrDestroyService(baseContext, true, force)
        }
        val flutterEngine: FlutterEngine
        val mainEngine = FlutterEngineCache.getInstance().get("main")
        val serviceEngine = FlutterEngineCache.getInstance().get("service")
        flutterEngine = if (engineId == "main" && mainEngine !== null) {
            mainEngine
        } else if (engineId == "service" && serviceEngine !== null) {
            serviceEngine
        } else {
            mainEngine ?: serviceEngine!!
        }
        return flutterEngine
    }

    override fun onBind(intent: Intent): IBinder? {
        return null
    }

    override fun onTimeout(p0: Int, p1: Int) {
        super.onTimeout(p0, p1)
        stopOAVService(timedOut = true, error = false)
    }

    override fun onDestroy() {
        super.onDestroy()
        stopOAVService(timedOut = false, error = false)
    }

    private fun stopOAVService(timedOut: Boolean, error: Boolean) {
        methodChannel?.setMethodCallHandler(null)
        stopForeground(STOP_FOREGROUND_REMOVE)
        stopSelf()
        if (error) {
            showAppErrorNotification(error = true)
        } else if (timedOut) {
            showAppErrorNotification(error = false)
        }
    }
}
