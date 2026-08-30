import '../api/token_store.dart';
import 'lazy_secure_value.dart';
import 'secure_random.dart';
import 'secure_store.dart';

/// Secure-storage keys owned by this layer.
///
/// Namespaced so a later feature cannot collide with them.
class SecureStorageKeys {
  const SecureStorageKeys._();

  static const String accessToken = 'school_mobile.access_token';
  static const String refreshToken = 'school_mobile.refresh_token';
  static const String deviceId = 'school_mobile.device_id';
  static const String databaseKey = 'school_mobile.database_key';
}

/// [TokenStore] backed by the platform keystore.
///
/// Nothing here is written anywhere but the injected [SecureStore]: no
/// SharedPreferences, no files, no logging of any stored value.
class SecureTokenStore implements TokenStore {
  SecureTokenStore({required this.store})
      : _deviceId = LazySecureValue(
          store: store,
          key: SecureStorageKeys.deviceId,
          generate: randomUuidV4,
        );

  final SecureStore store;
  final LazySecureValue _deviceId;

  @override
  Future<String?> readAccessToken() =>
      store.read(SecureStorageKeys.accessToken);

  @override
  Future<String?> readRefreshToken() =>
      store.read(SecureStorageKeys.refreshToken);

  /// The device id, provisioning one on first use.
  ///
  /// Returns a stable random v4 UUID for the lifetime of the install. It is
  /// never derived from hardware, and it survives [clear] — see the note
  /// there.
  @override
  Future<String?> readDeviceId() => _deviceId.get();

  @override
  Future<void> writeAccessToken(String token) =>
      store.write(SecureStorageKeys.accessToken, token);

  @override
  Future<void> writeRefreshToken(String token) =>
      store.write(SecureStorageKeys.refreshToken, token);

  @override
  Future<void> writeDeviceId(String deviceId) =>
      store.write(SecureStorageKeys.deviceId, deviceId);

  /// Drops the credentials — access and refresh token — and keeps the device
  /// id.
  ///
  /// The device id is an identifier, not a credential: it grants nothing on
  /// its own, and the server binds a token family to it. Losing it on every
  /// failed refresh would make each recovered session look like a brand new
  /// device, defeating the reuse detection that relies on a stable family.
  /// Use [forgetDevice] for an explicit "forget this device".
  ///
  /// Note this differs from `InMemoryTokenStore.clear()` in `lib/core/api/`,
  /// which also drops the device id.
  @override
  Future<void> clear() async {
    await store.delete(SecureStorageKeys.accessToken);
    await store.delete(SecureStorageKeys.refreshToken);
  }

  /// Full reset: credentials *and* the device identity. The next
  /// [readDeviceId] provisions a new id, so the install looks like a new
  /// device to the server.
  Future<void> forgetDevice() async {
    await clear();
    await _deviceId.clear();
  }

  /// Number of device ids this instance has generated; 1 after first use.
  int get deviceIdGenerationCount => _deviceId.generationCount;
}
