import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/sync/sync.dart';

/// A [DeltaSource] that replays a script.
///
/// The contract in `laravel-api/openapi.yaml` defines no delta endpoint, so
/// there is nothing real to call here. This fake stands in for the interface
/// the engine was built against.
class ScriptedDeltaSource implements DeltaSource {
  ScriptedDeltaSource(this._pages);

  final List<DeltaPage> _pages;

  /// Cursors the engine presented, in order — this is what proves the cursor
  /// did or did not advance between calls.
  final List<String?> cursorsSeen = <String?>[];

  int _index = 0;

  @override
  Future<DeltaPage> fetchSince({
    required String entityType,
    String? cursor,
  }) async {
    cursorsSeen.add(cursor);
    if (_index >= _pages.length) return const DeltaPage();
    return _pages[_index++];
  }
}

const String students = 'student';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late AppDatabase db;

  setUp(() {
    db = AppDatabase.memory();
    addTearDown(db.close);
  });

  group('pulling changes', () {
    test('upserts entities into the cache and advances the cursor', () async {
      final source = ScriptedDeltaSource(<DeltaPage>[
        const DeltaPage(
          changes: <DeltaChange>[
            DeltaChange(entityId: '1', payloadJson: '{"name":"A"}', etag: 'e1'),
            DeltaChange(entityId: '2', payloadJson: '{"name":"B"}'),
          ],
          nextCursor: 'cursor-2',
        ),
      ]);
      final cursors = InMemoryCursorStore();
      final sync =
          DeltaSync(database: db, source: source, cursorStore: cursors);

      final result = await sync.pull(entityType: students);

      expect(result.upserted, 2);
      expect(result.deleted, 0);
      expect((await db.readCache(students, '1'))!.payloadJson, '{"name":"A"}');
      expect((await db.readCache(students, '1'))!.etag, 'e1');
      expect(await cursors.read(students), 'cursor-2');
      expect(source.cursorsSeen, <String?>[null], reason: 'first pull');
    });

    test('resumes from the stored cursor on the next pull', () async {
      final cursors = InMemoryCursorStore();
      await cursors.write(students, 'cursor-7');
      final source = ScriptedDeltaSource(<DeltaPage>[
        const DeltaPage(nextCursor: 'cursor-8'),
      ]);

      await DeltaSync(database: db, source: source, cursorStore: cursors)
          .pull(entityType: students);

      expect(source.cursorsSeen, <String?>['cursor-7']);
      expect(await cursors.read(students), 'cursor-8');
    });

    test('a tombstone deletes the cached entity', () async {
      await db.upsertCache(
        entityType: students,
        entityId: '1',
        payloadJson: '{"name":"A"}',
      );
      final source = ScriptedDeltaSource(<DeltaPage>[
        const DeltaPage(
          changes: <DeltaChange>[DeltaChange.tombstone('1')],
          nextCursor: 'cursor-2',
        ),
      ]);

      final result = await DeltaSync(
        database: db,
        source: source,
        cursorStore: InMemoryCursorStore(),
      ).pull(entityType: students);

      expect(result.deleted, 1);
      expect(await db.readCache(students, '1'), isNull);
    });

    test('follows hasMore across pages', () async {
      final source = ScriptedDeltaSource(<DeltaPage>[
        const DeltaPage(
          changes: <DeltaChange>[DeltaChange(entityId: '1', payloadJson: '{}')],
          nextCursor: 'c1',
          hasMore: true,
        ),
        const DeltaPage(
          changes: <DeltaChange>[DeltaChange(entityId: '2', payloadJson: '{}')],
          nextCursor: 'c2',
        ),
      ]);
      final cursors = InMemoryCursorStore();

      final result = await DeltaSync(
        database: db,
        source: source,
        cursorStore: cursors,
      ).pull(entityType: students);

      expect(result.pages, 2);
      expect(result.upserted, 2);
      // The second fetch used the cursor the first page committed.
      expect(source.cursorsSeen, <String?>[null, 'c1']);
      expect(await cursors.read(students), 'c2');
    });
  });

  group('cursor safety', () {
    test('a failed cache write leaves the cursor exactly where it was',
        () async {
      final cursors = InMemoryCursorStore();
      await cursors.write(students, 'cursor-original');

      final source = ScriptedDeltaSource(<DeltaPage>[
        const DeltaPage(
          changes: <DeltaChange>[
            DeltaChange(entityId: '1', payloadJson: '{"name":"A"}'),
          ],
          nextCursor: 'cursor-next',
        ),
      ]);

      // Closing the database makes the cache write fail, standing in for any
      // storage failure part-way through applying a page. It has to be opened
      // first: drift connects lazily, so closing an untouched database is a
      // no-op and the next write would quietly succeed.
      await db.cacheCount();
      await db.close();

      await expectLater(
        DeltaSync(database: db, source: source, cursorStore: cursors)
            .pull(entityType: students),
        throwsA(anything),
      );

      expect(
        await cursors.read(students),
        'cursor-original',
        reason: 'advancing past data that was never written would lose it',
      );
    });

    test('the surviving cursor makes the next pull refetch the same page',
        () async {
      final cursors = InMemoryCursorStore();
      await cursors.write(students, 'cursor-original');
      final source = ScriptedDeltaSource(<DeltaPage>[
        const DeltaPage(
          changes: <DeltaChange>[DeltaChange(entityId: '1', payloadJson: '{}')],
          nextCursor: 'cursor-next',
        ),
      ]);

      final closed = AppDatabase.memory();
      await closed.cacheCount();
      await closed.close();
      await expectLater(
        DeltaSync(database: closed, source: source, cursorStore: cursors)
            .pull(entityType: students),
        throwsA(anything),
      );

      // Recovery: the same position is presented again, so nothing is skipped.
      await DeltaSync(
        database: db,
        source: ScriptedDeltaSource(<DeltaPage>[
          const DeltaPage(
            changes: <DeltaChange>[
              DeltaChange(entityId: '1', payloadJson: '{"name":"A"}'),
            ],
            nextCursor: 'cursor-next',
          ),
        ]),
        cursorStore: cursors,
      ).pull(entityType: students);

      expect(await db.readCache(students, '1'), isNotNull);
      expect(await cursors.read(students), 'cursor-next');
    });
  });

  group('cursor persistence', () {
    test('LocalCacheCursorStore round-trips through the database', () async {
      final cursors = LocalCacheCursorStore(db);

      expect(await cursors.read(students), isNull);
      await cursors.write(students, 'cursor-42');
      expect(await cursors.read(students), 'cursor-42');

      // A second instance over the same database sees it too.
      expect(await LocalCacheCursorStore(db).read(students), 'cursor-42');
    });
  });
}
