import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/router/router.dart';
import 'package:school_mobile/core/session/session.dart';
import 'package:school_mobile/core/theme/theme.dart';

/// Pumps the real app shell around [controller]'s router.
///
/// Deliberately the production `buildAppRouter` and the production
/// localizations: a router test that stubs the redirect proves nothing about
/// the redirect.
Future<GoRouter> pumpApp(
  WidgetTester tester, {
  required SessionController controller,
  String initialLocation = '/',
  AppScreens screens = const AppScreens(),
  Locale locale = const Locale('ar'),
  // The splash spins forever by design, so a settle would never return there.
  bool settle = true,
}) async {
  final router = buildAppRouter(
    controller: controller,
    screens: screens,
    initialLocation: initialLocation,
  );
  addTearDown(router.dispose);

  await tester.pumpWidget(MaterialApp.router(
    theme: AppTheme.light(),
    locale: locale,
    supportedLocales: AppLocales.supported,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    routerConfig: router,
    builder: (context, child) => AppI18nScope(
      formats: AppFormats(locale: locale.languageCode),
      child: child ?? const SizedBox.shrink(),
    ),
  ));
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump();
  }

  return router;
}

String locationOf(GoRouter router) =>
    router.routerDelegate.currentConfiguration.uri.path;

AppSession sessionWith(List<AppRole> roles, {AppRole? active}) => AppSession(
      userId: '7',
      displayName: 'Rania',
      roles: roles,
      activeRole: active,
    );

