import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'digit_shape.dart';

/// Separator between the amount and its currency code.
///
/// A plain space, stated explicitly so it cannot drift into a non-breaking
/// space and quietly break string comparisons on formatted amounts.
const String currencySeparator = ' ';

/// The *nominal* decimal places of currencies this app knows about.
///
/// JOD is a three-decimal currency: 1 JOD = 1000 fils. This map says what the
/// currency is, not what any particular payload carries — a server may store
/// and declare fewer decimals than the currency nominally has, and today ours
/// does exactly that. The authority for a given amount is the `decimals` field
/// that arrived with it; this map only bounds it from above.
const Map<String, int> knownCurrencyDecimals = <String, int>{
  'JOD': 3,
  'USD': 2,
  'EUR': 2,
};

/// The API sent something that is not a usable amount.
///
/// Raised instead of defaulting to zero: a silently-zero fee is worse than a
/// visible failure, because nobody notices it until the money is wrong.
class MoneyFormatException implements Exception {
  const MoneyFormatException(this.message);

  final String message;

  @override
  String toString() => 'MoneyFormatException: $message';
}

/// Arithmetic was attempted across two currencies.
class CurrencyMismatchException implements Exception {
  const CurrencyMismatchException(this.left, this.right);

  final String left;
  final String right;

  @override
  String toString() =>
      'CurrencyMismatchException: cannot combine $left with $right';
}

/// Arithmetic was attempted across two scales of the same currency.
///
/// Separate from [CurrencyMismatchException] because the cause and the fix are
/// different: this one means two parts of the app disagree about whether an
/// amount is counted in qirsh or in fils, which is a thousandfold error and
/// never a display problem.
class ScaleMismatchException implements Exception {
  const ScaleMismatchException(this.currency, this.left, this.right);

  final String currency;
  final int left;
  final int right;

  @override
  String toString() =>
      'ScaleMismatchException: cannot combine $currency at $left decimals '
      'with $currency at $right decimals';
}

/// An exact amount of money, held as integer minor units.
///
/// There is deliberately **no** constructor, field or method here that accepts
/// or produces a `double`. Money is counted in fils, never measured in floating
/// point, so no rounding step can quietly lose one.
@immutable
class Money implements Comparable<Money> {
  const Money({
    required this.minor,
    required this.currency,
    required this.decimals,
  }) : assert(decimals >= 0, 'decimals cannot be negative');

  /// Jordanian dinar, in fils.
  const Money.jod(this.minor)
      : currency = 'JOD',
        decimals = 3;

  /// Zero in [currency], using that currency's own nominal scale.
  ///
  /// Use [Money.zeroLike] instead wherever the zero will sit beside, or be
  /// combined with, an amount that came from the server: the server's scale is
  /// the one in play, and it need not be the nominal one.
  factory Money.zero(String currency) => Money(
        minor: 0,
        currency: currency,
        decimals: knownCurrencyDecimals[currency.toUpperCase()] ?? 2,
      );

  /// Zero in the same currency *and scale* as [other].
  ///
  /// The default for a missing amount in a payload, so an absent value and a
  /// present one are counted in the same units.
  factory Money.zeroLike(Money other) => Money(
        minor: 0,
        currency: other.currency,
        decimals: other.decimals,
      );

  /// The amount in minor units — fils for JOD.
  final int minor;

  /// ISO 4217 code, e.g. `JOD`.
  final String currency;

  /// Digits after the decimal separator. 3 for JOD.
  final int decimals;

  /// Reads the API shape `{minor, currency, decimals}`.
  ///
  /// Every field is checked. A `minor` that arrived as a JSON double (`12500.0`)
  /// is rejected rather than truncated, because that is exactly the path by
  /// which a fil goes missing.
  factory Money.fromJson(Object? json) {
    if (json is! Map) {
      throw const MoneyFormatException('Expected a money object.');
    }

    final rawMinor = json['minor'];
    if (rawMinor is! int) {
      throw MoneyFormatException(
        'Field "minor" must be an integer number of minor units, '
        'got ${rawMinor.runtimeType}.',
      );
    }

    final rawCurrency = json['currency'];
    if (rawCurrency is! String || rawCurrency.trim().isEmpty) {
      throw const MoneyFormatException(
        'Field "currency" must be a non-empty ISO 4217 code.',
      );
    }
    final currency = rawCurrency.trim().toUpperCase();

    final rawDecimals = json['decimals'];
    if (rawDecimals is! int || rawDecimals < 0 || rawDecimals > 6) {
      throw MoneyFormatException(
        'Field "decimals" must be an integer between 0 and 6, '
        'got ${rawDecimals.runtimeType}.',
      );
    }

    // A payload may declare FEWER decimals than the currency nominally has:
    // that is a server storing qirsh rather than fils, and the honest thing
    // for it to do is say so. It may not declare MORE, because precision the
    // currency does not have cannot have come from anywhere real.
    //
    // This deliberately does not pin JOD to 3. Pinning it would mean an
    // installed app rejecting every amount the day the server widens its
    // columns, turning a server-side improvement into a field outage.
    final nominal = knownCurrencyDecimals[currency];
    if (nominal != null && rawDecimals > nominal) {
      throw MoneyFormatException(
        '$currency has at most $nominal decimals, payload declared $rawDecimals.',
      );
    }

    return Money(minor: rawMinor, currency: currency, decimals: rawDecimals);
  }

  /// The API shape, round-tripping [fromJson].
  Map<String, Object> toJson() => <String, Object>{
        'minor': minor,
        'currency': currency,
        'decimals': decimals,
      };

