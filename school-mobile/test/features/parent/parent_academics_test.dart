import 'dart:convert';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/parent/parent.dart';
import 'package:school_mobile/shared/shared.dart';

import '../../support/mock_http_adapter.dart';

/// A fixed month so the calendar renders the same on every run.
final DateTime month = DateTime(2026, 9);

String _day(int day) => '2026-09-${day.toString().padLeft(2, '0')}';

Map<String, Object?> _attendance({
  List<Object?>? days,
  int? presentPercent = 75,
}) =>
    <String, Object?>{
      'data': <String, Object?>{
        'student_user_id': 1,
        'recorded_days': 4,
        'absent_days': 1,
        'late_days': 1,
        'present_percent': presentPercent,
        'days': days ??
            <Object?>[
              <String, Object?>{
                'id': 101,
                'date': _day(1),
                'status': 'present',
                'explainable': false,
              },
              <String, Object?>{
                'id': 102,
                'date': _day(2),
                'status': 'absent',
                'explainable': true,
                'note': 'Not in registration',
              },
              <String, Object?>{
                'id': 103,
                'date': _day(3),
                'status': 'late',
                'explainable': true,
              },
              <String, Object?>{
                'id': 104,
                'date': _day(4),
                'status': 'excused',
                'explainable': false,
              },
            ],
      },
    };

Map<String, Object?> _grades({List<Object?>? subjects}) => <String, Object?>{
      'data': <String, Object?>{
        'student_user_id': 1,
        'subjects': subjects ??
            <Object?>[
              <String, Object?>{
                'subject_id': 5,
                'subject': 'الرياضيات',
                'percent': 88,
                'components': <Object?>[
                  <String, Object?>{
                    'id': 1,
                    'name': 'اختبار قصير',
                    'score': '88.00',
                    'max_score': '100.00',
                    'period': 'الفصل الأول',
                  },
                ],
              },
            ],
      },
    };

Map<String, Object?> _reportCards({List<Object?>? cards}) => <String, Object?>{
      'data': <String, Object?>{
        'student_user_id': 1,
        'report_cards': cards ?? <Object?>[],
      },
    };

({
  ParentAcademicsController controller,
  ParentAcademicsRepository repository,
  AppDatabase database,
  MockHttpAdapter adapter,
}) buildAcademics(MockResponder responder) {
  final adapter = MockHttpAdapter(responder);
  final client = ApiClient(
    baseUrl: 'https://api.test',
    tokenStore: InMemoryTokenStore(deviceId: 'device'),
    adapter: adapter,
  );
  addTearDown(() => client.close(force: true));

  final database = AppDatabase.memory();
  addTearDown(database.close);

  final repository =
      ParentAcademicsRepository(dio: client.dio, database: database);
  final controller = ParentAcademicsController(
    repository: repository,
    studentUserId: 1,
    month: month,
  );
  addTearDown(controller.dispose);

  return (
    controller: controller,
    repository: repository,
    database: database,
    adapter: adapter,
  );
}

MockResponder happyPath({
  Map<String, Object?>? attendance,
  Map<String, Object?>? grades,
  Map<String, Object?>? reportCards,
}) =>
    (options) => switch (options.path) {
          '/mobile/v1/parent/children/1/attendance' =>
            MockReply(body: attendance ?? _attendance()),
          '/mobile/v1/parent/children/1/grades' =>
            MockReply(body: grades ?? _grades()),
          '/mobile/v1/parent/children/1/report-cards' =>
            MockReply(body: reportCards ?? _reportCards()),
          '/mobile/v1/parent/attendance/102/explain' =>
            const MockReply(statusCode: 201, body: <String, Object?>{
              'data': <String, Object?>{'id': 1, 'reason': 'حرارة'},
            }),
          _ => const MockReply(statusCode: 404),
        };

