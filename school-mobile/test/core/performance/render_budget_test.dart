import 'dart:convert';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/parent/parent.dart';
import 'package:school_mobile/features/teacher/teacher.dart';
import 'package:school_mobile/shared/shared.dart';

import '../../support/mock_http_adapter.dart';

/// What the mobile app can hold about performance without a handset.
///
/// The plan's target — cold start under two seconds and a home render under
/// one, on a three-year-old mid-range Android over throttled 3G — is a
/// wall-clock measurement on real hardware, and it has to be taken there. What
/// is checkable here is the shape that decides it:
///
///  * a screen renders from disk *before* the network answers, so the visible
///    time is disk time and not 3G time;
///  * one screen costs one request, not one per row;
///  * a screen with data on disk shows nothing that spins.
///
/// A regression in any of those turns a one-second render into a
/// twelve-second one on 3G, and none of them needs a device to catch.
const String kDate = '2026-09-05';

Map<String, Object?> _parentHome() => <String, Object?>{
      'data': <String, Object?>{
        'children': <Object?>[
          <String, Object?>{
            'id': 1,
            'name': 'ليان',
            'class_name': 'الصف السابع',
            'attendance': <String, Object?>{
              'present_percent': 92,
              'absent_days': 1,
            },
            'next_installment': null,
            'latest_grade': null,
            'today': <Object?>[],
          },
        ],
        'unread_count': 0,
        'generated_at': '2026-09-05T08:00:00+00:00',
      },
    };

Map<String, Object?> _teacherDay({int periods = 8}) => <String, Object?>{
      'data': <String, Object?>{
        'date': kDate,
        'attendance_window': <String, Object?>{
          'open': true,
          'hours': 48,
          'closes_at': '2026-09-07T23:59:59+00:00',
          'reason': null,
        },
        'periods': <Object?>[
          for (var i = 1; i <= periods; i++)
            <String, Object?>{
              'id': i,
              'class_room_id': i,
              'class_name': 'صف $i',
              'subject_id': 1,
              'subject': 'رياضيات',
              'start_time': '08:00:00',
              'end_time': '08:45:00',
              'room': 'A$i',
              'attendance_taken': false,
            },
        ],
        'classes': <Object?>[
          for (var i = 1; i <= periods; i++)
            <String, Object?>{
              'id': i,
              'name': 'صف $i',
              'grade': '7',
              'section': 'أ',
              'is_homeroom': false,
              'student_count': 30,
            },
        ],
      },
    };

Future<void> pumpIn(WidgetTester tester, Widget child) async {
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
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('a screen with data on disk does not wait for the network', () {
    testWidgets('the parent home paints before the request answers',
        (tester) async {
      // The whole point of cache-first. On 3G the request takes seconds; the
      // cached copy is on screen in the first frame after the disk read.
      final adapter = MockHttpAdapter(
        (options) => MockReply(
          body: _parentHome(),
          // Long enough that a network-first screen would still be blank.
          delay: const Duration(seconds: 5),
        ),
      );
      final client = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: InMemoryTokenStore(deviceId: 'device'),
        adapter: adapter,
      );
      addTearDown(() => client.close(force: true));

      final database = AppDatabase.memory();
      addTearDown(database.close);

      await database.upsertCache(
        entityType: ParentHomeRepository.entityType,
        entityId: ParentHomeRepository.entityId,
        payloadJson: jsonEncode(_parentHome()),
      );

      final controller = ParentHomeController(
        repository:
            ParentHomeRepository(dio: client.dio, database: database),
      );
      addTearDown(controller.dispose);

      await pumpIn(tester, ParentHomeScreen(controller: controller));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));

      // The request is still in flight and the child is already on screen.
      expect(find.text('ليان'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Let the slow response land so the test does not end mid-flight.
      await tester.pump(const Duration(seconds: 6));
    });
  });

  group('one screen costs one request', () {
    test('the teacher day fetches once, however many periods it holds',
        () async {
      // Eight periods and eight classes on one screen. A request per period
      // would be eight round trips before a teacher sees their morning.
      final adapter = MockHttpAdapter(
        (options) => MockReply(body: _teacherDay()),
      );
      final client = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: InMemoryTokenStore(deviceId: 'device'),
        adapter: adapter,
      );
      addTearDown(() => client.close(force: true));

      final database = AppDatabase.memory();
      addTearDown(database.close);

      final controller = TeacherDayController(
        repository: TeacherRepository(dio: client.dio, database: database),
        today: DateTime.parse(kDate),
      );
      addTearDown(controller.dispose);

      await controller.load();

      expect(adapter.requests, hasLength(1));
      final state = controller.state as ScreenData<TeacherDayView>;
      expect(state.value.day.periods, hasLength(8));
      expect(state.value.day.classes, hasLength(8));
    });

    test('a second open with a fresh cache still revalidates exactly once',
        () async {
      // Cache-first is not cache-only: the screen still asks, once, so a mark
      // entered five minutes ago appears. What it must not do is ask twice.
      final adapter = MockHttpAdapter(
        (options) => MockReply(body: _teacherDay(periods: 2)),
      );
      final client = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: InMemoryTokenStore(deviceId: 'device'),
        adapter: adapter,
      );
      addTearDown(() => client.close(force: true));

      final database = AppDatabase.memory();
      addTearDown(database.close);

      final repository = TeacherRepository(dio: client.dio, database: database);
      final first = TeacherDayController(
        repository: repository,
        today: DateTime.parse(kDate),
      );
      addTearDown(first.dispose);
      await first.load();

      final second = TeacherDayController(
        repository: repository,
        today: DateTime.parse(kDate),
      );
      addTearDown(second.dispose);
      await second.load();

      expect(adapter.requests, hasLength(2));
    });
  });

  group('a conditional request costs no body', () {
    test('a 304 is served from disk without reparsing a payload', () async {
      // The server's ETag turns a revalidate into one round trip and no body.
      // On 3G the body is most of the cost.
      final adapter = MockHttpAdapter((options) {
        if (options.headers.containsKey('If-None-Match')) {
          return const MockReply(statusCode: 304, body: null);
        }

        return MockReply(
          body: _teacherDay(periods: 1),
          headers: const <String, List<String>>{
            'etag': <String>['"abc"'],
          },
        );
      });
      final client = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: InMemoryTokenStore(deviceId: 'device'),
        adapter: adapter,
      );
      addTearDown(() => client.close(force: true));

      final database = AppDatabase.memory();
      addTearDown(database.close);

      final repository = TeacherRepository(dio: client.dio, database: database);
      await repository.refreshToday(kDate);

      final second = await repository.refreshToday(kDate);

      expect(second.value.periods, hasLength(1));
      // Not labelled stale: the server confirmed it, which is a stronger
      // statement than a guessed expiry.
      expect(second.fromCache, isFalse);
    });
  });
}
