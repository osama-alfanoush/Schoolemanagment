import 'dart:async';

import '../db/database_key_provider.dart';
import 'secure_token_store.dart';

/// Clears everything a signed-out session must not leave behind.
///
/// One call drops the access token, the refresh token and the database key.
/// The device id deliberately survives — see [SecureTokenStore.clear] — and is
/// removed only by [forgetDevice].
class SessionWipe {
  SessionWipe({required this.tokenStore, required this.databaseKeyProvider});

  final SecureTokenStore tokenStore;
  final DatabaseKeyProvider databaseKeyProvider;

  /// Sign-out wipe: credentials and key material go, device identity stays.
  Future<void> wipe() async {
    await tokenStore.clear();
    await databaseKeyProvider.clear();
  }

  /// "Forget this device": everything [wipe] removes, plus the device id.
  Future<void> forgetDevice() async {
    await wipe();
    await tokenStore.forgetDevice();
  }

  Future<void>? _lastWipe;

  /// Completes when the most recent event-triggered wipe has finished.
  ///
  /// The stream listener cannot await, so this exposes the in-flight wipe for
  /// callers (and tests) that need to know it is done.
  Future<void> get settled => _lastWipe ?? Future<void>.value();

  /// Runs [wipe] whenever the API layer reports the session is gone.
  ///
  /// Pass `ApiClient.onUnauthenticated`, which `TokenRefreshCoordinator` emits
  /// after a refresh fails. Cancel the returned subscription on teardown.
  StreamSubscription<void> bindTo(Stream<void> onUnauthenticated) =>
      onUnauthenticated.listen((_) {
        _lastWipe = wipe();
      });
}
