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

class MainActivity: FlutterActivity() {
    private val channel = "studio.okcode.open_alert_viewer/main"

    override fun onCreate(bundle: Bundle?) {
        super.onCreate(bundle)
        FlutterEngineCache.getInstance().put("main", flutterEngine)
        CreateOrDestroyService(context, false)
        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
        call, result ->
            if (call.method == "startForeground") {
                val intent = Intent(this, OAVForegroundService::class.java)
                intent.putExtra("engineId", "main")
                context.startForegroundService(intent)
                result.success("started")
            } else {
                result.notImplemented()
            }
        }
    }
}
