import 'dart:convert';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/sync/sync.dart';
import 'package:school_mobile/features/auth/auth.dart';
import 'package:school_mobile/features/student/student.dart';
import 'package:school_mobile/features/teacher/teacher.dart';

import '../../support/mock_http_adapter.dart';

/// Values that must never appear in a log line, an event, an exception or a
/// crash report. Each stands for a class of thing, and each is deliberately
/// distinctive enough to grep for.
const String kToken = 'eyJhbGciOiJIUzI1NiJ9.SECRET-BEARER-TOKEN';
const String kRefresh = 'REFRESH-TOKEN-VALUE-9f2c';
const String kChildName = 'ليان أحمد الفلاني';
const String kGuardianPhone = '0790000000';
const String kAdmissionNo = 'STU-000123';
const String kPassword = 'the-parents-password';
const String kDatabaseKey = 'DATABASE-KEY-MATERIAL-c41d';

/// Everything the app might write out, collected in one place.
class Recorder {
  final List<String> lines = <String>[];

  void add(String line) => lines.add(line);

  /// Every recorded line joined, for a single containment assertion.
  String get all => lines.join('\n');
}

void expectNoSecrets(String haystack, {String reason = ''}) {
  for (final secret in <String>[
    kToken,
    kRefresh,
    kChildName,
    kGuardianPhone,
    kAdmissionNo,
    kPassword,
    kDatabaseKey,
  ]) {
    expect(
      haystack,
      isNot(contains(secret)),
      reason: '$reason leaked "$secret"',
    );
  }
}

