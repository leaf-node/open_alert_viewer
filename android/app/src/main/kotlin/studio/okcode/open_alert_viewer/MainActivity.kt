/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

package studio.okcode.open_alert_viewer

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "studio.okcode.open_alert_viewer/main"

    private fun startForegroundService(engineId: String, force: Boolean) {
        stopService(Intent(this, OAVForegroundService::class.java))
        val intent = Intent(this, OAVForegroundService::class.java)
        intent.putExtra("engineId", engineId)
        intent.putExtra("force", force)
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
                startForegroundService("main", false)
                result.success("started")
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        startForegroundService("service", true)
    }
}
