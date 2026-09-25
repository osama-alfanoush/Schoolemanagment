import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';

import 'api_log.dart';
import 'auth_interceptor.dart';
import 'error_interceptor.dart';
import 'etag_interceptor.dart';
import 'etag_store.dart';
import 'retry_interceptor.dart';
import 'retry_policy.dart';
import 'token_refresh_coordinator.dart';
import 'token_store.dart';

/// Builds the app's configured [Dio] and owns the state the interceptors share.
///
/// The base URL is always injected — there is no default, and no host appears
/// anywhere in this layer.
class ApiClient {
  ApiClient({
    required String baseUrl,
    required this.tokenStore,
    Duration connectTimeout = const Duration(seconds: 10),
    Duration receiveTimeout = const Duration(seconds: 20),
    EtagStore? etagStore,
    RetryPolicy retryPolicy = const RetryPolicy(),
    HttpClientAdapter? adapter,
    ApiLogSink? logSink,
    Random? random,
    Future<void> Function(Duration)? delay,
  }) : etagStore = etagStore ?? InMemoryEtagStore() {
    if (baseUrl.isEmpty) {
      throw ArgumentError.value(baseUrl, 'baseUrl', 'must not be empty');
    }

    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      // 304 is a successful conditional GET, not a failure.
      validateStatus: (status) =>
          status != null &&
          ((status >= HttpStatus.ok && status < HttpStatus.multipleChoices) ||
              status == HttpStatus.notModified),
    );

    dio = Dio(options);
    // Rotation runs on its own Dio so it can never re-enter the auth or retry
    // interceptors, which is what makes a 401 on /auth/refresh terminal.
    _refreshDio = Dio(options);

    if (adapter != null) {
      dio.httpClientAdapter = adapter;
      _refreshDio.httpClientAdapter = adapter;
    }

    coordinator = TokenRefreshCoordinator(
      refreshDio: _refreshDio,
      tokenStore: tokenStore,
      onUnauthenticated: _emitUnauthenticated,
    );

    dio.interceptors.addAll(<Interceptor>[
      if (logSink != null) ApiLogInterceptor(logSink),
      EtagInterceptor(store: this.etagStore),
      AuthInterceptor(
        dio: dio,
        tokenStore: tokenStore,
        coordinator: coordinator,
      ),
      RetryInterceptor(
        dio: dio,
        policy: retryPolicy,
        random: random,
        delay: delay,
      ),
      const ErrorInterceptor(),
    ]);
  }

  /// The configured client. Hand this to feature code.
  late final Dio dio;

  /// Validator cache backing conditional GETs.
  final EtagStore etagStore;

  /// Rotation coordinator; [TokenRefreshCoordinator.refreshCallCount] is useful
  /// in tests.
  late final TokenRefreshCoordinator coordinator;

  final TokenStore tokenStore;
  late final Dio _refreshDio;

  final StreamController<void> _unauthenticated =
      StreamController<void>.broadcast();

  /// Fires when the session is gone for good: refresh failed, the store has
  /// been cleared, and the app layer should return the user to sign-in.
  Stream<void> get onUnauthenticated => _unauthenticated.stream;

  void _emitUnauthenticated() {
    if (!_unauthenticated.isClosed) _unauthenticated.add(null);
  }

  /// Releases the client's resources.
  Future<void> close({bool force = false}) async {
    dio.close(force: force);
    _refreshDio.close(force: force);
    await _unauthenticated.close();
  }
}
