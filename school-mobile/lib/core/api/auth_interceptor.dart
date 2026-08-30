import 'dart:io';

import 'package:dio/dio.dart';

import 'api_error.dart';
import 'token_refresh_coordinator.dart';
import 'token_store.dart';

/// Marks a request that has already been retried after a refresh, so a second
/// 401 fails instead of looping.
const String authRetriedFlag = 'school_mobile.auth_retried';

/// Attaches the bearer token and recovers from a single expired-token 401.
///
/// On 401 the interceptor asks [TokenRefreshCoordinator] for a fresh token —
/// which collapses concurrent callers into one rotation — and replays the
/// original request exactly once.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.dio,
    required this.tokenStore,
    required this.coordinator,
  });

  final Dio dio;
  final TokenStore tokenStore;
  final TokenRefreshCoordinator coordinator;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // The refresh call carries the refresh token itself; never overwrite it.
    if (options.extra[refreshRequestFlag] == true) {
      handler.next(options);
      return;
    }

    final token = await tokenStore.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldAttemptRefresh(err)) {
      handler.next(err);
      return;
    }

    final String accessToken;
    try {
      accessToken = await coordinator.refresh();
    } on ApiError catch (error) {
      // Refresh failed: the store is already cleared and the unauthenticated
      // event emitted by the coordinator. Never retry the refresh.
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: err.type,
          error: error,
        ),
      );
      return;
    }

    final retryOptions = err.requestOptions
      ..headers['Authorization'] = 'Bearer $accessToken'
      ..extra[authRetriedFlag] = true;

    try {
      final response = await dio.fetch<dynamic>(retryOptions);
      handler.resolve(response);
    } on DioException catch (error) {
      handler.next(error);
    }
  }

  bool _shouldAttemptRefresh(DioException err) {
    if (err.response?.statusCode != HttpStatus.unauthorized) return false;
    // A 401 from the rotation endpoint must never start another rotation.
    if (err.requestOptions.extra[refreshRequestFlag] == true) return false;
    // One retry only.
    if (err.requestOptions.extra[authRetriedFlag] == true) return false;
    return true;
  }
}
