import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api.dart';
import 'package:school_mobile/core/db/app_database.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/features/parent/parent.dart';

import '../../support/mock_http_adapter.dart';

Map<String, Object?> _money(int minor, {int decimals = 3}) => <String, Object?>{
      'minor': minor,
      'currency': 'JOD',
      'decimals': decimals,
    };

/// The summary as the server actually sends it: qirsh, declaring two decimals.
///
/// The server's money columns are decimal(x,2) and its internal minor unit is
/// the qirsh, so this — not the three-decimal shape above — is the live
/// contract. The three-decimal fixtures stay because the client must keep
/// rendering fils correctly for the day the columns widen.
Map<String, Object?> _summaryAtStoredScale() => <String, Object?>{
      'data': <String, Object?>{
        'children': <Object?>[
          <String, Object?>{
            'student_user_id': 1,
            'name': 'ليان',
            'billed': _money(30000, decimals: 2),
            'paid': _money(15000, decimals: 2),
            'outstanding': _money(15000, decimals: 2),
            'overdue': _money(0, decimals: 2),
            'overdue_count': 0,
          },
        ],
        'total': _money(30000, decimals: 2),
        'total_outstanding': _money(15000, decimals: 2),
        'overdue_count': 0,
      },
    };

Map<String, Object?> _summary({int outstanding = 150000}) => <String, Object?>{
      'data': <String, Object?>{
        'children': <Object?>[
          <String, Object?>{
            'student_user_id': 1,
            'name': 'ليان',
            'billed': _money(300000),
            'paid': _money(300000 - outstanding),
            'outstanding': _money(outstanding),
            'overdue': _money(0),
            'overdue_count': 0,
          },
        ],
        'total': _money(300000),
        'total_outstanding': _money(outstanding),
        'overdue_count': 0,
      },
    };

Map<String, Object?> _plans({
  bool reconciles = true,
  bool payable = true,
  bool overdue = false,
  int decimals = 3,
}) =>
    <String, Object?>{
      'data': <String, Object?>{
        'student_user_id': 1,
        'plans': <Object?>[
          <String, Object?>{
            'id': 9,
            'plan_no': 'PLAN-1',
            'total': _money(300000, decimals: decimals),
            'reconciles': reconciles,
            'installments': <Object?>[
              <String, Object?>{
                'id': 11,
                'sequence_no': 1,
                'due_date': '2026-09-10',
                'amount': _money(150000, decimals: decimals),
                'outstanding': _money(150000, decimals: decimals),
                'status': 'pending',
                'overdue': overdue,
                'payable': payable,
                'days_remaining': overdue ? -3 : 5,
              },
              <String, Object?>{
                'id': 12,
                'sequence_no': 2,
                'due_date': '2026-10-10',
                'amount': _money(150000, decimals: decimals),
                'outstanding': _money(0, decimals: decimals),
                'status': 'paid',
                'overdue': false,
                'payable': false,
                'days_remaining': 35,
              },
            ],
          },
        ],
      },
    };

Map<String, Object?> _intent() => <String, Object?>{
      'data': <String, Object?>{
        'reference': 'PAY-ABCDEFGH1234',
        'installment_id': 11,
        'amount': _money(150000),
        'status': 'created',
      },
    };

Map<String, Object?> _invoice({
  String clearance = 'pending',
  String? qr,
}) =>
    <String, Object?>{
      'data': <String, Object?>{
        'id': 4,
        'student_user_id': 1,
        'invoice_no': 'INV-0001',
        'description': 'رسوم الفصل الأول',
        'amount': _money(300000),
        'paid': _money(150000),
        'outstanding': _money(150000),
        'due_date': '2026-09-10',
        'status': 'partial',
        'clearance': <String, Object?>{
          'state': clearance,
          'cleared_at': clearance == 'cleared' ? '2026-09-01T10:00:00Z' : null,
          'qr': qr,
        },
      },
    };

