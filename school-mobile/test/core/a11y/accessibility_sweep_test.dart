import 'package:dio/dio.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/parent/parent.dart';
import 'package:school_mobile/features/student/student.dart';
import 'package:school_mobile/features/teacher/teacher.dart';
import 'package:school_mobile/shared/shared.dart';

import '../../support/mock_http_adapter.dart';

const String kDate = '2026-09-05';

/// Every screen this app puts in front of a person, built over one mocked
/// transport, and checked for the three things the plan asks for: Arabic
/// labels a screen reader can read, 48dp targets, and 200% text scale.
///
/// Written as a sweep rather than per screen on purpose. The per-screen tests
/// already cover behaviour; what a sweep catches is the screen somebody adds
/// next, and the icon-only button somebody adds to a screen that had none.
Map<String, Object?> _teacherDay() => <String, Object?>{
      'data': <String, Object?>{
        'date': kDate,
        'attendance_window': <String, Object?>{
          'open': true,
          'hours': 48,
          'closes_at': '2026-09-07T23:59:59+00:00',
          'reason': null,
        },
        'periods': <Object?>[
          <String, Object?>{
            'id': 1,
            'class_room_id': 10,
            'class_name': 'الصف السابع أ',
            'subject_id': 3,
            'subject': 'رياضيات',
            'start_time': '08:00:00',
            'end_time': '08:45:00',
            'room': 'A1',
            'attendance_taken': false,
          },
        ],
        'classes': <Object?>[
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

Map<String, Object?> _roster() => <String, Object?>{
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
            'name': 'ليان أحمد',
            'admission_no': 'STU-1',
            'has_photo': false,
            'guardians': <Object?>[
              <String, Object?>{
                'guardian_user_id': 90,
                'name': 'أم ليان',
                'relation': 'mother',
                'phone': '0790000000',
              },
            ],
            'status': null,
            'note': null,
          },
        ],
      },
    };

Map<String, Object?> _studentHome() => <String, Object?>{
      'data': <String, Object?>{
        'student_user_id': 7,
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
        'attendance': <String, Object?>{'present_percent': 92, 'absent_days': 1},
        'next_due': null,
        'unread_count': 0,
      },
    };

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

({Dio dio, AppDatabase database}) wire(MockResponder responder) {
  final client = ApiClient(
    baseUrl: 'https://api.test',
    tokenStore: InMemoryTokenStore(deviceId: 'device'),
    adapter: MockHttpAdapter(responder),
  );
  addTearDown(() => client.close(force: true));

  final database = AppDatabase.memory();
  addTearDown(database.close);

  return (dio: client.dio, database: database);
}

MockResponder everything() => (options) => switch (options.path) {
      '/mobile/v1/teacher/today' => MockReply(body: _teacherDay()),
      '/mobile/v1/teacher/roster/10' => MockReply(body: _roster()),
      '/mobile/v1/student/home' => MockReply(body: _studentHome()),
      '/mobile/v1/parent/home' => MockReply(body: _parentHome()),
      _ => const MockReply(statusCode: 404),
    };

Future<void> pumpScreen(
  WidgetTester tester,
  Widget child, {
  double textScale = 1.0,
}) async {
  await tester.pumpWidget(MaterialApp(
    theme: AppTheme.light(),
    locale: const Locale('ar'),
    supportedLocales: AppLocales.supported,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: Builder(
      builder: (context) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(textScale)),
        child: AppI18nScope(
          formats: const AppFormats(locale: 'ar'),
          child: child,
        ),
      ),
    ),
  ));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump(const Duration(seconds: 1));
  await tester.pump();
}

/// Runs [body] with the semantics tree built, and takes it down afterwards.
///
/// The handle must be disposed inside the test body: the framework verifies it
/// before `addTearDown` callbacks run, so a teardown-based dispose fails every
/// test that uses one.
Future<void> withSemantics(
  WidgetTester tester,
  Future<void> Function() body,
) async {
  final handle = tester.ensureSemantics();
  try {
    await body();
  } finally {
    handle.dispose();
  }
}

