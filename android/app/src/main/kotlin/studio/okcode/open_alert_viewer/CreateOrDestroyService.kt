/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

package studio.okcode.open_alert_viewer

import android.content.Context
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.FlutterEngineGroup
import io.flutter.embedding.engine.dart.DartExecutor.DartEntrypoint

class CreateOrDestroyService (context: Context, createService: Boolean) {
    private val serviceEngineId: String = "single_service_engine"
    init {
        if (createService) {
            var serviceEngine = FlutterEngineCache.getInstance().get(serviceEngineId)
            if (serviceEngine == null) {
                val group = FlutterEngineGroup(context)
                val entrypoint = DartEntrypoint(
                    "lib/main.dart", "startBackground")
                serviceEngine = group.createAndRunEngine(context, entrypoint)
                FlutterEngineCache.getInstance().put(serviceEngineId, serviceEngine)
            }
        } else {
            val serviceEngine = FlutterEngineCache.getInstance().get(serviceEngineId)
            try {
                serviceEngine?.destroy()
            } catch (_: RuntimeException) {}
        }
    }
}
