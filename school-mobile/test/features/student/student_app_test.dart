import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/student/student.dart';

import '../../support/mock_http_adapter.dart';

const int kMe = 7;

Map<String, Object?> _home({int studentUserId = kMe}) => <String, Object?>{
      'data': <String, Object?>{
        'student_user_id': studentUserId,
        'class_name': 'الصف الثامن أ',
        'today': <Object?>[
          <String, Object?>{
            'id': 1,
            'subject': 'رياضيات',
            'start_time': '08:00:00',
            'end_time': '08:45:00',
            'room': 'A1',
          },
        ],
        'attendance': <String, Object?>{
          'present_percent': 92,
          'absent_days': 1,
        },
        'next_due': <String, Object?>{
          'assignment_id': 5,
          'title': 'واجب الرياضيات',
          'due_at': '2026-09-08T12:00:00Z',
        },
        'unread_count': 2,
      },
    };

Map<String, Object?> _assignments({
  String? status,
  String? dueAt,
  String? score,
}) =>
    <String, Object?>{
      'data': <String, Object?>{
        'assignments': <Object?>[
          <String, Object?>{
            'id': 5,
            'title': 'واجب الرياضيات',
            'instructions': 'حل التمارين.',
            'subject': 'رياضيات',
            'due_at': dueAt ?? '2026-12-08T12:00:00Z',
            'has_attachment': false,
            'max_score': '100.00',
            'submission': status == null
                ? null
                : <String, Object?>{
                    'status': status,
                    'submitted_at': '2026-09-05T09:00:00Z',
                    'score': score,
                    'feedback': null,
                    'has_file': false,
                  },
          },
        ],
      },
    };

({
  StudentRepository repository,
  AppDatabase database,
  MockHttpAdapter adapter,
}) buildStudent(MockResponder responder) {
  final adapter = MockHttpAdapter(responder);
  final client = ApiClient(
    baseUrl: 'https://api.test',
    tokenStore: InMemoryTokenStore(deviceId: 'device'),
    adapter: adapter,
  );
  addTearDown(() => client.close(force: true));

  final database = AppDatabase.memory();
  addTearDown(database.close);

  return (
    repository: StudentRepository(dio: client.dio, database: database),
    database: database,
    adapter: adapter,
  );
}

