package jo.schoolsuite.mobile

import android.view.WindowManager
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/**
 * FlutterFragmentActivity, not FlutterActivity.
 *
 * androidx.biometric — which local_auth uses to show the system prompt —
 * requires a FragmentActivity host. On a plain FlutterActivity the prompt
 * throws `no_fragment_activity` at runtime, which only shows up on a device.
 */
class MainActivity : FlutterFragmentActivity() {

    /**
     * FLAG_SECURE, driven per screen from Dart.
     *
     * Set on the screens that display a family's money or a child's record:
     * fees, invoices, receipts, published marks, attendance, and a class
     * roster carrying guardians' phone numbers. It blocks screenshots, screen
     * recording, and — the one people forget — the thumbnail Android renders
     * of the app in the task switcher, which is where a fee balance would
     * otherwise sit in plain view on a shared phone.
     *
     * Deliberately not set for the whole app. A parent has every reason to
     * screenshot a timetable or a notice and send it on, and people who cannot
     * do the ordinary thing photograph the screen with another phone, which
     * defeats the protection entirely.
     */
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "jo.schoolsuite.mobile/secure_screen",
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "setSecure" -> {
                    val secure = call.arguments as? Boolean ?: false
                    // The window flag has to be touched on the UI thread.
                    runOnUiThread {
                        if (secure) {
                            window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        } else {
                            window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
                        }
                    }
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }
}
