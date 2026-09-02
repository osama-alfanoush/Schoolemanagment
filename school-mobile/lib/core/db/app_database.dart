import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'database_errors.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// How long terminal and cached rows are kept before eviction may remove them.
class EvictionPolicy {
  const EvictionPolicy({
    this.cacheTtl = const Duration(days: 7),
    this.maxCacheRows = 5000,
    this.succeededOutboxRetention = const Duration(days: 1),
  });

  /// Cache rows older than this may be evicted.
  final Duration cacheTtl;

  /// Upper bound on cache rows; the oldest are dropped first.
  final int maxCacheRows;

  /// How long a succeeded outbox row is kept, so a recent sync stays auditable.
  final Duration succeededOutboxRetention;
}

/// Backoff applied by [AppDatabase.markFailed].
class OutboxBackoff {
  const OutboxBackoff({
    this.base = const Duration(seconds: 30),
    this.max = const Duration(hours: 6),
  });

  final Duration base;
  final Duration max;

  /// Delay before retry number [attempts]; doubles each time, capped at [max].
  Duration delayFor(int attempts) {
    if (attempts <= 0) return base;
    final exponential = base.inMilliseconds * pow(2, attempts - 1);
    final capped = min(exponential.toDouble(), max.inMilliseconds.toDouble());
    return Duration(milliseconds: capped.toInt());
  }
}

