import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/parent/parent.dart';
import 'package:school_mobile/shared/shared.dart';

import '../../support/mock_http_adapter.dart';

Map<String, Object?> _money(int minor) => <String, Object?>{
      'minor': minor,
      'currency': 'JOD',
      'decimals': 3,
    };

Map<String, Object?> _child({
  int id = 1,
  String name = 'ليان',
  int? presentPercent = 75,
  Map<String, Object?>? installment,
  Map<String, Object?>? grade,
  List<Object?> today = const <Object?>[],
}) =>
    <String, Object?>{
      'id': id,
      'name': name,
      'class_name': 'الصف السابع',
      'attendance': <String, Object?>{
        'present_percent': presentPercent,
        'absent_days': 1,
      },
      'next_installment': installment,
      'latest_grade': grade,
      'today': today,
    };

Map<String, Object?> _home({List<Object?>? children}) => <String, Object?>{
      'data': <String, Object?>{
        'children': children ?? <Object?>[_child()],
        'unread_count': 2,
        'generated_at': '2026-09-04T08:00:00+00:00',
      },
    };

({
  ParentHomeController controller,
  ParentHomeRepository repository,
  AppDatabase database,
  MockHttpAdapter adapter,
}) buildHome(MockResponder responder) {
  final adapter = MockHttpAdapter(responder);
  final client = ApiClient(
    baseUrl: 'https://api.test',
    tokenStore: InMemoryTokenStore(deviceId: 'device'),
    adapter: adapter,
  );
  addTearDown(() => client.close(force: true));

  final database = AppDatabase.memory();
  addTearDown(database.close);

  final repository = ParentHomeRepository(dio: client.dio, database: database);
  final controller = ParentHomeController(repository: repository);
  addTearDown(controller.dispose);

  return (
    controller: controller,
    repository: repository,
    database: database,
    adapter: adapter,
  );
}

Future<void> pumpHome(
  WidgetTester tester,
  ParentHomeController controller, {
  bool isOffline = false,
  String locale = 'ar',
}) async {
  await tester.pumpWidget(MaterialApp(
    theme: AppTheme.light(),
    locale: Locale(locale),
    supportedLocales: AppLocales.supported,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: AppI18nScope(
      formats: AppFormats(locale: locale),
      child: ParentHomeScreen(controller: controller, isOffline: isOffline),
    ),
  ));
  // Bounded pumps rather than pumpAndSettle: the loading state holds a
  // CircularProgressIndicator, which animates forever and never settles.
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump();
}

