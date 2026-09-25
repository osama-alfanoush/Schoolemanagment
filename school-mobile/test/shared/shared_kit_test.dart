import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/api/api_error.dart';
import 'package:school_mobile/core/i18n/i18n.dart';
import 'package:school_mobile/core/sync/sync_status.dart';
import 'package:school_mobile/core/theme/theme.dart';
import 'package:school_mobile/shared/shared.dart';

/// Pumps [child] inside the real theme, localizations and formats.
Future<void> pumpKit(
  WidgetTester tester,
  Widget child, {
  String locale = 'ar',
  DigitShape digitShape = DigitShape.western,
  bool showHijri = false,
  double textScale = 1.0,
}) async {
  await tester.pumpWidget(MaterialApp(
    theme: AppTheme.light(),
    locale: Locale(locale),
    supportedLocales: AppLocales.supported,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: Builder(
      builder: (context) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(textScale),
        ),
        child: AppI18nScope(
          formats: AppFormats(
            locale: locale,
            digitShape: digitShape,
            showHijri: showHijri,
          ),
          child: child,
        ),
      ),
    ),
  ));
  await tester.pump();
}

/// Fails if anything painted outside the window — the shape a clipped layout
/// takes when the text scale grows.
void expectNoOverflow(WidgetTester tester) {
  expect(tester.takeException(), isNull);
}

const List<String> locales = <String>['ar', 'en'];

