package jo.schoolsuite.mobile

import io.flutter.embedding.android.FlutterFragmentActivity

/**
 * FlutterFragmentActivity, not FlutterActivity.
 *
 * androidx.biometric — which local_auth uses to show the system prompt —
 * requires a FragmentActivity host. On a plain FlutterActivity the prompt
 * throws `no_fragment_activity` at runtime, which only shows up on a device.
 */
class MainActivity : FlutterFragmentActivity()
