import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/auth/secure_store.dart';
import 'package:school_mobile/core/auth/secure_token_store.dart';

/// RFC 9562 version-4 layout: '4' in the version position and one of 8/9/a/b
/// in the variant position.
final RegExp uuidV4 = RegExp(
  r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
);

const String accessValue = 'access-token-value-aaaaaaaa';
const String refreshValue = 'refresh-token-value-bbbbbbbb';

void main() {
  group('credential persistence', () {
    test('a token survives into a freshly constructed store', () async {
      final backend = InMemorySecureStore();

      await SecureTokenStore(store: backend).writeAccessToken(accessValue);
      await SecureTokenStore(store: backend).writeRefreshToken(refreshValue);

      // A brand new instance over the same keystore, as after an app restart.
      final reopened = SecureTokenStore(store: backend);
      expect(await reopened.readAccessToken(), accessValue);
      expect(await reopened.readRefreshToken(), refreshValue);
    });

    test('secrets go only to secure storage, under namespaced keys', () async {
      final backend = InMemorySecureStore();
      final store = SecureTokenStore(store: backend);

      await store.writeAccessToken(accessValue);
      await store.writeRefreshToken(refreshValue);
      await store.readDeviceId();

      expect(
        backend.writtenKeys,
        containsAll(<String>[
          SecureStorageKeys.accessToken,
          SecureStorageKeys.refreshToken,
          SecureStorageKeys.deviceId,
        ]),
      );
      // Every key this layer touches is one of its own; nothing leaks into
      // some other, unencrypted namespace.
      for (final key in backend.keys) {
        expect(key, startsWith('school_mobile.'));
      }
    });
  });

  group('device id', () {
    test('is a random v4 UUID, not a hardware identifier', () async {
      final store = SecureTokenStore(store: InMemorySecureStore());

      final deviceId = await store.readDeviceId();

      expect(deviceId, isNotNull);
      expect(deviceId, matches(uuidV4));
    });

    test('is stable across repeated reads and a fresh store instance',
        () async {
      final backend = InMemorySecureStore();
      final store = SecureTokenStore(store: backend);

      final first = await store.readDeviceId();
      final second = await store.readDeviceId();
      final afterRestart = await SecureTokenStore(store: backend).readDeviceId();

      expect(second, first);
      expect(afterRestart, first);
      expect(store.deviceIdGenerationCount, 1);
    });

    test('two independent first-runs produce different device ids', () async {
      final firstInstall =
          await SecureTokenStore(store: InMemorySecureStore()).readDeviceId();
      final secondInstall =
          await SecureTokenStore(store: InMemorySecureStore()).readDeviceId();

      expect(firstInstall, matches(uuidV4));
      expect(secondInstall, matches(uuidV4));
      expect(firstInstall, isNot(secondInstall));
    });

    test('concurrent first use generates exactly one device id', () async {
      final store = SecureTokenStore(store: InMemorySecureStore());

      final ids = await Future.wait<String?>(
        List<Future<String?>>.generate(10, (_) => store.readDeviceId()),
      );

      expect(store.deviceIdGenerationCount, 1);
      expect(ids.toSet(), hasLength(1));
    });

    test('survives clear, so a failed refresh does not change device identity',
        () async {
      final backend = InMemorySecureStore();
      final store = SecureTokenStore(store: backend);
      await store.writeAccessToken(accessValue);
      await store.writeRefreshToken(refreshValue);
      final deviceId = await store.readDeviceId();

      await store.clear();

      expect(await store.readAccessToken(), isNull);
      expect(await store.readRefreshToken(), isNull);
      expect(await store.readDeviceId(), deviceId,
          reason: 'the device id is an identifier, not a credential');
      expect(store.deviceIdGenerationCount, 1);
    });

    test('forgetDevice drops the device id and the next read mints a new one',
        () async {
      final store = SecureTokenStore(store: InMemorySecureStore());
      final original = await store.readDeviceId();

      await store.forgetDevice();
      final replacement = await store.readDeviceId();

      expect(replacement, matches(uuidV4));
      expect(replacement, isNot(original));
      expect(store.deviceIdGenerationCount, 2);
    });
  });
}
