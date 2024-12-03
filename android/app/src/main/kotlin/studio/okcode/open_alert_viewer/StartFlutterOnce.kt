package studio.okcode.open_alert_viewer

import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.FlutterEngineGroup
import io.flutter.embedding.engine.dart.DartExecutor

class StartFlutterOnce (context: Context, backgroundOnly: Boolean) {
    private val bgEngineName: String = "single_bg_engine"
    private val fgEngineName: String = "single_fg_engine"
    lateinit var flutterEngine: FlutterEngine
    init {
        val engineName: String
        if (backgroundOnly) {
            engineName = bgEngineName
        } else {
            FlutterEngineCache.getInstance().get(bgEngineName)?.destroy()
            engineName = fgEngineName
        }
        if (FlutterEngineCache.getInstance().get(engineName) == null) {
            val group = FlutterEngineGroup(context)
            flutterEngine = group.createAndRunDefaultEngine(context)
            flutterEngine.dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
            FlutterEngineCache.getInstance().put(engineName, flutterEngine)
        }
    }
}
