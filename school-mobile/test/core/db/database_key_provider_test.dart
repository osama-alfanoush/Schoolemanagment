import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/auth/secure_store.dart';
import 'package:school_mobile/core/auth/secure_token_store.dart';
import 'package:school_mobile/core/db/database_key_provider.dart';

void main() {
  group('database key', () {
    test('is 256 bits and stable across reads', () async {
      final provider = DatabaseKeyProvider(store: InMemorySecureStore());

      final first = await provider.key();
      final second = await provider.key();

      expect(first, hasLength(32), reason: '32 bytes == 256 bits');
      expect(second, first);
      expect(provider.generationCount, 1);
    });

    test('survives into a freshly constructed provider', () async {
      final backend = InMemorySecureStore();

      final original = await DatabaseKeyProvider(store: backend).key();
      final afterRestart = await DatabaseKeyProvider(store: backend).key();

      expect(afterRestart, original);
    });

    test('two independent first-runs produce different keys', () async {
      final first = await DatabaseKeyProvider(store: InMemorySecureStore()).key();
      final second =
          await DatabaseKeyProvider(store: InMemorySecureStore()).key();

      expect(first, isNot(second));
      // A CSPRNG key must not be a constant or a run of zeros.
      expect(first.every((byte) => byte == first.first), isFalse);
    });

    test('concurrent first use produces exactly one key', () async {
      final backend = InMemorySecureStore();
      final provider = DatabaseKeyProvider(store: backend);

      final keys = await Future.wait(
        List.generate(10, (_) => provider.key()),
      );

      // Two keys here would mean a database encrypted under a key nobody kept.
      expect(provider.generationCount, 1);
      final distinct = keys.map(base64Encode).toSet();
      expect(distinct, hasLength(1));

      // And the one key is the one actually persisted.
      final stored = await backend.read(SecureStorageKeys.databaseKey);
      expect(stored, distinct.single);
    });

    test('is stored encoded, and cleared on demand', () async {
      final backend = InMemorySecureStore();
      final provider = DatabaseKeyProvider(store: backend);
      final original = await provider.key();

      expect(await backend.read(SecureStorageKeys.databaseKey),
          base64Encode(original));

      await provider.clear();
      expect(await backend.read(SecureStorageKeys.databaseKey), isNull);

      final replacement = await provider.key();
      expect(replacement, isNot(original));
      expect(provider.generationCount, 2);
    });
  });

  group('corrupt key material', () {
    test('a wrong-length key is rejected without quoting the value', () async {
      const String shortKey = 'c2hvcnQta2V5LW1hdGVyaWFs'; // 18 bytes, not 32
      final backend = InMemorySecureStore();
      await backend.write(SecureStorageKeys.databaseKey, shortKey);

      final provider = DatabaseKeyProvider(store: backend);

      await expectLater(
        provider.key(),
        throwsA(
          isA<DatabaseKeyException>().having(
            (e) => e.toString(),
            'toString',
            isNot(contains(shortKey)),
          ),
        ),
      );
    });

    test('an unparseable key is rejected without quoting the value', () async {
      const String garbage = 'not-valid-base64!!!!';
      final backend = InMemorySecureStore();
      await backend.write(SecureStorageKeys.databaseKey, garbage);

      Object? captured;
      try {
        await DatabaseKeyProvider(store: backend).key();
      } catch (error) {
        captured = error;
      }

      expect(captured, isA<DatabaseKeyException>());
      expect(captured.toString(), isNot(contains(garbage)));
    });
  });
}