({
  ParentFeesController fees,
  ParentFinanceRepository repository,
  AppDatabase database,
  MockHttpAdapter adapter,
}) buildFees(MockResponder responder) {
  final adapter = MockHttpAdapter(responder);
  final client = ApiClient(
    baseUrl: 'https://api.test',
    tokenStore: InMemoryTokenStore(deviceId: 'device'),
    adapter: adapter,
  );
  addTearDown(() => client.close(force: true));

  final database = AppDatabase.memory();
  addTearDown(database.close);

  final repository =
      ParentFinanceRepository(dio: client.dio, database: database);
  final fees = ParentFeesController(repository: repository);
  addTearDown(fees.dispose);

  return (
    fees: fees,
    repository: repository,
    database: database,
    adapter: adapter,
  );
}

/// The default happy-path responder.
MockResponder happyPath({Map<String, Object?>? plans, Map<String, Object?>? summary}) =>
    (options) => switch (options.path) {
          '/mobile/v1/parent/finance/summary' =>
            MockReply(body: summary ?? _summary()),
          '/mobile/v1/parent/children/1/installments' =>
            MockReply(body: plans ?? _plans()),
          '/mobile/v1/parent/pay/11/intent' =>
            MockReply(statusCode: 201, body: _intent()),
          _ => const MockReply(statusCode: 404),
        };

