import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Narrow key/value contract over the platform keystore.
///
/// The rest of this layer depends on this rather than on
/// `flutter_secure_storage` directly, so tests can run without a device: the
/// production implementation is the only thing that touches a platform
/// channel.
abstract class SecureStore {
  Future<String?> read(String key);

  Future<void> write(String key, String value);

  Future<void> delete(String key);

  Future<void> deleteAll();
}

/// Production [SecureStore]: encrypted-at-rest storage on Android, under a
/// Keystore-held master key.
///
/// This app ships Android only, so no other platform options are configured.
///
/// `encryptedSharedPreferences: true` is set because this work order requires
/// it. Note that in flutter_secure_storage 10.0.0 the flag is deprecated and
/// **ignored**: Google deprecated Jetpack Security, so the plugin now always
/// uses its own ciphers and migrates existing entries on first access. Entries
/// are therefore encrypted at rest either way; the flag is retained for
/// explicitness and must be dropped before v11, which removes it.
class FlutterSecureStore implements SecureStore {
  FlutterSecureStore({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              // Required by the work order; a no-op in 10.0.0, see the
              // class doc above.
              // ignore: deprecated_member_use
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
            );

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);

  @override
  Future<void> deleteAll() => _storage.deleteAll();
}

/// Non-persistent [SecureStore] standing in for the keystore in tests.
///
/// It is the *backend*, never the code under test.
class InMemorySecureStore implements SecureStore {
  final Map<String, String> _entries = <String, String>{};

  /// Keys written since construction, in order. Lets a test prove that a
  /// secret went to secure storage and nowhere else.
  final List<String> writtenKeys = <String>[];

  /// Keys currently held.
  Iterable<String> get keys => _entries.keys;

  @override
  Future<String?> read(String key) async => _entries[key];

  @override
  Future<void> write(String key, String value) async {
    _entries[key] = value;
    writtenKeys.add(key);
  }

  @override
  Future<void> delete(String key) async => _entries.remove(key);

  @override
  Future<void> deleteAll() async => _entries.clear();
}
