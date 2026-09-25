import 'dart:async';

import 'package:dio/dio.dart';

import 'api_error.dart';
import 'token_store.dart';

/// Path of the rotation endpoint, relative to the injected base URL.
///
/// The server takes the refresh token in the `Authorization` header and returns
/// a fresh `access_token` + `refresh_token` pair.
const String authRefreshPath = '/auth/refresh';

/// Marks a request as the refresh call itself, so the auth interceptor never
/// tries to refresh in response to its failure.
const String refreshRequestFlag = 'school_mobile.is_refresh_request';

/// Serialises refresh-token rotation.
///
/// The server rotates refresh tokens and treats a re-presented token as theft,
/// revoking the whole device family. Two concurrent refreshes would therefore
/// log the user out. [refresh] guarantees that concurrent callers share a
/// single in-flight request: the first caller starts it, every later caller
/// awaits the same future.
class TokenRefreshCoordinator {
  TokenRefreshCoordinator({
    required this.refreshDio,
    required this.tokenStore,
    required this.onUnauthenticated,
  });

  final Dio refreshDio;
  final TokenStore tokenStore;
  final void Function() onUnauthenticated;

  Future<String>? _inFlight;

  /// Number of rotation requests actually issued. Used by tests to prove that
  /// concurrent 401s collapse into one call.
  int get refreshCallCount => _refreshCallCount;
  int _refreshCallCount = 0;

  /// Rotates the token pair, or joins the rotation already running.
  ///
  /// Resolves with the new access token. On failure the store is cleared, an
  /// unauthenticated event is emitted, and the failure is propagated to every
  /// waiter. A failed refresh is never retried.
  Future<String> refresh() {
    // No `await` between the read and the assignment, so on Dart's single
    // event loop this is an atomic check-and-set: only the first caller
    // creates the future.
    return _inFlight ??= _run().whenComplete(() => _inFlight = null);
  }

  Future<String> _run() async {
    final refreshToken = await tokenStore.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      await _failAndClear();
      throw const UnauthorizedError(message: 'No refresh token available.');
    }

    _refreshCallCount++;

    late final Response<dynamic> response;
    try {
      response = await refreshDio.post<dynamic>(
        authRefreshPath,
        options: Options(
          headers: <String, String>{'Authorization': 'Bearer $refreshToken'},
          extra: <String, dynamic>{refreshRequestFlag: true},
        ),
      );
    } on DioException catch (error) {
      await _failAndClear();
      throw UnauthorizedError(
        message: 'Session refresh failed.',
        requestId: requestIdOf(error.response),
      );
    }

    final body = response.data;
    final accessToken = body is Map ? body['access_token'] : null;
    final newRefreshToken = body is Map ? body['refresh_token'] : null;

    if (accessToken is! String || accessToken.isEmpty) {
      await _failAndClear();
      throw UnauthorizedError(
        message: 'Session refresh returned no access token.',
        requestId: requestIdOf(response),
      );
    }

    await tokenStore.writeAccessToken(accessToken);
    if (newRefreshToken is String && newRefreshToken.isNotEmpty) {
      await tokenStore.writeRefreshToken(newRefreshToken);
    }
    return accessToken;
  }

  Future<void> _failAndClear() async {
    await tokenStore.clear();
    onUnauthenticated();
  }
}

/// Reads the correlation id from a response, if the server set one.
String? requestIdOf(Response<dynamic>? response) {
  final value = response?.headers.value(requestIdHeader);
  return (value == null || value.isEmpty) ? null : value;
}