Future<void> pumpAcademics(
  WidgetTester tester,
  ParentAcademicsController controller, {
  String locale = 'ar',
  Key? key,
}) async {
  await tester.pumpWidget(MaterialApp(
    theme: AppTheme.light(),
    locale: Locale(locale),
    supportedLocales: AppLocales.supported,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: AppI18nScope(
      formats: AppFormats(locale: locale),
      child: ParentAcademicsScreen(key: key, controller: controller),
    ),
  ));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump();
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('reading the payload', () {
    test('an unknown attendance status is not treated as present', () {
      // Silently colouring an unrecognised status as present is how a new
      // server value becomes an attendance record nobody questions.
      final attendance = ChildAttendance.fromJson(_attendance(days: <Object?>[
        <String, Object?>{
          'id': 1,
          'date': _day(1),
          'status': 'suspended',
          'explainable': false,
        },
      ]));

      expect(attendance.days.single.status, AttendanceStatus.unknown);
    });

    test('an unmarked window is null, not perfect', () {
      final attendance =
          ChildAttendance.fromJson(_attendance(presentPercent: null));

      expect(attendance.presentPercent, isNull);
    });

    test('an unreadable day is skipped rather than failing the screen', () {
      final attendance = ChildAttendance.fromJson(_attendance(days: <Object?>[
        <String, Object?>{
          'id': 1,
          'date': _day(1),
          'status': 'present',
          'explainable': false,
        },
        <String, Object?>{'status': 'absent'},
        'not an object',
      ]));

      expect(attendance.days, hasLength(1));
    });

    test('there is no unissued form of a report card', () {
      // The client cannot represent one, which is what makes it unreachable
      // rather than merely hidden.
      final cards = IssuedReportCard.listFrom(_reportCards(cards: <Object?>[
        <String, Object?>{
          'id': 7,
          'version': 2,
          'period': 'الفصل الأول',
          'issued_at': '2026-09-01T10:00:00Z',
        },
      ]));

      expect(cards.single.version, 2);
      expect(cards.single.id, 7);
    });
  });

  group('cache first', () {
    test('renders from cache before the network is consulted', () async {
      final academics = buildAcademics((options) async => MockReply(
            body: switch (options.path) {
              '/mobile/v1/parent/children/1/attendance' => _attendance(),
              '/mobile/v1/parent/children/1/grades' => _grades(),
              _ => _reportCards(),
            },
            delay: const Duration(seconds: 1),
          ));

      await academics.database.upsertCache(
        entityType: ParentAcademicsRepository.entityType,
        entityId: '1',
        payloadJson: jsonEncode(<String, Object?>{
          'attendance': _attendance(),
          'grades': _grades(),
          'report_cards': _reportCards(),
        }),
      );

      final loading = academics.controller.load();
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(academics.controller.state, isA<ScreenData<ChildAcademics>>());
      expect(academics.controller.isShowingCache, isTrue);

      await loading;
      expect(academics.controller.isShowingCache, isFalse);
    });

    test('a failed refresh never overwrites the last good copy', () async {
      final academics = buildAcademics((options) => const MockReply(statusCode: 500));

      await academics.database.upsertCache(
        entityType: ParentAcademicsRepository.entityType,
        entityId: '1',
        payloadJson: jsonEncode(<String, Object?>{
          'attendance': _attendance(),
          'grades': _grades(),
          'report_cards': _reportCards(),
        }),
      );

      await academics.controller.load();

      final row = await academics.database.readCache(
        ParentAcademicsRepository.entityType,
        '1',
      );
      expect(row, isNotNull);
      expect(academics.controller.state, isA<ScreenData<ChildAcademics>>());
    });

    test('the three calls are cached as one screen, not three', () async {
      // Caching them apart would let a fresh attendance month render beside
      // last week's marks.
      final academics = buildAcademics(happyPath());

      await academics.controller.load();

      final row = await academics.database.readCache(
        ParentAcademicsRepository.entityType,
        '1',
      );
      final decoded = jsonDecode(row!.payloadJson) as Map<String, Object?>;
      expect(decoded.keys, containsAll(<String>['attendance', 'grades', 'report_cards']));
    });
  });

  group('the attendance calendar', () {
    testWidgets('draws the month with a cell per day', (tester) async {
      final academics = buildAcademics(happyPath());
      await pumpAcademics(tester, academics.controller);

      expect(find.byKey(const Key('attendance-calendar')), findsOneWidget);
    });

    testWidgets('an absence opens its detail, including the school note',
        (tester) async {
      final academics = buildAcademics(happyPath());
      await pumpAcademics(tester, academics.controller);

      await tester.tap(find.byKey(const Key('day-2026-9-2')));
      await tester.pumpAndSettle();

      expect(find.text('غائب'), findsWidgets);
      expect(find.text('Not in registration'), findsOneWidget);
      expect(find.byKey(const Key('explain-102')), findsOneWidget);
    });

    testWidgets('a present day offers no explain action', (tester) async {
      final academics = buildAcademics(happyPath());
      await pumpAcademics(tester, academics.controller);

      await tester.tap(find.byKey(const Key('day-2026-9-1')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('explain-101')), findsNothing);
    });

    testWidgets('explaining an absence sends it and says so', (tester) async {
      final academics = buildAcademics(happyPath());
      await pumpAcademics(tester, academics.controller);

      await tester.tap(find.byKey(const Key('day-2026-9-2')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('explain-102')));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key('explain-reason')), 'حرارة مرتفعة');
      await tester.tap(find.byKey(const Key('explain-submit')));
      await tester.pumpAndSettle();

      expect(
        academics.adapter.countFor('/mobile/v1/parent/attendance/102/explain'),
        1,
      );
      expect(find.byKey(const Key('academics-notice')), findsOneWidget);
    });

    testWidgets('an empty reason is refused before anything is sent',
        (tester) async {
      final academics = buildAcademics(happyPath());
      await pumpAcademics(tester, academics.controller);

      await tester.tap(find.byKey(const Key('day-2026-9-2')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('explain-102')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('explain-submit')));
      await tester.pumpAndSettle();

      expect(find.text('اكتب سبب الغياب.'), findsOneWidget);
      expect(
        academics.adapter.countFor('/mobile/v1/parent/attendance/102/explain'),
        0,
      );
    });

    test('an explanation reuses its key across retries', () async {
      final sentKeys = <String>[];
      var down = true;

      final academics = buildAcademics((options) {
        if (options.path == '/mobile/v1/parent/attendance/102/explain') {
          sentKeys.add('${options.headers['Idempotency-Key']}');
          if (down) throw connectionLost(options);

          return const MockReply(statusCode: 201, body: <String, Object?>{
            'data': <String, Object?>{'id': 1},
          });
        }

        return switch (options.path) {
          '/mobile/v1/parent/children/1/attendance' => MockReply(body: _attendance()),
          '/mobile/v1/parent/children/1/grades' => MockReply(body: _grades()),
          _ => MockReply(body: _reportCards()),
        };
      });

      await expectLater(
        academics.repository.explainAbsence(102, 'حرارة'),
        throwsA(isA<ApiError>()),
      );

      down = false;
      await academics.repository.explainAbsence(102, 'حرارة');

      expect(sentKeys.length, greaterThan(1));
      expect(sentKeys.toSet(), hasLength(1));
    });
  });

  group('grades and report cards', () {
    testWidgets('published marks are shown with their subject breakdown',
        (tester) async {
      final academics = buildAcademics(happyPath());
      await pumpAcademics(tester, academics.controller);

      // The list is lazy; the grades section is below the calendar.
      await tester.dragUntilVisible(
        find.byKey(const Key('subject-الرياضيات')),
        find.byKey(const Key('academics-list')),
        const Offset(0, -200),
      );

      expect(find.byKey(const Key('subject-الرياضيات')), findsOneWidget);
      expect(find.textContaining('88.00'), findsOneWidget);
    });

    testWidgets('no published marks says so rather than showing nothing',
        (tester) async {
      final academics = buildAcademics(
        happyPath(grades: _grades(subjects: <Object?>[])),
      );
      await pumpAcademics(tester, academics.controller);

      await tester.dragUntilVisible(
        find.text('لا توجد درجات منشورة بعد.'),
        find.byKey(const Key('academics-list')),
        const Offset(0, -200),
      );
      expect(find.text('لا توجد درجات منشورة بعد.'), findsOneWidget);
    });

    testWidgets('with nothing issued there is no report card to open',
        (tester) async {
      final academics = buildAcademics(happyPath());
      await pumpAcademics(tester, academics.controller);

      await tester.dragUntilVisible(
        find.text('لا توجد شهادات صادرة بعد.'),
        find.byKey(const Key('academics-list')),
        const Offset(0, -200),
      );
      expect(find.text('لا توجد شهادات صادرة بعد.'), findsOneWidget);
      expect(find.byKey(const Key('open-report-card-7')), findsNothing);
    });

    testWidgets('an issued report card is offered for download',
        (tester) async {
      final academics = buildAcademics(happyPath(
        reportCards: _reportCards(cards: <Object?>[
          <String, Object?>{
            'id': 7,
            'version': 1,
            'period': 'الفصل الأول',
            'issued_at': '2026-09-01T10:00:00Z',
          },
        ]),
      ));
      await pumpAcademics(tester, academics.controller);

      await tester.dragUntilVisible(
        find.byKey(const Key('report-card-7')),
        find.byKey(const Key('academics-list')),
        const Offset(0, -200),
      );
      expect(find.byKey(const Key('report-card-7')), findsOneWidget);
      expect(find.byKey(const Key('open-report-card-7')), findsOneWidget);
    });
  });

  group('presentation', () {
    testWidgets('a cached screen is labelled stale, a live one is not',
        (tester) async {
      final cached = buildAcademics((options) async => MockReply(
            body: switch (options.path) {
              '/mobile/v1/parent/children/1/attendance' => _attendance(),
              '/mobile/v1/parent/children/1/grades' => _grades(),
              _ => _reportCards(),
            },
            // Long enough to still be in flight when the assertion runs,
            // short enough to finish before the test ends.
            delay: const Duration(milliseconds: 400),
          ));
      await cached.database.upsertCache(
        entityType: ParentAcademicsRepository.entityType,
        entityId: '1',
        payloadJson: jsonEncode(<String, Object?>{
          'attendance': _attendance(),
          'grades': _grades(),
          'report_cards': _reportCards(),
        }),
      );

      // The cache read is a real database call, so it needs real time to
      // finish; the network call behind it is deliberately still in flight.
      await tester.runAsync(() => cached.controller.load().timeout(
            const Duration(milliseconds: 150),
            onTimeout: () {},
          ));

      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.light(),
        locale: const Locale('ar'),
        supportedLocales: AppLocales.supported,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: AppI18nScope(
          formats: const AppFormats(locale: 'ar'),
          child: ParentAcademicsScreen(controller: cached.controller),
        ),
      ));
      await tester.pump();

      expect(cached.controller.isShowingCache, isTrue);
      expect(find.byKey(const Key('staleness-label')), findsOneWidget);

      // The screen's own initState started a second request. Let both the
      // real one and the fake-clock one finish, so no timer outlives the test.
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 500)),
      );
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
    });

    testWidgets('survives 200% text scale in both locales', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      for (final locale in <String>['ar', 'en']) {
        final academics = buildAcademics(happyPath(
          reportCards: _reportCards(cards: <Object?>[
            <String, Object?>{
              'id': 7,
              'version': 1,
              'period': 'الفصل الأول',
              'issued_at': '2026-09-01T10:00:00Z',
            },
          ]),
        ));

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
                child: ParentAcademicsScreen(
                  key: ValueKey<String>(locale),
                  controller: academics.controller,
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
