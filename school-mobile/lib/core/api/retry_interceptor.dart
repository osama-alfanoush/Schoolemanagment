import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';

import 'retry_policy.dart';

/// Tracks how many times a request has been replayed.
const String retryAttemptKey = 'school_mobile.retry_attempt';

/// Replays transient failures with exponential backoff and jitter.
///
/// Classification lives in [RetryPolicy]: 4xx is never retried, and POST/PATCH
/// only when the caller supplied an `Idempotency-Key`.
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    this.policy = const RetryPolicy(),
    Random? random,
    Future<void> Function(Duration)? delay,
  })  : _random = random ?? Random(),
        _delay = delay ?? Future<void>.delayed;

  final Dio dio;
  final RetryPolicy policy;
  final Random _random;
  final Future<void> Function(Duration) _delay;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final attempt = (err.requestOptions.extra[retryAttemptKey] as int? ?? 0) + 1;

    if (attempt >= policy.maxAttempts || !policy.shouldRetry(err)) {
      handler.next(err);
      return;
    }

    await _delay(policy.delayFor(attempt, _random));

    final options = err.requestOptions..extra[retryAttemptKey] = attempt;
    try {
      handler.resolve(await dio.fetch<dynamic>(options));
    } on DioException catch (error) {
      handler.next(error);
    }
  }
}
