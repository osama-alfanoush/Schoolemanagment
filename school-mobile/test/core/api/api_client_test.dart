import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';

import '../../support/mock_http_adapter.dart';

/// Base URL for the suite.
///
/// Dio rejects a relative baseUrl off the web platform, so a host is
/// structurally required here. `.test` is reserved by RFC 6761 and never
/// resolves in real DNS, and every test installs [MockHttpAdapter], so no
/// socket is ever opened. This is the same value the work order's own build
/// command uses. Production code under lib/ contains no URL at all.
const String testBaseUrl = 'https://example.test/api';

// Fake credentials. The 'never leaks a secret' test asserts none of these
// reach a log line or an error message.
const String initialAccess = 'access-initial-aaaaaaaaaaaa';
const String rotatedAccess = 'access-rotated-bbbbbbbbbbbb';
const String initialRefresh = 'refresh-initial-cccccccccccc';
const String rotatedRefresh = 'refresh-rotated-dddddddddddd';
const String userPassword = 'sup3r-secret-passphrase';

const String protectedPath = '/protected';

MockReply rotatedTokens({Duration delay = Duration.zero}) => MockReply(
      body: const <String, dynamic>{
        'access_token': rotatedAccess,
        'refresh_token': rotatedRefresh,
        'token_type': 'Bearer',
        'expires_in': 7200,
      },
      delay: delay,
    );

const MockReply unauthorized = MockReply(
  statusCode: 401,
  body: <String, dynamic>{'message': 'Unauthenticated.'},
);

