import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';

import '../api/api_client.dart';
import '../api/api_error.dart';
import '../api/retry_policy.dart';
import '../db/app_database.dart';
import '../db/tables.dart';
import 'outbox_backoff.dart';
import 'sync_events.dart';
import 'sync_status.dart';

/// What one drain pass did. Counts are of rows, not requests.
class DrainReport {
  const DrainReport({
    this.sent = 0,
    this.succeeded = 0,
    this.failed = 0,
    this.dead = 0,
    this.recovered = 0,
    this.stoppedEarly = false,
  });

  final int sent;
  final int succeeded;
  final int failed;
  final int dead;

  /// Rows returned to the queue after a previous drain died mid-flight.
  final int recovered;

  /// True when the pass gave up before draining the queue — no connectivity,
  /// or the session is gone. The remaining rows are untouched.
  final bool stoppedEarly;

  @override
  String toString() => 'DrainReport(sent: $sent, succeeded: $succeeded, '
      'failed: $failed, dead: $dead, recovered: $recovered, '
      'stoppedEarly: $stoppedEarly)';
}

/// How one row's attempt resolved.
enum _Outcome { succeeded, retry, dead, conflict, stop }

/// Sends queued writes and records what the server said.
///
/// Composes [AppDatabase] for the queue and [ApiClient] for transport. It
/// never deletes a row and never marks one succeeded without a 2xx.
class OutboxDrainer {
  OutboxDrainer({
    required this.database,
    required this.client,
    OutboxBackoff? backoff,
    this.maxAttempts = 8,
    DateTime Function()? clock,
  })  : backoff = backoff ?? JitteredOutboxBackoff(),
        _clock = clock ?? DateTime.now;

  final AppDatabase database;
  final ApiClient client;

  /// Applied by [AppDatabase.markFailed] when a row is rescheduled.
  final OutboxBackoff backoff;

  /// Server rejections tolerated before a row is given up on.
  ///
  /// Only failures the server actually produced count toward this. Losing
  /// connectivity never kills a row: an offline device would otherwise burn
  /// through every attempt and bury a teacher's work.
  final int maxAttempts;

  final DateTime Function() _clock;

  final StreamController<SyncEvent> _events =
      StreamController<SyncEvent>.broadcast();
  final StreamController<SyncStatus> _status =
      StreamController<SyncStatus>.broadcast();

  /// Rows the engine gave up on, and conflicts the server refused. Every dead
  /// row is announced here — none is swallowed.
  Stream<SyncEvent> get events => _events.stream;

  /// Observable state for the UI.
  Stream<SyncStatus> get status => _status.stream;

  SyncStatus get currentStatus => _currentStatus;
  SyncStatus _currentStatus = const SyncStatus();

  /// Number of drain passes actually executed. Concurrent callers share one
  /// pass, so this does not grow with the number of [drain] calls.
  int get drainCount => _drainCount;
  int _drainCount = 0;

  Future<DrainReport>? _inFlight;

  /// Drains the queue, or joins the pass already running.
  ///
  /// Only one pass runs at a time: a second call while draining awaits the
  /// first rather than starting a parallel drain, which would let two passes
  /// claim and send overlapping work.
  Future<DrainReport> drain() {
    // No `await` between the read and the assignment, so on Dart's single
    // event loop this is an atomic check-and-set.
    return _inFlight ??= _runDrain().whenComplete(() => _inFlight = null);
  }

  Future<DrainReport> _runDrain() async {
    _drainCount++;
    await _emit(state: SyncState.draining);

    var sent = 0;
    var succeeded = 0;
    var failed = 0;
    var dead = 0;
    var stoppedEarly = false;
    var lastState = SyncState.idle;

    final recovered = await _recoverAbandonedRows();

    try {
      // Bounded so a misbehaving row can never spin the loop forever.
      for (var i = 0; i < 10000; i++) {
        final entry = await database.claimNext(now: _clock());
        if (entry == null) break;

        sent++;
        final outcome = await _attempt(entry);

        switch (outcome.result) {
          case _Outcome.succeeded:
            succeeded++;
          case _Outcome.retry:
            failed++;
          case _Outcome.dead:
          case _Outcome.conflict:
            dead++;
          case _Outcome.stop:
            // The row is deliberately left `inflight`: it was never rejected,
            // so it must not burn an attempt. The next pass recovers it.
            stoppedEarly = true;
            lastState = outcome.offline ? SyncState.offline : SyncState.error;
        }

        if (stoppedEarly) break;
      }
    } finally {
      await _emit(state: lastState);
    }

    return DrainReport(
      sent: sent,
      succeeded: succeeded,
      failed: failed,
      dead: dead,
      recovered: recovered,
      stoppedEarly: stoppedEarly,
    );
  }

  /// Returns rows abandoned by a drain that died mid-flight.
  ///
  /// Only one drain runs at a time, so any row still `inflight` when a pass
  /// starts belongs to a pass that never finished — the process was killed, or
  /// connectivity dropped. Such a row was never rejected, so it goes back to
  /// `pending` with its attempt count untouched and is retried under the same
  /// idempotency key, which the server can deduplicate.
  Future<int> _recoverAbandonedRows() async {
    return (database.update(database.localOutbox)
          ..where((t) => t.status.equalsValue(OutboxStatus.inflight)))
        .write(
      const LocalOutboxCompanion(
        status: Value(OutboxStatus.pending),
        nextAttemptAt: Value<DateTime?>(null),
      ),
    );
  }

