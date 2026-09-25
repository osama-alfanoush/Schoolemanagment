/// Something the user needs to be told about.
///
/// These carry identifiers and a short reason — never the request payload, a
/// token or any personal data. The UI joins [outboxRowId] back to the local
/// outbox row to render the detail, so nothing sensitive travels through an
/// event or a log line.
sealed class SyncEvent {
  const SyncEvent({
    required this.outboxRowId,
    required this.endpoint,
    required this.method,
    required this.idempotencyKey,
    required this.reason,
    this.statusCode,
    this.requestId,
  });

  /// Row in `LocalOutbox`. Still present — dead is a state, not a deletion.
  final int outboxRowId;

  final String endpoint;
  final String method;
  final String idempotencyKey;

  /// Short diagnostic, e.g. `HTTP 422`. Never a response body.
  final String reason;

  final int? statusCode;

  /// Server correlation id, so support can find the request.
  final String? requestId;
}

/// A write the server refused, and replaying will not help.
class OutboxRowDead extends SyncEvent {
  const OutboxRowDead({
    required super.outboxRowId,
    required super.endpoint,
    required super.method,
    required super.idempotencyKey,
    required super.reason,
    super.statusCode,
    super.requestId,
  });

  @override
  String toString() =>
      'OutboxRowDead(row: $outboxRowId, $method $endpoint, $reason)';
}

/// A write rejected because the server's copy moved on.
///
/// Policy is server wins: the queued write is not replayed, the row is left
/// dead rather than deleted, and this event lets the UI tell the user exactly
/// which submission was rejected.
class OutboxConflict extends SyncEvent {
  const OutboxConflict({
    required super.outboxRowId,
    required super.endpoint,
    required super.method,
    required super.idempotencyKey,
    required super.reason,
    super.statusCode,
    super.requestId,
  });

  @override
  String toString() =>
      'OutboxConflict(row: $outboxRowId, $method $endpoint, $reason)';
}