void main() {
  group('LoadingView', () {
    testWidgets('renders and announces itself in both locales', (tester) async {
      for (final locale in locales) {
        await pumpKit(tester, const Scaffold(body: LoadingView()), locale: locale);

        expect(find.byKey(const Key('loading-view')), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expectNoOverflow(tester);
      }
    });
  });

  group('EmptyView', () {
    testWidgets('says so in Arabic without an error tone', (tester) async {
      await pumpKit(tester, const Scaffold(body: EmptyView()));

      expect(find.text('لا توجد بيانات'), findsOneWidget);
      expectNoOverflow(tester);
    });

    testWidgets('an action, when offered, meets the minimum tap target',
        (tester) async {
      await pumpKit(
        tester,
        Scaffold(
          body: EmptyView(actionLabel: 'إضافة', onAction: () {}),
        ),
      );

      final size = tester.getSize(find.widgetWithText(FilledButton, 'إضافة'));
      expect(size.height, greaterThanOrEqualTo(Dimens.minTapTarget));
    });
  });

  group('ErrorView', () {
    const failure = ServerError(
      message: 'The server failed to handle the request.',
      requestId: 'req_01HZY7K3',
      statusCode: 500,
    );

    testWidgets('shows the request id so a parent can quote it on the phone',
        (tester) async {
      await pumpKit(tester, const Scaffold(body: ErrorView(error: failure)));

      expect(find.byKey(const Key('request-id-card')), findsOneWidget);
      expect(find.text('req_01HZY7K3'), findsOneWidget);
      expect(find.text('رقم المرجع'), findsOneWidget);
    });

    testWidgets('the request id stays Latin and unshaped under Arabic-Indic digits',
        (tester) async {
      // Shaping it would make it stop matching the server logs, which is the
      // one job this string has.
      await pumpKit(
        tester,
        const Scaffold(body: ErrorView(error: failure)),
        digitShape: DigitShape.arabicIndic,
      );

      expect(find.text('req_01HZY7K3'), findsOneWidget);
      final text = tester.widget<SelectableText>(
        find.widgetWithText(SelectableText, 'req_01HZY7K3'),
      );
      expect(text.textDirection, TextDirection.ltr);
    });

    testWidgets('being offline is said plainly, not blamed on the server',
        (tester) async {
      await pumpKit(
        tester,
        const Scaffold(body: ErrorView(error: OfflineError())),
      );

      expect(find.text('لا يوجد اتصال بالإنترنت'), findsOneWidget);
      expect(find.text('تعذّر تحميل البيانات'), findsNothing);
    });

    testWidgets('a failure with no request id simply omits the card',
        (tester) async {
      await pumpKit(
        tester,
        const Scaffold(body: ErrorView(error: TimeoutError())),
      );

      expect(find.byKey(const Key('request-id-card')), findsNothing);
      expectNoOverflow(tester);
    });

    testWidgets('retry is offered and reaches the caller', (tester) async {
      var retries = 0;
      await pumpKit(
        tester,
        Scaffold(body: ErrorView(error: failure, onRetry: () => retries++)),
      );

      await tester.tap(find.byKey(const Key('error-retry')));
      expect(retries, 1);
    });

    testWidgets('survives 200% text scale in both locales', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      for (final locale in locales) {
        await pumpKit(
          tester,
          const Scaffold(body: ErrorView(error: failure)),
          locale: locale,
          textScale: 2.0,
        );

        expectNoOverflow(tester);
        expect(find.byKey(const Key('error-view')), findsOneWidget);
      }
    });
  });

  group('OfflineBanner', () {
    testWidgets('is absent while online and present while offline',
        (tester) async {
      await pumpKit(tester, const Scaffold(body: OfflineBanner(isOffline: false)));
      expect(find.byKey(const Key('offline-banner')), findsNothing);

      await pumpKit(tester, const Scaffold(body: OfflineBanner(isOffline: true)));
      expect(find.byKey(const Key('offline-banner')), findsOneWidget);
      expect(find.text('أنت غير متصل. تُعرض بيانات محفوظة.'), findsOneWidget);
    });
  });

  group('PendingSyncBadge', () {
    testWidgets('shows nothing when the device owes the server nothing',
        (tester) async {
      await pumpKit(
        tester,
        const Scaffold(body: PendingSyncBadge(status: SyncStatus())),
      );

      expect(find.byKey(const Key('pending-sync-badge')), findsNothing);
    });

    testWidgets('counts pending and dead rows separately', (tester) async {
      // Folding a dead row into the pending count is how a rejected attendance
      // submission disappears without anyone being told.
      await pumpKit(
        tester,
        const Scaffold(
          body: PendingSyncBadge(
            status: SyncStatus(pendingCount: 3, deadCount: 1),
          ),
        ),
      );

      expect(find.byKey(const Key('pending-sync-chip')), findsOneWidget);
      expect(find.byKey(const Key('failed-sync-chip')), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('the count follows the digit-shape preference', (tester) async {
      await pumpKit(
        tester,
        const Scaffold(body: PendingSyncBadge(status: SyncStatus(pendingCount: 12))),
        digitShape: DigitShape.arabicIndic,
      );

      expect(find.text('١٢'), findsOneWidget);
      expect(find.text('12'), findsNothing);
    });

    testWidgets('a tappable badge meets the minimum tap target', (tester) async {
      await pumpKit(
        tester,
        Scaffold(
          body: PendingSyncBadge(
            status: const SyncStatus(pendingCount: 2),
            onTap: () {},
          ),
        ),
      );

      final size = tester.getSize(find.byKey(const Key('pending-sync-chip')));
      expect(size.height, greaterThanOrEqualTo(Dimens.minTapTarget));
      expect(size.width, greaterThanOrEqualTo(Dimens.minTapTarget));
    });
  });

  group('MoneyText', () {
    testWidgets('renders JOD at exactly three decimals in both locales',
        (tester) async {
      for (final locale in locales) {
        await pumpKit(
          tester,
          const Scaffold(body: MoneyText(Money.jod(12500))),
          locale: locale,
        );

        expect(find.textContaining('12.500'), findsOneWidget, reason: locale);
      }
    });

    testWidgets('a single fil is not rounded away', (tester) async {
      await pumpKit(
        tester,
        const Scaffold(body: MoneyText(Money.jod(1))),
        locale: 'en',
      );

      expect(find.textContaining('0.001'), findsOneWidget);
    });

    testWidgets('follows the digit-shape preference', (tester) async {
      await pumpKit(
        tester,
        const Scaffold(body: MoneyText(Money.jod(12500))),
        digitShape: DigitShape.arabicIndic,
      );

      expect(find.textContaining('١٢'), findsOneWidget);
    });
  });

  group('DateText', () {
    final date = DateTime(2026, 9, 3);

    testWidgets('shows only the Gregorian date until Hijri is turned on',
        (tester) async {
      await pumpKit(tester, Scaffold(body: DateText(date)));
      expect(find.textContaining('هـ'), findsNothing);

      await pumpKit(tester, Scaffold(body: DateText(date)), showHijri: true);
      expect(find.textContaining('هـ'), findsOneWidget);
    });

    testWidgets('the Hijri date honours the digit shape rather than overriding it',
        (tester) async {
      // The hijri package rewrites digits to Arabic-Indic on its own whenever
      // its language is Arabic; AppFormats builds the string itself so the
      // user's preference stays authoritative. This is the guard on that.
      await pumpKit(
        tester,
        Scaffold(body: DateText(date)),
        showHijri: true,
        digitShape: DigitShape.western,
      );

      final rendered = tester.widget<Text>(find.byType(Text)).data!;
      expect(rendered, contains('2026'));
      expect(rendered, isNot(contains('٢٠٢٦')));
    });
  });

  group('ValueRow', () {
    /// Aligned to the top so the row takes its natural height: inside a bare
    /// Scaffold body it would stretch to the viewport and the geometry below
    /// would measure the stretch rather than the layout.
    Widget feeRow() => const Align(
          alignment: AlignmentDirectional.topCenter,
          child: ValueRow(
            label: Text('الرسوم الدراسية للفصل الدراسي الأول'),
            secondary: Text('تستحق في ٣ سبتمبر'),
            value: MoneyText(Money.jod(1250500)),
          ),
        );

    testWidgets('lays a label beside an amount at normal scale', (tester) async {
      await pumpKit(tester, Scaffold(body: feeRow()));

      expectNoOverflow(tester);
      expect(find.byType(MoneyText), findsOneWidget);
    });

    testWidgets('keeps the amount beside the label at normal scale',
        (tester) async {
      await pumpKit(tester, Scaffold(body: feeRow()));

      final label = tester.getRect(find.byType(Text).first);
      final amount = tester.getRect(find.byType(MoneyText));

      // Same line: the amount starts above where the label ends.
      expect(amount.top, lessThan(label.bottom));
    });

    testWidgets('moves the amount below the label at 200% text scale',
        (tester) async {
      // The exact case a ListTile throws on: a long Arabic label with a
      // three-decimal amount beside it. Every fee row in the app is this
      // shape. Side by side at 200% the two halves become unreadably narrow
      // columns of wrapped text long before anything actually clips, so the
      // test is on the layout changing, not merely on the absence of an
      // overflow error.
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      for (final locale in locales) {
        await pumpKit(
          tester,
          Scaffold(body: feeRow()),
          locale: locale,
          textScale: 2.0,
        );

        final label = tester.getRect(find.byType(Text).first);
        final amount = tester.getRect(find.byType(MoneyText));

        expect(
          amount.top,
          greaterThanOrEqualTo(label.bottom),
          reason: 'the amount should sit below the label at 200% ($locale)',
        );
        expectNoOverflow(tester);
      }
    });

    testWidgets('a tappable row meets the minimum tap target', (tester) async {
      await pumpKit(
        tester,
        Scaffold(
          body: ValueRow(
            label: const Text('قسط'),
            value: const MoneyText(Money.jod(500)),
            onTap: () {},
          ),
        ),
      );

      expect(
        tester.getSize(find.byType(ValueRow)).height,
        greaterThanOrEqualTo(Dimens.minTapTarget),
      );
    });
  });

  group('ListScaffold', () {
    ScreenState<List<String>> data() =>
        const ScreenData<List<String>>(<String>['one', 'two']);

    Widget list(ScreenState<List<String>> state, {Future<void> Function()? onRefresh}) =>
        ListScaffold<List<String>>(
          title: 'الرسوم',
          state: state,
          onRefresh: onRefresh,
          builder: (context, value) => ListView(
            children: <Widget>[for (final item in value) ListTile(title: Text(item))],
          ),
        );

    testWidgets('renders each state through the same frame', (tester) async {
      await pumpKit(tester, list(const ScreenLoading<List<String>>()));
      expect(find.byKey(const Key('loading-view')), findsOneWidget);

      await pumpKit(tester, list(const ScreenEmpty<List<String>>()));
      expect(find.byKey(const Key('empty-view')), findsOneWidget);

      await pumpKit(
        tester,
        list(const ScreenError<List<String>>(OfflineError())),
      );
      expect(find.byKey(const Key('error-view')), findsOneWidget);

      await pumpKit(tester, list(data()));
      expect(find.text('one'), findsOneWidget);
    });

    testWidgets('pull-to-refresh works over the empty state, not just a long list',
        (tester) async {
      var refreshes = 0;
      await pumpKit(
        tester,
        list(
          const ScreenEmpty<List<String>>(),
          onRefresh: () async => refreshes++,
        ),
      );

      await tester.fling(
        find.byKey(const Key('empty-view')),
        const Offset(0, 320),
        1000,
      );
      await tester.pumpAndSettle();

      expect(refreshes, 1);
    });

    testWidgets('the sync badge sits in the app bar when there is work owed',
        (tester) async {
      await pumpKit(
        tester,
        ListScaffold<List<String>>(
          title: 'الرسوم',
          state: data(),
          syncStatus: const SyncStatus(pendingCount: 2),
          builder: (context, value) => const SizedBox.shrink(),
        ),
      );

      expect(find.byKey(const Key('pending-sync-chip')), findsOneWidget);
    });

    testWidgets('is right-to-left in Arabic and left-to-right in English',
        (tester) async {
      for (final entry in <String, TextDirection>{
        'ar': TextDirection.rtl,
        'en': TextDirection.ltr,
      }.entries) {
        await pumpKit(tester, list(data()), locale: entry.key);

        expect(
          Directionality.of(tester.element(find.byType(AppBar))),
          entry.value,
          reason: entry.key,
        );
      }
    });

    testWidgets('survives 200% text scale in both locales', (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      for (final locale in locales) {
        await pumpKit(
          tester,
          ListScaffold<List<String>>(
            title: 'الرسوم الدراسية للفصل الأول',
            state: data(),
            isOffline: true,
            syncStatus: const SyncStatus(pendingCount: 4, deadCount: 2),
            lastUpdatedLabel: '10:24',
            builder: (context, value) => ListView(
              children: <Widget>[
                for (final item in value)
                  ValueRow(
                    label: Text(item),
                    value: const MoneyText(Money.jod(12500)),
                  ),
              ],
            ),
          ),
          locale: locale,
          textScale: 2.0,
        );

        expectNoOverflow(tester);
      }
    });
  });

  group('DetailScaffold', () {
    testWidgets('pins the primary action at the minimum tap target',
        (tester) async {
      await pumpKit(
        tester,
        DetailScaffold<String>(
          title: 'الفاتورة',
          state: const ScreenData<String>('body'),
          bottomAction: FilledButton(onPressed: () {}, child: const Text('ادفع')),
          builder: (context, value) => Text(value),
        ),
      );

      final size = tester.getSize(find.widgetWithText(FilledButton, 'ادفع'));
      expect(size.height, greaterThanOrEqualTo(Dimens.minTapTarget));
    });

    testWidgets('survives 200% text scale with a banner and an action',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 1920);
      tester.view.devicePixelRatio = 3.0;
      addTearDown(tester.view.reset);

      for (final locale in locales) {
        await pumpKit(
          tester,
          DetailScaffold<String>(
            title: 'تفاصيل الفاتورة',
            state: const ScreenData<String>('body'),
            isOffline: true,
            lastUpdatedLabel: '10:24',
            bottomAction:
                FilledButton(onPressed: () {}, child: const Text('ادفع الآن')),
            builder: (context, value) => const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MoneyText(Money.jod(1250500)),
                SizedBox(height: 8),
                Text('نص طويل نسبيًا لاختبار التفاف السطور عند تكبير الخط.'),
              ],
            ),
          ),
          locale: locale,
          textScale: 2.0,
        );

        expectNoOverflow(tester);
      }
    });
  });
}