void main() {
  late InMemoryTokenStore store;

  setUp(() {
    store = InMemoryTokenStore(
      accessToken: initialAccess,
      refreshToken: initialRefresh,
      deviceId: 'device-1',
    );
  });

  /// Assembles a client over [responder]; never touches a socket.
  ({ApiClient client, MockHttpAdapter adapter, List<Duration> delays}) build(
    MockResponder responder, {
    RetryPolicy policy = const RetryPolicy(maxAttempts: 1),
    ApiLogSink? logSink,
  }) {
    final adapter = MockHttpAdapter(responder);
    final delays = <Duration>[];
    final client = ApiClient(
      baseUrl: testBaseUrl,
      tokenStore: store,
      adapter: adapter,
      retryPolicy: policy,
      logSink: logSink,
      random: Random(20260831),
      delay: (duration) async => delays.add(duration),
    );
    addTearDown(() => client.close(force: true));
    return (client: client, adapter: adapter, delays: delays);
  }

  group('base URL', () {
    test('is injected and never defaulted', () {
      expect(
        () => ApiClient(baseUrl: '', tokenStore: store),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('401 refresh', () {
    test('refreshes then retries the original request once with the new token',
        () async {
      final harness = build((options) {
        if (options.path == authRefreshPath) return rotatedTokens();
        return options.headers['Authorization'] == 'Bearer $rotatedAccess'
            ? const MockReply(body: <String, dynamic>{'ok': true})
            : unauthorized;
      });

      final response = await harness.client.dio.get<dynamic>(protectedPath);

      expect(response.statusCode, 200);
      expect(harness.adapter.countFor(authRefreshPath), 1);

      final attempts = harness.adapter.requestsFor(protectedPath);
      expect(attempts, hasLength(2), reason: 'original + exactly one retry');
      expect(attempts.first.authorization, 'Bearer $initialAccess');
      expect(attempts.last.authorization, 'Bearer $rotatedAccess');
      expect(await store.readAccessToken(), rotatedAccess);
      expect(await store.readRefreshToken(), rotatedRefresh);
    });

    test('ten concurrent 401s trigger exactly one refresh call', () async {
      final harness = build((options) {
        if (options.path == authRefreshPath) {
          // Held open so all ten waiters genuinely overlap.
          return rotatedTokens(delay: const Duration(milliseconds: 40));
        }
        return options.headers['Authorization'] == 'Bearer $rotatedAccess'
            ? const MockReply(body: <String, dynamic>{'ok': true})
            : unauthorized;
      });

      final responses = await Future.wait<Response<dynamic>>(
        List<Future<Response<dynamic>>>.generate(
          10,
          (index) => harness.client.dio.get<dynamic>('$protectedPath/$index'),
        ),
      );

      expect(responses, hasLength(10));
      expect(responses.every((r) => r.statusCode == 200), isTrue);

      // The whole point of the order: rotation must not race, because the
      // server revokes the device family when a consumed token is replayed.
      expect(harness.adapter.countFor(authRefreshPath), 1);
      expect(harness.client.coordinator.refreshCallCount, 1);
    });

    test('refresh failure clears the store, emits unauthenticated, no retry',
        () async {
      final harness = build((options) => unauthorized);

      final events = <void>[];
      harness.client.onUnauthenticated.listen(events.add);

      await expectLater(
        harness.client.dio.get<dynamic>(protectedPath),
        throwsA(
          isA<DioException>()
              .having((e) => e.error, 'error', isA<UnauthorizedError>()),
        ),
      );
      await Future<void>.delayed(Duration.zero);

      expect(harness.adapter.countFor(authRefreshPath), 1,
          reason: 'a failed refresh is never retried');
      expect(await store.readAccessToken(), isNull);
      expect(await store.readRefreshToken(), isNull);
      expect(events, hasLength(1));
    });

    test('a 401 from the refresh endpoint does not recurse', () async {
      final harness = build((options) => unauthorized);

      await expectLater(
        harness.client.dio.get<dynamic>(protectedPath),
        throwsA(isA<DioException>()),
      );
      // The store is cleared now, so a second call must fail without issuing
      // another rotation request.
      await expectLater(
        harness.client.dio.get<dynamic>(protectedPath),
        throwsA(isA<DioException>()),
      );

      expect(harness.adapter.countFor(authRefreshPath), 1);
      expect(harness.client.coordinator.refreshCallCount, 1);
    });
  });

  group('conditional GET', () {
    test('sends If-None-Match once an ETag is known and surfaces 304',
        () async {
      const String etag = 'W/"items-v1"';
      final harness = build((options) {
        final sent = options.headers['If-None-Match'] ??
            options.headers['if-none-match'];
        if (sent == etag) {
          return const MockReply(statusCode: 304, body: null);
        }
        return const MockReply(
          body: <String, dynamic>{'items': <dynamic>[]},
          headers: <String, List<String>>{
            'etag': <String>[etag],
          },
        );
      });

      final fresh = await harness.client.dio.get<dynamic>('/items');
      expect(fresh.statusCode, 200);
      expect(fresh.isNotModified, isFalse);
      expect(
        harness.adapter.requestsFor('/items').first.hasHeader('If-None-Match'),
        isFalse,
        reason: 'nothing cached yet, so no validator to send',
      );

      final cached = await harness.client.dio.get<dynamic>('/items');
      expect(cached.statusCode, 304);
      expect(cached.isNotModified, isTrue,
          reason: '304 must be distinguishable from 200');

      final second = harness.adapter.requestsFor('/items').last;
      expect(second.header('If-None-Match'), etag);
    });
  });

  group('retry', () {
    test('retries 503 with backoff', () async {
      final harness = build(
        (options) => const MockReply(statusCode: 503, body: <String, dynamic>{}),
        policy: const RetryPolicy(
          maxAttempts: 3,
          baseDelay: Duration(milliseconds: 100),
          maxDelay: Duration(seconds: 2),
        ),
      );

      await expectLater(
        harness.client.dio.get<dynamic>('/flaky'),
        throwsA(
          isA<DioException>()
              .having((e) => e.error, 'error', isA<ServerError>()),
        ),
      );

      expect(harness.adapter.countFor('/flaky'), 3);
      expect(harness.delays, hasLength(2), reason: 'two backoff waits');
      for (final delay in harness.delays) {
        expect(delay, greaterThanOrEqualTo(Duration.zero));
        expect(delay, lessThanOrEqualTo(const Duration(seconds: 2)));
      }
    });

    test('never retries a 422 and exposes its field errors', () async {
      final harness = build(
        (options) => const MockReply(
          statusCode: 422,
          body: <String, dynamic>{
            'message': 'Validation failed',
            'errors': <String, dynamic>{
              'email': <String>['The email field is required.'],
            },
          },
        ),
        policy: const RetryPolicy(maxAttempts: 3),
      );

      Object? captured;
      try {
        await harness.client.dio.get<dynamic>('/invalid');
      } catch (error) {
        captured = error;
      }

      final apiError = apiErrorOf(captured);
      expect(apiError, isA<ValidationError>());
      expect(
        (apiError! as ValidationError).firstErrorFor('email'),
        'The email field is required.',
      );
      expect(harness.adapter.countFor('/invalid'), 1,
          reason: '4xx is never retried');
      expect(harness.delays, isEmpty);
    });

    test('never retries a POST without an Idempotency-Key', () async {
      final harness = build(
        (options) => const MockReply(statusCode: 503, body: <String, dynamic>{}),
        policy: const RetryPolicy(maxAttempts: 3),
      );

      await expectLater(
        harness.client.dio
            .post<dynamic>('/orders', data: const <String, dynamic>{}),
        throwsA(isA<DioException>()),
      );

      expect(harness.adapter.countFor('/orders'), 1);
      expect(harness.delays, isEmpty);
    });

    test('retries a POST that carries an Idempotency-Key', () async {
      final harness = build(
        (options) => const MockReply(statusCode: 503, body: <String, dynamic>{}),
        policy: const RetryPolicy(maxAttempts: 3),
      );

      await expectLater(
        harness.client.dio.post<dynamic>(
          '/orders',
          data: const <String, dynamic>{},
          options: Options(
            headers: <String, String>{idempotencyKeyHeader: 'key-1'},
          ),
        ),
        throwsA(isA<DioException>()),
      );

      expect(harness.adapter.countFor('/orders'), 3);
    });
  });

  group('error typing', () {
    test('loss of connectivity is an OfflineError, not a ServerError',
        () async {
      final harness = build((options) => throw connectionLost(options));

      Object? captured;
      try {
        await harness.client.dio.get<dynamic>('/anything');
      } catch (error) {
        captured = error;
      }

      final apiError = apiErrorOf(captured);
      expect(apiError, isA<OfflineError>());
      expect(apiError, isA<NetworkError>());
      expect(apiError, isNot(isA<ServerError>()));
    });

    test('carries the request id the server returned', () async {
      const String correlationId = 'c0ffee-1234-5678-abcd';
      final harness = build(
        (options) => const MockReply(
          statusCode: 500,
          body: <String, dynamic>{'message': 'Server Error'},
          headers: <String, List<String>>{
            'x-request-id': <String>[correlationId],
          },
        ),
      );

      Object? captured;
      try {
        await harness.client.dio.get<dynamic>('/boom');
      } catch (error) {
        captured = error;
      }

      final apiError = apiErrorOf(captured);
      expect(apiError, isA<ServerError>());
      expect(apiError!.requestId, correlationId);
      expect(apiError.toString(), contains(correlationId));
    });
  });

  group('secret hygiene', () {
    test('never leaks a token, refresh token or password to logs or errors',
        () async {
      final logLines = <String>[];
      final harness = build(
        (options) => const MockReply(
          statusCode: 422,
          body: <String, dynamic>{
            'message': 'Validation failed',
            'errors': <String, dynamic>{
              'password': <String>['The password is incorrect.'],
            },
          },
          headers: <String, List<String>>{
            'x-request-id': <String>['req-77'],
          },
        ),
        logSink: logLines.add,
      );

      Object? captured;
      try {
        await harness.client.dio.post<dynamic>(
          '/auth/change-password',
          data: const <String, dynamic>{
            'current_password': userPassword,
            'new_password': userPassword,
          },
        );
      } catch (error) {
        captured = error;
      }

      // The logger must actually have run, or this test proves nothing.
      expect(logLines, isNotEmpty);
      expect(logLines.join('\n'), contains('/api/auth/change-password'));

      final apiError = apiErrorOf(captured);
      expect(apiError, isA<ValidationError>());

      final haystacks = <String>[
        ...logLines,
        apiError.toString(),
        apiError!.message,
      ];
      const secrets = <String>[
        initialAccess,
        initialRefresh,
        rotatedAccess,
        rotatedRefresh,
        userPassword,
      ];

      for (final haystack in haystacks) {
        for (final secret in secrets) {
          expect(haystack, isNot(contains(secret)),
              reason: 'secret material must never be logged or surfaced');
        }
        expect(haystack, isNot(contains('Bearer ')));
      }
    });
  });
}
