import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/token_store.dart';
import 'package:school_mobile/core/auth/secure_store.dart';
import 'package:school_mobile/core/auth/secure_token_store.dart';

const String accessValue = 'access-token-value-aaaaaaaa';
const String refreshValue = 'refresh-token-value-bbbbbbbb';
const String deviceValue = 'device-id-cccccccccccc';

/// Every [TokenStore] implementation, so the contract is checked against all of
/// them rather than whichever one a caller happens to hold.
///
/// `forgetDevice` is reached through a per-implementation closure because it is
/// deliberately not declared on the interface — see the note in
/// `lib/core/api/token_store.dart`.
final Map<String, ({TokenStore Function() create, Future<void> Function(TokenStore) forgetDevice})>
    implementations = <String, ({TokenStore Function() create, Future<void> Function(TokenStore) forgetDevice})>{
  'InMemoryTokenStore': (
    create: InMemoryTokenStore.new,
    forgetDevice: (store) => (store as InMemoryTokenStore).forgetDevice(),
  ),
  'SecureTokenStore': (
    create: () => SecureTokenStore(store: InMemorySecureStore()),
    forgetDevice: (store) => (store as SecureTokenStore).forgetDevice(),
  ),
};

void main() {
  implementations.forEach((name, impl) {
    group('$name honours the TokenStore contract', () {
      late TokenStore store;

      setUp(() async {
        store = impl.create();
        await store.writeAccessToken(accessValue);
        await store.writeRefreshToken(refreshValue);
        await store.writeDeviceId(deviceValue);
      });

      test('round-trips what was written', () async {
        expect(await store.readAccessToken(), accessValue);
        expect(await store.readRefreshToken(), refreshValue);
        expect(await store.readDeviceId(), deviceValue);
      });

      test('clear drops the credentials and keeps the device id', () async {
        await store.clear();

        expect(await store.readAccessToken(), isNull);
        expect(await store.readRefreshToken(), isNull);
        expect(
          await store.readDeviceId(),
          deviceValue,
          reason: 'the device id is an identifier, not a credential: a failed '
              'refresh must not change device identity',
        );
      });

      test('forgetDevice drops the device id as well', () async {
        await impl.forgetDevice(store);

        expect(await store.readAccessToken(), isNull);
        expect(await store.readRefreshToken(), isNull);
        expect(await store.readDeviceId(), isNot(deviceValue));
      });
    });
  });

  test('both implementations agree on what clear leaves behind', () async {
    final results = <String, ({bool access, bool refresh, bool device})>{};

    for (final entry in implementations.entries) {
      final store = entry.value.create();
      await store.writeAccessToken(accessValue);
      await store.writeRefreshToken(refreshValue);
      await store.writeDeviceId(deviceValue);
      await store.clear();

      results[entry.key] = (
        access: await store.readAccessToken() != null,
        refresh: await store.readRefreshToken() != null,
        device: await store.readDeviceId() == deviceValue,
      );
    }

    // The whole point of the fix: one interface, one behaviour.
    expect(results.values.toSet(), hasLength(1),
        reason: 'implementations of one interface must not disagree: $results');
    expect(results.values.first, (access: false, refresh: false, device: true));
  });
}