/// The app's encrypted local store.
///
/// Holds the offline write queue and the read cache. Opening it is the job of
/// `encrypted_database.dart`; this class only owns the schema and operations.
@DriftDatabase(tables: <Type>[LocalOutbox, LocalCache])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  /// In-memory database for tests. Nothing is persisted and no key is used,
  /// so this exercises the schema and operations, not encryption.
  AppDatabase.memory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  /// Migration policy.
  ///
  /// Version 1 is the only schema that has ever shipped. Going forward:
  ///
  /// * Migrations are **additive only** — new tables, new nullable columns,
  ///   new indexes. A column is never dropped or retyped in place, because a
  ///   half-applied destructive change would take unsynced work with it.
  /// * Every version bump gets an explicit `from`/`to` step here. There is
  ///   deliberately no `destructiveFallback`: wiping the database to resolve a
  ///   schema mismatch is exactly the silent data loss this layer exists to
  ///   prevent.
  /// * An unrecognised upgrade path raises [DatabaseMigrationException] rather
  ///   than opening a database whose shape does not match the code.
  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          throw DatabaseMigrationException(
            'No migration is defined from schema v$from to v$to.',
          );
        },
        beforeOpen: (OpeningDetails details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  // ---------------------------------------------------------------- outbox

  /// Queues a write, or returns the existing row when [idempotencyKey] has
  /// already been queued.
  ///
  /// Deduplication is the point of the key: enqueueing twice is a replay, not
  /// a second piece of work.
  Future<OutboxEntry> enqueue({
    required String endpoint,
    required String method,
    required String payloadJson,
    required String idempotencyKey,
    DateTime? now,
  }) {
    final createdAt = now ?? DateTime.now();

    return transaction(() async {
      final existing = await (select(localOutbox)
            ..where((t) => t.idempotencyKey.equals(idempotencyKey)))
          .getSingleOrNull();
      if (existing != null) return existing;

      return into(localOutbox).insertReturning(
        LocalOutboxCompanion.insert(
          endpoint: endpoint,
          method: method,
          payloadJson: payloadJson,
          idempotencyKey: idempotencyKey,
          status: OutboxStatus.pending,
          createdAt: createdAt,
        ),
      );
    });
  }

  /// Atomically takes the next due row and marks it `inflight`.
  ///
  /// Returns null when nothing is due. The claim is a conditional update
  /// inside a transaction: the row only moves to `inflight` if it is still
  /// claimable, so two concurrent drains can never take the same row. If a
  /// row is lost to a competing drain the loop moves on to the next candidate
  /// rather than reporting "nothing to do".
  Future<OutboxEntry?> claimNext({DateTime? now}) {
    final at = now ?? DateTime.now();

    return transaction(() async {
      // Bounded so a pathological loser can never spin forever.
      for (var attempt = 0; attempt < 1000; attempt++) {
        final candidate = await (select(localOutbox)
              ..where((t) => t.status.isInValues(<OutboxStatus>[
                    OutboxStatus.pending,
                    OutboxStatus.failed,
                  ]))
              ..where((t) =>
                  t.nextAttemptAt.isNull() |
                  t.nextAttemptAt.isSmallerOrEqualValue(at))
              ..orderBy(<OrderClauseGenerator<$LocalOutboxTable>>[
                (t) => OrderingTerm.asc(t.createdAt),
                (t) => OrderingTerm.asc(t.id),
              ])
              ..limit(1))
            .getSingleOrNull();

        if (candidate == null) return null;

        final claimed = await (update(localOutbox)
              ..where((t) => t.id.equals(candidate.id))
              ..where((t) => t.status.isInValues(<OutboxStatus>[
                    OutboxStatus.pending,
                    OutboxStatus.failed,
                  ])))
            .write(
          const LocalOutboxCompanion(status: Value(OutboxStatus.inflight)),
        );

        if (claimed == 1) {
          return candidate.copyWith(status: OutboxStatus.inflight);
        }
        // Someone else claimed it between the select and the update; try the
        // next candidate instead of giving up.
      }

      throw StateError('claimNext exceeded its retry bound');
    });
  }

  /// Marks a claimed row as accepted by the server.
  Future<void> markSucceeded(int id, {DateTime? now}) async {
    await (update(localOutbox)..where((t) => t.id.equals(id))).write(
      LocalOutboxCompanion(
        status: const Value(OutboxStatus.succeeded),
        completedAt: Value(now ?? DateTime.now()),
        lastError: const Value<String?>(null),
      ),
    );
  }

  /// Records a transient failure and schedules the retry.
  ///
  /// [reason] must be a short diagnostic — a status code or error name. Never
  /// pass a response body: it can carry personal data and it is persisted.
  Future<void> markFailed(
    int id, {
    required String reason,
    OutboxBackoff backoff = const OutboxBackoff(),
    DateTime? now,
  }) async {
    final at = now ?? DateTime.now();

    await transaction(() async {
      final entry = await (select(localOutbox)..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (entry == null) return;

      final attempts = entry.attempts + 1;
      await (update(localOutbox)..where((t) => t.id.equals(id))).write(
        LocalOutboxCompanion(
          status: const Value(OutboxStatus.failed),
          attempts: Value(attempts),
          lastError: Value(reason),
          nextAttemptAt: Value(at.add(backoff.delayFor(attempts))),
        ),
      );
    });
  }

  /// Gives up on a row. It stays in the database so the user can still see the
  /// work that never synced.
  Future<void> markDead(int id, {required String reason, DateTime? now}) async {
    await (update(localOutbox)..where((t) => t.id.equals(id))).write(
      LocalOutboxCompanion(
        status: const Value(OutboxStatus.dead),
        lastError: Value(reason),
        completedAt: Value(now ?? DateTime.now()),
      ),
    );
  }

  Future<OutboxEntry?> outboxEntry(int id) =>
      (select(localOutbox)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<OutboxEntry>> outboxByStatus(OutboxStatus status) =>
      (select(localOutbox)..where((t) => t.status.equalsValue(status))).get();

  Future<List<OutboxEntry>> allOutbox() => select(localOutbox).get();

  // ----------------------------------------------------------------- cache

  /// Inserts or replaces the cached copy of one entity.
  Future<void> upsertCache({
    required String entityType,
    required String entityId,
    required String payloadJson,
    String? etag,
    String? syncCursor,
    DateTime? now,
  }) async {
    await into(localCache).insertOnConflictUpdate(
      LocalCacheCompanion.insert(
        entityType: entityType,
        entityId: entityId,
        payloadJson: payloadJson,
        etag: Value<String?>(etag),
        syncCursor: Value<String?>(syncCursor),
        fetchedAt: now ?? DateTime.now(),
      ),
    );
  }

  Future<CacheEntry?> readCache(String entityType, String entityId) =>
      (select(localCache)
            ..where((t) => t.entityType.equals(entityType))
            ..where((t) => t.entityId.equals(entityId)))
          .getSingleOrNull();

  Future<List<CacheEntry>> readCacheByType(String entityType) =>
      (select(localCache)..where((t) => t.entityType.equals(entityType))).get();

  /// Removes one cached entity. Returns the number of rows removed.
  Future<int> deleteCache(String entityType, String entityId) =>
      (delete(localCache)
            ..where((t) => t.entityType.equals(entityType))
            ..where((t) => t.entityId.equals(entityId)))
          .go();

  Future<int> deleteCacheByType(String entityType) =>
      (delete(localCache)..where((t) => t.entityType.equals(entityType))).go();

  Future<int> cacheCount() async {
    final count = countAll();
    final row = await (selectOnly(localCache)..addColumns(<Expression<Object>>[count]))
        .getSingle();
    return row.read(count)!;
  }

  // -------------------------------------------------------------- eviction

  /// Drops cache rows fetched longer ago than [EvictionPolicy.cacheTtl].
  ///
  /// Only touches the cache: everything here can be fetched again.
  Future<int> evictExpiredCache({
    EvictionPolicy policy = const EvictionPolicy(),
    DateTime? now,
  }) {
    final cutoff = (now ?? DateTime.now()).subtract(policy.cacheTtl);
    return (delete(localCache)
          ..where((t) => t.fetchedAt.isSmallerThanValue(cutoff)))
        .go();
  }

  /// Enforces [EvictionPolicy.maxCacheRows], dropping the oldest rows first.
  Future<int> capCacheRows({EvictionPolicy policy = const EvictionPolicy()}) {
    return transaction(() async {
      final total = await cacheCount();
      final excess = total - policy.maxCacheRows;
      if (excess <= 0) return 0;

      final doomed = await (select(localCache)
            ..orderBy(<OrderClauseGenerator<$LocalCacheTable>>[
              (t) => OrderingTerm.asc(t.fetchedAt),
              (t) => OrderingTerm.asc(t.entityType),
              (t) => OrderingTerm.asc(t.entityId),
            ])
            ..limit(excess))
          .get();

      var removed = 0;
      for (final entry in doomed) {
        removed += await deleteCache(entry.entityType, entry.entityId);
      }
      return removed;
    });
  }

  /// Drops outbox rows that are safely finished.
  ///
  /// Only `succeeded` rows past [EvictionPolicy.succeededOutboxRetention] are
  /// removed. `pending`, `inflight` and `failed` rows are unsent work, and
  /// `dead` rows are a failure the user has not seen yet — none of them are
  /// ever evicted automatically.
  Future<int> evictCompletedOutbox({
    EvictionPolicy policy = const EvictionPolicy(),
    DateTime? now,
  }) {
    final cutoff =
        (now ?? DateTime.now()).subtract(policy.succeededOutboxRetention);
    return (delete(localOutbox)
          ..where((t) => t.status.equalsValue(OutboxStatus.succeeded))
          ..where((t) => t.completedAt.isNotNull())
          ..where((t) => t.completedAt.isSmallerThanValue(cutoff)))
        .go();
  }

  /// Runs every eviction pass. Returns the number of rows removed in total.
  Future<int> runEviction({
    EvictionPolicy policy = const EvictionPolicy(),
    DateTime? now,
  }) async {
    final at = now ?? DateTime.now();
    var removed = 0;
    removed += await evictExpiredCache(policy: policy, now: at);
    removed += await capCacheRows(policy: policy);
    removed += await evictCompletedOutbox(policy: policy, now: at);
    return removed;
  }

  bool _closed = false;

  /// Closes the database. Safe to call more than once.
  @override
  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    await super.close();
  }
}
