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

const String kPath = '/mobile/v1/teacher/gradebook/10/3';

Map<String, Object?> _sheet({
  String state = 'draft',
  bool editable = true,
  bool withGradebook = true,
  int items = 1,
  String? score = '18.50',
  int version = 1,
}) =>
    <String, Object?>{
      'data': <String, Object?>{
        'class_room_id': 10,
        'subject_id': 3,
        'gradebook': withGradebook
            ? <String, Object?>{
                'id': 7,
                'state': state,
                'editable': editable,
                'reopened_until': null,
              }
            : null,
        'components': <Object?>[
          for (var i = 1; i <= items; i++)
            <String, Object?>{
              'id': i,
              'name': 'اختبار $i',
              'type': 'quiz',
              'max_score': '20.00',
              'weight': '10.00',
            },
        ],
        'students': <Object?>[
          <String, Object?>{
            'student_user_id': 1,
            'name': 'ليان',
            'grades': score == null
                ? <Object?>[]
                : <Object?>[
                    <String, Object?>{
                      'grade_component_id': 1,
                      'score': score,
                      'version': version,
                    },
                  ],
          },
          <String, Object?>{
            'student_user_id': 2,
            'name': 'سامي',
            'grades': <Object?>[],
          },
        ],
      },
    };

({
  GradeEntryController controller,
  TeacherRepository repository,
  AppDatabase database,
  ApiClient client,
  MockHttpAdapter adapter,
}) buildGrades(MockResponder responder) {
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
  final controller = GradeEntryController(
    repository: repository,
    classRoomId: 10,
    subjectId: 3,
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

MockResponder sheetOnly({Map<String, Object?>? body}) =>
    (options) => options.path == kPath
        ? MockReply(body: body ?? _sheet())
        : const MockReply(statusCode: 404);

Future<void> pumpGrades(
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
  await tester.pump(const Duration(seconds: 1));
  await tester.pump();
}

GradeEntryView viewOf(GradeEntryController controller) =>
    (controller.state as ScreenData<GradeEntryView>).value;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('the workflow state is on screen, not discovered at submission', () {
    test('a finalized sheet refuses entry', () async {
      final grades = buildGrades(
        sheetOnly(body: _sheet(state: 'finalized', editable: false)),
      );

      await grades.controller.load();
      grades.controller.enter(2, '15');

      expect(await grades.controller.submit(), isFalse);
      expect(await grades.database.allOutbox(), isEmpty);
    });

    testWidgets('a locked sheet says which state it is in', (tester) async {
      final grades = buildGrades(
        sheetOnly(body: _sheet(state: 'submitted', editable: false)),
      );

      await pumpGrades(tester, GradeEntryScreen(controller: grades.controller));

      expect(find.text('مُرسل للاعتماد'), findsOneWidget);
      expect(find.byKey(const Key('gradebook-locked')), findsOneWidget);
      expect(find.byKey(const Key('grades-submit')), findsNothing);
    });

    testWidgets('a locked sheet does not offer editable fields', (tester) async {
      final grades = buildGrades(
        sheetOnly(body: _sheet(state: 'approved', editable: false)),
      );

      await pumpGrades(tester, GradeEntryScreen(controller: grades.controller));

      final field = tester.widget<TextField>(find.byKey(const Key('score-1')));
      expect(field.enabled, isFalse);
    });

    testWidgets('a reopened sheet the server calls editable is editable',
        (tester) async {
      // The client never works the window out for itself: the reopen deadline
      // is a timestamp, and a phone clock a day out would offer an editable
      // sheet the server refuses.
      final grades = buildGrades(
        sheetOnly(body: _sheet(state: 'reopened')),
      );

      await pumpGrades(tester, GradeEntryScreen(controller: grades.controller));

      expect(find.text('مفتوح مؤقتًا'), findsOneWidget);
      final field = tester.widget<TextField>(find.byKey(const Key('score-1')));
      expect(field.enabled, isTrue);
    });

    testWidgets('no gradebook at all is said plainly', (tester) async {
      final grades = buildGrades(
        sheetOnly(body: _sheet(withGradebook: false)),
      );

      await pumpGrades(tester, GradeEntryScreen(controller: grades.controller));

      expect(find.byKey(const Key('gradebook-missing')), findsOneWidget);
      expect(find.byKey(const Key('grades-submit')), findsNothing);
    });
  });

  group('entry', () {
    test('the version read with each mark is sent back with it', () async {
      // Without it, a phone offline since Tuesday overwrites a correction made
      // on Wednesday and nobody is told.
      final grades = buildGrades(sheetOnly(body: _sheet(version: 4)));
      await grades.controller.load();

      grades.controller.enter(1, '19');
      await grades.controller.submit();

      final payload = jsonDecode(
        (await grades.database.allOutbox()).single.payloadJson,
      ) as Map<String, Object?>;
      final rows = (payload['grades']! as List<Object?>)
          .cast<Map<String, Object?>>();
      final lian = rows.firstWhere((r) => r['student_user_id'] == 1);

      expect(lian['version'], 4);
      expect(lian['score'], 19);
    });

    test('a blank cell is not sent as a zero', () async {
      // A mark not yet given is not a mark of nought.
      final grades = buildGrades(sheetOnly(body: _sheet(score: null)));
      await grades.controller.load();

      grades.controller.enter(1, '19');

      expect(await grades.controller.submit(), isTrue);

      final payload = jsonDecode(
        (await grades.database.allOutbox()).single.payloadJson,
      ) as Map<String, Object?>;

      expect(payload['grades'], hasLength(1));
    });

    test('a mark above the maximum is refused before it is queued', () async {
      final grades = buildGrades(sheetOnly());
      await grades.controller.load();

      grades.controller.enter(2, '25');

      expect(grades.controller.invalidEntries(), <int>[2]);
      expect(await grades.controller.submit(), isFalse);
      expect(await grades.database.allOutbox(), isEmpty);
    });

    testWidgets('an invalid entry is called out beside the cell',
        (tester) async {
      final grades = buildGrades(sheetOnly());
      await pumpGrades(tester, GradeEntryScreen(controller: grades.controller));

      await tester.enterText(find.byKey(const Key('score-2')), '25');
      // Settled: the Scaffold animates the button out, and the controller
      // refuses a submission during that animation anyway.
      await tester.pumpAndSettle();

      expect(find.text('درجة غير صالحة'), findsOneWidget);
      expect(find.byKey(const Key('grades-submit')), findsNothing);
    });

    testWidgets('each assessment is marked on its own', (tester) async {
      final grades = buildGrades(sheetOnly(body: _sheet(items: 2)));
      await pumpGrades(tester, GradeEntryScreen(controller: grades.controller));

      expect(find.byKey(const Key('item-1')), findsOneWidget);
      expect(find.byKey(const Key('item-2')), findsOneWidget);

      await tester.tap(find.byKey(const Key('item-2')));
      await tester.pumpAndSettle();

      expect(viewOf(grades.controller).draft!.gradeItemId, 2);
    });
  });

  group('a queued mark is never shown as saved', () {
    test('the queue, not a local flag, decides', () async {
      final grades = buildGrades(sheetOnly());
      await grades.controller.load();
      grades.controller.enter(2, '15');
      await grades.controller.submit();

      expect(await grades.repository.queuedGradeItems(10, 3), <int>{1});
    });

    testWidgets('the row says waiting to send', (tester) async {
      final grades = buildGrades(sheetOnly());
      await pumpGrades(tester, GradeEntryScreen(controller: grades.controller));

      await tester.enterText(find.byKey(const Key('score-2')), '15');
      await tester.pump();
      await tester.tap(find.byKey(const Key('grades-submit')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('queued-1')), findsOneWidget);
      expect(find.text('حُفظت على هذا الجهاز، وستصل المدرسة عند توفّر الاتصال.'),
          findsOneWidget);
    });

    test('a drained batch stops being queued', () async {
      final grades = buildGrades(sheetOnly());
      await grades.controller.load();
      grades.controller.enter(2, '15');
      await grades.controller.submit();

      final row = (await grades.database.allOutbox()).single;
      await grades.database.markSucceeded(row.id);

      expect(await grades.repository.queuedGradeItems(10, 3), isEmpty);
    });
  });

  group('a conflict is explained, never silent', () {
    test('the server wins: the queued row dies rather than being replayed',
        () async {
      final grades = buildGrades((options) =>
          options.path == TeacherEndpoints.gradesBatch
              ? const MockReply(statusCode: 409)
              : MockReply(body: _sheet()));

      await grades.controller.load();
      grades.controller.enter(2, '15');
      await grades.controller.submit();

      final drainer = OutboxDrainer(
        database: grades.database,
        client: grades.client,
      );
      addTearDown(drainer.close);
      await drainer.drain();
      await drainer.drain();

      final row = (await grades.database.allOutbox()).single;
      expect(row.status, OutboxStatus.dead);
      expect(
        grades.adapter.requestsFor(TeacherEndpoints.gradesBatch),
        hasLength(1),
        reason: 'a conflict is not retried; the server copy stands',
      );
    });

    test('the conflict is announced, not swallowed', () async {
      final grades = buildGrades((options) =>
          options.path == TeacherEndpoints.gradesBatch
              ? const MockReply(statusCode: 409)
              : MockReply(body: _sheet()));

      await grades.controller.load();
      grades.controller.enter(2, '15');
      await grades.controller.submit();

      final drainer = OutboxDrainer(
        database: grades.database,
        client: grades.client,
      );
      addTearDown(drainer.close);

      final events = <SyncEvent>[];
      final subscription = drainer.events.listen(events.add);
      addTearDown(subscription.cancel);

      await drainer.drain();
      await Future<void>.delayed(Duration.zero);

      expect(events.whereType<OutboxConflict>(), hasLength(1));
    });

    testWidgets('the teacher sees which marks were refused', (tester) async {
      // Never silent data loss: the refused values are the teacher's own
      // input on the teacher's own device, and showing them is what lets the
      // marks be entered again.
      final grades = buildGrades(sheetOnly());
      await pumpGrades(tester, GradeEntryScreen(controller: grades.controller));

      await tester.enterText(find.byKey(const Key('score-2')), '15');
      await tester.pump();
      await tester.tap(find.byKey(const Key('grades-submit')));
      await tester.pumpAndSettle();

      final rows = await tester.runAsync(grades.database.allOutbox);
      final rowId = rows!.single.id;
      await tester.runAsync(
        () => grades.database.markDead(rowId, reason: 'HTTP 409'),
      );
      await tester.runAsync(grades.controller.load);
      await tester.pumpAndSettle();

      expect(find.byKey(Key('grades-rejected-$rowId')), findsOneWidget);
      expect(find.text('رُفضت الدرجات: تغيّرت على الخادم'), findsOneWidget);
      expect(
        find.byKey(Key('rejected-grade-$rowId-2')),
        findsOneWidget,
        reason: 'the marks that were refused have to be readable',
      );
    });

    testWidgets('a plain refusal is not dressed up as a conflict',
        (tester) async {
      final grades = buildGrades(sheetOnly());
      await pumpGrades(tester, GradeEntryScreen(controller: grades.controller));

      await tester.enterText(find.byKey(const Key('score-2')), '15');
      await tester.pump();
      await tester.tap(find.byKey(const Key('grades-submit')));
      await tester.pumpAndSettle();

      final rows = await tester.runAsync(grades.database.allOutbox);
      await tester.runAsync(
        () => grades.database.markDead(rows!.single.id, reason: 'HTTP 422'),
      );
      await tester.runAsync(grades.controller.load);
      await tester.pumpAndSettle();

      expect(find.text('رُفضت الدرجات'), findsOneWidget);
      expect(find.text('رُفضت الدرجات: تغيّرت على الخادم'), findsNothing);
    });
  });

  group('offline', () {
    test('a column is entered and queued with no network', () async {
      var online = true;
      final grades = buildGrades((options) {
        if (!online) throw connectionLost(options);

        return MockReply(body: _sheet());
      });

      await grades.controller.load();
      online = false;

      grades.controller.enter(2, '15');

      expect(await grades.controller.submit(), isTrue);
      expect(await grades.database.allOutbox(), hasLength(1));
      expect(
        grades.adapter.requestsFor(TeacherEndpoints.gradesBatch),
        isEmpty,
      );
    });

    test('a cold start with nothing cached and no network is an error',
        () async {
      final grades = buildGrades((options) => throw connectionLost(options));

      await grades.controller.load();

      expect(grades.controller.state, isA<ScreenError<GradeEntryView>>());
    });
  });

  group('presentation', () {
    testWidgets('survives 200% text scale in both locales', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      for (final locale in <String>['ar', 'en']) {
        final grades = buildGrades(sheetOnly());

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
                child: GradeEntryScreen(
                  key: ValueKey<String>(locale),
                  controller: grades.controller,
                ),
              ),
            ),
          ),
        ));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pump(const Duration(seconds: 1));
        await tester.pump();

        expect(tester.takeException(), isNull, reason: locale);
      }
    });
  });
}
