import 'dart:math';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/db/tables.dart';
import 'package:school_mobile/core/sync/sync.dart';

import '../../support/mock_http_adapter.dart';

/// Dio rejects a relative baseUrl off the web platform, so a host is
/// structurally required. `.test` is reserved by RFC 6761 and never resolves,
/// and every test installs [MockHttpAdapter], so no socket is ever opened.
const String testBaseUrl = 'https://example.test/api';

const String accessToken = 'access-token-aaaaaaaaaaaa';

/// Stands in for a teacher's attendance mark. Test 'no secret or payload
/// reaches a log line or an event' asserts none of this escapes.
const String attendancePayload =
    '{"student_id":7,"student_name":"Layla Haddad","present":false}';

const String attendanceEndpoint = '/attendance';

final DateTime t0 = DateTime.utc(2026, 8, 31, 9);

const MockReply ok = MockReply(body: <String, dynamic>{'ok': true});

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late AppDatabase db;

  setUp(() {
    db = AppDatabase.memory();
    addTearDown(db.close);
  });

  ({
    ApiClient client,
    MockHttpAdapter adapter,
    OutboxDrainer drainer,
    List<String> logs,
    List<SyncEvent> events,
  }) build(
    MockResponder responder, {
    DateTime Function()? clock,
    int maxAttempts = 8,
    OutboxBackoff? backoff,
    ApiLogSink? logSink,
  }) {
    final adapter = MockHttpAdapter(responder);
    final logs = <String>[];
    final client = ApiClient(
      baseUrl: testBaseUrl,
      tokenStore: InMemoryTokenStore(accessToken: accessToken),
      adapter: adapter,
      // One HTTP attempt per send, so request counts below are exact and are
      // not confused by the transport layer's own retries.
      retryPolicy: const RetryPolicy(maxAttempts: 1),
      logSink: logSink ?? logs.add,
    );
    addTearDown(() => client.close(force: true));

    final drainer = OutboxDrainer(
      database: db,
      client: client,
      clock: clock ?? () => t0,
      maxAttempts: maxAttempts,
      backoff: backoff,
    );
    addTearDown(drainer.close);

    final events = <SyncEvent>[];
    drainer.events.listen(events.add);

    return (
      client: client,
      adapter: adapter,
      drainer: drainer,
      logs: logs,
      events: events,
    );
  }

  Future<OutboxEntry> queue(String key, {DateTime? at}) => db.enqueue(
        endpoint: attendanceEndpoint,
        method: 'POST',
        payloadJson: attendancePayload,
        idempotencyKey: key,
        now: at ?? t0,
      );

  group('draining a queue', () {
    test('twenty queued writes send exactly twenty requests, no duplicates',
        () async {
      for (var i = 0; i < 20; i++) {
        await queue('idem-$i', at: t0.add(Duration(seconds: i)));
      }
      final harness = build((options) => ok);

      final report = await harness.drainer.drain();

      expect(harness.adapter.countFor(attendanceEndpoint), 20,
          reason: 'exactly one request per queued write');
      expect(report.succeeded, 20);
      expect(await db.outboxByStatus(OutboxStatus.succeeded), hasLength(20));
      expect(await db.outboxByStatus(OutboxStatus.pending), isEmpty);

      // Every request carried its own key, and no key was sent twice.
      final keys = harness.adapter
          .requestsFor(attendanceEndpoint)
          .map((r) => r.header(idempotencyKeyHeader))
          .toList();
      expect(keys.whereType<String>(), hasLength(20));
      expect(keys.toSet(), hasLength(20), reason: 'zero duplicates');
    });

    test('sends the row idempotency key as the Idempotency-Key header',
        () async {
      await queue('idem-attendance-1');
      final harness = build((options) => ok);

      await harness.drainer.drain();

      final sent = harness.adapter.requestsFor(attendanceEndpoint).single;
      expect(sent.header(idempotencyKeyHeader), 'idem-attendance-1');
      expect(sent.method, 'POST');
    });
  });

  group('a drain killed mid-flight', () {
    test('retries under the same key, losing nothing and double-counting none',
        () async {
      await queue('idem-1');

      // The clock is called to claim the row and again to mark the result.
      // Throwing on that second call kills the pass after the request has
      // reached the server but before the row is marked — exactly what a
      // process death mid-drain leaves behind.
      var kill = true;
      var calls = 0;
      DateTime clock() {
        calls++;
        if (kill && calls == 2) throw StateError('process died mid-flight');
        return t0;
      }

      final harness = build((options) => ok, clock: clock);

      await expectLater(harness.drainer.drain(), throwsA(isA<StateError>()));

      // The kill genuinely landed AFTER the send: the server really did
      // receive the write, carrying its idempotency key, and only then was the
      // pass interrupted. A kill that never sent would prove nothing here.
      expect(harness.adapter.countFor(attendanceEndpoint), 1);
      expect(
        harness.adapter.requestsFor(attendanceEndpoint).single
            .header(idempotencyKeyHeader),
        'idem-1',
      );

      // The row is stranded, not lost, and was never marked succeeded.
      final stranded = (await db.allOutbox()).single;
      expect(stranded.status, OutboxStatus.inflight);
      expect(await db.outboxByStatus(OutboxStatus.succeeded), isEmpty);

      kill = false;
      final report = await harness.drainer.drain();

      // Sent a second time under the SAME key: a replay the server can
      // deduplicate, not a new write.
      final keys = harness.adapter
          .requestsFor(attendanceEndpoint)
          .map((r) => r.header(idempotencyKeyHeader))
          .toList();
      expect(keys, hasLength(2));
      expect(keys.toSet(), <String>{'idem-1'});

      expect(report.recovered, 1);
      expect(report.succeeded, 1, reason: 'counted as succeeded exactly once');
      expect(await db.allOutbox(), hasLength(1), reason: 'no row lost');
      expect((await db.allOutbox()).single.status, OutboxStatus.succeeded);
      // The interruption was ours, not a rejection, so no attempt was spent.
      expect((await db.allOutbox()).single.attempts, 0);
    });
  });

  group('concurrent drains', () {
    test('ten concurrent drain calls run exactly one pass', () async {
      for (var i = 0; i < 5; i++) {
        await queue('idem-$i', at: t0.add(Duration(seconds: i)));
      }
      final harness = build(
        (options) => const MockReply(
          body: <String, dynamic>{'ok': true},
          // Held open so the ten callers genuinely overlap.
          delay: Duration(milliseconds: 20),
        ),
      );

      final reports = await Future.wait<DrainReport>(
        List<Future<DrainReport>>.generate(10, (_) => harness.drainer.drain()),
      );

      expect(harness.drainer.drainCount, 1, reason: 'one pass, not ten');
      expect(harness.adapter.countFor(attendanceEndpoint), 5,
          reason: 'five rows means five requests, not fifty');
      expect(reports.every((r) => r.succeeded == 5), isTrue,
          reason: 'every caller observes the same pass');
      expect(await db.outboxByStatus(OutboxStatus.succeeded), hasLength(5));
    });
  });

  group('classification', () {
    test('a 422 is dead immediately and is never retried', () async {
      await queue('idem-1');
      final harness = build(
        (options) => const MockReply(
          statusCode: 422,
          body: <String, dynamic>{
            'message': 'Validation failed',
            'errors': <String, dynamic>{
              'student_id': <String>['Already recorded.'],
            },
          },
        ),
      );

      final first = await harness.drainer.drain();
      expect(first.dead, 1);
      expect(harness.adapter.countFor(attendanceEndpoint), 1);

      final row = (await db.allOutbox()).single;
      expect(row.status, OutboxStatus.dead);

      // A later pass must not touch it, however much time has passed.
      final second = await harness.drainer.drain();
      expect(second.sent, 0);
      expect(harness.adapter.countFor(attendanceEndpoint), 1,
          reason: 'a dead row is never retried');
      expect(await db.allOutbox(), hasLength(1), reason: 'dead is not deleted');
    });

    test('a 503 is retried, with the attempt count and backoff growing',
        () async {
      await queue('idem-1');
      var now = t0;
      final harness = build(
        (options) => const MockReply(statusCode: 503, body: <String, dynamic>{}),
        clock: () => now,
      );

      await harness.drainer.drain();
      final afterFirst = (await db.allOutbox()).single;
      expect(afterFirst.status, OutboxStatus.failed);
      expect(afterFirst.attempts, 1);
      expect(afterFirst.nextAttemptAt, isNotNull);

      // Move past the backoff so the row is eligible again.
      now = afterFirst.nextAttemptAt!.add(const Duration(seconds: 1));
      await harness.drainer.drain();
      final afterSecond = (await db.allOutbox()).single;

      expect(afterSecond.attempts, 2);
      expect(harness.adapter.countFor(attendanceEndpoint), 2);
      expect(afterSecond.status, OutboxStatus.failed);
    });

    test('a backoff under a second still waits for a later pass', () async {
      // The outbox stores times to the whole second. A jittered pick under a
      // second used to round back to "now", so the same pass claimed the row
      // again and spent a second attempt with no backoff at all. That is how
      // the test above failed about one run in thirty.
      await queue('idem-1');
      final harness = build(
        (options) => const MockReply(statusCode: 503, body: <String, dynamic>{}),
        clock: () => t0,
        backoff: JitteredOutboxBackoff(random: _AlwaysPicks(500)),
      );

      await harness.drainer.drain();
      final row = (await db.allOutbox()).single;

      expect(row.attempts, 1);
      expect(harness.adapter.countFor(attendanceEndpoint), 1);
      expect(row.nextAttemptAt!.isAfter(t0), isTrue);
    });

    test('a row that exhausts its attempts goes dead and is announced',
        () async {
      await queue('idem-1');
      var now = t0;
      final harness = build(
        (options) => const MockReply(statusCode: 503, body: <String, dynamic>{}),
        clock: () => now,
        maxAttempts: 3,
      );

      for (var i = 0; i < 3; i++) {
        await harness.drainer.drain();
        final row = (await db.allOutbox()).single;
        if (row.nextAttemptAt != null) {
          now = row.nextAttemptAt!.add(const Duration(seconds: 1));
        }
      }

      final row = (await db.allOutbox()).single;
      expect(row.status, OutboxStatus.dead);
      expect(harness.events.whereType<OutboxRowDead>(), hasLength(1),
          reason: 'a row going dead is surfaced, never swallowed');
      expect(harness.events.first.idempotencyKey, 'idem-1');
    });

    test('a row whose backoff has not elapsed is not claimed early', () async {
      await queue('idem-1');
      var now = t0;
      final harness = build(
        (options) => const MockReply(statusCode: 503, body: <String, dynamic>{}),
        clock: () => now,
        // A fixed, long backoff so the window is unambiguous.
        backoff: const OutboxBackoff(
          base: Duration(hours: 1),
          max: Duration(hours: 1),
        ),
      );

      await harness.drainer.drain();
      final row = (await db.allOutbox()).single;
      expect(row.nextAttemptAt!.isAfter(now), isTrue);

      now = t0.add(const Duration(minutes: 5));
      final second = await harness.drainer.drain();

      expect(second.sent, 0);
      expect(harness.adapter.countFor(attendanceEndpoint), 1,
          reason: 'nextAttemptAt in the future must be respected');
    });

    test('losing connectivity stops the pass without spending an attempt',
        () async {
      await queue('idem-1');
      final harness = build((options) => throw connectionLost(options));

      final report = await harness.drainer.drain();

      expect(report.stoppedEarly, isTrue);
      expect(harness.drainer.currentStatus.state, SyncState.offline);

      final row = (await db.allOutbox()).single;
      expect(row.status, OutboxStatus.inflight);
      expect(row.attempts, 0,
          reason: 'an offline device must not burn the row toward death');
      expect(harness.events, isEmpty, reason: 'nothing was rejected');
    });
  });

  group('conflict', () {
    test('emits a typed conflict event and leaves the row dead, not deleted',
        () async {
      await queue('idem-1');
      final harness = build(
        (options) => const MockReply(
          statusCode: 409,
          body: <String, dynamic>{'message': 'Attendance already finalised.'},
          headers: <String, List<String>>{
            'x-request-id': <String>['req-conflict-1'],
          },
        ),
      );

      await harness.drainer.drain();

      final conflicts = harness.events.whereType<OutboxConflict>().toList();
      expect(conflicts, hasLength(1));

      final conflict = conflicts.single;
      expect(conflict.statusCode, 409);
      expect(conflict.endpoint, attendanceEndpoint);
      expect(conflict.method, 'POST');
      expect(conflict.idempotencyKey, 'idem-1');
      expect(conflict.requestId, 'req-conflict-1');

      // Server wins: the write is not replayed, but it is not thrown away.
      final row = (await db.allOutbox()).single;
      expect(row.status, OutboxStatus.dead);
      expect(conflict.outboxRowId, row.id,
          reason: 'the event points at the surviving row so the UI can '
              'show what was rejected');
    });
  });

  group('status', () {
    test('reports accurate pending and dead counts across a full cycle',
        () async {
      await queue('succeeds', at: t0);
      await queue('rejected', at: t0.add(const Duration(seconds: 1)));
      await queue('transient', at: t0.add(const Duration(seconds: 2)));

      final harness = build((options) {
        final key = options.headers[idempotencyKeyHeader];
        if (key == 'rejected') {
          return const MockReply(statusCode: 422, body: <String, dynamic>{});
        }
        if (key == 'transient') {
          return const MockReply(statusCode: 503, body: <String, dynamic>{});
        }
        return ok;
      });

      final before = await harness.drainer.refreshStatus();
      expect(before.pendingCount, 3);
      expect(before.deadCount, 0);
      expect(before.hasUnsyncedWork, isTrue);

      final observed = <SyncStatus>[];
      harness.drainer.status.listen(observed.add);

      await harness.drainer.drain();
      await Future<void>.delayed(Duration.zero);

      final after = harness.drainer.currentStatus;
      expect(after.state, SyncState.idle);
      expect(after.deadCount, 1, reason: 'the 422');
      expect(after.pendingCount, 1, reason: 'the 503 awaits its retry');
      expect(observed.map((s) => s.state), contains(SyncState.draining));
    });
  });

  group('secret hygiene', () {
    test('no token or payload reaches a log line, an event or a report',
        () async {
      await queue('idem-1');
      final harness = build(
        (options) => const MockReply(
          statusCode: 409,
          body: <String, dynamic>{
            'message': 'Conflict',
            'student_name': 'Layla Haddad',
          },
        ),
      );

      final report = await harness.drainer.drain();

      // The logger must actually have run, or this proves nothing.
      expect(harness.logs, isNotEmpty);
      expect(harness.logs.join('\n'), contains(attendanceEndpoint));

      final row = (await db.allOutbox()).single;
      final haystacks = <String>[
        ...harness.logs,
        ...harness.events.map((e) => e.toString()),
        report.toString(),
        harness.drainer.currentStatus.toString(),
        row.lastError ?? '',
      ];

      for (final haystack in haystacks) {
        expect(haystack, isNot(contains(attendancePayload)));
        expect(haystack, isNot(contains('Layla Haddad')));
        expect(haystack, isNot(contains(accessToken)));
        expect(haystack, isNot(contains('Bearer ')));
      }

      // The payload is still safely in the database for the UI to render.
      expect(row.payloadJson, attendancePayload);
    });
  });
}

/// A [Random] that always picks the same value, to make jitter deterministic.
class _AlwaysPicks implements Random {
  _AlwaysPicks(this.value);

  final int value;

  @override
  int nextInt(int max) => value < max ? value : max - 1;

  @override
  double nextDouble() => 0;

  @override
  bool nextBool() => false;
}