Future<void> pumpFees(
  WidgetTester tester,
  ParentFeesController controller, {
  bool isOffline = false,
  String locale = 'ar',
  Key? key,
}) async {
  await tester.pumpWidget(MaterialApp(
    theme: AppTheme.light(),
    locale: Locale(locale),
    supportedLocales: AppLocales.supported,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: AppI18nScope(
      formats: AppFormats(locale: locale),
      child: ParentFeesScreen(
        key: key,
        controller: controller,
        isOffline: isOffline,
      ),
    ),
  ));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  await tester.pump();
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  group('the idempotency key', () {
    test('is minted once per attempt and reused on every retry', () async {
      // The acceptance criterion: a tapped payment that times out must not
      // double-charge when the parent taps again.
      final fees = buildFees((options) => throw connectionLost(options));

      final first = await fees.repository.keyForAttempt(11);
      final second = await fees.repository.keyForAttempt(11);
      final third = await fees.repository.keyForAttempt(11);

      expect(second, first);
      expect(third, first);
    });

    test('survives an app restart mid-payment', () async {
      // A fresh key after a restart would make the server treat the resumed
      // attempt as a second payment.
      final fees = buildFees(happyPath());
      final key = await fees.repository.keyForAttempt(11);

      final restarted = ParentFinanceRepository(
        dio: fees.repository.dio,
        database: fees.database,
      );

      expect(await restarted.keyForAttempt(11), key);
    });

    test('a payment that times out reuses its key on every retry', () async {
      // The acceptance criterion, end to end. Note there are two layers of
      // retry here and both must carry the same key: the transport retries a
      // lost connection on its own, and the parent tapping again after it
      // finally gives up is a second logical attempt.
      var connectionDown = true;
      final sentKeys = <String>[];

      final fees = buildFees((options) {
        if (options.path == '/mobile/v1/parent/pay/11/intent') {
          sentKeys.add('${options.headers['Idempotency-Key']}');
          // The whole first logical attempt fails, transport retries and all,
          // so it genuinely gives up rather than recovering on its own.
          if (connectionDown) throw connectionLost(options);

          return MockReply(statusCode: 201, body: _intent());
        }

        return switch (options.path) {
          '/mobile/v1/parent/finance/summary' => MockReply(body: _summary()),
          '/mobile/v1/parent/children/1/installments' => MockReply(body: _plans()),
          _ => const MockReply(statusCode: 404),
        };
      });

      await expectLater(
        fees.repository.createIntent(11),
        throwsA(isA<ApiError>()),
      );

      // The connection comes back and the parent taps pay again.
      connectionDown = false;
      await fees.repository.createIntent(11);

      expect(sentKeys.length, greaterThan(1));
      expect(
        sentKeys.toSet(),
        hasLength(1),
        reason: 'every attempt, transport retry or user retry, must reuse '
            'the first key -- a fresh one is a second charge',
      );
    });

    test('different installments get different keys', () async {
      final fees = buildFees(happyPath());

      expect(
        await fees.repository.keyForAttempt(11),
        isNot(await fees.repository.keyForAttempt(12)),
      );
    });

    test('a completed payment ends the attempt, so the next one is new',
        () async {
      final fees = buildFees(happyPath());

      final key = await fees.repository.keyForAttempt(11);
      await fees.repository.createIntent(11);

      expect(await fees.repository.keyForAttempt(11), isNot(key));
    });

    test('the key is sent as a header, not in the body', () async {
      final fees = buildFees(happyPath());

      await fees.repository.createIntent(11);

      final request =
          fees.adapter.requestsFor('/mobile/v1/parent/pay/11/intent').single;
      expect(request.header('Idempotency-Key'), isNotEmpty);
      expect(request.json, isEmpty);
    });
  });

  group('payments are never queued', () {
    testWidgets('offline says so instead of saving it for later',
        (tester) async {
      // Everything else that writes in this app goes to the outbox. Money does
      // not: a payment replayed hours later against a balance that has moved
      // is a charge nobody authorised.
      final fees = buildFees(happyPath());
      await pumpFees(tester, fees.fees, isOffline: true);

      await tester.tap(find.byKey(const Key('pay-installment-11')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('pay-confirm')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('payment-outcome')), findsOneWidget);
      expect(find.text('الدفع يحتاج اتصالًا بالإنترنت'), findsOneWidget);
      expect(fees.adapter.countFor('/mobile/v1/parent/pay/11/intent'), 0);
    });

    test('nothing about a payment is ever written to the outbox', () async {
      final fees = buildFees(happyPath());

      await fees.repository.createIntent(11);

      expect(await fees.database.allOutbox(), isEmpty);
    });
  });

  group('the fees screen', () {
    testWidgets('paying is two taps from here', (tester) async {
      // Three from the home screen, counting the tab. The confirmation is the
      // last point at which the amount sits beside the child's name.
      final fees = buildFees(happyPath());
      await pumpFees(tester, fees.fees);

      var taps = 0;

      await tester.tap(find.byKey(const Key('pay-installment-11')));
      taps++;
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('pay-confirm')));
      taps++;
      await tester.pumpAndSettle();

      expect(taps, 2);
      expect(fees.adapter.countFor('/mobile/v1/parent/pay/11/intent'), 1);
      expect(find.textContaining('PAY-ABCDEFGH1234'), findsOneWidget);
    });

    testWidgets('cancelling the confirmation sends nothing', (tester) async {
      final fees = buildFees(happyPath());
      await pumpFees(tester, fees.fees);

      await tester.tap(find.byKey(const Key('pay-installment-11')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('إلغاء'));
      await tester.pumpAndSettle();

      expect(fees.adapter.countFor('/mobile/v1/parent/pay/11/intent'), 0);
    });

    testWidgets('a settled installment offers no pay button', (tester) async {
      // The server says what is payable. A button enabled by client-side
      // arithmetic against a stale copy fails at the till.
      final fees = buildFees(happyPath());
      await pumpFees(tester, fees.fees);

      expect(find.byKey(const Key('pay-installment-11')), findsOneWidget);
      expect(find.byKey(const Key('pay-installment-12')), findsNothing);
    });

    testWidgets('a schedule that does not add up is surfaced, not hidden',
        (tester) async {
      final fees = buildFees(happyPath(plans: _plans(reconciles: false)));
      await pumpFees(tester, fees.fees);

      expect(find.byKey(const Key('schedule-mismatch')), findsOneWidget);
    });

    testWidgets('amounts render at exactly three decimals in both locales',
        (tester) async {
      for (final locale in <String>['ar', 'en']) {
        final fees = buildFees(happyPath());
        await pumpFees(
          tester,
          fees.fees,
          locale: locale,
          key: ValueKey<String>(locale),
        );

        // 150000 fils is 150.000 JOD. Two decimals would be a different sum.
        expect(
          find.textContaining('150.000'),
          findsWidgets,
          reason: locale,
        );
        expect(find.textContaining('150.00 '), findsNothing, reason: locale);
      }
    });

    testWidgets('the scale the server actually sends renders in both locales',
        (tester) async {
      // 150.00 JOD as 15 000 qirsh declaring two decimals. It must read as
      // 150.00 and never as 150.000: the third digit would be precision the
      // database does not hold, shown to a parent as though it were real.
      for (final locale in <String>['ar', 'en']) {
        // Both endpoints at the stored scale, because that is what the server
        // sends: a screen mixing qirsh and fils is not a state that occurs.
        final fees = buildFees(happyPath(
          summary: _summaryAtStoredScale(),
          plans: _plans(decimals: 2),
        ));

        await pumpFees(
          tester,
          fees.fees,
          locale: locale,
          key: ValueKey<String>(locale),
        );

        expect(find.textContaining('150.00'), findsWidgets, reason: locale);
        expect(find.textContaining('150.000'), findsNothing, reason: locale);
      }
    });

    testWidgets('an overdue installment reads as overdue', (tester) async {
      final fees = buildFees(happyPath(plans: _plans(overdue: true)));
      await pumpFees(tester, fees.fees);

      expect(find.textContaining('متأخر'), findsOneWidget);
    });

    testWidgets('survives 200% text scale in both locales', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      for (final locale in <String>['ar', 'en']) {
        final fees = buildFees(happyPath(plans: _plans(overdue: true)));

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
                child: ParentFeesScreen(
                  key: ValueKey<String>(locale),
                  controller: fees.fees,
                ),
              ),
            ),
          ),
        ));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));
        await tester.pump();

        expect(tester.takeException(), isNull, reason: locale);
      }
    });
  });

  group('the invoice screen', () {
    Future<void> pumpInvoice(
      WidgetTester tester,
      InvoiceDetailController controller, {
      Key? key,
    }) async {
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.light(),
        locale: const Locale('ar'),
        supportedLocales: AppLocales.supported,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: AppI18nScope(
          formats: const AppFormats(locale: 'ar'),
          child: InvoiceDetailScreen(key: key, controller: controller),
        ),
      ));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump();
    }

    testWidgets('an uncleared invoice shows its state and no QR',
        (tester) async {
      final fees = buildFees((options) => MockReply(body: _invoice()));
      final controller = InvoiceDetailController(
        repository: fees.repository,
        invoiceId: 4,
      );
      addTearDown(controller.dispose);

      await pumpInvoice(tester, controller);

      expect(find.byKey(const Key('clearance-state')), findsOneWidget);
      expect(find.text('قيد المعالجة — لم تصدر بعد'), findsOneWidget);
      expect(find.byKey(const Key('clearance-qr')), findsNothing);
      expect(find.byKey(const Key('clearance-no-qr')), findsOneWidget);
    });

    testWidgets('a cleared invoice shows the authority QR and nothing invented',
        (tester) async {
      final fees = buildFees((options) => MockReply(
            body: _invoice(clearance: 'cleared', qr: 'AUTHORITY-PAYLOAD-123'),
          ));
      final controller = InvoiceDetailController(
        repository: fees.repository,
        invoiceId: 4,
      );
      addTearDown(controller.dispose);

      await pumpInvoice(tester, controller);

      expect(find.text('AUTHORITY-PAYLOAD-123'), findsOneWidget);
      expect(find.byKey(const Key('clearance-no-qr')), findsNothing);
    });

    testWidgets('a QR on an uncleared invoice is ignored, not rendered',
        (tester) async {
      // A server bug must not be able to put a bogus code on a parent's
      // screen: the QR is read only from an invoice that says it is cleared.
      final fees = buildFees((options) => MockReply(
            body: _invoice(clearance: 'pending', qr: 'SHOULD-NOT-APPEAR'),
          ));
      final controller = InvoiceDetailController(
        repository: fees.repository,
        invoiceId: 4,
      );
      addTearDown(controller.dispose);

      await pumpInvoice(tester, controller);

      expect(find.text('SHOULD-NOT-APPEAR'), findsNothing);
      expect(find.byKey(const Key('clearance-no-qr')), findsOneWidget);
    });

    test('an unrecognised clearance state is treated as not cleared', () {
      final invoice = InvoiceDetail.tryFrom(
        (_invoice(clearance: 'something-new', qr: 'X')['data']! as Map),
      )!;

      expect(invoice.clearance, ClearanceState.unknown);
      expect(invoice.showsQr, isFalse);
      expect(invoice.qr, isNull);
    });
  });
}