  bool get isNegative => minor < 0;

  bool get isZero => minor == 0;

  /// 10^[decimals], computed in integers.
  int get _scale {
    var result = 1;
    for (var i = 0; i < decimals; i++) {
      result *= 10;
    }
    return result;
  }

  /// Whole units, e.g. 12 for 12500 fils.
  int get wholeUnits => minor.abs() ~/ _scale;

  /// Minor units below one whole unit, e.g. 500 for 12500 fils.
  int get fractionalUnits => minor.abs() % _scale;

  Money operator +(Money other) => Money(
        minor: minor + _assertCompatible(other).minor,
        currency: currency,
        decimals: decimals,
      );

  Money operator -(Money other) => Money(
        minor: minor - _assertCompatible(other).minor,
        currency: currency,
        decimals: decimals,
      );

  Money operator -() =>
      Money(minor: -minor, currency: currency, decimals: decimals);

  /// Scales by a whole number. There is no multiply-by-double: a 7.5% fee is
  /// expressed as a ratio through [allocate] or as integer minor units.
  Money multiplyBy(int factor) =>
      Money(minor: minor * factor, currency: currency, decimals: decimals);

  /// Splits into [parts] amounts that sum back to exactly this one.
  ///
  /// There is no plain division, because dividing money always leaves a
  /// remainder that has to go somewhere. Here the remaining minor units are
  /// handed out one each to the earliest parts, so nothing is created and
  /// nothing is lost: `allocate(n).reduce((a, b) => a + b) == this`, always.
  List<Money> allocate(int parts) {
    if (parts < 1) {
      throw ArgumentError.value(parts, 'parts', 'must be at least 1');
    }

    // Work on the magnitude so the remainder is distributed the same way for
    // negative amounts as for positive ones.
    final sign = isNegative ? -1 : 1;
    final magnitude = minor.abs();
    final base = magnitude ~/ parts;
    final remainder = magnitude % parts;

    return List<Money>.generate(
      parts,
      (index) => Money(
        minor: sign * (base + (index < remainder ? 1 : 0)),
        currency: currency,
        decimals: decimals,
      ),
      growable: false,
    );
  }

  /// Splits by integer weights, exactly. Used for pro-rata shares.
  List<Money> allocateByRatios(List<int> ratios) {
    if (ratios.isEmpty || ratios.any((r) => r < 0)) {
      throw ArgumentError.value(ratios, 'ratios', 'must be non-negative');
    }
    final total = ratios.reduce((a, b) => a + b);
    if (total == 0) {
      throw ArgumentError.value(ratios, 'ratios', 'must not sum to zero');
    }

    final sign = isNegative ? -1 : 1;
    final magnitude = minor.abs();
    final shares = <int>[];
    var distributed = 0;
    for (final ratio in ratios) {
      final share = magnitude * ratio ~/ total;
      shares.add(share);
      distributed += share;
    }

    // Hand the rounding remainder out one unit at a time, largest ratio first.
    var remainder = magnitude - distributed;
    final order = List<int>.generate(ratios.length, (i) => i)
      ..sort((a, b) => ratios[b].compareTo(ratios[a]));
    for (final index in order) {
      if (remainder == 0) break;
      shares[index] += 1;
      remainder -= 1;
    }

    return <Money>[
      for (final share in shares)
        Money(minor: sign * share, currency: currency, decimals: decimals),
    ];
  }

  /// Refuses arithmetic that would mix currencies or scales.
  ///
  /// The scale half matters as much as the currency half. `minor` means
  /// nothing without the scale it is counted in, so adding 1250 qirsh to
  /// 12500 fils yields 13750 of neither. While the server declared the same
  /// scale as the currency's nominal one this could not happen; now that a
  /// payload may legitimately carry fewer decimals than [knownCurrencyDecimals]
  /// says, it can, and silently.
  Money _assertCompatible(Money other) {
    if (other.currency != currency) {
      throw CurrencyMismatchException(currency, other.currency);
    }
    if (other.decimals != decimals) {
      throw ScaleMismatchException(currency, decimals, other.decimals);
    }
    return other;
  }

  /// Renders the amount for display.
  ///
  /// The integer and fractional halves are formatted separately from integers,
  /// so the value never passes through a `double`. [locale] supplies the group
  /// and decimal separators; [digitShape] chooses the numerals.
  String format({
    String locale = 'ar',
    DigitShape digitShape = DigitShape.western,
    bool showCurrency = true,
  }) {
    final symbols = NumberFormat.decimalPattern(locale).symbols;
    final grouped = NumberFormat.decimalPattern(locale).format(wholeUnits);

    final buffer = StringBuffer();
    if (isNegative) buffer.write(symbols.MINUS_SIGN);
    buffer.write(grouped);
    if (decimals > 0) {
      buffer
        ..write(symbols.DECIMAL_SEP)
        ..write(fractionalUnits.toString().padLeft(decimals, '0'));
    }
    if (showCurrency) {
      buffer
        ..write(currencySeparator)
        ..write(currency);
    }

    return shapeDigits(buffer.toString(), digitShape);
  }

  @override
  int compareTo(Money other) =>
      minor.compareTo(_assertCompatible(other).minor);

  @override
  bool operator ==(Object other) =>
      other is Money &&
      other.minor == minor &&
      other.currency == currency &&
      other.decimals == decimals;

  @override
  int get hashCode => Object.hash(minor, currency, decimals);

  @override
  String toString() => 'Money($minor minor, $currency, $decimals dp)';
}
