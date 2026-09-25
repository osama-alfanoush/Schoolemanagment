import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:school_mobile/core/i18n/app_formats.dart';
import 'package:school_mobile/core/i18n/digit_shape.dart';
import 'package:school_mobile/core/i18n/money.dart';

/// Digits only; separators and letters must be left alone.
final RegExp arabicIndicDigit = RegExp(r'[٠-٩]');
final RegExp westernDigit = RegExp(r'[0-9]');

final DateTime sample = DateTime(2026, 9, 3);

void main() {
  setUpAll(initializeDateFormatting);

  group('digit shaping', () {
    test('maps both directions and leaves everything else alone', () {
      expect(shapeDigits('12.500 JOD', DigitShape.arabicIndic), '١٢.٥٠٠ JOD');
      expect(shapeDigits('١٢.٥٠٠ JOD', DigitShape.western), '12.500 JOD');
      // Already in the target shape: unchanged.
      expect(shapeDigits('12.500 JOD', DigitShape.western), '12.500 JOD');
    });

    test('does not touch separators or letters', () {
      const input = '1,234.567 JOD';
      final shaped = shapeDigits(input, DigitShape.arabicIndic);

      expect(shaped.contains(','), isTrue);
      expect(shaped.contains('.'), isTrue);
      expect(shaped.contains('JOD'), isTrue);
      expect(westernDigit.hasMatch(shaped), isFalse);
    });
  });

  group('the preference applies to every kind of number', () {
    const western = AppFormats(locale: 'ar');
    const arabicIndic =
        AppFormats(locale: 'ar', digitShape: DigitShape.arabicIndic);

    test('money follows the preference', () {
      const amount = Money.jod(12500);

      expect(western.money(amount), '12.500 JOD');
      expect(arabicIndic.money(amount), '١٢.٥٠٠ JOD');
    });

    test('dates follow the preference', () {
      final westernDate = western.gregorianDate(sample);
      final shapedDate = arabicIndic.gregorianDate(sample);

      expect(westernDigit.hasMatch(westernDate), isTrue);
      expect(arabicIndicDigit.hasMatch(westernDate), isFalse);

      expect(arabicIndicDigit.hasMatch(shapedDate), isTrue);
      expect(westernDigit.hasMatch(shapedDate), isFalse,
          reason: 'a date must not keep Western digits when the user chose '
              'Arabic-Indic');
    });

    test('plain integers follow the preference', () {
      expect(western.integer(1234567), '1,234,567');
      expect(arabicIndic.integer(1234567), '١,٢٣٤,٥٦٧');
    });

    test('non-money decimals follow the preference', () {
      expect(westernDigit.hasMatch(western.decimal(87.5, fractionDigits: 1)),
          isTrue);
      expect(
        arabicIndicDigit.hasMatch(arabicIndic.decimal(87.5, fractionDigits: 1)),
        isTrue,
      );
      expect(
        westernDigit.hasMatch(arabicIndic.decimal(87.5, fractionDigits: 1)),
        isFalse,
      );
    });

    test('percentages and times follow the preference too', () {
      expect(westernDigit.hasMatch(arabicIndic.percent(85)), isFalse);
      expect(
        westernDigit.hasMatch(
          arabicIndic.time(DateTime(2026, 9, 3, 14, 30)),
        ),
        isFalse,
      );
    });

    test('nothing anywhere keeps Western digits under the Arabic-Indic shape',
        () {
      final rendered = <String>[
        arabicIndic.money(const Money.jod(12500)),
        arabicIndic.integer(2026),
        arabicIndic.gregorianDate(sample),
        arabicIndic.shortDate(sample),
        arabicIndic.time(DateTime(2026, 9, 3, 9, 5)),
        arabicIndic.percent(50),
        arabicIndic.hijriDate(sample),
      ];

      for (final value in rendered) {
        expect(westernDigit.hasMatch(value), isFalse, reason: 'in "$value"');
        expect(arabicIndicDigit.hasMatch(value), isTrue, reason: 'in "$value"');
      }
    });
  });

  group('dates', () {
    test('renders Gregorian in the active locale', () {
      expect(
        const AppFormats(locale: 'en').gregorianDate(sample),
        'September 3, 2026',
      );
      expect(
        const AppFormats(locale: 'ar').gregorianDate(sample),
        '3 سبتمبر 2026',
      );
    });

    test('the Hijri flag is off by default and adds the date when on', () {
      const plain = AppFormats(locale: 'en');
      const withHijri = AppFormats(locale: 'en', showHijri: true);

      expect(plain.date(sample), 'September 3, 2026');
      expect(withHijri.date(sample), contains('September 3, 2026'));
      expect(withHijri.date(sample), contains('AH'));
    });

    test('Hijri conversion matches published Umm al-Qura anchors', () {
      const formats = AppFormats(locale: 'en');

      // 1 Muharram 1445 AH fell on 19 July 2023.
      expect(formats.hijriDate(DateTime(2023, 7, 19)), '1 Muharram 1445 AH');
      // 1 Muharram 1446 AH fell on 7 July 2024.
      expect(formats.hijriDate(DateTime(2024, 7, 7)), '1 Muharram 1446 AH');
    });

    test('Hijri respects the digit preference rather than forcing its own', () {
      // The hijri package rewrites digits itself when its language is Arabic;
      // this proves our preference wins.
      const westernArabic = AppFormats(locale: 'ar');

      final rendered = westernArabic.hijriDate(sample);
      expect(westernDigit.hasMatch(rendered), isTrue);
      expect(arabicIndicDigit.hasMatch(rendered), isFalse);
      expect(rendered, contains('هـ'));
    });
  });
}
