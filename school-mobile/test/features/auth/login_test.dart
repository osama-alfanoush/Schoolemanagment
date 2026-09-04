import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/session/session.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/auth/auth.dart';

import '../../support/mock_http_adapter.dart';

const String _email = 'rania@example.test';
const String _password = 'correct horse battery staple';
const String _deviceId = 'device-uuid-under-test';

Map<String, Object?> _userPayload({String role = 'parent'}) =>
    <String, Object?>{'id': 42, 'name': 'رانيا', 'role': role};

Map<String, Object?> _successBody({bool mustChangePassword = false}) =>
    <String, Object?>{
      'token': 'access-token-value',
      'access_token': 'access-token-value',
      'refresh_token': 'refresh-token-value',
      'token_type': 'Bearer',
      'expires_in': 7200,
      'must_change_password': mustChangePassword,
      'user': _userPayload(),
    };

/// Builds the whole auth stack over a mocked transport.
({
  AuthRepository repository,
  LoginController controller,
  SessionController session,
  InMemoryTokenStore store,
  MockHttpAdapter adapter,
  List<String> log,
}) buildAuth(
  MockResponder responder, {
  String? deviceId = _deviceId,
}) {
  final adapter = MockHttpAdapter(responder);
  final store = InMemoryTokenStore(deviceId: deviceId);
  final log = <String>[];

  final client = ApiClient(
    baseUrl: 'https://api.test',
    tokenStore: store,
    adapter: adapter,
    logSink: log.add,
  );
  addTearDown(() => client.close(force: true));

  final session = SessionController();
  addTearDown(session.dispose);

  final repository = AuthRepository(
    api: AuthApi(dio: client.dio, tokenStore: store),
    tokenStore: store,
    controller: session,
  );
  final controller = LoginController(repository: repository);
  addTearDown(controller.dispose);

  return (
    repository: repository,
    controller: controller,
    session: session,
    store: store,
    adapter: adapter,
    log: log,
  );
}

Future<void> pumpLogin(
  WidgetTester tester,
  LoginController controller, {
  String locale = 'ar',
}) async {
  await tester.pumpWidget(MaterialApp(
    theme: AppTheme.light(),
    locale: Locale(locale),
    supportedLocales: AppLocales.supported,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: AppI18nScope(
      formats: AppFormats(locale: locale),
      child: LoginScreen(controller: controller),
    ),
  ));
  await tester.pump();
}

