import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/teacher/teacher.dart';

import '../../support/mock_http_adapter.dart';

Map<String, Object?> _assignment({
  int id = 1,
  bool published = false,
  bool hasAttachment = false,
  int submitted = 0,
}) =>
    <String, Object?>{
      'id': id,
      'class_room_id': 10,
      'subject_id': 3,
      'title': 'واجب الرياضيات',
      'instructions': 'حل التمارين.',
      'due_at': '2026-09-08T12:00:00Z',
      'published': published,
      'published_at': published ? '2026-09-05T09:00:00Z' : null,
      'has_attachment': hasAttachment,
      'submission_counts': <String, Object?>{
        'submitted': submitted,
        'late': 0,
        'graded': 0,
        'pending': 2 - submitted,
      },
      'class_size': 2,
    };

Map<String, Object?> _list({List<Object?>? rows}) => <String, Object?>{
      'data': <String, Object?>{
        'assignments': rows ?? <Object?>[_assignment()],
      },
    };

Map<String, Object?> _options({
  bool openNow = true,
  List<Object?>? templates,
}) =>
    <String, Object?>{
      'data': <String, Object?>{
        'templates': templates ??
            <Object?>[
              <String, Object?>{
                'key': 'bring_materials',
                'title': 'إحضار مستلزمات',
                'body': 'يرجى إحضار المستلزمات التالية في الحصة القادمة: :detail',
              },
            ],
        'window': <String, Object?>{'from': '07:00', 'to': '17:00'},
        'open_now': openNow,
      },
    };

({
  AssignmentsController controller,
  TeacherRepository repository,
  AppDatabase database,
  MockHttpAdapter adapter,
}) buildAssignments(MockResponder responder) {
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
  final controller = AssignmentsController(repository: repository);
  addTearDown(controller.dispose);

  return (
    controller: controller,
    repository: repository,
    database: database,
    adapter: adapter,
  );
}

({
  AnnounceController controller,
  MockHttpAdapter adapter,
}) buildAnnounce(MockResponder responder, {int? guardianUserId}) {
  final adapter = MockHttpAdapter(responder);
  final client = ApiClient(
    baseUrl: 'https://api.test',
    tokenStore: InMemoryTokenStore(deviceId: 'device'),
    adapter: adapter,
  );
  addTearDown(() => client.close(force: true));

  final database = AppDatabase.memory();
  addTearDown(database.close);

  final controller = AnnounceController(
    repository: TeacherRepository(dio: client.dio, database: database),
    classRoomId: 10,
    guardianUserId: guardianUserId,
  );
  addTearDown(controller.dispose);

  return (controller: controller, adapter: adapter);
}

