import 'dart:convert';
import 'dart:typed_data';

import '../auth/lazy_secure_value.dart';
import '../auth/secure_random.dart';
import '../auth/secure_store.dart';
import '../auth/secure_token_store.dart';

/// Length of the database key. SQLCipher takes a 256-bit key.
const int databaseKeyLengthBytes = 32;

/// Raised when the stored key cannot be used.
///
/// The message never quotes the stored value — a corrupt key is still key
/// material.
class DatabaseKeyException implements Exception {
  const DatabaseKeyException(this.message);

  final String message;

  @override
  String toString() => 'DatabaseKeyException: $message';
}

/// Provides the SQLCipher key, generating it once on first use.
///
/// No database is opened here; this order only provisions and stores the key.
/// It is held base64-encoded in secure storage and never written anywhere else.
class DatabaseKeyProvider {
  DatabaseKeyProvider({required SecureStore store})
      : _value = LazySecureValue(
          store: store,
          key: SecureStorageKeys.databaseKey,
          generate: () => base64Encode(randomBytes(databaseKeyLengthBytes)),
        );

  final LazySecureValue _value;

  /// The 256-bit key, provisioning one on first use.
  ///
  /// Concurrent first callers share a single generation, so an install can
  /// never end up with two keys and an unreadable database.
  Future<Uint8List> key() async {
    final encoded = await _value.get();

    final Uint8List bytes;
    try {
      bytes = base64Decode(encoded);
    } on FormatException {
      throw const DatabaseKeyException('Stored database key is not valid base64.');
    }

    if (bytes.length != databaseKeyLengthBytes) {
      throw const DatabaseKeyException(
        'Stored database key is not 256 bits.',
      );
    }
    return bytes;
  }

  /// Discards the key. The next [key] call provisions a fresh one, which makes
  /// any database still encrypted under the old key unreadable — so only call
  /// this as part of a wipe.
  Future<void> clear() => _value.clear();

  /// Number of keys this instance has generated; 1 after first use.
  int get generationCount => _value.generationCount;
}
