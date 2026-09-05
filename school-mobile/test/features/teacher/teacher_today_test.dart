import 'dart:convert';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/db/tables.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/teacher/teacher.dart';
import 'package:school_mobile/shared/shared.dart';

import '../../support/mock_http_adapter.dart';

const String kDate = '2026-09-05';

Map<String, Object?> _window({bool open = true, String? reason}) =>
    <String, Object?>{
      'open': open,
      'hours': 48,
      'closes_at': '2026-09-07T23:59:59+00:00',
      'reason': reason,
    };

Map<String, Object?> _period({
  int id = 1,
  int classRoomId = 10,
  bool attendanceTaken = false,
}) =>
    <String, Object?>{
      'id': id,
      'class_room_id': classRoomId,
      'class_name': 'الصف السابع أ',
      'subject_id': 3,
      'subject': 'رياضيات',
      'start_time': '08:00:00',
      'end_time': '08:45:00',
      'room': 'A1',
      'attendance_taken': attendanceTaken,
    };

Map<String, Object?> _day({
  List<Object?>? periods,
  List<Object?>? classes,
  bool windowOpen = true,
  String? windowReason,
}) =>
    <String, Object?>{
      'data': <String, Object?>{
        'date': kDate,
        'attendance_window': _window(open: windowOpen, reason: windowReason),
        'periods': periods ?? <Object?>[_period()],
        'classes': classes ??
            <Object?>[
              <String, Object?>{
                'id': 10,
                'name': 'الصف السابع أ',
                'grade': '7',
                'section': 'أ',
                'is_homeroom': true,
                'student_count': 28,
              },
            ],
      },
    };

({
  TeacherDayController controller,
  TeacherRepository repository,
  AppDatabase database,
  MockHttpAdapter adapter,
}) buildDay(MockResponder responder) {
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
  final controller = TeacherDayController(
    repository: repository,
    today: DateTime.parse(kDate),
  );
  addTearDown(controller.dispose);

  return (
    controller: controller,
    repository: repository,
    database: database,
    adapter: adapter,
  );
}

MockResponder happyPath({Map<String, Object?>? day}) =>
    (options) => options.path == '/mobile/v1/teacher/today'
        ? MockReply(body: day ?? _day())
        : const MockReply(statusCode: 404);

Future<void> queueAttendance(
  AppDatabase database, {
  int classRoomId = 10,
  String date = kDate,
  String key = 'queued-1',
  OutboxStatus status = OutboxStatus.pending,
}) async {
  final row = await database.enqueue(
    endpoint: TeacherEndpoints.attendanceBatch,
    method: 'POST',
    payloadJson: jsonEncode(<String, Object?>{
      'class_room_id': classRoomId,
      'date': date,
      'records': <Object?>[],
    }),
    idempotencyKey: key,
  );

  if (status == OutboxStatus.dead) {
    await database.markDead(row.id, reason: 'rejected');
  } else if (status == OutboxStatus.succeeded) {
    await database.markSucceeded(row.id);
  }
}