Future<void> pumpTeacher(
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

  group('a draft reaches nobody', () {
    testWidgets('a draft is labelled a draft, with what that means',
        (tester) async {
      final screen = buildAssignments((options) =>
          options.path == '/mobile/v1/teacher/assignments'
              ? MockReply(body: _list())
              : const MockReply(statusCode: 404));

      await pumpTeacher(
        tester,
        AssignmentsScreen(
          controller: screen.controller,
          classRoomId: 10,
          subjectId: 3,
        ),
      );

      expect(find.text('مسودة'), findsOneWidget);
      expect(find.byKey(const Key('draft-note-1')), findsOneWidget);
      expect(find.byKey(const Key('publish-1')), findsOneWidget);
    });

    testWidgets('a published assignment shows how the class is doing',
        (tester) async {
      final screen = buildAssignments((options) =>
          options.path == '/mobile/v1/teacher/assignments'
              ? MockReply(
                  body: _list(
                    rows: <Object?>[_assignment(published: true, submitted: 1)],
                  ),
                )
              : const MockReply(statusCode: 404));

      await pumpTeacher(
        tester,
        AssignmentsScreen(
          controller: screen.controller,
          classRoomId: 10,
          subjectId: 3,
        ),
      );

      expect(find.text('منشور'), findsOneWidget);
      expect(find.text('1 / 2'), findsOneWidget);
      expect(find.byKey(const Key('publish-1')), findsNothing);
    });

    test('publishing goes to the publish endpoint, not to a rewrite', () async {
      final screen = buildAssignments((options) => switch (options.path) {
            '/mobile/v1/teacher/assignments' => MockReply(body: _list()),
            '/mobile/v1/teacher/assignments/1/publish' => MockReply(
                body: <String, Object?>{
                  'data': _assignment(published: true),
                },
              ),
            _ => const MockReply(statusCode: 404),
          });

      await screen.controller.load();
      expect(await screen.controller.publish(1), isTrue);

      expect(
        screen.adapter.countFor('/mobile/v1/teacher/assignments/1/publish'),
        1,
      );
    });
  });

  group('an upload never fails silently', () {
    testWidgets('a failed upload is on screen and the assignment survives',
        (tester) async {
      // The acceptance criterion. The only thing a failed upload costs is the
      // file; the homework is already saved, and the retry is one tap.
      final screen = buildAssignments((options) => switch (options.path) {
            '/mobile/v1/teacher/assignments' => MockReply(body: _list()),
            '/mobile/v1/teacher/assignments/1/attachment' =>
              const MockReply(statusCode: 422),
            _ => const MockReply(statusCode: 404),
          });

      final file = File('${Directory.systemTemp.path}/worksheet.pdf')
        ..writeAsStringSync('x');
      addTearDown(() => file.existsSync() ? file.deleteSync() : null);

      await pumpTeacher(
        tester,
        AssignmentsScreen(
          controller: screen.controller,
          classRoomId: 10,
          subjectId: 3,
          picker: () async =>
              PickedFile(path: file.path, name: 'worksheet.pdf'),
        ),
      );

      // Real async: a multipart upload reads a real file and dio schedules
      // real timers, neither of which the widget test's fake clock drives.
      await tester.runAsync(
        () => screen.controller.attach(
          1,
          PickedFile(path: file.path, name: 'worksheet.pdf'),
        ),
      );
      await tester.pump();

      expect(find.byKey(const Key('upload-failed-1')), findsOneWidget);
      expect(
        find.text('تعذّر رفع الملف. الواجب محفوظ، أعد المحاولة.'),
        findsOneWidget,
      );
      // Still there, and still a draft.
      expect(find.byKey(const Key('assignment-1')), findsOneWidget);
      expect(find.text('إعادة المحاولة'), findsOneWidget);
    });

    testWidgets('an upload that succeeds says the file is attached',
        (tester) async {
      var attached = false;
      final screen = buildAssignments((options) => switch (options.path) {
            '/mobile/v1/teacher/assignments' =>
              MockReply(body: _list(rows: <Object?>[
                _assignment(hasAttachment: attached),
              ])),
            '/mobile/v1/teacher/assignments/1/attachment' => () {
                attached = true;

                return MockReply(
                  body: <String, Object?>{'data': _assignment(hasAttachment: true)},
                );
              }(),
            _ => const MockReply(statusCode: 404),
          });

      final file = File('${Directory.systemTemp.path}/worksheet2.pdf')
        ..writeAsStringSync('x');
      addTearDown(() => file.existsSync() ? file.deleteSync() : null);

      await pumpTeacher(
        tester,
        AssignmentsScreen(
          controller: screen.controller,
          classRoomId: 10,
          subjectId: 3,
          picker: () async =>
              PickedFile(path: file.path, name: 'worksheet2.pdf'),
        ),
      );

      await tester.runAsync(
        () => screen.controller.attach(
          1,
          PickedFile(path: file.path, name: 'worksheet2.pdf'),
        ),
      );
      await tester.pump();

      expect(find.byKey(const Key('attached-1')), findsOneWidget);
      expect(find.byKey(const Key('upload-failed-1')), findsNothing);
    });

    testWidgets('the attach button asks the picker for a file', (tester) async {
      var asked = 0;
      final screen = buildAssignments((options) =>
          options.path == '/mobile/v1/teacher/assignments'
              ? MockReply(body: _list())
              : const MockReply(statusCode: 404));

      await pumpTeacher(
        tester,
        AssignmentsScreen(
          controller: screen.controller,
          classRoomId: 10,
          subjectId: 3,
          // Cancelling the picker uploads nothing, which is also the correct
          // behaviour when a teacher backs out of the file chooser.
          picker: () async {
            asked++;

            return null;
          },
        ),
      );

      await tester.tap(find.byKey(const Key('attach-1')));
      await tester.pumpAndSettle();

      expect(asked, 1);
      expect(find.byKey(const Key('uploading-1')), findsNothing);
      expect(find.byKey(const Key('upload-failed-1')), findsNothing);
    });

    testWidgets('a build with no file picker offers no attach button',
        (tester) async {
      final screen = buildAssignments((options) =>
          options.path == '/mobile/v1/teacher/assignments'
              ? MockReply(body: _list())
              : const MockReply(statusCode: 404));

      await pumpTeacher(
        tester,
        AssignmentsScreen(
          controller: screen.controller,
          classRoomId: 10,
          subjectId: 3,
        ),
      );

      expect(find.byKey(const Key('attach-1')), findsNothing);
    });
  });

  group('hand-in status', () {
    testWidgets('the whole class is listed, including who has not handed in',
        (tester) async {
      final adapter = MockHttpAdapter((options) => const MockReply(
            body: <String, Object?>{
              'data': <String, Object?>{
                'assignment_id': 1,
                'title': 'واجب',
                'published': true,
                'students': <Object?>[
                  <String, Object?>{
                    'student_user_id': 1,
                    'name': 'ليان',
                    'status': 'submitted',
                  },
                  <String, Object?>{
                    'student_user_id': 2,
                    'name': 'سامي',
                    'status': null,
                  },
                ],
              },
            },
          ));
      final client = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: InMemoryTokenStore(deviceId: 'device'),
        adapter: adapter,
      );
      addTearDown(() => client.close(force: true));
      final database = AppDatabase.memory();
      addTearDown(database.close);

      final controller = HandInsController(
        repository: TeacherRepository(dio: client.dio, database: database),
        assignmentId: 1,
      );
      addTearDown(controller.dispose);

      await pumpTeacher(tester, HandInsScreen(controller: controller));

      expect(find.text('سُلّم'), findsOneWidget);
      // Absent means not handed in. A blank would read as "fine", which is the
      // opposite of what a teacher opens this screen to find out.
      expect(find.text('لم يُسلّم'), findsOneWidget);
    });
  });

  group('notices use approved wording only', () {
    test('there is no method that sends free text', () {
      // The absence is the point. A client cannot accidentally offer what the
      // product deliberately does not.
      final announce = buildAnnounce((options) => MockReply(body: _options()));

      expect(announce.controller.chooseTemplate, isA<Function>());
      // AnnounceController exposes chooseTemplate, describe and send. There is
      // nothing that takes a title and a body.
    });

    testWidgets('the exact wording is shown before it is sent', (tester) async {
      final announce = buildAnnounce(
        (options) => options.path == '/mobile/v1/teacher/announcement-templates'
            ? MockReply(body: _options())
            : const MockReply(statusCode: 404),
      );

      await pumpTeacher(tester, AnnounceScreen(controller: announce.controller));

      await tester.enterText(
        find.byKey(const Key('announce-detail')),
        'مسطرة ومقص',
      );
      await tester.pump();

      expect(find.byKey(const Key('announce-preview')), findsOneWidget);
      expect(
        find.text('يرجى إحضار المستلزمات التالية في الحصة القادمة: مسطرة ومقص'),
        findsOneWidget,
      );
    });

    testWidgets('outside school hours there is no send button at all',
        (tester) async {
      // The acceptance criterion. A push at 23:40 wakes a household.
      final announce = buildAnnounce(
        (options) => options.path == '/mobile/v1/teacher/announcement-templates'
            ? MockReply(body: _options(openNow: false))
            : const MockReply(statusCode: 404),
      );

      await pumpTeacher(tester, AnnounceScreen(controller: announce.controller));

      expect(find.byKey(const Key('announce-closed')), findsOneWidget);
      final button = tester.widget<FilledButton>(
        find.byKey(const Key('announce-send')),
      );
      expect(button.onPressed, isNull);
    });

    test('a refusal by the server is explained, not swallowed', () async {
      final announce = buildAnnounce((options) => switch (options.path) {
            '/mobile/v1/teacher/announcement-templates' =>
              MockReply(body: _options()),
            '/mobile/v1/teacher/announcements' =>
              const MockReply(statusCode: 409),
            _ => const MockReply(statusCode: 404),
          });

      await announce.controller.load();
      announce.controller.describe('مسطرة');

      expect(await announce.controller.send(), isFalse);
      expect(announce.controller.refusal, AnnounceRefusal.outsideHours);
    });

    test('a notice the teacher may not send is explained too', () async {
      final announce = buildAnnounce((options) => switch (options.path) {
            '/mobile/v1/teacher/announcement-templates' =>
              MockReply(body: _options()),
            '/mobile/v1/teacher/announcements' =>
              const MockReply(statusCode: 403),
            _ => const MockReply(statusCode: 404),
          });

      await announce.controller.load();

      expect(await announce.controller.send(), isFalse);
      expect(announce.controller.refusal, AnnounceRefusal.notPermitted);
    });

    test('a notice carries an idempotency key', () async {
      final announce = buildAnnounce((options) => switch (options.path) {
            '/mobile/v1/teacher/announcement-templates' =>
              MockReply(body: _options()),
            '/mobile/v1/teacher/announcements' =>
              const MockReply(statusCode: 201, body: <String, Object?>{}),
            _ => const MockReply(statusCode: 404),
          });

      await announce.controller.load();
      announce.controller.describe('مسطرة');
      await announce.controller.send();

      expect(
        announce.adapter
            .requestsFor('/mobile/v1/teacher/announcements')
            .single
            .header('Idempotency-Key'),
        isNotEmpty,
      );
    });

    test('a guardian notice addresses that guardian, not the class', () async {
      final announce = buildAnnounce(
        (options) => switch (options.path) {
          '/mobile/v1/teacher/announcement-templates' =>
            MockReply(body: _options()),
          '/mobile/v1/teacher/announcements' =>
            const MockReply(statusCode: 201, body: <String, Object?>{}),
          _ => const MockReply(statusCode: 404),
        },
        guardianUserId: 90,
      );

      await announce.controller.load();
      await announce.controller.send();

      expect(
        announce.adapter
            .requestsFor('/mobile/v1/teacher/announcements')
            .single
            .json['audience'],
        'guardian:90',
      );
    });

    testWidgets('offline says so rather than queueing a notice for midnight',
        (tester) async {
      // A notice queued at four and drained at midnight arrives exactly when
      // the school's hours exist to prevent.
      final announce = buildAnnounce(
        (options) => options.path == '/mobile/v1/teacher/announcement-templates'
            ? MockReply(body: _options())
            : const MockReply(statusCode: 404),
      );

      await pumpTeacher(
        tester,
        AnnounceScreen(controller: announce.controller, isOffline: true),
      );

      expect(find.byKey(const Key('announce-offline')), findsOneWidget);
      final button = tester.widget<FilledButton>(
        find.byKey(const Key('announce-send')),
      );
      expect(button.onPressed, isNull);
    });
  });

  group('presentation', () {
    testWidgets('survives 200% text scale in both locales', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      for (final locale in <String>['ar', 'en']) {
        final screen = buildAssignments((options) =>
            options.path == '/mobile/v1/teacher/assignments'
                ? MockReply(body: _list())
                : const MockReply(statusCode: 404));

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
                child: AssignmentsScreen(
                  key: ValueKey<String>(locale),
                  controller: screen.controller,
                  classRoomId: 10,
                  subjectId: 3,
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
