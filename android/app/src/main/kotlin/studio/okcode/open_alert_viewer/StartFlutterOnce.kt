/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

package studio.okcode.open_alert_viewer

import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.FlutterEngineGroup
import io.flutter.embedding.engine.dart.DartExecutor.DartEntrypoint

class StartFlutterOnce (context: Context, serviceOnly: Boolean) {
    private val serviceEngineName: String = "single_service_engine"
    private val withGuiEngineName: String = "single_with_ui_engine"
    val flutterEngine: FlutterEngine
    init {
        val engineName: String
        val entrypoint: DartEntrypoint
        if (serviceOnly) {
            engineName = serviceEngineName
        } else {
            val serviceEngine = FlutterEngineCache.getInstance().get(serviceEngineName)
            try {
                serviceEngine?.destroy()
            } catch (_: RuntimeException) {}
            engineName = withGuiEngineName
        }
        val flutterEngineTmp = FlutterEngineCache.getInstance().get(engineName)
        if (flutterEngineTmp == null) {
            val group = FlutterEngineGroup(context)
            flutterEngine = group.createAndRunDefaultEngine(context)
            if (serviceOnly) {
                entrypoint = DartEntrypoint(
                    "lib/main.dart", "startBackground")
            } else {
                entrypoint = DartEntrypoint.createDefault()
            }
            flutterEngine.dartExecutor.executeDartEntrypoint(entrypoint)
            FlutterEngineCache.getInstance().put(engineName, flutterEngine)
        } else {
            flutterEngine = flutterEngineTmp
        }
    }
}
