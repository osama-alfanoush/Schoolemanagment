import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/i18n/digit_shape.dart';
import 'package:school_mobile/core/i18n/money.dart';

void main() {
  group('formatting JOD', () {
    test('12500 fils renders with exactly three decimals in both locales', () {
      const amount = Money.jod(12500);

      expect(amount.format(locale: 'en'), '12.500 JOD');
      expect(amount.format(locale: 'ar'), '12.500 JOD');
    });

    test('keeps trailing zeros that a two-decimal currency would drop', () {
      // 12.500 must never render as 12.5 or 12.50 — it has to match the paper
      // invoice digit for digit.
      expect(const Money.jod(12500).format(locale: 'en'), '12.500 JOD');
      expect(const Money.jod(12000).format(locale: 'en'), '12.000 JOD');
      expect(const Money.jod(1).format(locale: 'en'), '0.001 JOD');
      expect(const Money.jod(999).format(locale: 'en'), '0.999 JOD');
    });

    test('a currency declaring two decimals renders with two', () {
      const usd = Money(minor: 1250, currency: 'USD', decimals: 2);

      expect(usd.format(locale: 'en'), '12.50 USD');
    });

    test('groups thousands and keeps the fils', () {
      expect(
        const Money.jod(1234567).format(locale: 'en'),
        '1,234.567 JOD',
      );
    });

    test('negative amounts keep their sign and their decimals', () {
      expect(const Money.jod(-12500).format(locale: 'en'), '-12.500 JOD');
    });

    test('renders Arabic-Indic digits on request, separators untouched', () {
      expect(
        const Money.jod(1234567)
            .format(locale: 'ar', digitShape: DigitShape.arabicIndic),
        '١,٢٣٤.٥٦٧ JOD',
      );
    });
  });

  group('parsing the API shape', () {
    test('reads {minor, currency, decimals}', () {
      final money = Money.fromJson(
        jsonDecode('{"minor":12500,"currency":"JOD","decimals":3}'),
      );

      expect(money.minor, 12500);
      expect(money.currency, 'JOD');
      expect(money.decimals, 3);
      expect(money.format(locale: 'en'), '12.500 JOD');
    });

    test('a double minor is rejected, not truncated', () {
      // This is the exact path by which a fil goes missing.
      expect(
        () => Money.fromJson(
          jsonDecode('{"minor":12500.7,"currency":"JOD","decimals":3}'),
        ),
        throwsA(isA<MoneyFormatException>()),
      );
    });

    test('a missing minor is a typed error, never a silent zero', () {
      expect(
        () => Money.fromJson(const <String, Object?>{
          'currency': 'JOD',
          'decimals': 3,
        }),
        throwsA(isA<MoneyFormatException>()),
      );
    });

    test('a string minor is a typed error', () {
      expect(
        () => Money.fromJson(const <String, Object?>{
          'minor': '12500',
          'currency': 'JOD',
          'decimals': 3,
        }),
        throwsA(isA<MoneyFormatException>()),
      );
    });

    test('JOD declaring the wrong number of decimals is rejected', () {
      expect(
        () => Money.fromJson(const <String, Object?>{
          'minor': 1250,
          'currency': 'JOD',
          'decimals': 2,
        }),
        throwsA(isA<MoneyFormatException>()),
      );
    });

    test('a missing or absurd decimals field is rejected', () {
      expect(
        () => Money.fromJson(const <String, Object?>{
          'minor': 1,
          'currency': 'XXX',
        }),
        throwsA(isA<MoneyFormatException>()),
      );
      expect(
        () => Money.fromJson(const <String, Object?>{
          'minor': 1,
          'currency': 'XXX',
          'decimals': 99,
        }),
        throwsA(isA<MoneyFormatException>()),
      );
    });

    test('a missing currency is rejected', () {
      expect(
        () => Money.fromJson(const <String, Object?>{'minor': 1, 'decimals': 3}),
        throwsA(isA<MoneyFormatException>()),
      );
    });

    test('round-trips through toJson', () {
      const original = Money.jod(12500);
      expect(Money.fromJson(original.toJson()), original);
    });
  });

  group('arithmetic', () {
    test('adds and subtracts in minor units', () {
      expect(const Money.jod(12500) + const Money.jod(1), const Money.jod(12501));
      expect(const Money.jod(12500) - const Money.jod(500), const Money.jod(12000));
    });

    test('multiplies by a whole number', () {
      expect(const Money.jod(12500).multiplyBy(3), const Money.jod(37500));
    });

    test('adding two different currencies throws', () {
      const jod = Money.jod(1000);
      const usd = Money(minor: 1000, currency: 'USD', decimals: 2);

      expect(() => jod + usd, throwsA(isA<CurrencyMismatchException>()));
      expect(() => jod - usd, throwsA(isA<CurrencyMismatchException>()));
    });
  });

  group('splitting', () {
    test('an uneven split sums back to exactly the original', () {
      // 100 fils across 3 parts cannot divide evenly.
      const total = Money.jod(100);

      final parts = total.allocate(3);

      expect(parts.map((p) => p.minor).toList(), <int>[34, 33, 33]);
      final sum = parts.reduce((a, b) => a + b);
      expect(sum, total, reason: 'not one fil may be created or lost');
      expect(sum.minor, 100);
    });

    test('every split from 1 to 50 parts sums back exactly', () {
      const total = Money.jod(12500);

      for (var parts = 1; parts <= 50; parts++) {
        final split = total.allocate(parts);
        expect(split, hasLength(parts));
        expect(
          split.reduce((a, b) => a + b),
          total,
          reason: 'split into $parts parts lost or gained a fil',
        );
      }
    });

    test('a negative amount splits without losing a fil either', () {
      const total = Money.jod(-100);

      final parts = total.allocate(3);

      expect(parts.map((p) => p.minor).toList(), <int>[-34, -33, -33]);
      expect(parts.reduce((a, b) => a + b), total);
    });

    test('ratio splits are exact too', () {
      const total = Money.jod(1000);

      final parts = total.allocateByRatios(<int>[1, 1, 1]);

      expect(parts.reduce((a, b) => a + b), total);
      expect(parts.map((p) => p.minor).toList(), <int>[334, 333, 333]);
    });

    test('splitting into fewer than one part is rejected', () {
      expect(() => const Money.jod(1).allocate(0), throwsArgumentError);
    });
  });

  group('no floating point anywhere in the money path', () {
    test('Money exposes no double-valued member and no double constructor', () {
      const amount = Money.jod(12500);

      // Every numeric part of the type is an int.
      expect(amount.minor, isA<int>());
      expect(amount.wholeUnits, isA<int>());
      expect(amount.fractionalUnits, isA<int>());
      expect(amount.decimals, isA<int>());
      expect(amount.toJson()['minor'], isA<int>());

      // And nothing is a double, which a `12.5`-style value would be.
      expect(amount.minor, isNot(isA<double>()));
      expect(amount.toJson()['minor'], isNot(isA<double>()));
    });

    test('the value that a double round-trip would corrupt stays exact', () {
      // 0.1 + 0.2 != 0.3 in binary floating point. In fils it is just integers,
      // so the same sum is exact.
      final sum = const Money.jod(100) + const Money.jod(200);

      expect(sum.minor, 300);
      expect(sum.format(locale: 'en'), '0.300 JOD');
    });

    test('a large amount keeps every fil', () {
      const large = Money.jod(999999999);

      expect(large.format(locale: 'en'), '999,999.999 JOD');
      expect(large.wholeUnits, 999999);
      expect(large.fractionalUnits, 999);
    });
  });
}
