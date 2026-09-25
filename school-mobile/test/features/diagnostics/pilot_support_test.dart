import 'dart:convert';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/session/session.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/diagnostics/support_bundle.dart';
import 'package:school_mobile/shared/shared.dart';

import '../../support/mock_http_adapter.dart';

const String kChildName = 'ليان أحمد الفلاني';
const String kToken = 'SECRET-BEARER-TOKEN-9f2c';
const String kNote = 'كان مريضًا بالأمس';

Map<String, Object?> _bootstrap({
  bool payments = true,
  bool studentApp = true,
}) =>
    <String, Object?>{
      'data': <String, Object?>{
        'user': <String, Object?>{'id': 1, 'name': kChildName},
        'roles': <String>['parent'],
        'features': <String, Object?>{
          'parent_payments': payments,
          'parent_messages': true,
          'teacher_attendance': true,
          'student_app': studentApp,
        },
      },
    };

({FeatureFlagStore store, AppDatabase database, MockHttpAdapter adapter})
    buildFlags(MockResponder responder) {
  final adapter = MockHttpAdapter(responder);
  final client = ApiClient(
    baseUrl: 'https://api.test',
    tokenStore: InMemoryTokenStore(deviceId: 'device-1'),
    adapter: adapter,
  );
  addTearDown(() => client.close(force: true));

  final database = AppDatabase.memory();
  addTearDown(database.close);

  final store = FeatureFlagStore(dio: client.dio, database: database);
  addTearDown(store.dispose);

  return (store: store, database: database, adapter: adapter);
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('an error screen carries the id support needs', () {
    testWidgets('the request id is on screen and selectable', (tester) async {
      // A pilot support call starts with "read me the id at the bottom". If it
      // is not there, or cannot be selected, the call goes nowhere.
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.light(),
        locale: const Locale('ar'),
        supportedLocales: AppLocales.supported,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: const AppI18nScope(
          formats: AppFormats(locale: 'ar'),
          child: Scaffold(
            body: ErrorView(
              error: UnknownError(
                message: 'حدث خطأ',
                statusCode: 500,
                requestId: 'req-9f2c-abc',
              ),
            ),
          ),
        ),
      ));
      await tester.pump();

      expect(find.byKey(const Key('request-id-card')), findsOneWidget);
      expect(find.text('req-9f2c-abc'), findsOneWidget);
      expect(find.byType(SelectableText), findsWidgets);
    });

    testWidgets('an error with no id shows no empty card', (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.light(),
        locale: const Locale('ar'),
        supportedLocales: AppLocales.supported,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: const AppI18nScope(
          formats: AppFormats(locale: 'ar'),
          child: Scaffold(body: ErrorView(error: OfflineError())),
        ),
      ));
      await tester.pump();

      expect(find.byKey(const Key('request-id-card')), findsNothing);
    });
  });

  group('feature flags', () {
    test('a school can switch a surface off', () async {
      final flags = buildFlags(
        (options) => MockReply(body: _bootstrap(payments: false)),
      );

      await flags.store.load();

      expect(flags.store.isOn(Features.parentPayments), isFalse);
      expect(flags.store.isOn(Features.parentMessages), isTrue);
    });

    test('an unreachable server is not "everything off"', () async {
      // A pilot phone that cannot reach the server on the first morning must
      // show the app, not an empty shell. One bad connection must not become
      // an outage.
      final flags = buildFlags((options) => throw connectionLost(options));

      await flags.store.load();

      expect(flags.store.isOn(Features.parentPayments), isTrue);
      expect(flags.store.isOn(Features.studentApp), isTrue);
    });

    test('a failed refresh keeps what the school last said', () async {
      var online = true;
      final flags = buildFlags((options) {
        if (!online) throw connectionLost(options);

        return MockReply(body: _bootstrap(payments: false));
      });

      await flags.store.load();
      online = false;
      await flags.store.refresh();

      expect(
        flags.store.isOn(Features.parentPayments),
        isFalse,
        reason: 'the last known answer must stand',
      );
    });

    test('a cold start reads the flags off disk', () async {
      final adapter = MockHttpAdapter(
        (options) => MockReply(body: _bootstrap(studentApp: false)),
      );
      final client = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: InMemoryTokenStore(deviceId: 'device-1'),
        adapter: adapter,
      );
      addTearDown(() => client.close(force: true));

      final database = AppDatabase.memory();
      addTearDown(database.close);

      final first = FeatureFlagStore(dio: client.dio, database: database);
      addTearDown(first.dispose);
      await first.load();

      // A second launch, offline, over the same database.
      final offline = ApiClient(
        baseUrl: 'https://api.test',
        tokenStore: InMemoryTokenStore(deviceId: 'device-1'),
        adapter: MockHttpAdapter((options) => throw connectionLost(options)),
      );
      addTearDown(() => offline.close(force: true));

      final second = FeatureFlagStore(dio: offline.dio, database: database);
      addTearDown(second.dispose);
      await second.load();

      expect(second.isOn(Features.studentApp), isFalse);
    });

    test('a flag this build has never heard of is on', () async {
      // A build that does not know a flag must not break, and a flag the
      // server stops sending must not silently disable a shipped screen.
      final flags = buildFlags((options) => MockReply(body: _bootstrap()));
      await flags.store.load();

      expect(flags.store.isOn('a_flag_from_next_year'), isTrue);
    });
  });

  group('the diagnostics export is safe to paste anywhere', () {
    test('it carries counts and statuses, never contents', () async {
      final database = AppDatabase.memory();
      addTearDown(database.close);

      final tokens = InMemoryTokenStore(deviceId: 'device-abc-123');
      await tokens.writeAccessToken(kToken);

      final queued = await database.enqueue(
        endpoint: '/mobile/v1/teacher/attendance/batch',
        method: 'POST',
        payloadJson: jsonEncode(<String, Object?>{
          'records': <Object?>[
            <String, Object?>{'student_user_id': 1, 'note': kNote},
          ],
        }),
        idempotencyKey: 'idem-1',
      );
      await database.markDead(queued.id, reason: 'HTTP 422');

      await database.upsertCache(
        entityType: 'parent_home',
        entityId: 'current',
        payloadJson: jsonEncode(<String, Object?>{'child': kChildName}),
      );

      final bundle = await SupportBundleBuilder(
        database: database,
        tokenStore: tokens,
        appVersion: '1.0.0+1',
        baseUrl: 'https://api.school.test',
        userId: '42',
      ).build(now: DateTime.utc(2026, 9, 6, 10));

      final text = bundle.toText();

      // What support needs.
      expect(text, contains('device-abc-123'));
      expect(text, contains('1.0.0+1'));
      expect(text, contains('dead: 1'));
      expect(text, contains('parent_home'));
      expect(text, contains('HTTP 422'));
      expect(text, contains('/mobile/v1/teacher/attendance/batch'));

      // What it must never carry.
      for (final secret in <String>[kChildName, kToken, kNote]) {
        expect(text, isNot(contains(secret)), reason: 'leaked "$secret"');
        expect(supportBundleJson(bundle), isNot(contains(secret)));
      }
    });

    test('a cache entity id never reaches the bundle', () async {
      // An entity id can be a student id, and a bundle is a thing people paste
      // into group chats.
      final database = AppDatabase.memory();
      addTearDown(database.close);

      await database.upsertCache(
        entityType: 'teacher_roster',
        entityId: '10:2026-09-05',
        payloadJson: '{}',
      );

      final bundle = await SupportBundleBuilder(
        database: database,
        tokenStore: InMemoryTokenStore(deviceId: 'device-1'),
        appVersion: '1.0.0+1',
      ).build();

      expect(bundle.toText(), contains('teacher_roster'));
      expect(bundle.toText(), isNot(contains('10:2026-09-05')));
    });

    test('it reports the flags the device is running on', () async {
      final flags = buildFlags(
        (options) => MockReply(body: _bootstrap(payments: false)),
      );
      await flags.store.load();

      final bundle = await SupportBundleBuilder(
        database: flags.database,
        tokenStore: InMemoryTokenStore(deviceId: 'device-1'),
        appVersion: '1.0.0+1',
        flags: flags.store,
      ).build();

      expect(bundle.toText(), contains('parent_payments: off'));
      expect(bundle.toText(), contains('parent_messages: on'));
    });

    test('an empty device produces a bundle, not an error', () async {
      // The support call where nothing has happened yet is a real one.
      final database = AppDatabase.memory();
      addTearDown(database.close);

      final bundle = await SupportBundleBuilder(
        database: database,
        tokenStore: InMemoryTokenStore(deviceId: null),
        appVersion: '1.0.0+1',
      ).build();

      expect(bundle.toText(), contains('(none)'));
      expect(bundle.queue['pending'], 0);
    });

    test('the failure list is capped so the bundle stays pasteable', () async {
      final database = AppDatabase.memory();
      addTearDown(database.close);

      for (var i = 0; i < 25; i++) {
        final row = await database.enqueue(
          endpoint: '/mobile/v1/teacher/grades/batch',
          method: 'POST',
          payloadJson: '{}',
          idempotencyKey: 'idem-$i',
        );
        await database.markDead(row.id, reason: 'HTTP 409');
      }

      final bundle = await SupportBundleBuilder(
        database: database,
        tokenStore: InMemoryTokenStore(deviceId: 'device-1'),
        appVersion: '1.0.0+1',
      ).build();

      expect(
        bundle.recentFailures,
        hasLength(SupportBundleBuilder.failureLimit),
      );
      expect(bundle.queue['dead'], 25);
    });
  });
}