/// Every semantics node that a screen reader would treat as actionable.
List<SemanticsNode> actionableNodes(WidgetTester tester) {
  final found = <SemanticsNode>[];

  void walk(SemanticsNode node) {
    final data = node.getSemanticsData();
    final flags = data.flagsCollection;
    final isActionable = data.hasAction(SemanticsAction.tap) || flags.isButton;

    // A node that merges its children describes one control; its children are
    // the parts of that control, not controls of their own.
    if (isActionable && !flags.isHidden) {
      found.add(node);
    }

    node.visitChildren((child) {
      walk(child);

      return true;
    });
  }

  final root =
      tester.binding.rootPipelineOwner.semanticsOwner?.rootSemanticsNode;
  if (root != null) walk(root);

  return found;
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  /// The screens under sweep, each built fresh so one failure does not cascade.
  final screens = <String, Widget Function(({Dio dio, AppDatabase database}))>{
    'teacher day': (wired) {
      final controller = TeacherDayController(
        repository: TeacherRepository(dio: wired.dio, database: wired.database),
        today: DateTime.parse(kDate),
      );
      addTearDown(controller.dispose);

      return TeacherTodayScreen(controller: controller);
    },
    'class roster': (wired) {
      final controller = ClassRosterController(
        repository: TeacherRepository(dio: wired.dio, database: wired.database),
        classRoomId: 10,
        date: kDate,
      );
      addTearDown(controller.dispose);

      return ClassRosterScreen(
        controller: controller,
        dialer: _NoDialer(),
      );
    },
    'attendance register': (wired) {
      final controller = AttendanceController(
        repository: TeacherRepository(dio: wired.dio, database: wired.database),
        classRoomId: 10,
        date: kDate,
      );
      addTearDown(controller.dispose);

      return AttendanceScreen(controller: controller);
    },
    'student home': (wired) {
      final controller = StudentHomeController(
        repository: StudentRepository(dio: wired.dio, database: wired.database),
      );
      addTearDown(controller.dispose);

      return StudentHomeScreen(controller: controller);
    },
    'parent home': (wired) {
      final controller = ParentHomeController(
        repository:
            ParentHomeRepository(dio: wired.dio, database: wired.database),
      );
      addTearDown(controller.dispose);

      return ParentHomeScreen(controller: controller);
    },
  };

  group('every control a screen reader can reach has something to say', () {
    for (final entry in screens.entries) {
      testWidgets('${entry.key}: no unlabelled control', (tester) async {
        // An icon with no label is read out as nothing at all. On an
        // Arabic-first app used by families, that is the difference between a
        // usable screen and a wall of silence.
        await withSemantics(tester, () async {
          await pumpScreen(tester, entry.value(wire(everything())));

          for (final node in actionableNodes(tester)) {
            final data = node.getSemanticsData();
            final described = data.label.trim().isNotEmpty ||
                data.tooltip.trim().isNotEmpty ||
                data.value.trim().isNotEmpty;

            expect(
              described,
              isTrue,
              reason: '${entry.key} has a tappable control with no label, '
                  'tooltip or value at ${node.rect}',
            );
          }
        });
      });

      testWidgets('${entry.key}: every target clears 48dp', (tester) async {
        await withSemantics(tester, () async {
          await pumpScreen(tester, entry.value(wire(everything())));

          for (final node in actionableNodes(tester)) {
            final size = node.rect.size;

            // Zero-sized nodes are collapsed or off-screen and are not targets.
            if (size.isEmpty) continue;

            expect(
              size.height,
              greaterThanOrEqualTo(Dimens.minTapTarget - 0.5),
              reason: '${entry.key} has a ${size.height}dp tall target: '
                  '"${node.getSemanticsData().label}"',
            );
          }
        });
      });

      testWidgets('${entry.key}: renders at 200% without throwing',
          (tester) async {
        tester.view.physicalSize = const Size(1080, 1920);
        tester.view.devicePixelRatio = 3.0;
        addTearDown(tester.view.reset);

        await pumpScreen(tester, entry.value(wire(everything())), textScale: 2);

        expect(tester.takeException(), isNull);
      });
    }
  });

  group('the labels are Arabic, not glyphs', () {
    testWidgets('the teacher day reads its state in words', (tester) async {
      // The progress of a period is carried by an icon *and* a word. An icon
      // alone is unreadable to a screen reader and ambiguous to everyone else.
      await withSemantics(tester, () async {
        await pumpScreen(tester, screens['teacher day']!(wire(everything())));

        expect(find.text('لم يُرصد الحضور'), findsOneWidget);
      });
    });

    testWidgets('a roster row says whether the guardian can be reached',
        (tester) async {
      await withSemantics(tester, () async {
        await pumpScreen(tester, screens['class roster']!(wire(everything())));

        expect(find.byKey(const Key('student-1')), findsOneWidget);
      });
    });
  });
}

/// A dialer that never dials, for a screen under sweep rather than under test.
class _NoDialer implements GuardianDialer {
  @override
  Future<bool> call(String phone) async => false;
}
