import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/router/router.dart';
import 'package:school_mobile/core/session/session.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/auth/auth.dart';

import '../../support/mock_http_adapter.dart';

const String _email = 'principal@example.test';
const String _password = 'correct horse battery staple';
const String _deviceId = 'device-uuid-under-test';
const String _challengeToken = 'mfa-challenge-token';

const Map<String, Object?> _mfaChallengeBody = <String, Object?>{
  'mfa_required': true,
  'mfa_enrollment_required': false,
  'mfa_token': _challengeToken,
  'token_type': 'Bearer',
  'expires_in': 300,
};

Map<String, Object?> _tokens() => <String, Object?>{
      'access_token': 'access-token-value',
      'refresh_token': 'refresh-token-value',
      'token_type': 'Bearer',
      'expires_in': 7200,
    };

Map<String, Object?> _mePayload({bool mustChangePassword = false}) =>
    <String, Object?>{
      'user': <String, Object?>{
        'id': 7,
        'name': 'سامي',
        'role': 'teacher',
        'must_change_password': mustChangePassword,
      },
      'permissions': <String>[],
    };

({
  AuthRepository repository,
  SessionController session,
  InMemoryTokenStore store,
  MockHttpAdapter adapter,
  List<String> log,
}) buildAuth(MockResponder responder, {String? accessToken}) {
  final adapter = MockHttpAdapter(responder);
  final store = InMemoryTokenStore(deviceId: _deviceId, accessToken: accessToken);
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

  return (
    repository: AuthRepository(
      api: AuthApi(dio: client.dio, tokenStore: store),
      tokenStore: store,
      controller: session,
    ),
    session: session,
    store: store,
    adapter: adapter,
    log: log,
  );
}

Future<void> pumpAuth(
  WidgetTester tester,
  AuthRepository repository, {
  String locale = 'ar',
}) async {
  await tester.pumpWidget(MaterialApp(
    theme: AppTheme.light(),
    locale: Locale(locale),
    supportedLocales: AppLocales.supported,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: AppI18nScope(
      formats: AppFormats(locale: locale),
      child: AuthGateway(repository: repository),
    ),
  ));
  await tester.pump();
}

Future<void> signIn(WidgetTester tester) async {
  await tester.enterText(find.byKey(const Key('login-email')), _email);
  await tester.enterText(find.byKey(const Key('login-password')), _password);
  await tester.tap(find.byKey(const Key('login-submit')));
  await tester.pumpAndSettle();
}

