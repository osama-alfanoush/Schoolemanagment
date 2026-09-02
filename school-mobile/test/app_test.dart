import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:school_mobile/main.dart';

final RegExp westernDigit = RegExp(r'[0-9]');
final RegExp arabicIndicDigit = RegExp(r'[٠-٩]');

void main() {
  setUpAll(initializeDateFormatting);

  /// Runs the real app with [locale] as the device language.
  Future<void> pumpApp(WidgetTester tester, {Locale? locale}) async {
    if (locale != null) {
      tester.platformDispatcher.localesTestValue = <Locale>[locale];
      addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    }
    await tester.pumpWidget(const SchoolSuiteApp());
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

  group('direction', () {
    testWidgets('renders right-to-left under ar', (tester) async {
      await pumpApp(tester, locale: const Locale('ar'));

      final context = tester.element(find.byType(VerificationScreen));
      expect(Localizations.localeOf(context), const Locale('ar'));
      expect(Directionality.of(context), TextDirection.rtl);
      expect(find.text('سويت المدرسة'), findsWidgets);
    });

    testWidgets('renders left-to-right under en', (tester) async {
      await pumpApp(tester, locale: const Locale('en'));

      final context = tester.element(find.byType(VerificationScreen));
      expect(Localizations.localeOf(context), const Locale('en'));
      expect(Directionality.of(context), TextDirection.ltr);
      expect(find.text('School Suite'), findsWidgets);
    });

    testWidgets('an unsupported device language falls back to Arabic',
        (tester) async {
      await pumpApp(tester, locale: const Locale('fr'));

      final context = tester.element(find.byType(VerificationScreen));
      expect(Localizations.localeOf(context), const Locale('ar'));
      expect(Directionality.of(context), TextDirection.rtl);
    });
  });

  group('the verification screen proves the layers are wired', () {
    testWidgets('shows a JOD amount with three decimals', (tester) async {
      await pumpApp(tester, locale: const Locale('en'));

      expect(valueUnder(tester, 'verification-amount'), '12.500 JOD');
    });

    testWidgets('shows a formatted date and the active digit shape',
        (tester) async {
      await pumpApp(tester, locale: const Locale('en'));

      expect(valueUnder(tester, 'verification-date'), 'September 3, 2026');
      expect(valueUnder(tester, 'verification-digit-shape'), 'Western');
    });

    testWidgets('toggling the digit shape restyles money and dates together',
        (tester) async {
      await pumpApp(tester, locale: const Locale('en'));

      expect(valueUnder(tester, 'verification-amount'), '12.500 JOD');

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
    testWidgets('does not overflow at 200% text scale', (tester) async {
      tester.platformDispatcher.textScaleFactorTestValue = 2.0;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await pumpApp(tester, locale: const Locale('ar'));

      // A RenderFlex overflow is reported as a framework exception; if one had
      // happened, this would return it.
      expect(tester.takeException(), isNull);

      // The scale really was applied, and the content is still there.
      final context = tester.element(find.byType(VerificationScreen));
      expect(MediaQuery.textScalerOf(context).scale(10), 20.0);
      expect(find.byKey(const Key('verification-amount')), findsOneWidget);
      expect(find.byKey(const Key('verification-date')), findsOneWidget);
    });

    testWidgets('still shows every value at 200% scale in English',
        (tester) async {
      tester.platformDispatcher.textScaleFactorTestValue = 2.0;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await pumpApp(tester, locale: const Locale('en'));

      expect(tester.takeException(), isNull);
      expect(valueUnder(tester, 'verification-amount'), '12.500 JOD');
    });
  });
}
