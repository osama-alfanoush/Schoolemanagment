import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/teacher/teacher.dart';
import 'package:school_mobile/shared/shared.dart';

import '../../support/mock_http_adapter.dart';

const String kDate = '2026-09-05';

/// A dialer that records rather than dialing, and can refuse.
class FakeDialer implements GuardianDialer {
  FakeDialer({this.succeeds = true});

  final bool succeeds;
  final List<String> dialled = <String>[];

  @override
  Future<bool> call(String phone) async {
    dialled.add(phone);

    return succeeds;
  }
}

Map<String, Object?> _student({
  int id = 1,
  String name = 'ليان أحمد',
  String admissionNo = 'STU-1',
  bool hasPhoto = false,
  List<Object?>? guardians,
}) =>
    <String, Object?>{
      'student_user_id': id,
      'name': name,
      'admission_no': admissionNo,
      'has_photo': hasPhoto,
      'guardians': guardians ??
          <Object?>[
            <String, Object?>{
              'guardian_user_id': 90,
              'name': 'أم ليان',
              'relation': 'mother',
              'phone': '0790000000',
            },
          ],
      'status': null,
      'note': null,
    };

Map<String, Object?> _roster({List<Object?>? students}) => <String, Object?>{
      'data': <String, Object?>{
        'class_room_id': 10,
        'date': kDate,
        'attendance_window': <String, Object?>{
          'open': true,
          'hours': 48,
          'closes_at': '2026-09-07T23:59:59+00:00',
          'reason': null,
        },
        'students': students ?? <Object?>[_student()],
      },
    };

({
  ClassRosterController controller,
  AppDatabase database,
  MockHttpAdapter adapter,
}) buildRoster(MockResponder responder) {
  final adapter = MockHttpAdapter(responder);
  final client = ApiClient(
    baseUrl: 'https://api.test',
    tokenStore: InMemoryTokenStore(deviceId: 'device'),
    adapter: adapter,
  );
  addTearDown(() => client.close(force: true));

  final database = AppDatabase.memory();
  addTearDown(database.close);

  final controller = ClassRosterController(
    repository: TeacherRepository(dio: client.dio, database: database),
    classRoomId: 10,
    date: kDate,
  );
  addTearDown(controller.dispose);

  return (controller: controller, database: database, adapter: adapter);
}

MockResponder happyPath({Map<String, Object?>? roster}) =>
    (options) => options.path == '/mobile/v1/teacher/roster/10'
        ? MockReply(body: roster ?? _roster())
        : const MockReply(statusCode: 404);

