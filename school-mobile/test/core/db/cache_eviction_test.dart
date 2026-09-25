import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/db/tables.dart';

final DateTime t0 = DateTime.utc(2026, 8, 31, 9);

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.memory();
    addTearDown(db.close);
  });

  group('cache operations', () {
    test('upsert then read returns the stored entity', () async {
      await db.upsertCache(
        entityType: 'student',
        entityId: '7',
        payloadJson: '{"name":"Layla"}',
        etag: 'W/"v1"',
        syncCursor: 'cursor-1',
        now: t0,
      );

      final entry = await db.readCache('student', '7');

      expect(entry, isNotNull);
      expect(entry!.payloadJson, '{"name":"Layla"}');
      expect(entry.etag, 'W/"v1"');
      expect(entry.syncCursor, 'cursor-1');
      expect(entry.fetchedAt.toUtc(), t0);
    });

    test('upsert replaces on the composite key rather than duplicating',
        () async {
      await db.upsertCache(
        entityType: 'student',
        entityId: '7',
        payloadJson: '{"name":"old"}',
        etag: 'W/"v1"',
        now: t0,
      );
      await db.upsertCache(
        entityType: 'student',
        entityId: '7',
        payloadJson: '{"name":"new"}',
        etag: 'W/"v2"',
        now: t0.add(const Duration(hours: 1)),
      );

      expect(await db.cacheCount(), 1);
      final entry = await db.readCache('student', '7');
      expect(entry!.payloadJson, '{"name":"new"}');
      expect(entry.etag, 'W/"v2"');
    });

    test('the same id under a different type is a different row', () async {
      await db.upsertCache(
        entityType: 'student',
        entityId: '7',
        payloadJson: '{}',
        now: t0,
      );
      await db.upsertCache(
        entityType: 'teacher',
        entityId: '7',
        payloadJson: '{}',
        now: t0,
      );

      expect(await db.cacheCount(), 2);
    });

    test('read-by-type, delete and delete-by-type', () async {
      for (var i = 0; i < 3; i++) {
        await db.upsertCache(
          entityType: 'student',
          entityId: '$i',
          payloadJson: '{}',
          now: t0,
        );
      }
      await db.upsertCache(
        entityType: 'teacher',
        entityId: '1',
        payloadJson: '{}',
        now: t0,
      );

      expect(await db.readCacheByType('student'), hasLength(3));

      expect(await db.deleteCache('student', '0'), 1);
      expect(await db.readCache('student', '0'), isNull);
      expect(await db.readCacheByType('student'), hasLength(2));

      expect(await db.deleteCacheByType('student'), 2);
      expect(await db.readCacheByType('student'), isEmpty);
      expect(await db.readCacheByType('teacher'), hasLength(1),
          reason: 'delete-by-type must not touch other types');
    });
  });

  group('cache eviction', () {
    test('removes rows older than the TTL and keeps fresher ones', () async {
      await db.upsertCache(
        entityType: 'student',
        entityId: 'stale',
        payloadJson: '{}',
        now: t0.subtract(const Duration(days: 10)),
      );
      await db.upsertCache(
        entityType: 'student',
        entityId: 'fresh',
        payloadJson: '{}',
        now: t0.subtract(const Duration(days: 1)),
      );

      final removed = await db.evictExpiredCache(
        policy: const EvictionPolicy(cacheTtl: Duration(days: 7)),
        now: t0,
      );

      expect(removed, 1);
      expect(await db.readCache('student', 'stale'), isNull);
      expect(await db.readCache('student', 'fresh'), isNotNull);
    });

    test('caps total rows, evicting oldest first', () async {
      for (var i = 0; i < 10; i++) {
        await db.upsertCache(
          entityType: 'student',
          entityId: '$i',
          payloadJson: '{}',
          now: t0.add(Duration(minutes: i)),
        );
      }

      final removed =
          await db.capCacheRows(policy: const EvictionPolicy(maxCacheRows: 4));

      expect(removed, 6);
      expect(await db.cacheCount(), 4);
      // The four newest survive.
      for (final id in <String>['6', '7', '8', '9']) {
        expect(await db.readCache('student', id), isNotNull, reason: 'kept $id');
      }
      for (final id in <String>['0', '1', '2', '3', '4', '5']) {
        expect(await db.readCache('student', id), isNull, reason: 'evicted $id');
      }
    });
  });

  group('outbox eviction', () {
    /// One row in every status, all old enough to be evicted if the policy
    /// allowed it.
    Future<Map<OutboxStatus, int>> seedEveryStatus() async {
      final ids = <OutboxStatus, int>{};
      final ancient = t0.subtract(const Duration(days: 30));

      for (final status in OutboxStatus.values) {
        final entry = await db.enqueue(
          endpoint: '/attendance',
          method: 'POST',
          payloadJson: '{"present":true}',
          idempotencyKey: 'idem-${status.name}',
          now: ancient,
        );
        ids[status] = entry.id;

        switch (status) {
          case OutboxStatus.pending:
            break;
          case OutboxStatus.inflight:
            await db.claimNext(now: ancient);
          case OutboxStatus.succeeded:
            await db.markSucceeded(entry.id, now: ancient);
          case OutboxStatus.failed:
            await db.markFailed(entry.id, reason: 'HTTP 503', now: ancient);
          case OutboxStatus.dead:
            await db.markDead(entry.id, reason: 'HTTP 422', now: ancient);
        }
      }
      return ids;
    }

    test('evicts only succeeded rows past retention, never anything else',
        () async {
      final ids = await seedEveryStatus();

      final removed = await db.evictCompletedOutbox(
        policy: const EvictionPolicy(
          succeededOutboxRetention: Duration(days: 1),
        ),
        now: t0,
      );

      expect(removed, 1, reason: 'only the succeeded row is disposable');

      // Every status asserted explicitly: unsent work must survive eviction.
      expect(await db.outboxEntry(ids[OutboxStatus.pending]!), isNotNull,
          reason: 'pending is unsent work');
      expect(await db.outboxEntry(ids[OutboxStatus.inflight]!), isNotNull,
          reason: 'inflight is unsent work');
      expect(await db.outboxEntry(ids[OutboxStatus.failed]!), isNotNull,
          reason: 'failed is unsent work awaiting retry');
      expect(await db.outboxEntry(ids[OutboxStatus.dead]!), isNotNull,
          reason: 'dead must stay visible to the user');
      expect(await db.outboxEntry(ids[OutboxStatus.succeeded]!), isNull,
          reason: 'succeeded past retention is the only evictable row');
    });

    test('keeps a succeeded row that is still inside the retention window',
        () async {
      final entry = await db.enqueue(
        endpoint: '/attendance',
        method: 'POST',
        payloadJson: '{}',
        idempotencyKey: 'recent',
        now: t0,
      );
      await db.markSucceeded(entry.id, now: t0);

      final removed = await db.evictCompletedOutbox(
        policy: const EvictionPolicy(
          succeededOutboxRetention: Duration(days: 1),
        ),
        now: t0.add(const Duration(hours: 1)),
      );

      expect(removed, 0);
      expect(await db.outboxEntry(entry.id), isNotNull);
    });

    test('a full eviction pass leaves all unsent work in place', () async {
      final ids = await seedEveryStatus();
      await db.upsertCache(
        entityType: 'student',
        entityId: 'stale',
        payloadJson: '{}',
        now: t0.subtract(const Duration(days: 30)),
      );

      await db.runEviction(now: t0);

      expect(await db.cacheCount(), 0);
      expect(await db.outboxByStatus(OutboxStatus.succeeded), isEmpty);
      expect(await db.outboxEntry(ids[OutboxStatus.pending]!), isNotNull);
      expect(await db.outboxEntry(ids[OutboxStatus.inflight]!), isNotNull);
      expect(await db.outboxEntry(ids[OutboxStatus.failed]!), isNotNull);
      expect(await db.outboxEntry(ids[OutboxStatus.dead]!), isNotNull);
    });
  });
}