void main() {
  group('the MFA challenge', () {
    test('sends the challenge grant, not a stored token', () async {
      // The grant is never written to the token store: doing so would make the
      // interceptor, the refresh coordinator and the router all read the app
      // as signed in while the second factor is still outstanding.
      final auth = buildAuth((options) => switch (options.path) {
            '/auth/login' =>
              const MockReply(statusCode: 202, body: _mfaChallengeBody),
            '/auth/mfa/challenge' => MockReply(body: _tokens()),
            '/auth/me' => MockReply(body: _mePayload()),
            _ => const MockReply(statusCode: 404),
          });

      final challenge = await auth.repository
          .signIn(email: _email, password: _password) as LoginNeedsMfa;
      expect(await auth.store.readAccessToken(), isNull);

      await auth.repository.completeMfaChallenge(
        challengeToken: challenge.challengeToken,
        code: '123456',
      );

      final request = auth.adapter.requestsFor('/auth/mfa/challenge').single;
      expect(request.authorization, 'Bearer $_challengeToken');
      expect(request.json['code'], '123456');
      expect(request.json.containsKey('recovery_code'), isFalse);
    });

    test('a stale access token cannot shadow the challenge grant', () async {
      // Login clears the store before it attempts, so nothing left over from a
      // previous session can be attached in place of the grant.
      final auth = buildAuth(
        (options) => switch (options.path) {
          '/auth/login' =>
            const MockReply(statusCode: 202, body: _mfaChallengeBody),
          '/auth/mfa/challenge' => MockReply(body: _tokens()),
          '/auth/me' => MockReply(body: _mePayload()),
          _ => const MockReply(statusCode: 404),
        },
        accessToken: 'stale-token-from-a-previous-session',
      );

      final challenge = await auth.repository
          .signIn(email: _email, password: _password) as LoginNeedsMfa;
      await auth.repository.completeMfaChallenge(
        challengeToken: challenge.challengeToken,
        code: '123456',
      );

      expect(
        auth.adapter.requestsFor('/auth/mfa/challenge').single.authorization,
        'Bearer $_challengeToken',
      );
    });

    test('sends a recovery code alone when that is what was entered', () async {
      final auth = buildAuth((options) => switch (options.path) {
            '/auth/mfa/challenge' => MockReply(body: _tokens()),
            '/auth/me' => MockReply(body: _mePayload()),
            _ => const MockReply(statusCode: 404),
          });

      await auth.repository.completeMfaChallenge(
        challengeToken: _challengeToken,
        recoveryCode: 'ABCD-EFGH',
      );

      final body = auth.adapter.requestsFor('/auth/mfa/challenge').single.json;
      expect(body['recovery_code'], 'ABCD-EFGH');
      expect(body.containsKey('code'), isFalse);
    });

    test('opens the session only after the user has been fetched', () async {
      final auth = buildAuth((options) => switch (options.path) {
            '/auth/mfa/challenge' => MockReply(body: _tokens()),
            '/auth/me' => MockReply(body: _mePayload()),
            _ => const MockReply(statusCode: 404),
          });

      await auth.repository.completeMfaChallenge(
        challengeToken: _challengeToken,
        code: '123456',
      );

      expect(auth.session.state.isSignedIn, isTrue);
      expect(auth.session.state.session!.activeRole, AppRole.teacher);
      expect(await auth.store.readAccessToken(), 'access-token-value');
      expect(auth.adapter.countFor('/auth/me'), 1);
    });

    test('a wrong code leaves no session and no stored token', () async {
      final auth = buildAuth((options) => switch (options.path) {
            '/auth/mfa/challenge' => const MockReply(
                statusCode: 422,
                body: <String, Object?>{
                  'message': 'Validation failed',
                  'errors': <String, Object?>{
                    'code': <String>['Invalid authentication or recovery code.'],
                  },
                },
              ),
            _ => const MockReply(statusCode: 404),
          });

      await expectLater(
        auth.repository.completeMfaChallenge(
          challengeToken: _challengeToken,
          code: '000000',
        ),
        throwsA(isA<MfaFailure>().having(
          (failure) => failure.kind,
          'kind',
          MfaFailureKind.invalidCode,
        )),
      );
      expect(auth.session.state.isSignedIn, isFalse);
      expect(await auth.store.readAccessToken(), isNull);
    });

    test('an expired grant is told apart from a wrong code', () async {
      // Retyping cannot fix an expired grant; the user has to start again, and
      // the message has to say so.
      final auth = buildAuth((options) => const MockReply(
            statusCode: 401,
            body: <String, Object?>{'message': 'Unauthenticated.'},
          ));

      try {
        await auth.repository.completeMfaChallenge(
          challengeToken: _challengeToken,
          code: '123456',
        );
        fail('expected an MfaFailure');
      } on MfaFailure catch (failure) {
        expect(failure.kind, MfaFailureKind.challengeExpired);
        expect(failure.needsFreshSignIn, isTrue);
      }
    });

    test('an incomplete enrollment is its own outcome', () async {
      final auth = buildAuth((options) => const MockReply(
            statusCode: 409,
            body: <String, Object?>{'message': 'MFA enrollment is incomplete.'},
          ));

      try {
        await auth.repository.completeMfaChallenge(
          challengeToken: _challengeToken,
          code: '123456',
        );
        fail('expected an MfaFailure');
      } on MfaFailure catch (failure) {
        expect(failure.kind, MfaFailureKind.enrollmentIncomplete);
        expect(failure.needsFreshSignIn, isTrue);
      }
    });

    test('no code or token reaches a log line or a failure', () async {
      final auth = buildAuth((options) => const MockReply(
            statusCode: 422,
            body: <String, Object?>{'message': 'Validation failed'},
          ));

      MfaFailure? captured;
      try {
        await auth.repository.completeMfaChallenge(
          challengeToken: _challengeToken,
          code: '424242',
        );
      } on MfaFailure catch (failure) {
        captured = failure;
      }

      final written = <String>[...auth.log, captured.toString()].join('\n');
      expect(written, isNot(contains('424242')));
      expect(written, isNot(contains(_challengeToken)));
    });
  });

  group('the MFA screen', () {
    testWidgets('a privileged account is held at the challenge, not let past',
        (tester) async {
      final auth = buildAuth((options) => switch (options.path) {
            '/auth/login' =>
              const MockReply(statusCode: 202, body: _mfaChallengeBody),
            _ => const MockReply(statusCode: 404),
          });
      await pumpAuth(tester, auth.repository);
      await signIn(tester);

      expect(find.byKey(const Key('mfa-entry')), findsOneWidget);
      expect(find.text('التحقق بخطوتين'), findsWidgets);
      expect(auth.session.state.isSignedIn, isFalse);
    });

    testWidgets('a six-digit code is required before anything is sent',
        (tester) async {
      final auth = buildAuth((options) => switch (options.path) {
            '/auth/login' =>
              const MockReply(statusCode: 202, body: _mfaChallengeBody),
            _ => const MockReply(statusCode: 404),
          });
      await pumpAuth(tester, auth.repository);
      await signIn(tester);

      await tester.enterText(find.byKey(const Key('mfa-entry')), '123');
      await tester.tap(find.byKey(const Key('mfa-submit')));
      await tester.pumpAndSettle();

      expect(find.text('الرمز غير مكتمل.'), findsOneWidget);
      expect(auth.adapter.countFor('/auth/mfa/challenge'), 0);
    });

    testWidgets('a valid code signs the user in', (tester) async {
      final auth = buildAuth((options) => switch (options.path) {
            '/auth/login' =>
              const MockReply(statusCode: 202, body: _mfaChallengeBody),
            '/auth/mfa/challenge' => MockReply(body: _tokens()),
            '/auth/me' => MockReply(body: _mePayload()),
            _ => const MockReply(statusCode: 404),
          });
      await pumpAuth(tester, auth.repository);
      await signIn(tester);

      await tester.enterText(find.byKey(const Key('mfa-entry')), '123456');
      await tester.tap(find.byKey(const Key('mfa-submit')));
      await tester.pumpAndSettle();

      expect(auth.session.state.isSignedIn, isTrue);
    });

    testWidgets('a wrong code shows an Arabic message and keeps the form',
        (tester) async {
      final auth = buildAuth((options) => switch (options.path) {
            '/auth/login' =>
              const MockReply(statusCode: 202, body: _mfaChallengeBody),
            '/auth/mfa/challenge' => const MockReply(
                statusCode: 422,
                body: <String, Object?>{'message': 'Validation failed'},
              ),
            _ => const MockReply(statusCode: 404),
          });
      await pumpAuth(tester, auth.repository);
      await signIn(tester);

      await tester.enterText(find.byKey(const Key('mfa-entry')), '000000');
      await tester.tap(find.byKey(const Key('mfa-submit')));
      await tester.pumpAndSettle();

      expect(find.text('الرمز غير صحيح. حاول مرة أخرى.'), findsOneWidget);
      expect(find.byKey(const Key('mfa-entry')), findsOneWidget);
      expect(auth.session.state.isSignedIn, isFalse);
    });

    testWidgets('an expired grant becomes a dead end with a way back',
        (tester) async {
      final auth = buildAuth((options) => switch (options.path) {
            '/auth/login' =>
              const MockReply(statusCode: 202, body: _mfaChallengeBody),
            '/auth/mfa/challenge' => const MockReply(statusCode: 401),
            _ => const MockReply(statusCode: 404),
          });
      await pumpAuth(tester, auth.repository);
      await signIn(tester);

      await tester.enterText(find.byKey(const Key('mfa-entry')), '123456');
      await tester.tap(find.byKey(const Key('mfa-submit')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('mfa-dead-end')), findsOneWidget);

      await tester.tap(find.text('العودة إلى تسجيل الدخول'));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('login-submit')), findsOneWidget);
    });

    testWidgets('recovery-code entry replaces the digit-only field',
        (tester) async {
      final auth = buildAuth((options) => switch (options.path) {
            '/auth/login' =>
              const MockReply(statusCode: 202, body: _mfaChallengeBody),
            '/auth/mfa/challenge' => MockReply(body: _tokens()),
            '/auth/me' => MockReply(body: _mePayload()),
            _ => const MockReply(statusCode: 404),
          });
      await pumpAuth(tester, auth.repository);
      await signIn(tester);

      await tester.tap(find.byKey(const Key('mfa-toggle-credential')));
      await tester.pumpAndSettle();

      // A recovery code is letters and dashes; the digit-only formatter would
      // silently eat it, so switching has to change the field, not just the
      // label.
      await tester.enterText(find.byKey(const Key('mfa-entry')), 'ABCD-EFGH');
      await tester.tap(find.byKey(const Key('mfa-submit')));
      await tester.pumpAndSettle();

      final body = auth.adapter.requestsFor('/auth/mfa/challenge').single.json;
      expect(body['recovery_code'], 'ABCD-EFGH');
    });

    testWidgets('an account that never enrolled is told where to go',
        (tester) async {
      final auth = buildAuth((options) => switch (options.path) {
            '/auth/login' => const MockReply(
                statusCode: 202,
                body: <String, Object?>{
                  'mfa_required': true,
                  'mfa_enrollment_required': true,
                  'mfa_token': _challengeToken,
                  'token_type': 'Bearer',
                  'expires_in': 300,
                },
              ),
            _ => const MockReply(statusCode: 404),
          });
      await pumpAuth(tester, auth.repository);
      await signIn(tester);

      expect(find.byKey(const Key('mfa-enrollment-required')), findsOneWidget);
      expect(find.byKey(const Key('mfa-entry')), findsNothing);
      expect(auth.session.state.isSignedIn, isFalse);
    });
  });

  group('a forced password change', () {
    testWidgets('blocks every screen until the password is replaced',
        (tester) async {
      final auth = buildAuth((options) => switch (options.path) {
            '/auth/change-password' => MockReply(body: <String, Object?>{
                'message': 'Password updated',
                ..._tokens(),
              }),
            _ => const MockReply(statusCode: 404),
          });

      auth.session.signedIn(
        AppSession(
          userId: '7',
          displayName: 'سامي',
          roles: const <AppRole>[AppRole.teacher],
        ),
        mustChangePassword: true,
      );

      final changePassword =
          ChangePasswordController(repository: auth.repository);
      addTearDown(changePassword.dispose);

      final router = buildAppRouter(
        controller: auth.session,
        screens: const AppScreens().withScreen(
          AppRoute.changePassword,
          (context, state) => ChangePasswordScreen(controller: changePassword),
        ),
      );
      addTearDown(router.dispose);

      await tester.pumpWidget(MaterialApp.router(
        theme: AppTheme.light(),
        locale: const Locale('ar'),
        supportedLocales: AppLocales.supported,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        routerConfig: router,
      ));
      await tester.pumpAndSettle();

      // The gate is closed: no shell, no tabs.
      expect(
        router.routerDelegate.currentConfiguration.uri.path,
        AppRoute.changePassword.path,
      );
      expect(find.byType(NavigationBar), findsNothing);

      // And it holds against an attempt to navigate straight past it.
      router.go(AppRoute.teacherToday.path);
      await tester.pumpAndSettle();
      expect(
        router.routerDelegate.currentConfiguration.uri.path,
        AppRoute.changePassword.path,
      );

      await tester.enterText(
        find.byKey(const Key('current-password')),
        'Temp1234',
      );
      await tester.enterText(
        find.byKey(const Key('new-password')),
        'Newpass1word',
      );
      await tester.enterText(
        find.byKey(const Key('confirm-password')),
        'Newpass1word',
      );
      await tester.ensureVisible(find.byKey(const Key('change-password-submit')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('change-password-submit')));
      await tester.pumpAndSettle();

      // Replaced: the gate lifts and the teacher lands in their own shell.
      expect(auth.session.state.mustChangePassword, isFalse);
      expect(
        router.routerDelegate.currentConfiguration.uri.path,
        AppRoute.teacherToday.path,
      );
      expect(find.byType(NavigationBar), findsOneWidget);
    });

    test('rotated tokens are stored, so the next call is not a mystery 401',
        () async {
      final auth = buildAuth((options) => const MockReply(body: <String, Object?>{
            'message': 'Password updated',
            'access_token': 'rotated-access',
            'refresh_token': 'rotated-refresh',
          }));
      await auth.store.writeAccessToken('old-access');
      await auth.store.writeRefreshToken('old-refresh');

      await auth.repository.changePassword(
        currentPassword: 'Temp1234',
        newPassword: 'Newpass1word',
      );

      // The server deletes every token and issues a new pair; keeping the old
      // ones would 401 on the very next request.
      expect(await auth.store.readAccessToken(), 'rotated-access');
      expect(await auth.store.readRefreshToken(), 'rotated-refresh');
    });

    test('a wrong current password is told apart from a rejected new one',
        () async {
      final auth = buildAuth((options) => const MockReply(
            statusCode: 422,
            body: <String, Object?>{
              'message': 'Validation failed',
              'errors': <String, Object?>{
                'current_password': <String>['Incorrect password.'],
              },
            },
          ));

      try {
        await auth.repository.changePassword(
          currentPassword: 'wrong',
          newPassword: 'Newpass1word',
        );
        fail('expected a PasswordChangeFailure');
      } on PasswordChangeFailure catch (failure) {
        expect(failure.kind, PasswordChangeFailureKind.currentPasswordIncorrect);
      }
    });

    testWidgets('the client checks the server rules before a round trip',
        (tester) async {
      final auth = buildAuth((options) => const MockReply(statusCode: 500));
      final controller = ChangePasswordController(repository: auth.repository);
      addTearDown(controller.dispose);

      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.light(),
        locale: const Locale('ar'),
        supportedLocales: AppLocales.supported,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: ChangePasswordScreen(controller: controller),
      ));
      await tester.pump();

      await tester.enterText(
        find.byKey(const Key('current-password')),
        'Temp1234',
      );
      await tester.enterText(find.byKey(const Key('new-password')), 'short1');
      await tester.enterText(find.byKey(const Key('confirm-password')), 'short1');
      await tester.ensureVisible(find.byKey(const Key('change-password-submit')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('change-password-submit')));
      await tester.pumpAndSettle();

      expect(find.text('كلمة المرور قصيرة جدًا.'), findsOneWidget);
      expect(auth.adapter.requests, isEmpty);
    });

    testWidgets('a mismatched confirmation is caught locally', (tester) async {
      final auth = buildAuth((options) => const MockReply(statusCode: 500));
      final controller = ChangePasswordController(repository: auth.repository);
      addTearDown(controller.dispose);

      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.light(),
        locale: const Locale('ar'),
        supportedLocales: AppLocales.supported,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: ChangePasswordScreen(controller: controller),
      ));
      await tester.pump();

      await tester.enterText(
        find.byKey(const Key('current-password')),
        'Temp1234',
      );
      await tester.enterText(
        find.byKey(const Key('new-password')),
        'Newpass1word',
      );
      await tester.enterText(
        find.byKey(const Key('confirm-password')),
        'Newpass2word',
      );
      await tester.ensureVisible(find.byKey(const Key('change-password-submit')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('change-password-submit')));
      await tester.pumpAndSettle();

      expect(find.text('كلمتا المرور غير متطابقتين.'), findsOneWidget);
      expect(auth.adapter.requests, isEmpty);
    });

    test('a login on a temporary password signs in blocked, not free',
        () async {
      final auth = buildAuth((options) => MockReply(body: <String, Object?>{
            ..._tokens(),
            'must_change_password': true,
            'user': <String, Object?>{'id': 7, 'name': 'سامي', 'role': 'teacher'},
          }));

      await auth.repository.signIn(email: _email, password: _password);

      expect(auth.session.state.isSignedIn, isTrue);
      expect(auth.session.state.mustChangePassword, isTrue);
    });
  });

  group('a deactivated account', () {
    test('is signed out on a cold start rather than shown stale data',
        () async {
      // EnsureAccountIsActive answers 401 and deletes every token the moment
      // the account is deactivated, so the restore call is where the app finds
      // out. Rendering the cached user instead would leave a dismissed staff
      // member looking at a roster.
      final auth = buildAuth((options) => const MockReply(
            statusCode: 401,
            body: <String, Object?>{'message': 'Unauthenticated.'},
          ));
      await auth.store.writeAccessToken('token-for-a-deactivated-account');
      await auth.store.writeRefreshToken('refresh-for-a-deactivated-account');

      await auth.repository.restore();

      expect(auth.session.state.status, SessionStatus.signedOut);
      expect(auth.session.state.session, isNull);
    });

    test('signing out clears the credentials even when the server is gone',
        () async {
      final auth = buildAuth((options) => throw connectionLost(options));
      await auth.store.writeAccessToken('access');
      await auth.store.writeRefreshToken('refresh');
      auth.session.signedIn(AppSession(
        userId: '7',
        displayName: 'سامي',
        roles: const <AppRole>[AppRole.teacher],
      ));

      await auth.repository.signOut();

      expect(await auth.store.readAccessToken(), isNull);
      expect(await auth.store.readRefreshToken(), isNull);
      expect(auth.session.state.status, SessionStatus.signedOut);
      // The device identity survives: it is an identifier, not a credential.
      expect(await auth.store.readDeviceId(), _deviceId);
    });
  });
}