void main() {
  group('landing', () {
    testWidgets('holds at the splash until the token store has been read',
        (tester) async {
      final controller = SessionController();
      addTearDown(controller.dispose);

      final router = await pumpApp(tester, controller: controller, settle: false);

      expect(find.byKey(const Key('splash-screen')), findsOneWidget);
      expect(locationOf(router), '/');
    });

    testWidgets('a signed-out user lands on sign-in', (tester) async {
      final controller = SessionController()..signedOut();
      addTearDown(controller.dispose);

      final router = await pumpApp(tester, controller: controller);

      expect(locationOf(router), AppRoute.signIn.path);
    });

    testWidgets('signing in moves the user off the sign-in screen',
        (tester) async {
      final controller = SessionController()..signedOut();
      addTearDown(controller.dispose);

      final router = await pumpApp(tester, controller: controller);
      expect(locationOf(router), AppRoute.signIn.path);

      controller.signedIn(sessionWith(<AppRole>[AppRole.parent]));
      await tester.pumpAndSettle();

      expect(locationOf(router), AppRoute.parentHome.path);
    });
  });

  group('role shells', () {
    testWidgets('each role lands in its own shell', (tester) async {
      for (final entry in <AppRole, String>{
        AppRole.parent: AppRoute.parentHome.path,
        AppRole.teacher: AppRoute.teacherToday.path,
        AppRole.student: AppRoute.studentHome.path,
      }.entries) {
        final controller = SessionController()
          ..signedIn(sessionWith(<AppRole>[entry.key]));
        addTearDown(controller.dispose);

        final router = await pumpApp(tester, controller: controller);

        expect(locationOf(router), entry.value, reason: entry.key.wireName);
        expect(
          find.byKey(Key('unbuilt-${AppRoute.homeFor(entry.key).routeName}')),
          findsOneWidget,
        );
      }
    });

    testWidgets('a single-role user is not offered a role switcher',
        (tester) async {
      final controller = SessionController()
        ..signedIn(sessionWith(<AppRole>[AppRole.parent]));
      addTearDown(controller.dispose);

      await pumpApp(tester, controller: controller);

      expect(find.byKey(const Key('role-switch-button')), findsNothing);
    });

    testWidgets('a tab tap moves to that branch without leaving the shell',
        (tester) async {
      final controller = SessionController()
        ..signedIn(sessionWith(<AppRole>[AppRole.parent]));
      addTearDown(controller.dispose);

      final router = await pumpApp(tester, controller: controller);

      await tester.tap(find.byKey(Key('tab-${AppRoute.parentFinance.routeName}')));
      await tester.pumpAndSettle();

      expect(locationOf(router), AppRoute.parentFinance.path);
      expect(find.byType(NavigationBar), findsOneWidget);
    });
  });

  group('multi-role', () {
    testWidgets('a two-role user switches shells without signing in again',
        (tester) async {
      final controller = SessionController()
        ..signedIn(sessionWith(<AppRole>[AppRole.parent, AppRole.teacher]));
      addTearDown(controller.dispose);

      final router = await pumpApp(tester, controller: controller);
      expect(locationOf(router), AppRoute.parentHome.path);

      await tester.tap(find.byKey(const Key('role-switch-button')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('switch-to-teacher')));
      await tester.pumpAndSettle();

      expect(locationOf(router), AppRoute.teacherToday.path);
      // The session survived: same user, still signed in, still holding both.
      expect(controller.state.isSignedIn, isTrue);
      expect(controller.state.session!.userId, '7');
      expect(controller.state.session!.activeRole, AppRole.teacher);
      expect(controller.state.session!.roles.length, 2);
    });

    testWidgets('a deep link into the other held role is allowed straight in',
        (tester) async {
      final controller = SessionController()
        ..signedIn(sessionWith(
          <AppRole>[AppRole.parent, AppRole.teacher],
          active: AppRole.parent,
        ));
      addTearDown(controller.dispose);

      final router = await pumpApp(
        tester,
        controller: controller,
        initialLocation: AppRoute.teacherClasses.path,
      );

      expect(locationOf(router), AppRoute.teacherClasses.path);
    });
  });

  group('deep links', () {
    testWidgets('a link into a role the user does not hold lands on their home',
        (tester) async {
      final controller = SessionController()
        ..signedIn(sessionWith(<AppRole>[AppRole.parent]));
      addTearDown(controller.dispose);

      final router = await pumpApp(
        tester,
        controller: controller,
        initialLocation: '/teacher/classes/9/attendance',
      );

      expect(locationOf(router), AppRoute.parentHome.path);
    });

    testWidgets('an unknown deep link shows not-found and does not crash',
        (tester) async {
      final controller = SessionController()
        ..signedIn(sessionWith(<AppRole>[AppRole.parent]));
      addTearDown(controller.dispose);

      final router = await pumpApp(
        tester,
        controller: controller,
        initialLocation: '/parent/this-route-does-not-exist',
      );

      expect(tester.takeException(), isNull);
      expect(find.byKey(const Key('not-found-screen')), findsOneWidget);

      await tester.tap(find.text('العودة إلى الرئيسية'));
      await tester.pumpAndSettle();

      expect(locationOf(router), AppRoute.parentHome.path);
    });

    testWidgets('a parametrised link reaches the screen with its parameter',
        (tester) async {
      String? seenInvoiceId;
      final controller = SessionController()
        ..signedIn(sessionWith(<AppRole>[AppRole.parent]));
      addTearDown(controller.dispose);

      final router = await pumpApp(
        tester,
        controller: controller,
        initialLocation: '/parent/finance/invoices/4821',
        screens: const AppScreens().withScreen(
          AppRoute.parentInvoice,
          (context, state) {
            seenInvoiceId = state.pathParameters['invoiceId'];
            return const Scaffold(body: Text('invoice'));
          },
        ),
      );

      expect(locationOf(router), '/parent/finance/invoices/4821');
      expect(seenInvoiceId, '4821');
    });

    testWidgets('a link opened before the session is known is not lost',
        (tester) async {
      // Cold start from a push: the token store has not been read yet, so the
      // link cannot be routed. Dropping it here is what makes a tapped
      // notification open the home screen instead of the thing it was about.
      final controller = SessionController();
      addTearDown(controller.dispose);

      final router = await pumpApp(
        tester,
        controller: controller,
        initialLocation: AppRoute.parentFinance.path,
        settle: false,
      );
      expect(locationOf(router), '/');

      controller.signedIn(sessionWith(<AppRole>[AppRole.parent]));
      await tester.pumpAndSettle();

      expect(locationOf(router), AppRoute.parentFinance.path);
    });
  });

  group('upgrade gate', () {
    testWidgets('force_upgrade blocks the app behind an Arabic upgrade screen',
        (tester) async {
      final controller = SessionController(
        currentVersion: const AppVersion(1, 0, 0),
      )..signedIn(sessionWith(<AppRole>[AppRole.parent]));
      addTearDown(controller.dispose);

      final router = await pumpApp(tester, controller: controller);
      expect(locationOf(router), AppRoute.parentHome.path);

      controller.applyUpgradePolicy(
        UpgradePolicy.fromJson(const <String, Object?>{'force_upgrade': true}),
      );
      await tester.pumpAndSettle();

      expect(locationOf(router), AppRoute.upgrade.path);
      expect(find.byKey(const Key('upgrade-screen')), findsOneWidget);
      expect(find.text('يجب تحديث التطبيق'), findsOneWidget);
      // Nothing else is reachable while the gate is closed.
      expect(find.byType(NavigationBar), findsNothing);
    });

    testWidgets('the gate holds against an attempt to navigate past it',
        (tester) async {
      final controller = SessionController(
        currentVersion: const AppVersion(1, 0, 0),
      )
        ..signedIn(sessionWith(<AppRole>[AppRole.parent]))
        ..applyUpgradePolicy(
          const UpgradePolicy(minSupported: AppVersion(2, 0, 0)),
        );
      addTearDown(controller.dispose);

      final router = await pumpApp(tester, controller: controller);
      expect(locationOf(router), AppRoute.upgrade.path);

      router.go(AppRoute.parentFinance.path);
      await tester.pumpAndSettle();

      expect(locationOf(router), AppRoute.upgrade.path);
    });

    testWidgets('a soft upgrade is a dismissible banner, not a wall',
        (tester) async {
      final controller = SessionController(
        currentVersion: const AppVersion(1, 0, 0),
      )
        ..signedIn(sessionWith(<AppRole>[AppRole.parent]))
        ..applyUpgradePolicy(
          const UpgradePolicy(recommended: AppVersion(1, 2, 0)),
        );
      addTearDown(controller.dispose);

      final router = await pumpApp(tester, controller: controller);

      expect(locationOf(router), AppRoute.parentHome.path);
      expect(find.byKey(const Key('soft-upgrade-banner')), findsOneWidget);

      await tester.tap(find.byKey(const Key('soft-upgrade-dismiss')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('soft-upgrade-banner')), findsNothing);
      expect(locationOf(router), AppRoute.parentHome.path);
    });
  });

  group('accounts with no phone app', () {
    testWidgets('an admin-only account is told, not dropped into a shell',
        (tester) async {
      final controller = SessionController()
        ..signedIn(sessionWith(const <AppRole>[]));
      addTearDown(controller.dispose);

      final router = await pumpApp(tester, controller: controller);

      expect(locationOf(router), AppRoute.noMobileRole.path);
      expect(find.byKey(const Key('no-mobile-role-screen')), findsOneWidget);
    });

    testWidgets('and cannot reach a shell by deep link either', (tester) async {
      final controller = SessionController()
        ..signedIn(sessionWith(const <AppRole>[]));
      addTearDown(controller.dispose);

      final router = await pumpApp(
        tester,
        controller: controller,
        initialLocation: AppRoute.teacherToday.path,
      );

      expect(locationOf(router), AppRoute.noMobileRole.path);
    });
  });

  group('presentation', () {
    testWidgets('the shell is right-to-left in Arabic and left-to-right in English',
        (tester) async {
      for (final entry in <String, TextDirection>{
        'ar': TextDirection.rtl,
        'en': TextDirection.ltr,
      }.entries) {
        final controller = SessionController()
          ..signedIn(sessionWith(<AppRole>[AppRole.parent]));
        addTearDown(controller.dispose);

        await pumpApp(
          tester,
          controller: controller,
          locale: Locale(entry.key),
        );

        expect(
          Directionality.of(tester.element(find.byType(NavigationBar))),
          entry.value,
          reason: entry.key,
        );
      }
    });

    testWidgets('the blocking upgrade screen survives 200% text scale',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      final controller = SessionController(
        currentVersion: const AppVersion(1, 0, 0),
      )
        ..signedIn(sessionWith(<AppRole>[AppRole.parent]))
        ..applyUpgradePolicy(const UpgradePolicy(forceUpgrade: true));
      addTearDown(controller.dispose);

      final router = buildAppRouter(controller: controller);
      addTearDown(router.dispose);

      await tester.pumpWidget(MaterialApp.router(
        theme: AppTheme.light(),
        locale: const Locale('ar'),
        supportedLocales: AppLocales.supported,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        routerConfig: router,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(2.0),
          ),
          child: child ?? const SizedBox.shrink(),
        ),
      ));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byKey(const Key('upgrade-screen')), findsOneWidget);
    });
  });
}
