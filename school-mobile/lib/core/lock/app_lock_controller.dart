import 'package:flutter/widgets.dart';

import '../auth/secure_store.dart';
import 'biometric_gate.dart';

/// Whether the app is currently behind the lock.
enum AppLockStatus {
  /// The feature is off, or this device cannot present a prompt.
  off,

  /// On, and the app is open.
  open,

  /// On, and the app is covered until the user proves who they are.
  locked,
}

/// The screen lock the user can put in front of the app.
///
/// **This is an app-lock, not authentication.** A successful unlock reveals a
/// session that already exists; it never creates one, never refreshes a token
/// and never speaks to the server. The token remains the only thing that
/// authorises anything. Nothing here stores a password to re-authenticate
/// with, because a stored password is a credential that outlives the session it
/// was meant to protect.
///
/// Failing to unlock therefore cannot "let you in anyway". The only two ways
/// off the lock screen are a successful prompt and signing out.
class AppLockController extends ChangeNotifier with WidgetsBindingObserver {
  AppLockController({
    required this.gate,
    required this.store,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  /// Secure-storage keys this feature owns.
  static const String enabledKey = 'school_mobile.app_lock_enabled';
  static const String timeoutKey = 'school_mobile.app_lock_timeout_seconds';

  /// Grace period after backgrounding before the lock engages.
  ///
  /// Zero would lock on every glance at a notification, which is how a
  /// security feature gets switched off within a day.
  static const Duration defaultTimeout = Duration(minutes: 2);

  /// Choices offered in settings.
  static const List<Duration> timeoutChoices = <Duration>[
    Duration.zero,
    Duration(minutes: 1),
    Duration(minutes: 2),
    Duration(minutes: 5),
    Duration(minutes: 15),
  ];

  final BiometricGate gate;
  final SecureStore store;
  final DateTime Function() _clock;

  AppLockStatus _status = AppLockStatus.off;
  Duration _timeout = defaultTimeout;
  DateTime? _backgroundedAt;
  bool _available = false;

  AppLockStatus get status => _status;

  bool get isLocked => _status == AppLockStatus.locked;

  bool get isEnabled => _status != AppLockStatus.off;

  /// Whether this device can present a prompt at all.
  bool get isAvailable => _available;

  Duration get timeout => _timeout;

  /// Reads the stored preference. Call once at startup.
  Future<void> load() async {
    _available = await gate.isAvailable();

    final seconds = int.tryParse(await store.read(timeoutKey) ?? '');
    if (seconds != null && seconds >= 0) _timeout = Duration(seconds: seconds);

    final enabled = await store.read(enabledKey) == 'true';

    // A device that can no longer present a prompt cannot hold a lock. Leaving
    // it "on" would strand the user behind a screen with no way through.
    _setStatus(enabled && _available ? AppLockStatus.open : AppLockStatus.off);
  }

  /// Turns the lock on. Refused when the device cannot present a prompt.
  Future<bool> enable() async {
    _available = await gate.isAvailable();
    if (!_available) return false;

    await store.write(enabledKey, 'true');
    _setStatus(AppLockStatus.open);

    return true;
  }

  Future<void> disable() async {
    await store.write(enabledKey, 'false');
    _setStatus(AppLockStatus.off);
  }

  Future<void> setTimeout(Duration timeout) async {
    if (timeout.isNegative) return;

    _timeout = timeout;
    await store.write(timeoutKey, '${timeout.inSeconds}');
    notifyListeners();
  }

  /// Locks now, regardless of the timeout. Used when the user asks, and when
  /// a fresh session starts on a device that already had the lock on.
  void lockNow() {
    if (_status == AppLockStatus.off) return;

    _setStatus(AppLockStatus.locked);
  }

  /// Prompts, and opens the app only on success.
  Future<UnlockOutcome> unlock({required String reason}) async {
    if (_status != AppLockStatus.locked) return UnlockOutcome.succeeded;

    final outcome = await gate.unlock(reason: reason);

    if (outcome == UnlockOutcome.succeeded) {
      _backgroundedAt = null;
      _setStatus(AppLockStatus.open);
    }

    // Every other outcome leaves the status alone. There is deliberately no
    // branch here that opens the app on a failure, a cancellation or a device
    // that has stopped supporting prompts — each of those would be a bypass.
    return outcome;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_status == AppLockStatus.off) return;

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        _backgroundedAt ??= _clock();
      case AppLifecycleState.resumed:
        final since = _backgroundedAt;
        _backgroundedAt = null;
        if (since == null) return;

        if (_clock().difference(since) >= _timeout) _setStatus(AppLockStatus.locked);
      case AppLifecycleState.inactive:
        // The transient state behind a notification shade or an incoming call.
        // Treating it as backgrounded would lock the app while the user is
        // still looking at it.
        break;
    }
  }

  /// Starts watching the app lifecycle.
  void bind() => WidgetsBinding.instance.addObserver(this);

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _setStatus(AppLockStatus next) {
    if (next == _status) return;

    _status = next;
    notifyListeners();
  }
}
