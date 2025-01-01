/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

package studio.okcode.open_alert_viewer

import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.FlutterEngineGroup
import io.flutter.embedding.engine.dart.DartExecutor.DartEntrypoint
import io.flutter.embedding.engine.loader.FlutterLoader

class StartFlutterOnce (context: Context, serviceOnly: Boolean, arguments: Array<String>) {
    private val serviceEngineId: String = "single_service_engine"
    private val withGuiEngineId: String = "single_with_ui_engine"
    val flutterEngine: FlutterEngine
    init {
        val engineName: String
        val entrypoint: DartEntrypoint
        if (serviceOnly) {
            engineName = serviceEngineId
        } else {
            val serviceEngine = FlutterEngineCache.getInstance().get(serviceEngineId)
            try {
                serviceEngine?.destroy()
            } catch (_: RuntimeException) {}
            engineName = withGuiEngineId
        }
        val flutterEngineTmp = FlutterEngineCache.getInstance().get(engineName)
        if (flutterEngineTmp == null) {
            val group = FlutterEngineGroup(context, arguments)
            if (serviceOnly) {
                entrypoint = DartEntrypoint(
                    "lib/main.dart", "startBackground")
            } else {
                entrypoint = DartEntrypoint.createDefault()
            }
            flutterEngine = group.createAndRunEngine(context, entrypoint)
            FlutterEngineCache.getInstance().put(engineName, flutterEngine)
        } else {
            flutterEngine = flutterEngineTmp
        }
    }
}