  Future<({_Outcome result, bool offline})> _attempt(OutboxEntry entry) async {
    final Object? body;
    try {
      body = jsonDecode(entry.payloadJson);
    } on FormatException {
      // Never quote the payload: it holds the teacher's data.
      await _markDead(entry, reason: 'Stored payload is not valid JSON.');
      return (result: _Outcome.dead, offline: false);
    }

    Response<dynamic>? response;
    ApiError? error;
    try {
      response = await client.dio.request<dynamic>(
        entry.endpoint,
        data: body,
        options: Options(
          method: entry.method,
          // What makes the replay safe if this row is ever sent twice.
          headers: <String, String>{
            idempotencyKeyHeader: entry.idempotencyKey,
          },
        ),
      );
    } on DioException catch (failure) {
      error = apiErrorOf(failure) ??
          const UnknownError(message: 'The request failed.');
    }

    if (error == null) {
      final status = response?.statusCode ?? 0;
      if (status >= 200 && status < 300) {
        // The only path to succeeded, and only with a 2xx in hand.
        await database.markSucceeded(entry.id, now: _clock());
        return (result: _Outcome.succeeded, offline: false);
      }
      // A non-2xx that did not throw: treat it as a rejection, not a success.
      error = UnknownError(
        message: 'Unexpected status.',
        statusCode: status,
      );
    }

    return _resolve(entry, error);
  }

  Future<({_Outcome result, bool offline})> _resolve(
    OutboxEntry entry,
    ApiError error,
  ) async {
    final status = error.statusCode;
    final reason = _reasonFor(error);

    // Connectivity or a lost session: nothing was rejected, so stop the pass
    // and leave the row alone rather than spending one of its attempts.
    if (error is NetworkError || error is OfflineError) {
      return (result: _Outcome.stop, offline: true);
    }
    if (error is UnauthorizedError) {
      return (result: _Outcome.stop, offline: false);
    }

    // The server's copy moved on. Server wins: do not replay.
    if (status == 409 || status == 412) {
      await database.markDead(entry.id, reason: reason, now: _clock());
      _publish(
        OutboxConflict(
          outboxRowId: entry.id,
          endpoint: entry.endpoint,
          method: entry.method,
          idempotencyKey: entry.idempotencyKey,
          reason: reason,
          statusCode: status,
          requestId: error.requestId,
        ),
      );
      return (result: _Outcome.conflict, offline: false);
    }

    // Transient: the request timed out, was throttled, or the server faltered.
    final retryable = error is TimeoutError ||
        status == 408 ||
        status == 429 ||
        status == null ||
        status >= 500;

    if (!retryable) {
      // Any other 4xx: the server rejected the request itself, and sending the
      // identical bytes again cannot change that.
      await _markDead(
        entry,
        reason: reason,
        statusCode: status,
        requestId: error.requestId,
      );
      return (result: _Outcome.dead, offline: false);
    }

    if (entry.attempts + 1 >= maxAttempts) {
      await _markDead(
        entry,
        reason: '$reason (gave up after ${entry.attempts + 1} attempts)',
        statusCode: status,
        requestId: error.requestId,
      );
      return (result: _Outcome.dead, offline: false);
    }

    await database.markFailed(
      entry.id,
      reason: reason,
      backoff: backoff,
      now: _clock(),
    );
    return (result: _Outcome.retry, offline: false);
  }

  Future<void> _markDead(
    OutboxEntry entry, {
    required String reason,
    int? statusCode,
    String? requestId,
  }) async {
    await database.markDead(entry.id, reason: reason, now: _clock());
    _publish(
      OutboxRowDead(
        outboxRowId: entry.id,
        endpoint: entry.endpoint,
        method: entry.method,
        idempotencyKey: entry.idempotencyKey,
        reason: reason,
        statusCode: statusCode,
        requestId: requestId,
      ),
    );
  }

  /// A short, safe diagnostic. Deliberately not the server's message body,
  /// which can quote submitted values.
  String _reasonFor(ApiError error) {
    final status = error.statusCode;
    if (status != null) return 'HTTP $status';
    return error.runtimeType.toString();
  }

  void _publish(SyncEvent event) {
    if (!_events.isClosed) _events.add(event);
  }

  /// Recomputes the counts from the outbox and publishes a status.
  Future<void> _emit({required SyncState state}) async {
    final pending = await database.outboxByStatus(OutboxStatus.pending);
    final inflight = await database.outboxByStatus(OutboxStatus.inflight);
    final waiting = await database.outboxByStatus(OutboxStatus.failed);
    final dead = await database.outboxByStatus(OutboxStatus.dead);

    _currentStatus = SyncStatus(
      state: state,
      pendingCount: pending.length + inflight.length + waiting.length,
      deadCount: dead.length,
    );
    if (!_status.isClosed) _status.add(_currentStatus);
  }

  /// Publishes the current counts without running a drain.
  Future<SyncStatus> refreshStatus() async {
    await _emit(state: _currentStatus.state);
    return _currentStatus;
  }

  Future<void> close() async {
    await _events.close();
    await _status.close();
  }
}
