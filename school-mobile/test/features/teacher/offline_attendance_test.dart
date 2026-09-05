import 'dart:convert';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/db/tables.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/sync/sync.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/teacher/teacher.dart';
import 'package:school_mobile/shared/shared.dart';

import '../../support/mock_http_adapter.dart';

const String kDate = '2026-09-05';

Map<String, Object?> _rosterBody({
  int students = 3,
  bool windowOpen = true,
  String? windowReason,
  String? existingStatus,
}) =>
    <String, Object?>{
      'data': <String, Object?>{
        'class_room_id': 10,
        'date': kDate,
        'attendance_window': <String, Object?>{
          'open': windowOpen,
          'hours': 48,
          'closes_at': '2026-09-07T23:59:59+00:00',
          'reason': windowReason,
        },
        'students': <Object?>[
          for (var i = 1; i <= students; i++)
            <String, Object?>{
              'student_user_id': i,
              'name': 'طالب $i',
              'admission_no': 'STU-$i',
              'has_photo': false,
              'guardians': <Object?>[],
              'status': existingStatus,
              'note': null,
            },
        ],
      },
    };

({
  AttendanceController controller,
  TeacherRepository repository,
  AppDatabase database,
  ApiClient client,
  MockHttpAdapter adapter,
}) buildAttendance(MockResponder responder) {
  final adapter = MockHttpAdapter(responder);
  final client = ApiClient(
    baseUrl: 'https://api.test',
    tokenStore: InMemoryTokenStore(deviceId: 'device'),
    adapter: adapter,
  );
  addTearDown(() => client.close(force: true));

  final database = AppDatabase.memory();
  addTearDown(database.close);

  final repository = TeacherRepository(dio: client.dio, database: database);
  final controller = AttendanceController(
    repository: repository,
    classRoomId: 10,
    date: kDate,
  );
  addTearDown(controller.dispose);

  return (
    controller: controller,
    repository: repository,
    database: database,
    client: client,
    adapter: adapter,
  );
}

MockResponder rosterOnly({Map<String, Object?>? body}) =>
    (options) => options.path == '/mobile/v1/teacher/roster/10'
        ? MockReply(body: body ?? _rosterBody())
        : const MockReply(statusCode: 404);

Future<void> pumpAttendance(
  WidgetTester tester,
  Widget child, {
  String locale = 'ar',
}) async {
  await tester.pumpWidget(MaterialApp(
    theme: AppTheme.light(),
    locale: Locale(locale),
    supportedLocales: AppLocales.supported,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: AppI18nScope(
      formats: AppFormats(locale: locale),
      child: child,
    ),
  ));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  // The Scaffold scales its floating action button in. Tapping mid-animation
  // hits the shrunken transform and misses.
  await tester.pump(const Duration(seconds: 1));
  await tester.pump();
}

