import 'package:school_mobile/core/lock/lock.dart';

/// A [BiometricGate] that answers whatever the test says, and records how many
/// times it was asked.
///
/// The real gate opens an OS prompt over a platform channel, which no test host
/// provides. Faking the prompt — and nothing else — keeps the lock's own rules
/// under test: when it engages, and what each outcome does.
class FakeBiometricGate implements BiometricGate {
  FakeBiometricGate({
    this.available = true,
    this.outcome = UnlockOutcome.succeeded,
  });

  bool available;
  UnlockOutcome outcome;

  /// Prompts shown. A lock that never prompts is not a lock.
  int prompts = 0;

  /// The reason string the last prompt was given, so a test can assert it is
  /// the user's language rather than a hard-coded English one.
  String? lastReason;

  @override
  Future<bool> isAvailable() async => available;

  @override
  Future<UnlockOutcome> unlock({required String reason}) async {
    prompts++;
    lastReason = reason;

    return outcome;
  }
}