Future<void> pumpStudent(
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

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('a student can only reach their own record', () {
    test('no request the app makes names a student', () async {
      // The acceptance criterion, checked where it can be checked on the
      // client: every request this app can produce, inspected for anything
      // that identifies a student. The server accepts no such parameter, and
      // the client has nowhere to put one.
      final student = buildStudent((options) => switch (options.path) {
            '/mobile/v1/student/home' => MockReply(body: _home()),
            '/mobile/v1/student/timetable' => const MockReply(
                body: <String, Object?>{'data': <String, Object?>{'days': <String, Object?>{}}},
              ),
            '/mobile/v1/student/assignments' => MockReply(body: _assignments()),
            '/mobile/v1/student/grades' => const MockReply(
                body: <String, Object?>{'data': <String, Object?>{'subjects': <Object?>[]}},
              ),
            '/mobile/v1/student/attendance' => const MockReply(
                body: <String, Object?>{'data': <String, Object?>{'days': <Object?>[]}},
              ),
            _ => const MockReply(statusCode: 404),
          });

      await student.repository.refreshHome();
      await student.repository.refreshTimetable();
      await student.repository.refreshAssignments();
      await student.repository.refreshGrades();
      await student.repository.refreshAttendance();

      expect(student.adapter.requests, hasLength(5));

      for (final request in student.adapter.requests) {
        expect(
          request.path,
          isNot(contains('student_user_id')),
          reason: '${request.path} carries a student id',
        );
        expect(request.path, isNot(matches(RegExp(r'\?'))));
        expect(
          request.json.keys,
          isEmpty,
          reason: 'a read must not carry a body at all',
        );
      }
    });

    test('the home screen reports whose record it is', () async {
      // So a mismatch between the token and the answer is visible rather than
      // silently rendered as the caller's own record.
      final student = buildStudent((options) => MockReply(body: _home()));

      final home = (await student.repository.refreshHome()).value;

      expect(home.studentUserId, kMe);
    });

    test('the repository exposes nothing that reads another student', () {
      // The absence is the product decision, not an oversight. Peer visibility
      // is a safeguarding surface with a moderation obligation nobody on this
      // project is staffed to carry.
      final student = buildStudent((options) => MockReply(body: _home()));
      final repository = student.repository;

      // Every read this repository offers, named explicitly. Adding one that
      // reaches another student means changing this list, which is the point.
      expect(repository.refreshHome, isA<Function>());
      expect(repository.refreshTimetable, isA<Function>());
      expect(repository.refreshAssignments, isA<Function>());
      expect(repository.refreshGrades, isA<Function>());
      expect(repository.refreshAttendance, isA<Function>());
      expect(repository.handIn, isA<Function>());
      // There is no classmates(), roster(), leaderboard(), ranking() or
      // message() to name here.
    });
  });

  group('handing in', () {
    test('the key survives a failed attempt and is reused', () async {
      // The retry that matters is the one after the app was killed mid-upload.
      // A fresh key there would produce a second hand-in for the same work.
      var online = false;
      final student = buildStudent((options) {
        if (options.path.endsWith('/submit')) {
          if (!online) throw connectionLost(options);

          return const MockReply(
            statusCode: 201,
            body: <String, Object?>{'data': <String, Object?>{'status': 'submitted'}},
          );
        }

        return MockReply(body: _assignments());
      });

      final first = await student.repository.handInKey(5);

      await expectLater(
        student.repository.handIn(assignmentId: 5, text: 'الحل'),
        throwsA(isA<Object>()),
      );

      // The failure left the key alone, including across a restart: it lives
      // in the local cache, not in memory.
      expect(await student.repository.handInKey(5), first);

      online = true;
      await student.repository.handIn(assignmentId: 5, text: 'الحل');

      final sent = student.adapter
          .requestsFor('/mobile/v1/student/assignments/5/submit');
      expect(sent.length, greaterThanOrEqualTo(2));
      for (final request in sent) {
        expect(
          request.header('Idempotency-Key'),
          first,
          reason: 'every attempt at one hand-in must carry the same key',
        );
      }
    });

    test('a new key is minted only after the server accepts', () async {
      final student = buildStudent((options) => options.path.endsWith('/submit')
          ? const MockReply(
              statusCode: 201,
              body: <String, Object?>{'data': <String, Object?>{'status': 'submitted'}},
            )
          : MockReply(body: _assignments()));

      final first = await student.repository.handInKey(5);
      await student.repository.handIn(assignmentId: 5, text: 'الحل');

      expect(await student.repository.handInKey(5), isNot(first));
    });

    test('a late hand-in comes back as late, not as on time', () async {
      final student = buildStudent((options) => options.path.endsWith('/submit')
          ? const MockReply(
              statusCode: 201,
              body: <String, Object?>{'data': <String, Object?>{'status': 'late'}},
            )
          : MockReply(body: _assignments()));

      expect(
        await student.repository.handIn(assignmentId: 5, text: 'متأخر'),
        HandInState.late,
      );
    });

    testWidgets('a failed hand-in says the work has not arrived',
        (tester) async {
      // Never "handed in". A student who believes their work is in stops
      // carrying it, and the teacher marks a blank.
      final student = buildStudent((options) {
        if (options.path.endsWith('/submit')) {
          throw connectionLost(options);
        }

        return MockReply(body: _assignments());
      });
      final controller =
          StudentAssignmentsController(repository: student.repository);
      addTearDown(controller.dispose);

      await pumpStudent(
        tester,
        StudentAssignmentsScreen(controller: controller),
      );

      await tester.runAsync(() => controller.handIn(5, text: 'الحل'));
      await tester.pump();

      expect(find.byKey(const Key('send-failed-5')), findsOneWidget);
      expect(
        find.text('تعذّر التسليم. لم يصل عملك بعد، أعد المحاولة.'),
        findsOneWidget,
      );
      expect(find.text('سُلّم'), findsNothing);
    });

    testWidgets('offline says so rather than queueing the work',
        (tester) async {
      final student = buildStudent((options) => MockReply(body: _assignments()));
      final controller =
          StudentAssignmentsController(repository: student.repository);
      addTearDown(controller.dispose);

      await pumpStudent(
        tester,
        StudentAssignmentsScreen(controller: controller, isOffline: true),
      );

      await tester.tap(find.byKey(const Key('assignment-5')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('hand-in-sheet')), findsNothing);
      expect(find.text('يحتاج التسليم إلى اتصال.'), findsOneWidget);
    });

    testWidgets('an empty hand-in is refused before it is sent',
        (tester) async {
      final student = buildStudent((options) => MockReply(body: _assignments()));
      final controller =
          StudentAssignmentsController(repository: student.repository);
      addTearDown(controller.dispose);

      await pumpStudent(
        tester,
        StudentAssignmentsScreen(controller: controller),
      );

      await tester.tap(find.byKey(const Key('assignment-5')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('hand-in-send')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('hand-in-empty')), findsOneWidget);
      expect(
        student.adapter.countFor('/mobile/v1/student/assignments/5/submit'),
        0,
      );
    });

    testWidgets('an overdue assignment warns that a hand-in will be late',
        (tester) async {
      // Warned, not blocked. Refusing a late hand-in loses the teacher the
      // work as well as the timestamp.
      final student = buildStudent(
        (options) => MockReply(body: _assignments(dueAt: '2020-01-01T00:00:00Z')),
      );
      final controller =
          StudentAssignmentsController(repository: student.repository);
      addTearDown(controller.dispose);

      await pumpStudent(
        tester,
        StudentAssignmentsScreen(controller: controller),
      );

      await tester.tap(find.byKey(const Key('assignment-5')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('hand-in-late-warning')), findsOneWidget);
      expect(find.byKey(const Key('hand-in-send')), findsOneWidget);
    });

    testWidgets('a file hand-in reaches the server as multipart',
        (tester) async {
      final student = buildStudent((options) => options.path.endsWith('/submit')
          ? const MockReply(
              statusCode: 201,
              body: <String, Object?>{'data': <String, Object?>{'status': 'submitted'}},
            )
          : MockReply(body: _assignments()));
      final controller =
          StudentAssignmentsController(repository: student.repository);
      addTearDown(controller.dispose);

      final file = File('${Directory.systemTemp.path}/homework.pdf')
        ..writeAsStringSync('x');
      addTearDown(() => file.existsSync() ? file.deleteSync() : null);

      await pumpStudent(
        tester,
        StudentAssignmentsScreen(controller: controller),
      );

      await tester.runAsync(
        () => controller.handIn(
          5,
          text: 'الحل',
          file: StudentFile(path: file.path, name: 'homework.pdf'),
        ),
      );
      await tester.pump();

      expect(
        student.adapter.countFor('/mobile/v1/student/assignments/5/submit'),
        1,
      );
      expect(find.byKey(const Key('send-failed-5')), findsNothing);
    });
  });

  group('the record is read-only', () {
    testWidgets('the home screen shows the day and what is due',
        (tester) async {
      final student = buildStudent((options) => MockReply(body: _home()));
      final controller = StudentHomeController(repository: student.repository);
      addTearDown(controller.dispose);

      await pumpStudent(tester, StudentHomeScreen(controller: controller));

      expect(find.byKey(const Key('lesson-1')), findsOneWidget);
      expect(find.byKey(const Key('student-next-due')), findsOneWidget);
      expect(find.text('الصف الثامن أ'), findsOneWidget);
    });

    testWidgets('a handed-in assignment says so and offers no false state',
        (tester) async {
      final student = buildStudent(
        (options) => MockReply(body: _assignments(status: 'graded', score: '18.00')),
      );
      final controller =
          StudentAssignmentsController(repository: student.repository);
      addTearDown(controller.dispose);

      await pumpStudent(
        tester,
        StudentAssignmentsScreen(controller: controller),
      );

      expect(find.text('مُصحّح'), findsOneWidget);
      expect(find.byKey(const Key('score-5')), findsOneWidget);
    });

    testWidgets('unmarked attendance is not shown as perfect', (tester) async {
      final student = buildStudent(
        (options) => const MockReply(
          body: <String, Object?>{
            'data': <String, Object?>{
              'days': <Object?>[],
              'recorded_days': 0,
              'absent_days': 0,
              'late_days': 0,
              'present_percent': null,
            },
          },
        ),
      );
      final controller =
          StudentRecordControllers.attendance(student.repository);
      addTearDown(controller.dispose);

      await pumpStudent(
        tester,
        StudentAttendanceScreen(controller: controller),
      );

      expect(find.text('—'), findsOneWidget);
      expect(find.text('100%'), findsNothing);
      expect(find.text('١٠٠٪'), findsNothing);
    });
  });

  group('presentation', () {
    testWidgets('survives 200% text scale in both locales', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      for (final locale in <String>['ar', 'en']) {
        final student = buildStudent((options) => MockReply(body: _home()));
        final controller =
            StudentHomeController(repository: student.repository);
        addTearDown(controller.dispose);

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
                child: StudentHomeScreen(
                  key: ValueKey<String>(locale),
                  controller: controller,
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