AttendanceView viewOf(AttendanceController controller) =>
    (controller.state as ScreenData<AttendanceView>).value;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('the default is everyone present', () {
    test('an untouched register marks the whole class present', () async {
      // In a class of thirty, twenty-eight are there. An app that makes a
      // teacher confirm each of the twenty-eight is slower than paper.
      final screen = buildAttendance(rosterOnly());

      await screen.controller.load();

      final draft = viewOf(screen.controller).draft;
      expect(draft.isAllPresent, isTrue);
      expect(draft.countOf(AttendanceStatus.present), 3);
    });

    test('marks the server already has are pre-filled, not overwritten',
        () async {
      // Opening an empty form on a day already marked is how the same class
      // gets taken twice.
      final screen = buildAttendance(
        rosterOnly(body: _rosterBody(existingStatus: 'absent')),
      );

      await screen.controller.load();

      expect(
        viewOf(screen.controller).draft.countOf(AttendanceStatus.absent),
        3,
      );
    });

    test('every student is sent, not only the exceptions', () async {
      // "Present" has to be a recorded fact. A partial roll cannot be told
      // apart from an unfinished one.
      final screen = buildAttendance(rosterOnly());
      await screen.controller.load();
      screen.controller.toggle(2);

      await screen.controller.submit();

      final payload = jsonDecode(
        (await screen.database.allOutbox()).single.payloadJson,
      ) as Map<String, Object?>;
      final records = payload['records']! as List<Object?>;

      expect(records, hasLength(3));
      expect(
        records
            .cast<Map<String, Object?>>()
            .firstWhere((r) => r['student_user_id'] == 2)['status'],
        'absent',
      );
    });
  });

  group('marking', () {
    test('a tap toggles present and absent, and back', () async {
      final screen = buildAttendance(rosterOnly());
      await screen.controller.load();

      screen.controller.toggle(1);
      expect(viewOf(screen.controller).draft.statusOf(1), AttendanceStatus.absent);

      screen.controller.toggle(1);
      expect(
        viewOf(screen.controller).draft.statusOf(1),
        AttendanceStatus.present,
      );
    });

    testWidgets('a swipe marks without removing the student', (tester) async {
      // A swipe that dismissed the row would be the opposite of what a
      // register needs: the student would leave the class.
      final screen = buildAttendance(rosterOnly());
      await pumpAttendance(
        tester,
        AttendanceScreen(controller: screen.controller),
        locale: 'en',
      );

      await tester.drag(find.byKey(const Key('student-1')), const Offset(400, 0));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('student-1')), findsOneWidget);
      expect(
        viewOf(screen.controller).draft.statusOf(1),
        AttendanceStatus.late,
      );
    });

    testWidgets('the swipe directions mirror in Arabic', (tester) async {
      // The same physical gesture must mean the same thing relative to the
      // start edge, which in Arabic is the right one. A swipe that means
      // "late" in English and "late" in Arabic while starting from opposite
      // edges is the bug this checks for.
      final screen = buildAttendance(rosterOnly());
      await pumpAttendance(
        tester,
        AttendanceScreen(controller: screen.controller),
      );

      await tester.drag(find.byKey(const Key('student-1')), const Offset(400, 0));
      await tester.pumpAndSettle();

      expect(
        viewOf(screen.controller).draft.statusOf(1),
        AttendanceStatus.excused,
        reason: 'rightward in RTL is a swipe from the end edge',
      );

      await tester.drag(find.byKey(const Key('student-2')), const Offset(-400, 0));
      await tester.pumpAndSettle();

      expect(viewOf(screen.controller).draft.statusOf(2), AttendanceStatus.late);
    });

    testWidgets('a long press opens the full chooser', (tester) async {
      final screen = buildAttendance(rosterOnly());
      await pumpAttendance(
        tester,
        AttendanceScreen(controller: screen.controller),
      );

      await tester.longPress(find.byKey(const Key('student-1')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('mark-sheet')), findsOneWidget);

      await tester.tap(find.byKey(const Key('mark-excused')));
      await tester.pumpAndSettle();

      expect(
        viewOf(screen.controller).draft.statusOf(1),
        AttendanceStatus.excused,
      );
    });

    testWidgets('every student row clears 48dp', (tester) async {
      final screen = buildAttendance(rosterOnly());
      await pumpAttendance(
        tester,
        AttendanceScreen(controller: screen.controller),
      );

      for (var i = 1; i <= 3; i++) {
        expect(
          tester.getSize(find.byKey(Key('student-$i'))).height,
          greaterThanOrEqualTo(Dimens.minTapTarget),
          reason: 'row $i is tapped thirty times a morning',
        );
      }
    });
  });

  group('offline', () {
    test('a full class is marked and queued with no network at all', () async {
      // The acceptance criterion: airplane mode, start to finish.
      var online = true;
      final screen = buildAttendance((options) {
        if (!online) throw connectionLost(options);

        return MockReply(body: _rosterBody());
      });

      await screen.controller.load();
      online = false;

      screen.controller.toggle(2);
      expect(await screen.controller.submit(), isTrue);

      final queued = await screen.database.allOutbox();
      expect(queued, hasLength(1));
      expect(queued.single.status, OutboxStatus.pending);
      expect(
        screen.adapter.requestsFor(TeacherEndpoints.attendanceBatch),
        isEmpty,
        reason: 'the screen must never touch the network itself',
      );
    });

    test('restoring connectivity submits exactly once', () async {
      var online = true;
      var batches = 0;
      final screen = buildAttendance((options) {
        if (options.path == TeacherEndpoints.attendanceBatch) {
          batches++;

          return const MockReply(body: <String, Object?>{'data': <String, Object?>{}});
        }
        if (!online) throw connectionLost(options);

        return MockReply(body: _rosterBody());
      });

      await screen.controller.load();
      online = false;
      screen.controller.toggle(2);
      await screen.controller.submit();

      online = true;
      final drainer = OutboxDrainer(
        database: screen.database,
        client: screen.client,
      );
      addTearDown(drainer.close);

      await drainer.drain();
      // A second pass, as would happen on the next connectivity change.
      await drainer.drain();

      expect(batches, 1);
      expect(
        (await screen.database.allOutbox()).single.status,
        OutboxStatus.succeeded,
      );
    });

    test('a queued batch carries an idempotency key', () async {
      final screen = buildAttendance(rosterOnly());
      await screen.controller.load();

      await screen.controller.submit();

      expect(
        (await screen.database.allOutbox()).single.idempotencyKey,
        isNotEmpty,
      );
    });
  });

  group('pending is pending, never saved', () {
    testWidgets('the confirmation says saved on this phone, not saved',
        (tester) async {
      final screen = buildAttendance(rosterOnly());
      await pumpAttendance(
        tester,
        AttendanceScreen(controller: screen.controller),
      );

      await tester.tap(find.byKey(const Key('attendance-submit')));
      await tester.pumpAndSettle();

      expect(
        find.text('حُفظ على هذا الجهاز، وسيصل المدرسة عند توفّر الاتصال.'),
        findsOneWidget,
      );
    });

    testWidgets('a queued register keeps saying so after it is sent',
        (tester) async {
      final screen = buildAttendance(rosterOnly());
      await pumpAttendance(
        tester,
        AttendanceScreen(controller: screen.controller),
      );

      expect(find.byKey(const Key('attendance-queued-notice')), findsNothing);

      await tester.tap(find.byKey(const Key('attendance-submit')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('attendance-queued-notice')), findsOneWidget);
    });
  });

  group('the edit window', () {
    test('a closed window refuses the submission locally', () async {
      // Queueing a batch certain to be refused turns a clear "you cannot edit
      // this day" into a rejection arriving hours later.
      final screen = buildAttendance(
        rosterOnly(body: _rosterBody(windowOpen: false, windowReason: 'انتهت المهلة.')),
      );
      await screen.controller.load();

      expect(await screen.controller.submit(), isFalse);
      expect(await screen.database.allOutbox(), isEmpty);
    });

    testWidgets('a closed window hides the submit button and says why',
        (tester) async {
      final screen = buildAttendance(
        rosterOnly(body: _rosterBody(windowOpen: false, windowReason: 'انتهت المهلة.')),
      );

      await pumpAttendance(
        tester,
        AttendanceScreen(controller: screen.controller),
      );

      expect(find.byKey(const Key('attendance-submit')), findsNothing);
      expect(find.byKey(const Key('attendance-window-closed')), findsOneWidget);
      expect(find.text('انتهت المهلة.'), findsOneWidget);
    });

    testWidgets('a closed window does not accept marks either', (tester) async {
      final screen = buildAttendance(
        rosterOnly(body: _rosterBody(windowOpen: false)),
      );
      await pumpAttendance(
        tester,
        AttendanceScreen(controller: screen.controller),
      );

      await tester.tap(find.byKey(const Key('student-1')));
      await tester.pump();

      expect(
        viewOf(screen.controller).draft.statusOf(1),
        AttendanceStatus.present,
        reason: 'an editable form the server will refuse is a lie',
      );
    });
  });

  group('a rejection is never silently dropped', () {
    testWidgets('the teacher is told which submission and why', (tester) async {
      // The drain itself is exercised by the plain tests below: it cannot run
      // inside testWidgets, whose fake clock never fires the transport's
      // timers. What this checks is the screen — a dead row must name the
      // submission and explain it, rather than vanishing.
      final screen = buildAttendance(rosterOnly());
      await pumpAttendance(
        tester,
        AttendanceScreen(controller: screen.controller),
      );

      await tester.tap(find.byKey(const Key('attendance-submit')));
      await tester.pumpAndSettle();

      // Real async, outside the fake clock, which is where the database lives.
      final rows = await tester.runAsync(screen.database.allOutbox);
      final rowId = rows!.single.id;
      await tester.runAsync(
        () => screen.database.markDead(rowId, reason: 'HTTP 422'),
      );
      await tester.runAsync(screen.controller.load);
      await tester.pumpAndSettle();

      expect(find.byKey(Key('rejected-$rowId')), findsOneWidget);
      expect(
        find.text('انتهت مهلة التعديل، فلم يُقبل هذا الإرسال.'),
        findsOneWidget,
      );
      expect(find.text('أعد الرصد ثم أرسله من جديد.'), findsOneWidget);
      expect(
        find.byKey(const Key('attendance-queued-notice')),
        findsNothing,
        reason: 'a rejected submission is not still on its way',
      );
    });

    test('a rejected batch is never counted as still sending', () async {
      final screen = buildAttendance((options) =>
          options.path == TeacherEndpoints.attendanceBatch
              ? const MockReply(statusCode: 422)
              : MockReply(body: _rosterBody()));

      await screen.controller.load();
      await screen.controller.submit();

      final drainer = OutboxDrainer(
        database: screen.database,
        client: screen.client,
      );
      addTearDown(drainer.close);
      await drainer.drain();

      expect(await screen.repository.queuedAttendance(kDate), isEmpty);
      expect(await screen.repository.rejectedAttendance(), hasLength(1));
    });

    test('a conflict is explained as a conflict, not as a generic refusal',
        () async {
      final screen = buildAttendance((options) =>
          options.path == TeacherEndpoints.attendanceBatch
              ? const MockReply(statusCode: 409)
              : MockReply(body: _rosterBody()));

      await screen.controller.load();
      await screen.controller.submit();

      final drainer = OutboxDrainer(
        database: screen.database,
        client: screen.client,
      );
      addTearDown(drainer.close);
      await drainer.drain();

      expect(
        (await screen.repository.rejectedAttendance()).single.statusCode,
        409,
      );
    });

    test('losing connectivity never kills a queued register', () async {
      // An offline device would otherwise burn through every attempt and bury
      // the teacher's work.
      final screen = buildAttendance((options) {
        if (options.path == TeacherEndpoints.attendanceBatch) {
          throw connectionLost(options);
        }

        return MockReply(body: _rosterBody());
      });

      await screen.controller.load();
      await screen.controller.submit();

      final drainer = OutboxDrainer(
        database: screen.database,
        client: screen.client,
      );
      addTearDown(drainer.close);
      for (var i = 0; i < 12; i++) {
        await drainer.drain();
      }

      final row = (await screen.database.allOutbox()).single;
      expect(row.status, isNot(OutboxStatus.dead));
      expect(row.attempts, 0, reason: 'no attempt was spent on being offline');
    });
  });

  group('presentation', () {
    testWidgets('the summary reads as a register, not a list of rows',
        (tester) async {
      final screen = buildAttendance(rosterOnly());
      await pumpAttendance(
        tester,
        AttendanceScreen(controller: screen.controller),
      );

      expect(find.text('الجميع حاضرون'), findsOneWidget);

      await tester.tap(find.byKey(const Key('student-1')));
      await tester.pump();

      expect(find.byKey(const Key('count-absent')), findsOneWidget);
    });

    testWidgets('survives 200% text scale in both locales', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      for (final locale in <String>['ar', 'en']) {
        final screen = buildAttendance(rosterOnly());

        await tester.pumpWidget(MaterialApp(
          theme: AppTheme.light(),
          locale: Locale(locale),
          supportedLocales: AppLocales.supported,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Builder(
            builder: (context) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(2.0)),
              child: AppI18nScope(
                formats: AppFormats(locale: locale),
                child: AttendanceScreen(
                  key: ValueKey<String>(locale),
                  controller: screen.controller,
                ),
              ),
            ),
          ),
        ));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pump();

        expect(tester.takeException(), isNull, reason: locale);
      }
    });
  });
}
