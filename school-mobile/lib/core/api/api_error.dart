import 'dart:io';

import 'package:dio/dio.dart';

/// Name of the correlation id header the API sets on every response
/// (see AssignRequestId::HEADER on the server).
const String requestIdHeader = 'X-Request-Id';

/// Typed failures the HTTP layer can produce.
///
/// Every error carries the server's correlation id when one was returned, so a
/// support conversation can quote it.
///
/// These types are deliberately free of any credential material: [message] is
/// either the server's own `message` field or a fixed string. Request bodies,
/// headers and tokens are never captured here.
sealed class ApiError implements Exception {
  const ApiError({required this.message, this.requestId, this.statusCode});

  /// Safe, human-readable summary. Never contains a token or a request body.
  final String message;

  /// Correlation id echoed by the server, when present.
  final String? requestId;

  /// HTTP status, when the failure came from a response.
  final int? statusCode;

  @override
  String toString() {
    final buffer = StringBuffer('$runtimeType: $message');
    if (statusCode != null) buffer.write(' (status $statusCode)');
    if (requestId != null) buffer.write(' [requestId: $requestId]');
    return buffer.toString();
  }
}

/// Transport failed. See [OfflineError] for the no-connectivity case.
class NetworkError extends ApiError {
  const NetworkError({required super.message, super.requestId, super.statusCode});
}

/// The device could not reach the network at all. Distinct from [ServerError]
/// so the UI can tell the user they are offline rather than blaming the server.
class OfflineError extends NetworkError {
  const OfflineError({super.message = 'No network connectivity.', super.requestId});
}

/// The request or response exceeded its timeout.
class TimeoutError extends ApiError {
  const TimeoutError({super.message = 'The request timed out.', super.requestId});
}

/// 401 — credentials missing, expired, or rejected after a refresh attempt.
class UnauthorizedError extends ApiError {
  const UnauthorizedError({
    super.message = 'Unauthenticated.',
    super.requestId,
    super.statusCode = HttpStatus.unauthorized,
  });
}

/// 403 — authenticated but not permitted. The API also returns this when a
/// token is used outside its purpose (an access token on /auth/refresh).
class ForbiddenError extends ApiError {
  const ForbiddenError({
    super.message = 'Forbidden.',
    super.requestId,
    super.statusCode = HttpStatus.forbidden,
  });
}

/// 404.
class NotFoundError extends ApiError {
  const NotFoundError({
    super.message = 'Resource not found.',
    super.requestId,
    super.statusCode = HttpStatus.notFound,
  });
}

/// 422 — carries the server's per-field messages
/// (`{"message": ..., "errors": {"field": ["..."]}}`).
class ValidationError extends ApiError {
  const ValidationError({
    required super.message,
    required this.fieldErrors,
    super.requestId,
    super.statusCode = HttpStatus.unprocessableEntity,
  });

  final Map<String, List<String>> fieldErrors;

  /// First message recorded against [field], if any.
  String? firstErrorFor(String field) {
    final errors = fieldErrors[field];
    return (errors == null || errors.isEmpty) ? null : errors.first;
  }
}

/// 5xx.
class ServerError extends ApiError {
  const ServerError({
    super.message = 'The server failed to handle the request.',
    super.requestId,
    super.statusCode,
  });
}

/// Anything the layer could not classify.
class UnknownError extends ApiError {
  const UnknownError({super.message = 'An unexpected error occurred.', super.requestId, super.statusCode});
}

/// Unwraps the [ApiError] carried by a thrown [DioException], if there is one.
ApiError? apiErrorOf(Object? error) {
  if (error is ApiError) return error;
  if (error is DioException && error.error is ApiError) return error.error! as ApiError;
  return null;
}
