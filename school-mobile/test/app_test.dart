import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:school_mobile/core/auth/secure_store.dart';
import 'package:school_mobile/features/auth/auth.dart';
import 'package:school_mobile/main.dart';

import 'support/mock_http_adapter.dart';

final RegExp westernDigit = RegExp(r'[0-9]');
final RegExp arabicIndicDigit = RegExp(r'[٠-٩]');

const String testEmail = 'rania@example.test';
const String testPassword = 'correct horse battery staple';

/// The `/auth/login` body for a parent, and the `/auth/me` body that restores
/// the same session on a restart.
MockReply _reply(RequestOptionsPath path) => switch (path) {
      RequestOptionsPath.login => const MockReply(body: <String, Object?>{
          'token': 'access-token-value',
          'access_token': 'access-token-value',
          'refresh_token': 'refresh-token-value',
          'token_type': 'Bearer',
          'expires_in': 7200,
          'must_change_password': false,
          'user': <String, Object?>{
            'id': 42,
            'name': 'رانيا',
            'role': 'parent',
          },
        }),
      RequestOptionsPath.me => const MockReply(body: <String, Object?>{
          'user': <String, Object?>{
            'id': 42,
            'name': 'رانيا',
            'role': 'parent',
          },
          'permissions': <String>[],
        }),
      RequestOptionsPath.other => const MockReply(statusCode: 404),
    };

enum RequestOptionsPath { login, me, other }

RequestOptionsPath _classify(String path) => switch (path) {
      '/auth/login' => RequestOptionsPath.login,
      '/auth/me' => RequestOptionsPath.me,
      _ => RequestOptionsPath.other,
    };

