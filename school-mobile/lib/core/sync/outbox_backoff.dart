import 'dart:math';

import '../db/app_database.dart';

/// Exponential backoff with full jitter, for outbox retries.
///
/// Extends the database's [OutboxBackoff] so it can be handed straight to
/// `markFailed`, adding the jitter that keeps a fleet of devices coming back
/// online together from retrying in lockstep.
///
/// Full jitter: a uniform pick from `[0, base * 2^(attempts-1)]`, and the
/// ceiling is [OutboxBackoff.max] — six hours by default, so a row that keeps
/// failing backs off to a few attempts a day rather than hammering the server.
class JitteredOutboxBackoff extends OutboxBackoff {
  JitteredOutboxBackoff({
    super.base = const Duration(seconds: 30),
    super.max = const Duration(hours: 6),
    Random? random,
  }) : _random = random ?? Random();

  final Random _random;

  /// The outbox stores times to the whole second. A pick below that rounds
  /// back to "now", and the same drain pass claims the row again: an attempt
  /// spent with no backoff at all, repeatable until the row goes dead.
  static const Duration resolution = Duration(seconds: 1);

  @override
  Duration delayFor(int attempts) {
    final ceiling = super.delayFor(attempts).inMilliseconds;
    if (ceiling <= 0) return Duration.zero;
    final floor = min(resolution.inMilliseconds, ceiling);
    return Duration(milliseconds: max(floor, _random.nextInt(ceiling + 1)));
  }
}

/// Zero delay, used when recovering a row abandoned by a killed drain.
///
/// That failure was ours, not the server's, so the row is eligible again
/// immediately rather than being punished with a backoff.
const OutboxBackoff immediateRetry =
    OutboxBackoff(base: Duration.zero, max: Duration.zero);
