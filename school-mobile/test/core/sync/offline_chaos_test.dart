import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/db/database_errors.dart';
import 'package:school_mobile/core/db/tables.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/sync/sync.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/teacher/teacher.dart';

import '../../support/mock_http_adapter.dart';

final DateTime t0 = DateTime.utc(2026, 9, 5, 9);

const String kDate = '2026-09-05';

Map<String, Object?> _rosterBody() => <String, Object?>{
      'data': <String, Object?>{
        'class_room_id': 10,
        'date': kDate,
        'attendance_window': <String, Object?>{
          'open': true,
          'hours': 48,
          'closes_at': '2026-09-07T23:59:59+00:00',
          'reason': null,
        },
        'students': <Object?>[
          <String, Object?>{
            'student_user_id': 1,
            'name': 'ليان',
            'admission_no': 'STU-1',
            'has_photo': false,
            'guardians': <Object?>[],
            'status': null,
            'note': null,
          },
        ],
      },
    };

Future<OutboxEntry> queue(AppDatabase db, {String key = 'idem-1'}) => db.enqueue(
      endpoint: '/mobile/v1/teacher/attendance/batch',
      method: 'POST',
      payloadJson: '{"class_room_id":10,"date":"$kDate","records":[]}',
      idempotencyKey: key,
      now: t0,
    );

/// A database that refuses to record anything, the way a full disk does.
class _FullDisk extends AppDatabase {
  _FullDisk() : super.memory();

  @override
  Future<OutboxEntry> enqueue({
    required String endpoint,
    required String method,
    required String payloadJson,
    required String idempotencyKey,
    DateTime? now,
  }) =>
      throw Exception('SqliteException(13): database or disk is full');
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('a clock that jumped forward does not strand a write', () {
    late AppDatabase db;

    setUp(() {
      db = AppDatabase.memory();
      addTearDown(db.close);
    });

    test('a row parked beyond the backoff ceiling is claimed anyway', () async {
      // The device thought it was next Tuesday when the failure was recorded,
      // then the clock was corrected. Without this the row waits for a date
      // that is now in the future for ever, and a write stranded by a clock is
      // lost as surely as one deleted.
      final row = await queue(db);
      await db.markFailed(
        row.id,
        reason: 'HTTP 503',
        backoff: const OutboxBackoff(base: Duration(seconds: 30)),
        // Recorded while the clock was seven days ahead.
        now: t0.add(const Duration(days: 7)),
      );

      final claimed = await db.claimNext(now: t0);

      expect(claimed, isNotNull);
      expect(claimed!.id, row.id);
    });

    test('an honest backoff inside the ceiling is still respected', () async {
      // The skew rule must not become "ignore backoff": a row that genuinely
      // has thirty seconds to wait still waits.
      final row = await queue(db);
      await db.markFailed(
        row.id,
        reason: 'HTTP 503',
        backoff: const OutboxBackoff(base: Duration(minutes: 5)),
        now: t0,
      );

      expect(await db.claimNext(now: t0), isNull);
      expect(
        (await db.claimNext(now: t0.add(const Duration(hours: 1))))?.id,
        row.id,
      );
    });

    test('a clock that jumped backwards retries early rather than losing it',
        () async {
      // The mirror case, and the trade-off is deliberate: a backwards jump
      // makes an honest backoff look like skew, so the row is claimed earlier
      // than intended. Every queued write carries an idempotency key, so an
      // early retry costs one request the server deduplicates -- the other
      // direction costs a teacher their register.
      final db = AppDatabase.memory();
      addTearDown(db.close);

      final row = await queue(db);
      await db.markFailed(
        row.id,
        reason: 'HTTP 503',
        backoff: const OutboxBackoff(base: Duration(minutes: 5)),
        now: t0,
      );

      final claimed = await db.claimNext(now: t0.subtract(const Duration(days: 3)));

      expect(claimed?.id, row.id, reason: 'the row is not lost');
      expect(await db.allOutbox(), hasLength(1), reason: 'and not duplicated');
      expect(claimed!.idempotencyKey, row.idempotencyKey);
    });
  });

