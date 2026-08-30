import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/auth/secure_store.dart';
import 'package:school_mobile/core/auth/secure_token_store.dart';
import 'package:school_mobile/core/auth/session_wipe.dart';
import 'package:school_mobile/core/db/database_key_provider.dart';

import '../../support/mock_http_adapter.dart';

/// Dio rejects a relative baseUrl off the web platform, so a host is
/// structurally required. `.test` is reserved by RFC 6761 and never resolves,
/// and the mock adapter means no socket is opened.
const String testBaseUrl = 'https://example.test/api';

const String accessValue = 'access-token-value-aaaaaaaa';
const String refreshValue = 'refresh-token-value-bbbbbbbb';

const MockReply unauthorized = MockReply(
  statusCode: 401,
  body: <String, dynamic>{'message': 'Unauthenticated.'},
);

/// A fully provisioned session: both tokens, a device id and a database key.
Future<
    ({
      InMemorySecureStore backend,
      SecureTokenStore tokenStore,
      DatabaseKeyProvider keyProvider,
      SessionWipe wipe,
      String deviceId,
      String databaseKey,
    })> provisionedSession() async {
  final backend = InMemorySecureStore();
  final tokenStore = SecureTokenStore(store: backend);
  final keyProvider = DatabaseKeyProvider(store: backend);

  await tokenStore.writeAccessToken(accessValue);
  await tokenStore.writeRefreshToken(refreshValue);
  final deviceId = (await tokenStore.readDeviceId())!;
  final databaseKey = base64Encode(await keyProvider.key());

  return (
    backend: backend,
    tokenStore: tokenStore,
    keyProvider: keyProvider,
    wipe: SessionWipe(tokenStore: tokenStore, databaseKeyProvider: keyProvider),
    deviceId: deviceId,
    databaseKey: databaseKey,
  );
}

void main() {
  group('SessionWipe', () {
    test('clears tokens and key material, and keeps the device id', () async {
      final session = await provisionedSession();

      await session.wipe.wipe();

      // Gone.
      expect(await session.tokenStore.readAccessToken(), isNull);
      expect(await session.tokenStore.readRefreshToken(), isNull);
      expect(
        await session.backend.read(SecureStorageKeys.databaseKey),
        isNull,
      );

      // Survives: the device identity, unchanged.
      expect(await session.tokenStore.readDeviceId(), session.deviceId);
      expect(session.tokenStore.deviceIdGenerationCount, 1);

      // Exactly one entry is left in the keystore, and it is the device id.
      expect(session.backend.keys, <String>[SecureStorageKeys.deviceId]);
    });

    test('forgetDevice additionally drops the device id', () async {
      final session = await provisionedSession();

      await session.wipe.forgetDevice();

      expect(session.backend.keys, isEmpty);
      expect(await session.tokenStore.readDeviceId(),
          isNot(session.deviceId));
    });

    test('a wiped database key is regenerated, not recovered', () async {
      final session = await provisionedSession();

      await session.wipe.wipe();
      final replacement = base64Encode(await session.keyProvider.key());

      expect(replacement, isNot(session.databaseKey));
    });
  });

  group('unauthenticated wiring', () {
    test('a failed refresh from the API layer triggers the wipe', () async {
      final session = await provisionedSession();

      // The real F-3 client and refresh coordinator, over a mock adapter.
      final adapter = MockHttpAdapter((options) => unauthorized);
      final client = ApiClient(
        baseUrl: testBaseUrl,
        tokenStore: session.tokenStore,
        adapter: adapter,
      );
      addTearDown(() => client.close(force: true));

      final subscription = session.wipe.bindTo(client.onUnauthenticated);
      addTearDown(subscription.cancel);

      // 401 -> refresh -> refresh also 401s -> coordinator gives up and emits.
      await expectLater(
        client.dio.get<dynamic>('/protected'),
        throwsA(isA<DioException>()),
      );
      await Future<void>.delayed(Duration.zero);
      await session.wipe.settled;

      expect(adapter.countFor(authRefreshPath), 1);
      expect(await session.tokenStore.readAccessToken(), isNull);
      expect(await session.tokenStore.readRefreshToken(), isNull);
      expect(
        await session.backend.read(SecureStorageKeys.databaseKey),
        isNull,
        reason: 'the wipe, not just the coordinator, must have run',
      );
      expect(await session.tokenStore.readDeviceId(), session.deviceId);
    });
  });

  group('secret hygiene', () {
    test('no token, database key or device id reaches output or errors',
        () async {
      final printed = <String>[];
      late final ({
        InMemorySecureStore backend,
        SecureTokenStore tokenStore,
        DatabaseKeyProvider keyProvider,
        SessionWipe wipe,
        String deviceId,
        String databaseKey,
      }) session;

      // Captures print() and debugPrint(), which routes through print.
      await runZoned(
        () async {
          session = await provisionedSession();
          await session.tokenStore.readAccessToken();
          await session.keyProvider.key();
          await session.wipe.wipe();
        },
        zoneSpecification: ZoneSpecification(
          print: (self, parent, zone, line) => printed.add(line),
        ),
      );

      // A corrupt key raises the layer's own error; it must not quote the
      // material either.
      await session.backend
          .write(SecureStorageKeys.databaseKey, 'not-base64!!!');
      Object? keyError;
      try {
        await session.keyProvider.key();
      } catch (error) {
        keyError = error;
      }
      expect(keyError, isA<DatabaseKeyException>());

      final secrets = <String>[
        accessValue,
        refreshValue,
        session.deviceId,
        session.databaseKey,
      ];
      final haystacks = <String>[
        ...printed,
        keyError.toString(),
        session.tokenStore.toString(),
        session.keyProvider.toString(),
        session.wipe.toString(),
      ];

      for (final haystack in haystacks) {
        for (final secret in secrets) {
          expect(haystack, isNot(contains(secret)),
              reason: 'secret material must never be printed or surfaced');
        }
      }

      // The exercise really handled the secrets, so the assertions above are
      // not passing on an empty run.
      expect(secrets.every((secret) => secret.isNotEmpty), isTrue);
      expect(session.databaseKey, isNotEmpty);
    });
  });
}
