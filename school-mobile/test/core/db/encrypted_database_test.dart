import 'dart:io';
import 'dart:typed_data';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/auth/secure_store.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/db/database_errors.dart';
import 'package:school_mobile/core/db/database_key_provider.dart';
import 'package:school_mobile/core/db/encrypted_database.dart';
import 'package:school_mobile/core/db/tables.dart';
import 'package:sqlite3/sqlite3.dart';

final DateTime t0 = DateTime.utc(2026, 8, 31, 9);

/// A payload standing in for a teacher's unsynced attendance mark. Test
/// 'no secret reaches an error message' asserts none of this leaks.
const String attendancePayload =
    '{"student_id":7,"student_name":"Layla Haddad","present":false}';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late Directory dir;
  late File file;

  setUp(() {
    dir = Directory.systemTemp.createTempSync('school_mobile_db_test');
    file = File('${dir.path}/app.db');
    addTearDown(() {
      if (dir.existsSync()) dir.deleteSync(recursive: true);
    });
  });

  /// A key provider over its own keystore, so two providers hold two keys.
  DatabaseKeyProvider newProvider() =>
      DatabaseKeyProvider(store: InMemorySecureStore());

  Future<void> seed(AppDatabase db) async {
    await db.enqueue(
      endpoint: '/attendance',
      method: 'POST',
      payloadJson: attendancePayload,
      idempotencyKey: 'idem-1',
      now: t0,
    );
    await db.upsertCache(
      entityType: 'student',
      entityId: '7',
      payloadJson: attendancePayload,
      etag: 'W/"v1"',
      now: t0,
    );
  }

  group('encryption', () {
    test('the test environment really provides SQLCipher', () {
      // Every assertion below depends on this. Plain SQLite accepts
      // `PRAGMA key` and silently writes an unencrypted file, so if this ever
      // regresses the encryption tests would pass while encrypting nothing.
      final raw = sqlite3.openInMemory();
      addTearDown(raw.close);

      final cipher = raw.select('PRAGMA cipher_version');
      expect(cipher, isNotEmpty,
          reason: 'no SQLCipher: the encryption tests would be meaningless');
    });

    test('the file on disk is encrypted, not a readable SQLite database',
        () async {
      final db = await openEncryptedDatabase(
        file: file,
        keyProvider: newProvider(),
      );
      await seed(db);
      await db.close();

      final header = await file.openRead(0, 16).first;
      expect(
        String.fromCharCodes(header.takeWhile((b) => b != 0)),
        isNot(startsWith('SQLite format 3')),
        reason: 'an unencrypted database starts with that magic string',
      );

      // And the payload is not sitting in the file in the clear.
      final bytes = await file.readAsBytes();
      expect(
        String.fromCharCodes(bytes.where((b) => b >= 32 && b < 127)),
        isNot(contains('Layla Haddad')),
      );
    });
  });

  group('reopening', () {
    test('returns previously written outbox and cache rows intact', () async {
      final provider = newProvider();

      final first = await openEncryptedDatabase(
        file: file,
        keyProvider: provider,
      );
      await seed(first);
      await first.close();

      // Same key, existing v1 file: the migration must not recreate anything.
      final second = await openEncryptedDatabase(
        file: file,
        keyProvider: provider,
      );
      addTearDown(second.close);

      final outbox = await second.allOutbox();
      expect(outbox, hasLength(1));
      expect(outbox.single.idempotencyKey, 'idem-1');
      expect(outbox.single.payloadJson, attendancePayload);
      expect(outbox.single.status, OutboxStatus.pending);
      expect(outbox.single.createdAt.toUtc(), t0);

      final cached = await second.readCache('student', '7');
      expect(cached, isNotNull);
      expect(cached!.payloadJson, attendancePayload);
      expect(cached.etag, 'W/"v1"');
    });

    test('opening an existing v1 database preserves rows added after reopen',
        () async {
      final provider = newProvider();

      final first =
          await openEncryptedDatabase(file: file, keyProvider: provider);
      await seed(first);
      await first.close();

      final second =
          await openEncryptedDatabase(file: file, keyProvider: provider);
      await second.enqueue(
        endpoint: '/grades',
        method: 'POST',
        payloadJson: '{"grade":91}',
        idempotencyKey: 'idem-2',
        now: t0,
      );
      await second.close();

      final third =
          await openEncryptedDatabase(file: file, keyProvider: provider);
      addTearDown(third.close);

      expect(await third.allOutbox(), hasLength(2));
    });
  });

  group('wrong key', () {
    test('is rejected with a typed error and leaves the file intact', () async {
      final original = newProvider();
      final first =
          await openEncryptedDatabase(file: file, keyProvider: original);
      await seed(first);
      await first.close();

      final bytesBefore = await file.readAsBytes();

      // A different keystore holds a different key.
      final wrong = newProvider();
      expect(
        await wrong.key(),
        isNot(await original.key()),
        reason: 'the two providers must genuinely differ',
      );

      await expectLater(
        openEncryptedDatabase(file: file, keyProvider: wrong),
        throwsA(isA<DatabaseUnreadableException>()),
      );

      // The whole point: nothing was deleted, recreated or repaired.
      expect(file.existsSync(), isTrue, reason: 'the file must survive');
      expect(await file.readAsBytes(), bytesBefore,
          reason: 'the file must be byte-for-byte unchanged');

      // And the data is still there for whoever holds the right key.
      final recovered =
          await openEncryptedDatabase(file: file, keyProvider: original);
      addTearDown(recovered.close);
      expect(await recovered.allOutbox(), hasLength(1));
    });

    test('a corrupt file is also a typed error, not a silent recreate',
        () async {
      await file.writeAsBytes(
        Uint8List.fromList(List<int>.generate(4096, (i) => i % 256)),
      );
      final bytesBefore = await file.readAsBytes();

      await expectLater(
        openEncryptedDatabase(file: file, keyProvider: newProvider()),
        throwsA(isA<LocalDatabaseException>()),
      );

      expect(file.existsSync(), isTrue);
      expect(await file.readAsBytes(), bytesBefore);
    });
  });

  group('secret hygiene', () {
    test('no key, payload or path appears in an error message', () async {
      final original = newProvider();
      final first =
          await openEncryptedDatabase(file: file, keyProvider: original);
      await seed(first);
      await first.close();

      final wrong = newProvider();
      Object? captured;
      try {
        await openEncryptedDatabase(file: file, keyProvider: wrong);
      } catch (error) {
        captured = error;
      }

      expect(captured, isA<DatabaseUnreadableException>());
      final text = captured.toString();

      final wrongKeyHex = _hex(await wrong.key());
      final rightKeyHex = _hex(await original.key());

      expect(text, isNot(contains(wrongKeyHex)));
      expect(text, isNot(contains(rightKeyHex)));
      expect(text, isNot(contains(attendancePayload)));
      expect(text, isNot(contains('Layla Haddad')));
      // File paths carry the account name, which is personal data.
      expect(text, isNot(contains(file.path)));
      expect(text, isNot(contains(dir.path)));

      // The message is still useful.
      expect(text, contains('DatabaseUnreadableException'));
      expect(text, contains('left untouched'));
    });
  });
}

String _hex(Uint8List bytes) =>
    bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
