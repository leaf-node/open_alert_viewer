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

class CreateOrDestroyService(context: Context, createService: Boolean, force: Boolean) {
    private val serviceEngineId: String = "service"
    private val mainEngineId: String = "main"

    init {
        if (createService) {
            var serviceEngine = FlutterEngineCache.getInstance().get(serviceEngineId)
            val mainEngine = FlutterEngineCache.getInstance().get(mainEngineId)
            if (force) {
                destroy(mainEngine)
                FlutterEngineCache.getInstance().put(mainEngineId, null)
            }
            if ((force || mainEngine == null) && serviceEngine == null) {
                val group = FlutterEngineGroup(context)
                val entrypoint = DartEntrypoint(
                    "lib/main.dart", "startBackground"
                )
                serviceEngine = group.createAndRunEngine(context, entrypoint)
                FlutterEngineCache.getInstance().put(serviceEngineId, serviceEngine)
            }
        } else {
            destroy(FlutterEngineCache.getInstance().get(serviceEngineId))
            FlutterEngineCache.getInstance().put(serviceEngineId, null)
        }
    }

    private fun destroy(engine: FlutterEngine?) {
        try {
            engine?.destroy()
        } catch (_: RuntimeException) {
        }
    }
}