Map<String, Object?> _roster() => <String, Object?>{
      'data': <String, Object?>{
        'class_room_id': 10,
        'date': '2026-09-05',
        'attendance_window': <String, Object?>{
          'open': true,
          'hours': 48,
          'closes_at': '2026-09-07T23:59:59+00:00',
          'reason': null,
        },
        'students': <Object?>[
          <String, Object?>{
            'student_user_id': 1,
            'name': kChildName,
            'admission_no': kAdmissionNo,
            'has_photo': false,
            'guardians': <Object?>[
              <String, Object?>{
                'guardian_user_id': 90,
                'name': 'أم ليان',
                'relation': 'mother',
                'phone': kGuardianPhone,
              },
            ],
            'status': null,
            'note': null,
          },
        ],
      },
    };

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('the API log records a shape, never a value', () {
    test('a whole request cycle leaks neither token nor payload', () async {
      final log = Recorder();
      final tokens = InMemoryTokenStore(deviceId: 'device-1');
      await tokens.writeAccessToken(kToken);
      await tokens.writeRefreshToken(kRefresh);

      final client = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: tokens,
        adapter: MockHttpAdapter(
          (options) => MockReply(
            body: _roster(),
            headers: const <String, List<String>>{
              'x-request-id': <String>['req-abc-123'],
            },
          ),
        ),
        logSink: log.add,
      );
      addTearDown(() => client.close(force: true));

      await client.dio.post<Object?>(
        '/mobile/v1/teacher/roster/10',
        data: <String, Object?>{
          'password': kPassword,
          'name': kChildName,
        },
      );

      expectNoSecrets(log.all, reason: 'the API log');
      // What it *should* carry: enough to correlate with the server.
      expect(log.all, contains('/mobile/v1/teacher/roster/10'));
      expect(log.all, contains('req-abc-123'));
    });

    test('a failure logs the status, not the response body', () async {
      final log = Recorder();
      final client = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: InMemoryTokenStore(deviceId: 'device-1'),
        adapter: MockHttpAdapter(
          (options) => const MockReply(
            statusCode: 422,
            body: <String, Object?>{
              'message': 'Rejected for $kChildName',
              'errors': <String, Object?>{'phone': kGuardianPhone},
            },
          ),
        ),
        logSink: log.add,
      );
      addTearDown(() => client.close(force: true));

      try {
        await client.dio.get<Object?>('/mobile/v1/teacher/roster/10');
      } on Object {
        // The failure itself is not what is under test.
      }

      expectNoSecrets(log.all, reason: 'the API error log');
      expect(log.all, contains('422'));
    });
  });

  group('a sync event carries an identifier, not a payload', () {
    test('a dead row is announced without quoting what it held', () async {
      final database = AppDatabase.memory();
      addTearDown(database.close);

      final tokens = InMemoryTokenStore(deviceId: 'device-1');
      await tokens.writeAccessToken(kToken);

      final client = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: tokens,
        adapter: MockHttpAdapter(
          (options) => const MockReply(
            statusCode: 422,
            body: <String, Object?>{'message': 'Rejected for $kChildName'},
          ),
        ),
      );
      addTearDown(() => client.close(force: true));

      await database.enqueue(
        endpoint: TeacherEndpoints.attendanceBatch,
        method: 'POST',
        payloadJson: jsonEncode(<String, Object?>{
          'class_room_id': 10,
          'date': '2026-09-05',
          'records': <Object?>[
            <String, Object?>{
              'student_user_id': 1,
              'status': 'absent',
              'note': kChildName,
            },
          ],
        }),
        idempotencyKey: 'idem-1',
      );

      final drainer = OutboxDrainer(database: database, client: client);
      addTearDown(drainer.close);

      final events = <SyncEvent>[];
      final subscription = drainer.events.listen(events.add);
      addTearDown(subscription.cancel);

      await drainer.drain();
      await Future<void>.delayed(Duration.zero);

      expect(events, hasLength(1));
      for (final event in events) {
        expectNoSecrets(event.toString(), reason: 'a sync event');
        expectNoSecrets(event.reason, reason: "a sync event's reason");
      }

      // And the row's own recorded error, which the UI reads back.
      final row = (await database.allOutbox()).single;
      expectNoSecrets('${row.lastError}', reason: 'the stored failure reason');
    });
  });

  group('a rejected submission shows a teacher their own data, not a log',
      () {
    test('the rejection the screen reads carries no server message', () async {
      // The distinction that makes this safe: the teacher sees the values
      // *their own device* wrote, and nothing that came back from the server.
      final database = AppDatabase.memory();
      addTearDown(database.close);

      final client = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: InMemoryTokenStore(deviceId: 'device-1'),
        adapter: MockHttpAdapter(
          (options) => const MockReply(
            statusCode: 422,
            body: <String, Object?>{'message': 'Rejected for $kChildName'},
          ),
        ),
      );
      addTearDown(() => client.close(force: true));

      final repository = TeacherRepository(dio: client.dio, database: database);

      final row = await database.enqueue(
        endpoint: TeacherEndpoints.attendanceBatch,
        method: 'POST',
        payloadJson: jsonEncode(<String, Object?>{
          'class_room_id': 10,
          'date': '2026-09-05',
          'records': <Object?>[],
        }),
        idempotencyKey: 'idem-2',
      );
      await database.markDead(row.id, reason: 'HTTP 422');

      final rejected = (await repository.rejectedAttendance()).single;

      expect(rejected.reason, 'HTTP 422');
      expectNoSecrets(rejected.reason, reason: 'a rejected submission');
    });
  });

  group('local failures name nothing', () {
    test('an unsent-work refusal carries a count, not the writes', () async {
      // The count travels so the user can be told what is at stake; the
      // contents do not, because they are the user's own data and an exception
      // is exactly the kind of thing that ends up in a crash report.
      const failure = UnsentWorkPending(3);

      expect(failure.count, 3);
      expectNoSecrets(failure.toString(), reason: 'UnsentWorkPending');
      expect(failure.toString(), contains('3'));
    });
  });

  group('the student surface sends nothing it should not', () {
    test('a hand-in body carries the work and the key, and no identity',
        () async {
      final database = AppDatabase.memory();
      addTearDown(database.close);

      final adapter = MockHttpAdapter(
        (options) => const MockReply(
          statusCode: 201,
          body: <String, Object?>{
            'data': <String, Object?>{'status': 'submitted'},
          },
        ),
      );
      final client = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: InMemoryTokenStore(deviceId: 'device-1'),
        adapter: adapter,
      );
      addTearDown(() => client.close(force: true));

      final repository =
          StudentRepository(dio: client.dio, database: database);

      await repository.handIn(assignmentId: 5, text: 'الحل');

      final request = adapter
          .requestsFor('/mobile/v1/student/assignments/5/submit')
          .single;

      expect(request.json['content_text'], 'الحل');
      expect(request.header('Idempotency-Key'), isNotEmpty);
      // No student id anywhere: the token is the scope. The path names the
      // *assignment*, which is not personal, and the surface, which is not
      // secret.
      expect(request.json.keys, isNot(contains('student_user_id')));
      expect(request.path, '/mobile/v1/student/assignments/5/submit');
      expect(request.path, isNot(contains('student_user_id')));
    });
  });
}
