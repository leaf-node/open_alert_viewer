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
import io.flutter.embedding.engine.dart.DartExecutor

class StartFlutterOnce (context: Context, backgroundOnly: Boolean) {
    private val serviceEngineName: String = "single_service_engine"
    private val withGuiEngineName: String = "single_with_ui_engine"
    lateinit private var flutterEngine: FlutterEngine
    init {
        val engineName: String
        if (backgroundOnly) {
            engineName = serviceEngineName
        } else {
            FlutterEngineCache.getInstance().get(serviceEngineName)?.destroy()
            engineName = withGuiEngineName
        }
        if (FlutterEngineCache.getInstance().get(engineName) == null) {
            val group = FlutterEngineGroup(context)
            flutterEngine = group.createAndRunDefaultEngine(context)
            flutterEngine.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
            FlutterEngineCache.getInstance().put(engineName, flutterEngine)
        }
    }
    fun getFlutterEngine() : FlutterEngine {
        return flutterEngine
    }
}