Future<void> pumpScreen(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(MaterialApp(
    theme: AppTheme.light(),
    locale: const Locale('ar'),
    supportedLocales: AppLocales.supported,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: AppI18nScope(
      formats: const AppFormats(locale: 'ar'),
      child: child,
    ),
  ));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump();
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('pending state comes from the outbox', () {
    test('a queued batch marks the period pending, not taken', () async {
      // The acceptance criterion for this order: pending tasks reflect the
      // actual queue. A screen-local flag would be wrong after a restart.
      final day = buildDay(happyPath());
      await queueAttendance(day.database);

      await day.controller.load();

      final state = day.controller.state as ScreenData<TeacherDayView>;
      expect(
        state.value.progressOf(state.value.day.periods.first),
        AttendanceProgress.queued,
      );
    });

    test('a drained batch stops being pending without a refetch', () async {
      final day = buildDay(happyPath());
      await queueAttendance(day.database);
      await day.controller.load();

      // The drain succeeded while the screen was open.
      final row = (await day.database.allOutbox()).single;
      await day.database.markSucceeded(row.id);
      await day.controller.refreshPending();

      final state = day.controller.state as ScreenData<TeacherDayView>;
      expect(
        state.value.progressOf(state.value.day.periods.first),
        AttendanceProgress.outstanding,
        reason: 'the server has not confirmed it yet either',
      );
    });

    test('a rejected batch is counted apart from work still in flight', () async {
      // Rolling the two together is how a rejected roll call disappears.
      final day = buildDay(happyPath());
      await queueAttendance(day.database, key: 'dead-1', status: OutboxStatus.dead);

      await day.controller.load();

      final state = day.controller.state as ScreenData<TeacherDayView>;
      expect(state.value.rejectedCount, 1);
      expect(state.value.queuedClassIds, isEmpty);
      expect(
        state.value.progressOf(state.value.day.periods.first),
        AttendanceProgress.outstanding,
      );
    });

    test('a batch queued for another day does not mark today', () async {
      final day = buildDay(happyPath());
      await queueAttendance(day.database, date: '2026-09-04');

      await day.controller.load();

      final state = day.controller.state as ScreenData<TeacherDayView>;
      expect(state.value.queuedClassIds, isEmpty);
    });

    test('a queue row that is not attendance is ignored', () async {
      final day = buildDay(happyPath());
      await day.database.enqueue(
        endpoint: TeacherEndpoints.gradesBatch,
        method: 'POST',
        payloadJson: jsonEncode(<String, Object?>{
          'class_room_id': 10,
          'date': kDate,
        }),
        idempotencyKey: 'grades-1',
      );

      await day.controller.load();

      final state = day.controller.state as ScreenData<TeacherDayView>;
      expect(state.value.queuedClassIds, isEmpty);
    });
  });

  group('offline', () {
    test('renders from cache when the network is gone', () async {
      // Acceptance: renders from cache offline.
      var online = true;
      final day = buildDay((options) {
        if (!online) throw connectionLost(options);

        return MockReply(body: _day());
      });

      await day.controller.load();
      expect(day.controller.state, isA<ScreenData<TeacherDayView>>());

      online = false;
      await day.controller.refresh();

      final state = day.controller.state;
      expect(state, isA<ScreenData<TeacherDayView>>());
      expect(
        (state as ScreenData<TeacherDayView>).value.day.periods,
        hasLength(1),
      );
    });

    test('a cold start with nothing cached and no network is an error, not a lie',
        () async {
      final day = buildDay((options) => throw connectionLost(options));

      await day.controller.load();

      expect(day.controller.state, isA<ScreenError<TeacherDayView>>());
    });

    test('a failed refresh still re-reads the queue', () async {
      var online = true;
      final day = buildDay((options) {
        if (!online) throw connectionLost(options);

        return MockReply(body: _day());
      });

      await day.controller.load();
      online = false;
      await queueAttendance(day.database);
      await day.controller.refresh();

      final state = day.controller.state as ScreenData<TeacherDayView>;
      expect(state.value.queuedClassIds, contains(10));
    });
  });

  group('presentation', () {
    testWidgets('a queued period says waiting, never received', (tester) async {
      final day = buildDay(happyPath());
      await queueAttendance(day.database);

      await pumpScreen(tester, TeacherTodayScreen(controller: day.controller));

      expect(find.text('بانتظار الإرسال'), findsOneWidget);
      expect(find.text('وصل المدرسة'), findsNothing);
    });

    testWidgets('a submitted period says so', (tester) async {
      final day = buildDay(happyPath(
        day: _day(periods: <Object?>[_period(attendanceTaken: true)]),
      ));

      await pumpScreen(tester, TeacherTodayScreen(controller: day.controller));

      expect(find.text('وصل المدرسة'), findsOneWidget);
    });

    testWidgets('a closed window is explained in the server\'s own words',
        (tester) async {
      final day = buildDay(happyPath(
        day: _day(windowOpen: false, windowReason: 'انتهت مهلة ٤٨ ساعة.'),
      ));

      await pumpScreen(tester, TeacherTodayScreen(controller: day.controller));

      expect(find.byKey(const Key('attendance-window-closed')), findsOneWidget);
      expect(find.text('انتهت مهلة ٤٨ ساعة.'), findsOneWidget);
    });

    testWidgets('a rejected batch is visible on the screen', (tester) async {
      final day = buildDay(happyPath());
      await queueAttendance(day.database, key: 'dead-1', status: OutboxStatus.dead);

      await pumpScreen(tester, TeacherTodayScreen(controller: day.controller));

      expect(find.byKey(const Key('attendance-rejected-notice')), findsOneWidget);
    });

    testWidgets('the class list shows size and homeroom', (tester) async {
      final day = buildDay(happyPath());

      await pumpScreen(tester, TeacherClassesScreen(controller: day.controller));

      expect(find.byKey(const Key('class-10')), findsOneWidget);
      expect(find.text('مربّي الصف'), findsOneWidget);
    });

    testWidgets('survives 200% text scale in both locales', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      for (final locale in <String>['ar', 'en']) {
        final day = buildDay(happyPath());

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
                child: TeacherTodayScreen(
                  key: ValueKey<String>(locale),
                  controller: day.controller,
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
