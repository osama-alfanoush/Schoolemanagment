import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';

/// Header that makes a POST/PATCH safe to replay.
const String idempotencyKeyHeader = 'Idempotency-Key';

/// Statuses worth retrying: the request never reached a handler, or a gateway
/// was momentarily unable to serve it.
const Set<int> retryableStatusCodes = <int>{
  HttpStatus.badGateway, // 502
  HttpStatus.serviceUnavailable, // 503
  HttpStatus.gatewayTimeout, // 504
};

/// Methods that can be replayed without changing server state.
const Set<String> idempotentMethods = <String>{
  'GET',
  'HEAD',
  'OPTIONS',
  'PUT',
  'DELETE',
};

/// Exponential backoff with full jitter.
class RetryPolicy {
  const RetryPolicy({
    this.maxAttempts = 3,
    this.baseDelay = const Duration(milliseconds: 300),
    this.maxDelay = const Duration(seconds: 8),
  }) : assert(maxAttempts >= 1, 'maxAttempts must be at least 1');

  /// Total attempts including the first, so 3 means at most 2 retries.
  final int maxAttempts;
  final Duration baseDelay;
  final Duration maxDelay;

  /// Backoff before retry number [attempt] (1-based).
  ///
  /// Full jitter: a uniform pick from `[0, base * 2^(attempt-1)]`, capped at
  /// [maxDelay]. Jitter keeps a fleet of clients from retrying in lockstep
  /// after an outage.
  Duration delayFor(int attempt, Random random) {
    final exponential = baseDelay.inMilliseconds * pow(2, attempt - 1);
    final ceiling = min(exponential.toDouble(), maxDelay.inMilliseconds.toDouble());
    if (ceiling <= 0) return Duration.zero;
    return Duration(milliseconds: random.nextInt(ceiling.toInt() + 1));
  }

  /// Whether [error] is a transient failure on a request that may be replayed.
  bool shouldRetry(DioException error) {
    if (!_isTransient(error)) return false;
    return _isReplayable(error.requestOptions);
  }

  bool _isTransient(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        final status = error.response?.statusCode;
        // Never retry a 4xx: the request itself is the problem.
        return status != null && retryableStatusCodes.contains(status);
      case DioExceptionType.badCertificate:
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        return false;
    }
  }

  bool _isReplayable(RequestOptions options) {
    final method = options.method.toUpperCase();
    if (idempotentMethods.contains(method)) return true;
    // POST/PATCH only when the caller made them idempotent explicitly.
    return _hasIdempotencyKey(options);
  }

  bool _hasIdempotencyKey(RequestOptions options) {
    for (final entry in options.headers.entries) {
      if (entry.key.toLowerCase() == idempotencyKeyHeader.toLowerCase()) {
        final value = entry.value;
        return value != null && value.toString().isNotEmpty;
      }
    }
    return false;
  }
}