void main() {
  setUpAll(initializeDateFormatting);

  /// Runs the real app over an in-memory keystore and a mocked transport.
  ///
  /// The production app is what is pumped — the same `SchoolSuiteApp`, router,
  /// session controller and login screen — so the startup path this exercises
  /// is the one that ships.
  Future<({InMemorySecureStore store, MockHttpAdapter adapter})> pumpApp(
    WidgetTester tester, {
    Locale? locale,
    InMemorySecureStore? store,
    bool restart = false,
  }) async {
    if (restart) {
      // Tear the running app down first. Pumping the same widget type again
      // would reuse its State, so initState -- the whole startup path this is
      // testing -- would never run a second time.
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump();
    }

    if (locale != null) {
      tester.platformDispatcher.localesTestValue = <Locale>[locale];
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    }

    final keystore = store ?? InMemorySecureStore();
    final adapter = MockHttpAdapter(
      (options) => _reply(_classify(options.path)),
    );

    await tester.pumpWidget(SchoolSuiteApp(
      secureStore: keystore,
      httpClientAdapter: adapter,
      baseUrl: 'https://api.test',
    ));
    await tester.pumpAndSettle();

    return (store: keystore, adapter: adapter);
  }

  /// Signs in through the real login screen.
  Future<void> signIn(WidgetTester tester) async {
    await tester.enterText(find.byKey(const Key('login-email')), testEmail);
    await tester.enterText(
      find.byKey(const Key('login-password')),
      testPassword,
    );
    // At 200% text scale the button is below the fold on a phone-sized
    // viewport, which is exactly the case this helper is used to exercise.
    await tester.ensureVisible(find.byKey(const Key('login-submit')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('login-submit')));
    await tester.pumpAndSettle();
  }

  /// Opens the profile tab, where the verification screen lives.
  Future<void> openProfile(WidgetTester tester) async {
    await tester.tap(find.byKey(const Key('tab-parentProfile')));
    await tester.pumpAndSettle();
  }

  /// The text of the widget under [key], as rendered.
  String valueUnder(WidgetTester tester, String key) {
    final column = tester.widget<Column>(
      find.descendant(
        of: find.byKey(Key(key)),
        matching: find.byType(Column),
      ),
    );
    return (column.children.last as Text).data!;
  }

  group('startup', () {
    testWidgets('a cold start with an empty keystore lands on sign-in',
        (tester) async {
      await pumpApp(tester, locale: const Locale('ar'));

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byKey(const Key('login-submit')), findsOneWidget);
    });

    testWidgets('signing in lands the parent in their own shell',
        (tester) async {
      await pumpApp(tester, locale: const Locale('ar'));
      await signIn(tester);

      expect(find.byType(LoginScreen), findsNothing);
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byKey(const Key('tab-parentHome')), findsOneWidget);
    });

    testWidgets('the session survives a restart without a second sign-in',
        (tester) async {
      // First launch: sign in, which writes the tokens to the keystore.
      final first = await pumpApp(tester, locale: const Locale('ar'));
      await signIn(tester);
      expect(find.byType(NavigationBar), findsOneWidget);

      // Second launch over the same keystore. Nothing is typed.
      final second = await pumpApp(
        tester,
        locale: const Locale('ar'),
        store: first.store,
        restart: true,
      );

      expect(find.byType(LoginScreen), findsNothing);
      expect(find.byType(NavigationBar), findsOneWidget);
      // The stored token was re-checked rather than trusted blindly.
      expect(second.adapter.countFor('/auth/me'), 1);
    });
  });

  group('direction', () {
    testWidgets('renders right-to-left under ar', (tester) async {
      await pumpApp(tester, locale: const Locale('ar'));

      final context = tester.element(find.byType(LoginScreen));
      expect(Localizations.localeOf(context), const Locale('ar'));
      expect(Directionality.of(context), TextDirection.rtl);
      expect(find.text('سويت المدرسة'), findsWidgets);
    });

    testWidgets('renders left-to-right under en', (tester) async {
      await pumpApp(tester, locale: const Locale('en'));

      final context = tester.element(find.byType(LoginScreen));
      expect(Localizations.localeOf(context), const Locale('en'));
      expect(Directionality.of(context), TextDirection.ltr);
      expect(find.text('School Suite'), findsWidgets);
    });

    testWidgets('an unsupported device language falls back to Arabic',
        (tester) async {
      await pumpApp(tester, locale: const Locale('fr'));

      final context = tester.element(find.byType(LoginScreen));
      expect(Localizations.localeOf(context), const Locale('ar'));
      expect(Directionality.of(context), TextDirection.rtl);
    });
  });

  group('the verification screen proves the layers are wired', () {
    testWidgets('shows a JOD amount with three decimals', (tester) async {
      await pumpApp(tester, locale: const Locale('en'));
      await signIn(tester);
      await openProfile(tester);

      expect(valueUnder(tester, 'verification-amount'), '12.500 JOD');
    });

    testWidgets('shows a formatted date and the active digit shape',
        (tester) async {
      await pumpApp(tester, locale: const Locale('en'));
      await signIn(tester);
      await openProfile(tester);

      expect(valueUnder(tester, 'verification-date'), 'September 3, 2026');
      expect(valueUnder(tester, 'verification-digit-shape'), 'Western');
    });

    testWidgets('toggling the digit shape restyles money and dates together',
        (tester) async {
      await pumpApp(tester, locale: const Locale('en'));
      await signIn(tester);
      await openProfile(tester);

      expect(valueUnder(tester, 'verification-amount'), '12.500 JOD');

      // The toggle is at the end of a scrolling screen inside the shell.
      await tester.ensureVisible(find.byKey(const Key('toggle-digit-shape')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('toggle-digit-shape')));
      await tester.pumpAndSettle();

      final amount = valueUnder(tester, 'verification-amount');
      final date = valueUnder(tester, 'verification-date');

      expect(amount, '١٢.٥٠٠ JOD');
      expect(westernDigit.hasMatch(date), isFalse,
          reason: 'the date must follow the same preference as the money');
      expect(arabicIndicDigit.hasMatch(date), isTrue);
      expect(valueUnder(tester, 'verification-digit-shape'), 'Arabic-Indic');
    });
  });

  group('accessibility', () {
    testWidgets('the sign-in screen does not overflow at 200% text scale',
        (tester) async {
      tester.platformDispatcher.textScaleFactorTestValue = 2.0;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await pumpApp(tester, locale: const Locale('ar'));

      // A RenderFlex overflow is reported as a framework exception; if one had
      // happened, this would return it.
      expect(tester.takeException(), isNull);

      final context = tester.element(find.byType(LoginScreen));
      expect(MediaQuery.textScalerOf(context).scale(10), 20.0);
      expect(find.byKey(const Key('login-submit')), findsOneWidget);
    });

    testWidgets('still shows every value at 200% scale in English',
        (tester) async {
      tester.platformDispatcher.textScaleFactorTestValue = 2.0;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await pumpApp(tester, locale: const Locale('en'));
      await signIn(tester);
      await openProfile(tester);

      expect(tester.takeException(), isNull);
      expect(valueUnder(tester, 'verification-amount'), '12.500 JOD');
    });
  });
}
