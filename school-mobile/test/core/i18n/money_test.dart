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

    test('JOD declaring two decimals is accepted, because the server stores two',
        () {
      // This inverts a rule that used to say JOD must always declare 3. The
      // server's money columns are decimal(x,2) and its internal minor unit is
      // the qirsh, so declaring 3 was the app being told a precision the
      // database never had. Accepting the server's own scale is what makes the
      // displayed amount true.
      final money = Money.fromJson(const <String, Object?>{
        'minor': 1250,
        'currency': 'JOD',
        'decimals': 2,
      });

      expect(money.decimals, 2);
      expect(money.format(locale: 'en'), '12.50 JOD');
    });

    test('JOD declaring four decimals is still rejected', () {
      // Fewer decimals than the currency has is a server being honest about
      // its storage. More is precision that cannot have come from anywhere
      // real, and rendering it would invent digits.
      expect(
        () => Money.fromJson(const <String, Object?>{
          'minor': 125000,
          'currency': 'JOD',
          'decimals': 4,
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

  group('the scale the server declares', () {
    // The server stores qirsh, not fils, and now says so. These pin the
    // rendering of that honest payload, and the capability the client keeps
    // for the day the server gains a third decimal.

    const qirsh = Money(minor: 1250, currency: 'JOD', decimals: 2);

    test('a two-decimal JOD amount renders with two in both locales', () {
      expect(qirsh.format(locale: 'en'), '12.50 JOD');
      expect(
        qirsh.format(locale: 'ar', digitShape: DigitShape.western),
        '12.50 JOD',
      );
    });

    test('and in Arabic-Indic digits, which is a separate code path', () {
      // Digits are shaped; the separator is deliberately left ASCII, as the
      // three-decimal case above already establishes.
      expect(
        qirsh.format(locale: 'ar', digitShape: DigitShape.arabicIndic),
        '١٢.٥٠ JOD',
      );
    });

    test('a trailing zero is not dropped', () {
      // 12.5 and 12.50 are the same number and different amounts of money on
      // a receipt. Padding is what keeps the column aligned with the invoice.
      const half = Money(minor: 1250, currency: 'JOD', decimals: 2);

      expect(half.format(locale: 'en', showCurrency: false), '12.50');
    });

    test('whole and fractional units split on the declared scale, not on 3',
        () {
      expect(qirsh.wholeUnits, 12);
      expect(qirsh.fractionalUnits, 50);
    });

    test('the client keeps its three-decimal capability', () {
      // The server's limitation is temporary; the type must not be narrowed to
      // match it, or widening the columns later becomes a client rewrite.
      const fils = Money.jod(12505);

      expect(fils.decimals, 3);
      expect(fils.format(locale: 'en'), '12.505 JOD');
      expect(fils.wholeUnits, 12);
      expect(fils.fractionalUnits, 505);
    });

    test('allocate stays exact at two decimals', () {
      // 100.00 JOD in qirsh, split three ways.
      const total = Money(minor: 10000, currency: 'JOD', decimals: 2);
      final parts = total.allocate(3);

      expect(parts.map((p) => p.minor).toList(), <int>[3334, 3333, 3333]);
      expect(parts.reduce((a, b) => a + b), total);
      expect(parts.every((p) => p.decimals == 2), isTrue);
    });

    test('mixing qirsh and fils is refused, not silently added', () {
      // 1250 qirsh + 12500 fils is 13750 of neither. While the server declared
      // the nominal scale this could not arise; now that it declares its own,
      // it can.
      const fils = Money.jod(12500);

      expect(() => qirsh + fils, throwsA(isA<ScaleMismatchException>()));
      expect(() => qirsh - fils, throwsA(isA<ScaleMismatchException>()));
      expect(() => qirsh.compareTo(fils), throwsA(isA<ScaleMismatchException>()));
    });

    test('a missing amount adopts the scale of the one beside it', () {
      final zero = Money.zeroLike(qirsh);

      expect(zero.decimals, 2);
      expect(zero + qirsh, qirsh);
    });
  });
}
