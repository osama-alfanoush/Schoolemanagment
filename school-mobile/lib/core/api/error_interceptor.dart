import 'dart:io';

import 'package:dio/dio.dart';

import 'api_error.dart';
import 'token_refresh_coordinator.dart';

/// Converts Dio's transport failures into the typed [ApiError] hierarchy.
///
/// The resulting error carries only the server's own `message`, the status and
/// the correlation id. Request bodies, headers and tokens are never copied in.
class ErrorInterceptor extends Interceptor {
  const ErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Preserve an ApiError another interceptor already produced.
    final existing = apiErrorOf(err.error);
    if (existing != null) {
      handler.next(err);
      return;
    }

    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: _map(err),
      ),
    );
  }

  ApiError _map(DioException err) {
    final requestId = requestIdOf(err.response);

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return TimeoutError(requestId: requestId);
      case DioExceptionType.connectionError:
        return OfflineError(requestId: requestId);
      case DioExceptionType.badCertificate:
        return NetworkError(
          message: 'The server certificate was rejected.',
          requestId: requestId,
        );
      case DioExceptionType.cancel:
        return UnknownError(message: 'The request was cancelled.', requestId: requestId);
      case DioExceptionType.unknown:
        if (err.error is SocketException) return OfflineError(requestId: requestId);
        return UnknownError(requestId: requestId);
      case DioExceptionType.badResponse:
        return _mapResponse(err.response, requestId);
    }
  }

  ApiError _mapResponse(Response<dynamic>? response, String? requestId) {
    final status = response?.statusCode;
    final body = response?.data;
    final serverMessage = (body is Map && body['message'] is String)
        ? body['message'] as String
        : null;

    switch (status) {
      case HttpStatus.unauthorized:
        return UnauthorizedError(
          message: serverMessage ?? 'Unauthenticated.',
          requestId: requestId,
        );
      case HttpStatus.forbidden:
        return ForbiddenError(
          message: serverMessage ?? 'Forbidden.',
          requestId: requestId,
        );
      case HttpStatus.notFound:
        return NotFoundError(
          message: serverMessage ?? 'Resource not found.',
          requestId: requestId,
        );
      case HttpStatus.unprocessableEntity:
        return ValidationError(
          message: serverMessage ?? 'Validation failed.',
          fieldErrors: _fieldErrors(body),
          requestId: requestId,
        );
    }

    if (status != null && status >= 500) {
      return ServerError(
        message: serverMessage ?? 'The server failed to handle the request.',
        requestId: requestId,
        statusCode: status,
      );
    }

    return UnknownError(
      message: serverMessage ?? 'An unexpected error occurred.',
      requestId: requestId,
      statusCode: status,
    );
  }

  /// Reads `{"errors": {"field": ["message", ...]}}` as the API returns it.
  Map<String, List<String>> _fieldErrors(Object? body) {
    if (body is! Map) return const <String, List<String>>{};
    final errors = body['errors'];
    if (errors is! Map) return const <String, List<String>>{};

    final result = <String, List<String>>{};
    errors.forEach((key, value) {
      if (value is List) {
        result['$key'] = value.map((item) => '$item').toList(growable: false);
      } else if (value is String) {
        result['$key'] = <String>[value];
      }
    });
    return result;
  }
}