void main() {
  // Each test opens its own in-memory database.
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('reading the payload', () {
    test('an unmarked week is null, not a perfect one', () {
      // 100% for a week nobody took the register is a lie a parent acts on.
      final home = ParentHome.fromJson(_home(
        children: <Object?>[_child(presentPercent: null)],
      ));

      expect(home.children.single.attendancePercent, isNull);
    });

    test('a money block with the wrong shape is dropped, not read as zero', () {
      // A silently-zero fee is worse than a missing one: nobody notices it
      // until the money is wrong.
      final home = ParentHome.fromJson(_home(children: <Object?>[
        _child(installment: <String, Object?>{
          'id': 5,
          'outstanding': <String, Object?>{'minor': 'not a number'},
        }),
      ]));

      expect(home.children.single.nextInstallment, isNull);
    });

    test('money is read as exact minor units', () {
      final home = ParentHome.fromJson(_home(children: <Object?>[
        _child(installment: <String, Object?>{
          'id': 5,
          'outstanding': _money(124500),
          'days_remaining': 3,
          'overdue': false,
          'due_date': '2026-09-07',
        }),
      ]));

      final installment = home.children.single.nextInstallment!;
      expect(installment.amount.minor, 124500);
      expect(installment.amount.decimals, 3);
    });

    test('an unreadable child is skipped rather than failing the screen', () {
      final home = ParentHome.fromJson(_home(children: <Object?>[
        _child(),
        <String, Object?>{'name': 'no id'},
        'not an object',
      ]));

      expect(home.children, hasLength(1));
    });
  });

  group('cache first', () {
    test('renders from cache before the network is consulted', () async {
      var served = 0;
      final home = buildHome((options) async {
        served++;
        // Slow enough that a network-first screen would still be blank.
        return MockReply(body: _home(), delay: const Duration(seconds: 1));
      });

      await home.database.upsertCache(
        entityType: ParentHomeRepository.entityType,
        entityId: ParentHomeRepository.entityId,
        payloadJson: jsonEncode(_home(children: <Object?>[_child(name: 'من الذاكرة')])),
      );

      final loading = home.controller.load();
      // Give the cache read a turn, but not the request.
      await Future<void>.delayed(const Duration(milliseconds: 50));

      final state = home.controller.state;
      expect(state, isA<ScreenData<ParentHome>>());
      expect(
        (state as ScreenData<ParentHome>).value.children.single.name,
        'من الذاكرة',
      );
      expect(home.controller.isShowingCache, isTrue);

      await loading;
      expect(served, 1);
      expect(home.controller.isShowingCache, isFalse);
    });

    test('a successful fetch is written to the cache', () async {
      final home = buildHome((options) => MockReply(body: _home()));

      await home.controller.load();

      final row = await home.database.readCache(
        ParentHomeRepository.entityType,
        ParentHomeRepository.entityId,
      );
      expect(row, isNotNull);
      expect(row!.payloadJson, contains('ليان'));
    });

    test('a failed fetch never overwrites the last good copy', () async {
      // A 500 that blanks the cache leaves the next cold start with nothing.
      final home = buildHome((options) => const MockReply(statusCode: 500));

      await home.database.upsertCache(
        entityType: ParentHomeRepository.entityType,
        entityId: ParentHomeRepository.entityId,
        payloadJson: jsonEncode(_home(children: <Object?>[_child(name: 'محفوظ')])),
      );

      await home.controller.load();

      final row = await home.database.readCache(
        ParentHomeRepository.entityType,
        ParentHomeRepository.entityId,
      );
      expect(row!.payloadJson, contains('محفوظ'));
      // And the screen still shows it rather than an error page.
      expect(home.controller.state, isA<ScreenData<ParentHome>>());
    });

    test('offline with no cache is an error the user can retry', () async {
      final home = buildHome((options) => throw connectionLost(options));

      await home.controller.load();

      expect(home.controller.state, isA<ScreenError<ParentHome>>());
    });

    test('a 304 keeps the cached copy rather than blanking the screen',
        () async {
      final home = buildHome((options) => const MockReply(statusCode: 304, body: null));

      await home.database.upsertCache(
        entityType: ParentHomeRepository.entityType,
        entityId: ParentHomeRepository.entityId,
        payloadJson: jsonEncode(_home(children: <Object?>[_child(name: 'ما زال صالحًا')])),
      );

      await home.controller.load();

      final state = home.controller.state as ScreenData<ParentHome>;
      expect(state.value.children.single.name, 'ما زال صالحًا');
    });

    test('a corrupt cache row is dropped rather than failing every open',
        () async {
      final home = buildHome((options) => MockReply(body: _home()));

      await home.database.upsertCache(
        entityType: ParentHomeRepository.entityType,
        entityId: ParentHomeRepository.entityId,
        payloadJson: 'not json at all',
      );

      expect(await home.repository.cached(), isNull);
      await home.controller.load();
      expect(home.controller.state, isA<ScreenData<ParentHome>>());
    });
  });

  group('the screen', () {
    testWidgets('a single-child guardian gets no picker, just the card',
        (tester) async {
      // A picker in front of a single-child family is a tap that exists only
      // because the screen was built for the harder case.
      final home = buildHome((options) => MockReply(body: _home()));
      await pumpHome(tester, home.controller);

      expect(find.byKey(const Key('child-card-1')), findsOneWidget);
      expect(find.byType(DropdownButton<int>), findsNothing);
      expect(find.byType(TabBar), findsNothing);
    });

    testWidgets('three siblings get three cards', (tester) async {
      final home = buildHome((options) => MockReply(
            body: _home(children: <Object?>[
              _child(id: 1, name: 'ليان'),
              _child(id: 2, name: 'يوسف'),
              _child(id: 3, name: 'رهف'),
            ]),
          ));
      await pumpHome(tester, home.controller);

      expect(find.byKey(const Key('child-card-1')), findsOneWidget);
      expect(find.byKey(const Key('child-card-2')), findsOneWidget);
      // The list is lazy, so the third card is built on the way to it.
      await tester.scrollUntilVisible(
        find.byKey(const Key('child-card-3')),
        200,
      );
      expect(find.byKey(const Key('child-card-3')), findsOneWidget);
    });

    testWidgets('an overdue payment reads as overdue, not as a plain amount',
        (tester) async {
      final home = buildHome((options) => MockReply(
            body: _home(children: <Object?>[
              _child(installment: <String, Object?>{
                'id': 5,
                'outstanding': _money(124500),
                'days_remaining': -3,
                'overdue': true,
                'due_date': '2026-09-01',
              }),
            ]),
          ));
      await pumpHome(tester, home.controller);

      expect(find.textContaining('متأخر'), findsOneWidget);
      expect(find.textContaining('124.500'), findsOneWidget);
    });

    testWidgets('an unmarked week says so rather than showing a number',
        (tester) async {
      final home = buildHome((options) => MockReply(
            body: _home(children: <Object?>[_child(presentPercent: null)]),
          ));
      await pumpHome(tester, home.controller);

      expect(find.text('لم يُسجَّل الحضور بعد'), findsOneWidget);
      expect(find.textContaining('%'), findsNothing);
    });

    testWidgets('the offline banner appears when connectivity is lost',
        (tester) async {
      final home = buildHome((options) => MockReply(body: _home()));
      await pumpHome(tester, home.controller, isOffline: true);

      expect(find.byKey(const Key('offline-banner')), findsOneWidget);
    });

    testWidgets('a cached screen is labelled as stale, a live one is not',
        (tester) async {
      // The window this exercises is the real one: the cached copy is on
      // screen and the revalidate has not come back yet.
      final cached = buildHome((options) => MockReply(
            body: _home(),
            delay: const Duration(seconds: 5),
          ));
      await cached.database.upsertCache(
        entityType: ParentHomeRepository.entityType,
        entityId: ParentHomeRepository.entityId,
        payloadJson: jsonEncode(_home()),
      );

      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.light(),
        locale: const Locale('ar'),
        supportedLocales: AppLocales.supported,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: AppI18nScope(
          formats: const AppFormats(locale: 'ar'),
          child: ParentHomeScreen(controller: cached.controller),
        ),
      ));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 50));

      expect(find.byKey(const Key('staleness-label')), findsOneWidget);
      // Let the outstanding request finish so the test ends cleanly.
      await tester.pump(const Duration(seconds: 6));

      final live = buildHome((options) => MockReply(body: _home()));
      await pumpHome(tester, live.controller);
      // Labelling a fresh screen as stale trains people to ignore the label.
      expect(find.byKey(const Key('staleness-label')), findsNothing);
    });

    testWidgets('pull-to-refresh goes back to the network', (tester) async {
      var served = 0;
      final home = buildHome((options) {
        served++;

        return MockReply(body: _home());
      });
      await pumpHome(tester, home.controller);
      expect(served, 1);

      await tester.fling(
        find.byKey(const Key('child-card-1')),
        const Offset(0, 400),
        1000,
      );
      await tester.pumpAndSettle();

      expect(served, 2);
    });

    testWidgets('a guardian with no linked children is told, not shown a spinner',
        (tester) async {
      final home = buildHome((options) => MockReply(
            body: _home(children: <Object?>[]),
          ));
      await pumpHome(tester, home.controller);

      expect(find.byKey(const Key('empty-view')), findsOneWidget);
      expect(find.textContaining('تواصل مع إدارة المدرسة'), findsOneWidget);
    });

    testWidgets('renders in both locales at 200% text scale without clipping',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      for (final locale in <String>['ar', 'en']) {
        final home = buildHome((options) => MockReply(
              body: _home(children: <Object?>[
                _child(
                  installment: <String, Object?>{
                    'id': 5,
                    'outstanding': _money(1250500),
                    'days_remaining': -2,
                    'overdue': true,
                    'due_date': '2026-09-01',
                  },
                  grade: <String, Object?>{
                    'subject': 'الرياضيات',
                    'score': '88.00',
                    'max_score': '100.00',
                  },
                  today: <Object?>[
                    <String, Object?>{
                      'id': 1,
                      'subject': 'الرياضيات',
                      'start_time': '08:00',
                    },
                  ],
                ),
              ]),
            ));

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
                // A distinct key per locale, so the second iteration builds a
                // fresh State and runs initState again. Without it the element
                // tree is reused, load() never fires, and the screen sits in
                // its loading state.
                child: ParentHomeScreen(
                  key: ValueKey<String>(locale),
                  controller: home.controller,
                ),
              ),
            ),
          ),
        ));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pump();

        expect(tester.takeException(), isNull, reason: locale);
        expect(find.byKey(const Key('child-card-1')), findsOneWidget);
      }
    });
  });
}
