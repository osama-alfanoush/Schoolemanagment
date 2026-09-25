/// What the engine is doing right now.
enum SyncState {
  /// Nothing in flight. Work may still be queued.
  idle,

  /// A drain pass is running.
  draining,

  /// The last attempt could not reach the server.
  offline,

  /// The last attempt failed for a reason other than connectivity.
  error,
}

/// Snapshot the UI can render.
///
/// Counts come from the outbox, so they survive restarts.
class SyncStatus {
  const SyncStatus({
    this.state = SyncState.idle,
    this.pendingCount = 0,
    this.deadCount = 0,
  });

  final SyncState state;

  /// Rows still owed to the server: pending, in flight, or awaiting retry.
  /// This is the number a teacher cares about — work not yet saved upstream.
  final int pendingCount;

  /// Rows the engine has given up on. They are never deleted, so the user can
  /// still be shown what did not sync.
  final int deadCount;

  bool get hasUnsyncedWork => pendingCount > 0;

  SyncStatus copyWith({SyncState? state, int? pendingCount, int? deadCount}) =>
      SyncStatus(
        state: state ?? this.state,
        pendingCount: pendingCount ?? this.pendingCount,
        deadCount: deadCount ?? this.deadCount,
      );

  @override
  bool operator ==(Object other) =>
      other is SyncStatus &&
      other.state == state &&
      other.pendingCount == pendingCount &&
      other.deadCount == deadCount;

  @override
  int get hashCode => Object.hash(state, pendingCount, deadCount);

  @override
  String toString() =>
      'SyncStatus(${state.name}, pending: $pendingCount, dead: $deadCount)';
}
