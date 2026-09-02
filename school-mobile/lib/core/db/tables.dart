import 'package:drift/drift.dart';

/// Lifecycle of a queued write.
///
/// `pending` and `failed` are both claimable — a failed row waits for its
/// backoff to elapse. `succeeded` and `dead` are terminal.
enum OutboxStatus {
  /// Waiting to be sent for the first time.
  pending,

  /// Claimed by a drain and in flight right now.
  inflight,

  /// Accepted by the server.
  succeeded,

  /// Rejected transiently; retried once [LocalOutbox.nextAttemptAt] passes.
  failed,

  /// Given up on. Never retried and never evicted automatically, so the
  /// failure stays visible to the user.
  dead,
}

/// Writes made offline, queued until the sync engine can send them.
///
/// This table is the durable record of work the user believes is saved, so
/// nothing here is deleted except deliberately.
@DataClassName('OutboxEntry')
class LocalOutbox extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Path the write is destined for, relative to the API base URL.
  TextColumn get endpoint => text()();

  TextColumn get method => text()();

  /// Request body, serialised. Never logged.
  TextColumn get payloadJson => text()();

  /// Deduplicates enqueues and makes the eventual retry safe to replay.
  TextColumn get idempotencyKey => text().unique()();

  TextColumn get status => textEnum<OutboxStatus>()();

  IntColumn get attempts => integer().withDefault(const Constant(0))();

  /// Short reason for the last failure. Never the response body.
  TextColumn get lastError => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  /// Earliest time this row may be claimed again; null means immediately.
  DateTimeColumn get nextAttemptAt => dateTime().nullable()();

  /// When the row reached a terminal state.
  DateTimeColumn get completedAt => dateTime().nullable()();
}

/// Server responses held for offline reads.
///
/// Unlike the outbox this is disposable: everything here can be fetched again,
/// which is what makes it safe to evict.
@DataClassName('CacheEntry')
class LocalCache extends Table {
  TextColumn get entityType => text()();

  TextColumn get entityId => text()();

  /// Cached response body, serialised. Never logged.
  TextColumn get payloadJson => text()();

  /// Validator for a conditional GET.
  TextColumn get etag => text().nullable()();

  /// Opaque delta-sync position supplied by the server.
  TextColumn get syncCursor => text().nullable()();

  DateTimeColumn get fetchedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{entityType, entityId};
}
