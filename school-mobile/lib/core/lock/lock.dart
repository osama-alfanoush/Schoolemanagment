/// The optional screen lock in front of the app.
///
/// An app-lock, never authentication: a successful unlock reveals a session
/// that already exists, and the token stays the only thing that authorises
/// anything.
library;

export 'app_lock_controller.dart';
export 'app_lock_overlay.dart';
export 'biometric_gate.dart';