Future<void> pumpRoster(
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
  await tester.pump();
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('offline', () {
    test('a second open renders from cache with no network', () async {
      var online = true;
      final roster = buildRoster((options) {
        if (!online) throw connectionLost(options);

        return MockReply(body: _roster());
      });

      await roster.controller.load();
      online = false;
      await roster.controller.refresh();

      final state = roster.controller.state;
      expect(state, isA<ScreenData<ClassRoster>>());
      expect((state as ScreenData<ClassRoster>).value.students, hasLength(1));
    });
  });

  group('student lookup', () {
    test('filters by name', () async {
      final roster = buildRoster(happyPath(
        roster: _roster(students: <Object?>[
          _student(name: 'ليان أحمد'),
          _student(id: 2, name: 'سامي خالد', admissionNo: 'STU-2'),
        ]),
      ));
      await roster.controller.load();

      roster.controller.search('سامي');

      final value =
          (roster.controller.state as ScreenData<ClassRoster>).value;
      expect(roster.controller.visible(value).single.userId, 2);
    });

    test('filters by admission number', () async {
      // The number is what a teacher has in front of them on a printed list.
      final roster = buildRoster(happyPath(
        roster: _roster(students: <Object?>[
          _student(name: 'ليان أحمد'),
          _student(id: 2, name: 'سامي خالد', admissionNo: 'STU-2'),
        ]),
      ));
      await roster.controller.load();

      roster.controller.search('stu-2');

      final value =
          (roster.controller.state as ScreenData<ClassRoster>).value;
      expect(roster.controller.visible(value).single.userId, 2);
    });

    testWidgets('a search with no match says so rather than showing nothing',
        (tester) async {
      final roster = buildRoster(happyPath());
      await pumpRoster(
        tester,
        ClassRosterScreen(controller: roster.controller, dialer: FakeDialer()),
      );

      await tester.enterText(find.byKey(const Key('roster-search')), 'zzz');
      await tester.pump();

      expect(find.byKey(const Key('roster-no-match')), findsOneWidget);
    });
  });

  group('contacting a guardian', () {
    testWidgets('tapping a student offers their guardian', (tester) async {
      final dialer = FakeDialer();
      final roster = buildRoster(happyPath());
      await pumpRoster(
        tester,
        ClassRosterScreen(controller: roster.controller, dialer: dialer),
      );

      await tester.tap(find.byKey(const Key('student-1')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('guardian-sheet')), findsOneWidget);

      await tester.tap(find.byKey(const Key('call-90')));
      await tester.pumpAndSettle();

      expect(dialer.dialled, <String>['0790000000']);
    });

    testWidgets('a guardian with no number gets no call button', (tester) async {
      // A call button that cannot call costs a tap and teaches the teacher
      // that the app is unreliable.
      final roster = buildRoster(happyPath(
        roster: _roster(students: <Object?>[
          _student(guardians: <Object?>[
            <String, Object?>{
              'guardian_user_id': 91,
              'name': 'أبو ليان',
              'relation': 'father',
              'phone': null,
            },
          ]),
        ]),
      ));
      await pumpRoster(
        tester,
        ClassRosterScreen(controller: roster.controller, dialer: FakeDialer()),
      );

      await tester.tap(find.byKey(const Key('student-1')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('guardian-91')), findsOneWidget);
      expect(find.byKey(const Key('call-91')), findsNothing);
      expect(find.text('لا يوجد رقم مسجّل.'), findsOneWidget);
    });

    testWidgets('a student with no guardian on file is told so', (tester) async {
      final roster = buildRoster(happyPath(
        roster: _roster(students: <Object?>[_student(guardians: <Object?>[])]),
      ));
      await pumpRoster(
        tester,
        ClassRosterScreen(controller: roster.controller, dialer: FakeDialer()),
      );

      await tester.tap(find.byKey(const Key('student-1')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('guardian-none')), findsOneWidget);
    });

    testWidgets('a device that cannot dial says so instead of doing nothing',
        (tester) async {
      // A school tablet with no SIM. Silence here reads as a broken button.
      final dialer = FakeDialer(succeeds: false);
      final roster = buildRoster(happyPath());
      await pumpRoster(
        tester,
        ClassRosterScreen(controller: roster.controller, dialer: dialer),
      );

      await tester.tap(find.byKey(const Key('student-1')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('call-90')));
      await tester.pumpAndSettle();

      expect(find.text('تعذّر بدء الاتصال.'), findsOneWidget);
    });
  });

  group('photos', () {
    testWidgets('no photo is requested when the server says there is none',
        (tester) async {
      final requested = <int>[];
      final roster = buildRoster(happyPath());

      await pumpRoster(
        tester,
        ClassRosterScreen(
          controller: roster.controller,
          dialer: FakeDialer(),
          photoUrlFor: (id) {
            requested.add(id);

            return 'https://api.test/files/profile-photo/$id';
          },
        ),
      );

      expect(find.byKey(const Key('avatar-1')), findsOneWidget);
      expect(
        requested,
        isEmpty,
        reason: 'thirty 404s on a school connection is a bad trade',
      );
    });
  });

  group('presentation', () {
    testWidgets('survives 200% text scale in both locales', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      for (final locale in <String>['ar', 'en']) {
        final roster = buildRoster(happyPath());

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
                child: ClassRosterScreen(
                  key: ValueKey<String>(locale),
                  controller: roster.controller,
                  dialer: FakeDialer(),
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
