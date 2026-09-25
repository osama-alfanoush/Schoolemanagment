import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/db/tables.dart';

/// Fixed clock so backoff and eviction windows are exact, not wall-clock.
final DateTime t0 = DateTime.utc(2026, 8, 31, 9);

Future<OutboxEntry> enqueueAttendance(
  AppDatabase db, {
  required String key,
  DateTime? at,
}) {
  return db.enqueue(
    endpoint: '/attendance',
    method: 'POST',
    payloadJson: '{"student_id":7,"present":true}',
    idempotencyKey: key,
    now: at ?? t0,
  );
}

void main() {
  late AppDatabase db;

  // Several tests deliberately open a second database instance.
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  setUp(() {
    db = AppDatabase.memory();
    addTearDown(db.close);
  });

  group('enqueue', () {
    test('the same idempotency key twice yields one row', () async {
      final first = await enqueueAttendance(db, key: 'idem-1');
      final second = await enqueueAttendance(db, key: 'idem-1');

      expect(await db.allOutbox(), hasLength(1));
      expect(second.id, first.id);
      expect(second.payloadJson, first.payloadJson);
    });

    test('distinct keys yield distinct rows', () async {
      await enqueueAttendance(db, key: 'idem-1');
      await enqueueAttendance(db, key: 'idem-2');

      expect(await db.allOutbox(), hasLength(2));
    });

    test('a new row starts pending with no attempts', () async {
      final entry = await enqueueAttendance(db, key: 'idem-1');

      expect(entry.status, OutboxStatus.pending);
      expect(entry.attempts, 0);
      expect(entry.completedAt, isNull);
      expect(entry.lastError, isNull);
    });
  });

  group('claimNext', () {
    test('ten concurrent claims against five rows claim each exactly once',
        () async {
      for (var i = 0; i < 5; i++) {
        await enqueueAttendance(db, key: 'idem-$i',
            at: t0.add(Duration(seconds: i)));
      }

      final claims = await Future.wait<OutboxEntry?>(
        List<Future<OutboxEntry?>>.generate(
          10,
          (_) => db.claimNext(now: t0.add(const Duration(minutes: 1))),
        ),
      );

      final claimed = claims.whereType<OutboxEntry>().toList();
      final claimedIds = claimed.map((e) => e.id).toList();

      // Every row taken, none taken twice, none missed.
      expect(claimed, hasLength(5), reason: 'five rows, five winners');
      expect(claimedIds.toSet(), hasLength(5), reason: 'no row claimed twice');
      expect(claims.where((e) => e == null), hasLength(5));

      // And the database agrees: all five are inflight, nothing left pending.
      expect(await db.outboxByStatus(OutboxStatus.inflight), hasLength(5));
      expect(await db.outboxByStatus(OutboxStatus.pending), isEmpty);
      for (final entry in claimed) {
        expect(entry.status, OutboxStatus.inflight);
      }
    });

    test('returns rows oldest first', () async {
      await enqueueAttendance(db, key: 'newer', at: t0.add(const Duration(hours: 1)));
      await enqueueAttendance(db, key: 'older', at: t0);

      final claimed = await db.claimNext(now: t0.add(const Duration(days: 1)));

      expect(claimed!.idempotencyKey, 'older');
    });

    test('returns null when nothing is due', () async {
      expect(await db.claimNext(now: t0), isNull);
    });

    test('does not claim a failed row before its backoff elapses', () async {
      final entry = await enqueueAttendance(db, key: 'idem-1');
      await db.claimNext(now: t0);
      await db.markFailed(entry.id, reason: 'HTTP 503', now: t0);

      final tooEarly = await db.claimNext(now: t0.add(const Duration(seconds: 5)));
      expect(tooEarly, isNull);

      final later = await db.claimNext(now: t0.add(const Duration(hours: 2)));
      expect(later, isNotNull);
      expect(later!.id, entry.id);
    });
  });

  group('terminal transitions', () {
    test('markSucceeded records completion and clears the last error',
        () async {
      final entry = await enqueueAttendance(db, key: 'idem-1');
      await db.markFailed(entry.id, reason: 'HTTP 503', now: t0);
      await db.markSucceeded(entry.id, now: t0);

      final stored = (await db.outboxEntry(entry.id))!;
      expect(stored.status, OutboxStatus.succeeded);
      expect(stored.completedAt!.toUtc(), t0);
      expect(stored.lastError, isNull);
    });

    test('markFailed increments attempts and schedules an increasing backoff',
        () async {
      final entry = await enqueueAttendance(db, key: 'idem-1');

      await db.markFailed(entry.id, reason: 'HTTP 503', now: t0);
      final first = (await db.outboxEntry(entry.id))!;

      await db.markFailed(entry.id, reason: 'HTTP 503', now: t0);
      final second = (await db.outboxEntry(entry.id))!;

      expect(first.attempts, 1);
      expect(second.attempts, 2);
      expect(first.status, OutboxStatus.failed);
      expect(
        second.nextAttemptAt!.isAfter(first.nextAttemptAt!),
        isTrue,
        reason: 'backoff must grow with attempts',
      );
    });

    test('markDead is terminal and keeps the row for the user to see',
        () async {
      final entry = await enqueueAttendance(db, key: 'idem-1');
      await db.markDead(entry.id, reason: 'HTTP 422', now: t0);

      final stored = (await db.outboxEntry(entry.id))!;
      expect(stored.status, OutboxStatus.dead);
      expect(stored.completedAt!.toUtc(), t0);
      expect(await db.claimNext(now: t0.add(const Duration(days: 30))), isNull);
    });
  });

  group('transactional integrity', () {
    test('an exception mid-transaction leaves no partial row', () async {
      await expectLater(
        db.transaction(() async {
          await enqueueAttendance(db, key: 'idem-1');
          await enqueueAttendance(db, key: 'idem-2');
          throw StateError('interrupted before commit');
        }),
        throwsA(isA<StateError>()),
      );

      expect(await db.allOutbox(), isEmpty,
          reason: 'a rolled back transaction must leave nothing behind');
    });

    test('a failed batch does not commit the rows that preceded it', () async {
      await enqueueAttendance(db, key: 'committed');

      await expectLater(
        db.transaction(() async {
          await enqueueAttendance(db, key: 'doomed');
          throw StateError('interrupted before commit');
        }),
        throwsA(isA<StateError>()),
      );

      final keys =
          (await db.allOutbox()).map((e) => e.idempotencyKey).toList();
      expect(keys, <String>['committed']);
    });
  });

  group('close', () {
    test('is safe to call twice', () async {
      final second = AppDatabase.memory();
      await second.allOutbox();

      await second.close();
      // The second call is the assertion: it must not throw.
      await second.close();

      // And it really is closed, so the double-close was not a no-op on a
      // still-open database.
      await expectLater(second.allOutbox(), throwsA(anything));
    });
  });
}
