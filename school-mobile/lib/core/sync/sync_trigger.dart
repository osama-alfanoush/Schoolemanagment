import 'dart:async';

/// Why a drain was asked for. Useful for diagnostics; carries no user data.
enum SyncTriggerReason {
  /// The user (or a screen) asked explicitly.
  onDemand,

  /// The app came back to the foreground.
  appResumed,

  /// Connectivity came back.
  connectivityRestored,
}

/// Coalesces drain requests.
///
/// Resume, connectivity and on-demand signals all funnel through one debounce
/// window, so a connection flapping on and off produces a single drain rather
/// than a storm of overlapping passes.
///
/// The lifecycle and connectivity streams are injected rather than observed
/// directly: binding them to real platform sources belongs to the app layer,
/// and keeping them as plain streams means this class is testable without a
/// device.
class SyncTrigger {
  SyncTrigger({
    required this.onTrigger,
    this.debounce = const Duration(seconds: 2),
  });

  /// Runs a drain. Typically `OutboxDrainer.drain`.
  final Future<void> Function(SyncTriggerReason reason) onTrigger;

  /// Requests arriving inside this window collapse into one drain.
  final Duration debounce;

  final List<StreamSubscription<void>> _subscriptions =
      <StreamSubscription<void>>[];

  Timer? _timer;
  SyncTriggerReason? _pendingReason;
  Future<void>? _running;
  bool _closed = false;

  /// Number of drains actually started. Coalesced requests do not each count.
  int get triggerCount => _triggerCount;
  int _triggerCount = 0;

  /// Completes when the most recent drain has finished.
  Future<void> get settled => _running ?? Future<void>.value();

  /// Asks for a drain, subject to the debounce window.
  void request([SyncTriggerReason reason = SyncTriggerReason.onDemand]) {
    if (_closed) return;
    _pendingReason = reason;
    _timer?.cancel();
    _timer = Timer(debounce, _fire);
  }

  /// Drains whenever [onResume] emits.
  void bindResume(Stream<void> onResume) {
    _subscriptions.add(
      onResume.listen((_) => request(SyncTriggerReason.appResumed)),
    );
  }

  /// Drains when connectivity is restored.
  ///
  /// Only the transition into connectivity triggers a drain; staying online
  /// emits nothing, and going offline never does.
  void bindConnectivity(Stream<bool> onConnectivity) {
    var wasOnline = true;
    _subscriptions.add(
      onConnectivity.listen((online) {
        if (online && !wasOnline) {
          request(SyncTriggerReason.connectivityRestored);
        }
        wasOnline = online;
      }),
    );
  }

  void _fire() {
    final reason = _pendingReason ?? SyncTriggerReason.onDemand;
    _pendingReason = null;
    _triggerCount++;
    _running = onTrigger(reason);
  }

  Future<void> close() async {
    _closed = true;
    _timer?.cancel();
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    _subscriptions.clear();
  }
}