  group('a drain killed mid-flight loses nothing', () {
    test('an inflight row is recovered with its attempts untouched', () async {
      // The process died between the request going out and the answer coming
      // back. The row was never rejected, so it must not spend an attempt.
      final db = AppDatabase.memory();
      addTearDown(db.close);

      final row = await queue(db);
      await db.claimNext(now: t0);
      expect((await db.outboxEntry(row.id))!.status, OutboxStatus.inflight);

      final adapter = MockHttpAdapter(
        (options) => const MockReply(body: <String, Object?>{}),
      );
      final client = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: InMemoryTokenStore(deviceId: 'device'),
        adapter: adapter,
      );
      addTearDown(() => client.close(force: true));

      final drainer = OutboxDrainer(database: db, client: client);
      addTearDown(drainer.close);

      final report = await drainer.drain();

      expect(report.recovered, 1);
      expect(report.succeeded, 1);
      expect((await db.outboxEntry(row.id))!.attempts, 0);
    });
  });

  group('a device that cannot write says so', () {
    test('the repository reports a local failure, not a silent success',
        () async {
      final db = _FullDisk();
      addTearDown(db.close);

      final adapter = MockHttpAdapter((options) => const MockReply());
      final client = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: InMemoryTokenStore(deviceId: 'device'),
        adapter: adapter,
      );
      addTearDown(() => client.close(force: true));

      final repository = TeacherRepository(dio: client.dio, database: db);

      await expectLater(
        repository.queueAttendance(
          const AttendanceDraft(
            classRoomId: 10,
            date: kDate,
            marks: <int, AttendanceStatus>{1: AttendanceStatus.present},
          ),
        ),
        throwsA(isA<LocalWriteFailedException>()),
      );
    });

    test('the message carries no payload and no file path', () async {
      // SQLite quotes file paths in its errors, and a path carries the account
      // name. The driver's message is deliberately dropped.
      const failure = LocalWriteFailedException();

      expect(failure.message, isNot(contains('/')));
      expect(failure.message, isNot(contains('class_room_id')));
      expect(failure.toString(), isNot(contains('SqliteException')));
    });

    testWidgets('the register says nothing was saved', (tester) async {
      // The one lie this screen must never tell. A teacher told "saved on this
      // phone" when nothing was written walks away, and nobody has the roll.
      final db = _FullDisk();
      addTearDown(db.close);

      final adapter = MockHttpAdapter(
        (options) => options.path == '/mobile/v1/teacher/roster/10'
            ? MockReply(body: _rosterBody())
            : const MockReply(statusCode: 404),
      );
      final client = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: InMemoryTokenStore(deviceId: 'device'),
        adapter: adapter,
      );
      addTearDown(() => client.close(force: true));

      final controller = AttendanceController(
        repository: TeacherRepository(dio: client.dio, database: db),
        classRoomId: 10,
        date: kDate,
      );
      addTearDown(controller.dispose);

      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.light(),
        locale: const Locale('ar'),
        supportedLocales: AppLocales.supported,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: const AppI18nScope(
          formats: AppFormats(locale: 'ar'),
          child: SizedBox.shrink(),
        ),
      ));
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.light(),
        locale: const Locale('ar'),
        supportedLocales: AppLocales.supported,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: AppI18nScope(
          formats: const AppFormats(locale: 'ar'),
          child: AttendanceScreen(controller: controller),
        ),
      ));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(seconds: 1));

      await tester.tap(find.byKey(const Key('attendance-submit')));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key('attendance-local-write-failed')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('attendance-queued-notice')),
        findsNothing,
        reason: 'nothing was written, so nothing may be shown as queued',
      );
      expect(
        find.text('حُفظ على هذا الجهاز، وسيصل المدرسة عند توفّر الاتصال.'),
        findsNothing,
      );
    });
  });

  group('nothing evicts unsent work', () {
    test('a pending row survives every eviction pass', () async {
      final db = AppDatabase.memory();
      addTearDown(db.close);

      await queue(db, key: 'pending-1');
      final failed = await queue(db, key: 'failed-1');
      await db.markFailed(
        failed.id,
        reason: 'HTTP 503',
        backoff: const OutboxBackoff(base: Duration(seconds: 30)),
        now: t0,
      );
      final dead = await queue(db, key: 'dead-1');
      await db.markDead(dead.id, reason: 'HTTP 422', now: t0);

      await db.runEviction(now: t0.add(const Duration(days: 365)));

      // Pending and failed are unsent work; dead is a failure the user has not
      // necessarily seen. None of the three is disposable.
      expect(await db.allOutbox(), hasLength(3));
    });
  });
}
