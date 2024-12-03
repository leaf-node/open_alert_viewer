/*
 * SPDX-FileCopyrightText: 2024 Open Alert Viewer authors
 *
 * SPDX-License-Identifier: MIT
 */

package studio.okcode.open_alert_viewer

import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    override fun provideFlutterEngine(context: Context): FlutterEngine {
        return StartFlutterOnce(context, false).flutterEngine
    }
}
