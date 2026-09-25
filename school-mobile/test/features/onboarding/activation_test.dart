import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/auth/secure_store.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/lock/lock.dart';
import 'package:school_mobile/core/session/session.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/onboarding/onboarding.dart';

import '../../support/fake_biometric_gate.dart';
import '../../support/mock_http_adapter.dart';

const String _deviceId = 'device-uuid-under-test';
const String _code = 'ABCD-EFGH-JKMN';
const String _activate = '/mobile/v1/onboarding/activate';

const Map<String, Object?> _activated = <String, Object?>{
  'access_token': 'access-token-value',
  'refresh_token': 'refresh-token-value',
  'token_type': 'Bearer',
  'must_change_password': false,
  'user': <String, Object?>{'id': 42, 'name': 'رانيا', 'role': 'parent'},
};

({
  ActivationController controller,
  SessionController session,
  AppLockController lock,
  FakeBiometricGate gate,
  InMemoryTokenStore store,
  MockHttpAdapter adapter,
  List<String> log,
}) buildActivation(
  MockResponder responder, {
  String? deviceId = _deviceId,
  bool lockAvailable = true,
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

  final gate = FakeBiometricGate(available: lockAvailable);
  final lock = AppLockController(gate: gate, store: InMemorySecureStore());
  addTearDown(lock.dispose);

  final controller = ActivationController(
    api: ActivationApi(dio: client.dio, tokenStore: store),
    session: session,
    lock: lock,
  );
  addTearDown(controller.dispose);

  return (
    controller: controller,
    session: session,
    lock: lock,
    gate: gate,
    store: store,
    adapter: adapter,
    log: log,
  );
}

Future<void> pumpActivation(
  WidgetTester tester,
  ActivationController controller, {
  VoidCallback? onCancel,
  String locale = 'ar',
}) async {
  await tester.pumpWidget(MaterialApp(
    theme: AppTheme.light(),
    locale: Locale(locale),
    supportedLocales: AppLocales.supported,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: AppI18nScope(
      formats: AppFormats(locale: locale),
      child: ActivationScreen(
        controller: controller,
        onCancel: onCancel ?? () {},
      ),
    ),
  ));
  await tester.pump();
}

void main() {
  group('activating from a school-issued code', () {
    test('sends the code and the device id, and no password', () async {
      final activation =
          buildActivation((options) => const MockReply(body: _activated));

      await activation.controller.api.activate(_code);

      final body = activation.adapter.requestsFor(_activate).single.json;
      expect(body['code'], _code);
      expect(body['device_id'], _deviceId);
      expect(body.containsKey('password'), isFalse);
      expect(body.containsKey('email'), isFalse);
    });

    test('is not attempted without a device id', () async {
      // The refresh family the server creates is bound to it. A session that
      // could never be revoked remotely must not be established at all.
      var attempted = false;
      final activation = buildActivation(
        (options) {
          attempted = true;
          return const MockReply(body: _activated);
        },
        deviceId: null,
      );

      await expectLater(
        activation.controller.api.activate(_code),
        throwsA(isA<ActivationFailure>().having(
          (failure) => failure.kind,
          'kind',
          ActivationFailureKind.deviceNotReady,
        )),
      );
      expect(attempted, isFalse);
    });

    test('stores both tokens', () async {
      final activation =
          buildActivation((options) => const MockReply(body: _activated));

      await activation.controller.api.activate(_code);

      expect(await activation.store.readAccessToken(), 'access-token-value');
      expect(await activation.store.readRefreshToken(), 'refresh-token-value');
    });

    test('a response without tokens is a failure, not a half-session',
        () async {
      final activation = buildActivation((options) => const MockReply(
            body: <String, Object?>{
              'user': <String, Object?>{'id': 42, 'role': 'parent'},
            },
          ));

      await expectLater(
        activation.controller.api.activate(_code),
        throwsA(isA<ActivationFailure>()),
      );
      expect(await activation.store.readAccessToken(), isNull);
    });

    test('a rejected code is one outcome, not four guesses at why', () async {
      // The server answers unknown, spent, expired and burned identically so
      // the endpoint cannot be used to discover which codes exist. Guessing
      // here would send a parent to the office for the wrong reason.
      final activation = buildActivation((options) => const MockReply(
            statusCode: 422,
            body: <String, Object?>{
              'message': 'This activation code cannot be used.',
            },
          ));

      await expectLater(
        activation.controller.api.activate(_code),
        throwsA(isA<ActivationFailure>().having(
          (failure) => failure.kind,
          'kind',
          ActivationFailureKind.codeRejected,
        )),
      );
    });

    test('the rate limiter is told apart from a bad code', () async {
      final activation = buildActivation(
        (options) => const MockReply(statusCode: 429),
      );

      try {
        await activation.controller.api.activate(_code);
        fail('expected an ActivationFailure');
      } on ActivationFailure catch (failure) {
        expect(failure.kind, ActivationFailureKind.tooManyAttempts);
      }
    });

    test('the code never reaches a log line or a failure', () async {
      final activation = buildActivation((options) => const MockReply(
            statusCode: 500,
            body: <String, Object?>{'message': 'Server error'},
          ));

      ActivationFailure? captured;
      try {
        await activation.controller.api.activate(_code);
      } on ActivationFailure catch (failure) {
        captured = failure;
      }

      final written =
          <String>[...activation.log, captured.toString()].join('\n');
      expect(written, isNot(contains(_code)));
      expect(written, isNot(contains('access-token-value')));
    });
  });

  group('the activation screen', () {
    testWidgets('will not send an empty or short code', (tester) async {
      final activation =
          buildActivation((options) => const MockReply(body: _activated));
      await pumpActivation(tester, activation.controller);

      await tester.tap(find.byKey(const Key('activate-submit')));
      await tester.pumpAndSettle();
      expect(find.text('أدخل رمز التفعيل.'), findsOneWidget);

      await tester.enterText(find.byKey(const Key('activate-code')), 'ABCD');
      await tester.tap(find.byKey(const Key('activate-submit')));
      await tester.pumpAndSettle();
      expect(find.text('الرمز غير مكتمل.'), findsOneWidget);

      expect(activation.adapter.requests, isEmpty);
    });

    testWidgets('accepts the code with or without its separators',
        (tester) async {
      final activation =
          buildActivation((options) => const MockReply(body: _activated));
      await pumpActivation(tester, activation.controller);

      // A parent typing off a printed slip will do either.
      await tester.enterText(
        find.byKey(const Key('activate-code')),
        'abcdefghjkmn',
      );
      await tester.tap(find.byKey(const Key('activate-submit')));
      await tester.pumpAndSettle();

      expect(activation.adapter.countFor(_activate), 1);
    });

    testWidgets('a parent activates without ever typing a password',
        (tester) async {
      final activation =
          buildActivation((options) => const MockReply(body: _activated));
      await pumpActivation(tester, activation.controller);

      await tester.enterText(find.byKey(const Key('activate-code')), _code);
      await tester.tap(find.byKey(const Key('activate-submit')));
      await tester.pumpAndSettle();

      // The lock step, then the session.
      expect(find.byKey(const Key('activate-protect')), findsOneWidget);
      expect(activation.session.state.isSignedIn, isFalse);

      await tester.tap(find.byKey(const Key('activate-skip-lock')));
      await tester.pumpAndSettle();

      expect(activation.session.state.isSignedIn, isTrue);
      expect(activation.session.state.session!.activeRole, AppRole.parent);
      expect(activation.session.state.mustChangePassword, isFalse);
      expect(find.byType(TextField), findsNothing);
    });

    testWidgets('turning on the lock uses the device credential, not a new PIN',
        (tester) async {
      // Inventing an app-specific PIN would mean storing another credential on
      // the device to protect a session the token already governs, and would
      // protect nothing the OS does not already.
      final activation =
          buildActivation((options) => const MockReply(body: _activated));
      await pumpActivation(tester, activation.controller);

      await tester.enterText(find.byKey(const Key('activate-code')), _code);
      await tester.tap(find.byKey(const Key('activate-submit')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('activate-enable-lock')));
      await tester.pumpAndSettle();

      expect(activation.lock.isEnabled, isTrue);
      expect(activation.session.state.isSignedIn, isTrue);
    });

    testWidgets('a phone with no screen lock still finishes activation',
        (tester) async {
      final activation = buildActivation(
        (options) => const MockReply(body: _activated),
        lockAvailable: false,
      );
      await pumpActivation(tester, activation.controller);

      await tester.enterText(find.byKey(const Key('activate-code')), _code);
      await tester.tap(find.byKey(const Key('activate-submit')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('activate-enable-lock')));
      await tester.pumpAndSettle();

      // The lock could not be turned on, but the parent is signed in rather
      // than stuck on a step their phone cannot complete.
      expect(activation.lock.isEnabled, isFalse);
      expect(activation.session.state.isSignedIn, isTrue);
    });

    testWidgets('a rejected code says what to do about it', (tester) async {
      final activation = buildActivation((options) => const MockReply(
            statusCode: 422,
            body: <String, Object?>{
              'message': 'This activation code cannot be used.',
            },
          ));
      await pumpActivation(tester, activation.controller);

      await tester.enterText(find.byKey(const Key('activate-code')), _code);
      await tester.tap(find.byKey(const Key('activate-submit')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('activate-failure')), findsOneWidget);
      expect(find.textContaining('تواصل مع إدارة المدرسة'), findsOneWidget);
      // Nothing from the server's English message reaches the screen.
      expect(find.textContaining('activation code'), findsNothing);
      expect(activation.session.state.isSignedIn, isFalse);
    });

    testWidgets('renders in both locales at 200% text scale without clipping',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      for (final locale in <String>['ar', 'en']) {
        final activation =
            buildActivation((options) => const MockReply(body: _activated));

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
                child: ActivationScreen(
                  controller: activation.controller,
                  onCancel: () {},
                ),
              ),
            ),
          ),
        ));
        await tester.pump();

        expect(tester.takeException(), isNull, reason: locale);
        expect(find.byKey(const Key('activate-submit')), findsOneWidget);
      }
    });
  });
}
