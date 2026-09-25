import '../db/app_database.dart';

/// One entity as a delta feed reports it.
class DeltaChange {
  const DeltaChange({
    required this.entityId,
    this.payloadJson,
    this.etag,
    this.deleted = false,
  });

  /// A tombstone: the entity is gone server-side and must leave the cache.
  const DeltaChange.tombstone(this.entityId)
      : payloadJson = null,
        etag = null,
        deleted = true;

  final String entityId;

  /// Serialised entity. Null for a tombstone.
  final String? payloadJson;

  final String? etag;

  final bool deleted;
}

/// One page of a delta feed.
class DeltaPage {
  const DeltaPage({
    this.changes = const <DeltaChange>[],
    this.nextCursor,
    this.hasMore = false,
  });

  final List<DeltaChange> changes;

  /// Position to resume from. Stored only once this page's writes commit.
  final String? nextCursor;

  final bool hasMore;
}

/// Source of changed entities since a cursor.
///
/// This is an interface, not an HTTP client, deliberately.
/// `laravel-api/openapi.yaml` defines **no** delta endpoint: there is no
/// `cursor`, `since` or `updated_after` parameter anywhere in the contract,
/// and no tombstone representation. Rather than invent a URL and a response
/// shape the server does not serve, the engine is built against this interface
/// and exercised with a fake. Implement it against the real endpoint once the
/// contract defines one — nothing else here needs to change.
abstract class DeltaSource {
  Future<DeltaPage> fetchSince({required String entityType, String? cursor});
}

/// Where the per-entity-type sync position lives.
abstract class CursorStore {
  Future<String?> read(String entityType);

  Future<void> write(String entityType, String cursor);
}

/// Non-persistent [CursorStore].
class InMemoryCursorStore implements CursorStore {
  final Map<String, String> _cursors = <String, String>{};

  @override
  Future<String?> read(String entityType) async => _cursors[entityType];

  @override
  Future<void> write(String entityType, String cursor) async =>
      _cursors[entityType] = cursor;
}

/// [CursorStore] kept in `LocalCache` under a reserved entity type, so the
/// position survives restarts without needing a schema change.
///
/// Note the row is an ordinary cache row and is therefore subject to cache
/// eviction. Losing it is safe: the next pull starts from no cursor and
/// refetches, which costs bandwidth but cannot lose data.
class LocalCacheCursorStore implements CursorStore {
  const LocalCacheCursorStore(this.database);

  /// Reserved entity type. The leading underscores keep it clear of real ones.
  static const String cursorEntityType = '__delta_cursor';

  final AppDatabase database;

  @override
  Future<String?> read(String entityType) async {
    final row = await database.readCache(cursorEntityType, entityType);
    return row?.syncCursor;
  }

  @override
  Future<void> write(String entityType, String cursor) {
    return database.upsertCache(
      entityType: cursorEntityType,
      entityId: entityType,
      payloadJson: '{}',
      syncCursor: cursor,
    );
  }
}

/// What one pull did.
class DeltaResult {
  const DeltaResult({
    this.upserted = 0,
    this.deleted = 0,
    this.pages = 0,
    this.cursor,
  });

  final int upserted;
  final int deleted;
  final int pages;

  /// Cursor in force after the pull.
  final String? cursor;

  @override
  String toString() =>
      'DeltaResult(upserted: $upserted, deleted: $deleted, pages: $pages)';
}

/// Pulls changed entities into [LocalCache].
///
/// The cursor advances only after the page's writes have committed. If a write
/// throws, the cursor stays where it was and the same page is fetched again —
/// re-applying a page is harmless because upserts are keyed by
/// `(entityType, entityId)`, whereas advancing past unwritten data would lose
/// it silently.
class DeltaSync {
  const DeltaSync({
    required this.database,
    required this.source,
    required this.cursorStore,
  });

  final AppDatabase database;
  final DeltaSource source;
  final CursorStore cursorStore;

  Future<DeltaResult> pull({
    required String entityType,
    int maxPages = 100,
  }) async {
    var cursor = await cursorStore.read(entityType);
    var upserted = 0;
    var deleted = 0;
    var pages = 0;

    for (var page = 0; page < maxPages; page++) {
      final fetched = await source.fetchSince(
        entityType: entityType,
        cursor: cursor,
      );
      pages++;

      // All of a page's writes land together, so a failure part-way through
      // cannot leave the cache half-updated under an advanced cursor.
      final counts = await database.transaction(() async {
        var applied = 0;
        var removed = 0;
        for (final change in fetched.changes) {
          if (change.deleted) {
            await database.deleteCache(entityType, change.entityId);
            removed++;
          } else {
            await database.upsertCache(
              entityType: entityType,
              entityId: change.entityId,
              payloadJson: change.payloadJson ?? '{}',
              etag: change.etag,
            );
            applied++;
          }
        }
        return (applied: applied, removed: removed);
      });

      upserted += counts.applied;
      deleted += counts.removed;

      // Only now, with the writes committed, is it safe to move on.
      final next = fetched.nextCursor;
      if (next != null) {
        await cursorStore.write(entityType, next);
        cursor = next;
      }

      if (!fetched.hasMore) break;
    }

    return DeltaResult(
      upserted: upserted,
      deleted: deleted,
      pages: pages,
      cursor: cursor,
    );
  }
}