void main() {
  group('the login request', () {
    test('carries the device id, without which revocation can never reach us',
        () async {
      // DeviceRegistry.revoke() kills refresh-token families by this binding.
      // Omitting it produces a session nobody can end remotely.
      final auth = buildAuth((options) => MockReply(body: _successBody()));

      await auth.repository.signIn(email: _email, password: _password);

      final request = auth.adapter.requestsFor('/auth/login').single;
      expect(request.json['device_id'], _deviceId);
      expect(request.json['email'], _email);
      expect(request.json['device_name'], isNotNull);
    });

    test('is not sent at all when no device id could be provisioned', () async {
      var attempted = false;
      final auth = buildAuth(
        (options) {
          attempted = true;
          return MockReply(body: _successBody());
        },
        deviceId: null,
      );

      await expectLater(
        auth.repository.signIn(email: _email, password: _password),
        throwsA(isA<LoginFailure>().having(
          (failure) => failure.kind,
          'kind',
          LoginFailureKind.deviceNotReady,
        )),
      );
      expect(attempted, isFalse, reason: 'the request must not go out');
    });

    test('trims the email but never touches the password', () async {
      final auth = buildAuth((options) => MockReply(body: _successBody()));

      await auth.repository.signIn(
        email: '  $_email  ',
        password: '  spaces matter  ',
      );

      final body = auth.adapter.requestsFor('/auth/login').single.json;
      expect(body['email'], _email);
      expect(body['password'], '  spaces matter  ');
    });
  });

  group('a successful login', () {
    test('persists both tokens and signs the session in', () async {
      final auth = buildAuth((options) => MockReply(body: _successBody()));

      final result =
          await auth.repository.signIn(email: _email, password: _password);

      expect(result, isA<LoginSucceeded>());
      expect(await auth.store.readAccessToken(), 'access-token-value');
      expect(await auth.store.readRefreshToken(), 'refresh-token-value');
      expect(auth.session.state.isSignedIn, isTrue);
      expect(auth.session.state.session!.userId, '42');
      expect(auth.session.state.session!.activeRole, AppRole.parent);
    });

    test('survives a restart: the stored token restores the session', () async {
      // First run.
      final first = buildAuth((options) => MockReply(body: _successBody()));
      await first.repository.signIn(email: _email, password: _password);

      final accessToken = await first.store.readAccessToken();
      final refreshToken = await first.store.readRefreshToken();
      final deviceId = await first.store.readDeviceId();

      // Second run: a fresh stack over the same persisted store.
      final restored = buildAuth(
        (options) => MockReply(
          body: <String, Object?>{
            'user': _userPayload(),
            'permissions': <String>[],
          },
        ),
        deviceId: deviceId,
      );
      await restored.store.writeAccessToken(accessToken!);
      await restored.store.writeRefreshToken(refreshToken!);

      await restored.repository.restore();

      expect(restored.session.state.isSignedIn, isTrue);
      expect(restored.session.state.session!.userId, '42');
      expect(restored.adapter.countFor('/auth/me'), 1);
    });

    test('a cold start with no token resolves to signed out, not to unknown',
        () async {
      final auth = buildAuth(
        (options) => const MockReply(statusCode: 401),
        deviceId: _deviceId,
      );

      await auth.repository.restore();

      expect(auth.session.state.status, SessionStatus.signedOut);
      expect(auth.adapter.requests, isEmpty);
    });

    test('a revoked token on cold start signs the user out rather than hanging',
        () async {
      final auth = buildAuth(
        (options) => const MockReply(
          statusCode: 401,
          body: <String, Object?>{'message': 'Unauthenticated.'},
        ),
      );
      await auth.store.writeAccessToken('stale');
      await auth.store.writeRefreshToken('also-stale');

      await auth.repository.restore();

      expect(auth.session.state.status, SessionStatus.signedOut);
    });

    test('reports a temporary password rather than hiding it', () async {
      final auth = buildAuth(
        (options) => MockReply(body: _successBody(mustChangePassword: true)),
      );

      final result =
          await auth.repository.signIn(email: _email, password: _password);

      expect((result as LoginSucceeded).mustChangePassword, isTrue);
    });

    test('a response without tokens is a failure, not a half-session',
        () async {
      // The cookie-bearing variant of this response exists for the web client.
      // Treating it as success would leave the app "signed in" with no token.
      final auth = buildAuth((options) => MockReply(
            body: <String, Object?>{
              'must_change_password': false,
              'user': _userPayload(),
            },
          ));

      await expectLater(
        auth.repository.signIn(email: _email, password: _password),
        throwsA(isA<LoginFailure>()),
      );
      expect(auth.session.state.isSignedIn, isFalse);
      expect(await auth.store.readAccessToken(), isNull);
    });
  });

  group('an MFA challenge', () {
    test('is returned as a challenge and never as a session', () async {
      final auth = buildAuth((options) => const MockReply(
            statusCode: 202,
            body: <String, Object?>{
              'mfa_required': true,
              'mfa_enrollment_required': false,
              'mfa_token': 'challenge-token',
              'token_type': 'Bearer',
              'expires_in': 300,
            },
          ));

      final result =
          await auth.repository.signIn(email: _email, password: _password);

      expect(result, isA<LoginNeedsMfa>());
      expect((result as LoginNeedsMfa).challengeToken, 'challenge-token');
      expect(result.expiresIn, const Duration(seconds: 300));
      // The whole point: no session, and no access token stored.
      expect(auth.session.state.isSignedIn, isFalse);
      expect(await auth.store.readAccessToken(), isNull);
    });
  });

  group('failures map to what the server actually returns', () {
    test('422 is invalid credentials, and says nothing about which half',
        () async {
      final auth = buildAuth((options) => const MockReply(
            statusCode: 422,
            body: <String, Object?>{
              'message': 'Validation failed',
              'errors': <String, Object?>{
                'email': <String>['Invalid credentials.'],
              },
            },
          ));

      await expectLater(
        auth.repository.signIn(email: _email, password: _password),
        throwsA(isA<LoginFailure>().having(
          (failure) => failure.kind,
          'kind',
          LoginFailureKind.invalidCredentials,
        )),
      );
    });

    test('429 with locked_until is a lockout, with the wait attached',
        () async {
      final until = DateTime.now().add(const Duration(minutes: 14, seconds: 30));
      final auth = buildAuth((options) => MockReply(
            statusCode: 429,
            body: <String, Object?>{
              'message': 'Account locked due to too many failed attempts.',
              'locked_until': until.toIso8601String(),
            },
          ));

      try {
        await auth.repository.signIn(email: _email, password: _password);
        fail('expected a LoginFailure');
      } on LoginFailure catch (failure) {
        expect(failure.kind, LoginFailureKind.accountLocked);
        expect(failure.retryInMinutes, 15);
      }
    });

    test('429 without locked_until is the rate limiter, not a lockout',
        () async {
      // Telling a user their account is locked when it is not sends them to
      // the school office to have a lock lifted that does not exist.
      final auth = buildAuth((options) => const MockReply(
            statusCode: 429,
            body: <String, Object?>{'message': 'Too Many Attempts.'},
            headers: <String, List<String>>{
              'Retry-After': <String>['60'],
            },
          ));

      try {
        await auth.repository.signIn(email: _email, password: _password);
        fail('expected a LoginFailure');
      } on LoginFailure catch (failure) {
        expect(failure.kind, LoginFailureKind.tooManyAttempts);
        expect(failure.retryIn, const Duration(seconds: 60));
      }
    });

    test('403 is no active school assignment', () async {
      final auth = buildAuth((options) => const MockReply(
            statusCode: 403,
            body: <String, Object?>{'message': 'Forbidden'},
          ));

      await expectLater(
        auth.repository.signIn(email: _email, password: _password),
        throwsA(isA<LoginFailure>().having(
          (failure) => failure.kind,
          'kind',
          LoginFailureKind.noSchoolAccess,
        )),
      );
    });

    test('a lost connection is offline, not a server fault', () async {
      final auth = buildAuth((options) => throw connectionLost(options));

      await expectLater(
        auth.repository.signIn(email: _email, password: _password),
        throwsA(isA<LoginFailure>().having(
          (failure) => failure.kind,
          'kind',
          LoginFailureKind.offline,
        )),
      );
    });

    test('a 500 carries the correlation id support will ask for', () async {
      final auth = buildAuth((options) => const MockReply(
            statusCode: 500,
            body: <String, Object?>{'message': 'Server error'},
            headers: <String, List<String>>{
              'X-Request-Id': <String>['req_abc123'],
            },
          ));

      try {
        await auth.repository.signIn(email: _email, password: _password);
        fail('expected a LoginFailure');
      } on LoginFailure catch (failure) {
        expect(failure.kind, LoginFailureKind.server);
        expect(failure.requestId, 'req_abc123');
      }
    });
  });

  group('secret hygiene', () {
    test('no password, email or token reaches a log line or a failure',
        () async {
      final auth = buildAuth((options) => const MockReply(
            statusCode: 500,
            body: <String, Object?>{'message': 'Server error'},
          ));

      LoginFailure? captured;
      try {
        await auth.repository.signIn(email: _email, password: _password);
      } on LoginFailure catch (failure) {
        captured = failure;
      }

      final written = <String>[
        ...auth.log,
        captured.toString(),
        auth.controller.state.toString(),
      ].join('\n');

      expect(written, isNot(contains(_password)));
      expect(written, isNot(contains(_email)));
      expect(written, isNot(contains('access-token-value')));
      expect(written, isNot(contains('refresh-token-value')));
    });

    test('a successful login writes no token into the log either', () async {
      final auth = buildAuth((options) => MockReply(body: _successBody()));

      await auth.repository.signIn(email: _email, password: _password);

      final written = auth.log.join('\n');
      expect(written, isNot(contains('access-token-value')));
      expect(written, isNot(contains(_password)));
    });
  });

  group('the login screen', () {
    testWidgets('refuses an empty form before touching the network',
        (tester) async {
      final auth = buildAuth((options) => MockReply(body: _successBody()));
      await pumpLogin(tester, auth.controller);

      await tester.tap(find.byKey(const Key('login-submit')));
      await tester.pumpAndSettle();

      expect(find.text('أدخل البريد الإلكتروني.'), findsOneWidget);
      expect(find.text('أدخل كلمة المرور.'), findsOneWidget);
      expect(auth.adapter.requests, isEmpty);
    });

    testWidgets('rejects a malformed email locally', (tester) async {
      final auth = buildAuth((options) => MockReply(body: _successBody()));
      await pumpLogin(tester, auth.controller);

      await tester.enterText(find.byKey(const Key('login-email')), 'not-email');
      await tester.enterText(find.byKey(const Key('login-password')), 'x');
      await tester.tap(find.byKey(const Key('login-submit')));
      await tester.pumpAndSettle();

      expect(find.text('البريد الإلكتروني غير صالح.'), findsOneWidget);
      expect(auth.adapter.requests, isEmpty);
    });

    testWidgets('submits and signs in', (tester) async {
      final auth = buildAuth((options) => MockReply(body: _successBody()));
      await pumpLogin(tester, auth.controller);

      await tester.enterText(find.byKey(const Key('login-email')), _email);
      await tester.enterText(find.byKey(const Key('login-password')), _password);
      await tester.tap(find.byKey(const Key('login-submit')));
      await tester.pumpAndSettle();

      expect(auth.session.state.isSignedIn, isTrue);
      expect(find.byKey(const Key('login-failure')), findsNothing);
    });

    testWidgets('shows an Arabic message for a lockout, not a raw error',
        (tester) async {
      final until = DateTime.now().add(const Duration(minutes: 15));
      final auth = buildAuth((options) => MockReply(
            statusCode: 429,
            body: <String, Object?>{
              'message': 'Account locked due to too many failed attempts.',
              'locked_until': until.toIso8601String(),
            },
          ));
      await pumpLogin(tester, auth.controller);

      await tester.enterText(find.byKey(const Key('login-email')), _email);
      await tester.enterText(find.byKey(const Key('login-password')), _password);
      await tester.tap(find.byKey(const Key('login-submit')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('login-failure')), findsOneWidget);
      expect(find.textContaining('تم إيقاف الحساب مؤقتًا'), findsOneWidget);
      // Nothing from the server's own English message reaches the screen.
      expect(find.textContaining('Account locked'), findsNothing);
      expect(find.textContaining('429'), findsNothing);
    });

    testWidgets('shows an Arabic message for wrong credentials',
        (tester) async {
      final auth = buildAuth((options) => const MockReply(
            statusCode: 422,
            body: <String, Object?>{
              'message': 'Validation failed',
              'errors': <String, Object?>{
                'email': <String>['Invalid credentials.'],
              },
            },
          ));
      await pumpLogin(tester, auth.controller);

      await tester.enterText(find.byKey(const Key('login-email')), _email);
      await tester.enterText(find.byKey(const Key('login-password')), 'wrong');
      await tester.tap(find.byKey(const Key('login-submit')));
      await tester.pumpAndSettle();

      expect(
        find.text('البريد الإلكتروني أو كلمة المرور غير صحيحة.'),
        findsOneWidget,
      );
      expect(find.textContaining('Invalid credentials'), findsNothing);
    });

    testWidgets('clears a stale failure as soon as the user retypes',
        (tester) async {
      final auth = buildAuth((options) => const MockReply(
            statusCode: 422,
            body: <String, Object?>{'message': 'Validation failed'},
          ));
      await pumpLogin(tester, auth.controller);

      await tester.enterText(find.byKey(const Key('login-email')), _email);
      await tester.enterText(find.byKey(const Key('login-password')), 'wrong');
      await tester.tap(find.byKey(const Key('login-submit')));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('login-failure')), findsOneWidget);

      await tester.enterText(find.byKey(const Key('login-password')), 'w');
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('login-failure')), findsNothing);
    });

    testWidgets('the password is obscured until the user asks otherwise',
        (tester) async {
      final auth = buildAuth((options) => MockReply(body: _successBody()));
      await pumpLogin(tester, auth.controller);

      EditableText passwordField() => tester.widget<EditableText>(
            find.descendant(
              of: find.byKey(const Key('login-password')),
              matching: find.byType(EditableText),
            ),
          );

      expect(passwordField().obscureText, isTrue);

      await tester.tap(find.byKey(const Key('login-password-visibility')));
      await tester.pumpAndSettle();

      expect(passwordField().obscureText, isFalse);
    });

    testWidgets('renders in both locales at 200% text scale without clipping',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      for (final locale in <String>['ar', 'en']) {
        final auth = buildAuth((options) => MockReply(body: _successBody()));

        await tester.pumpWidget(MaterialApp(
          theme: AppTheme.light(),
          locale: Locale(locale),
          supportedLocales: AppLocales.supported,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: Builder(
            builder: (context) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(2.0)),
              child: AppI18nScope(
                formats: AppFormats(locale: locale),
                child: LoginScreen(controller: auth.controller),
              ),
            ),
          ),
        ));
        await tester.pump();

        expect(tester.takeException(), isNull, reason: locale);
        expect(find.byKey(const Key('login-submit')), findsOneWidget);
      }
    });

    testWidgets('the submit button meets the minimum tap target',
        (tester) async {
      final auth = buildAuth((options) => MockReply(body: _successBody()));
      await pumpLogin(tester, auth.controller);

      expect(
        tester.getSize(find.byKey(const Key('login-submit'))).height,
        greaterThanOrEqualTo(48),
      );
    });
  });
}
