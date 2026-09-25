import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

import 'digit_shape.dart';
import 'money.dart';

/// Every user-facing number, amount and date goes through here.
///
/// Holding the locale, the digit shape and the calendar flag in one object is
/// what makes the digit preference apply everywhere rather than to whichever
/// call sites remembered to pass it.
class AppFormats {
  const AppFormats({
    this.locale = 'ar',
    this.digitShape = DigitShape.western,
    this.showHijri = false,
  });

  final String locale;

  final DigitShape digitShape;

  /// Show the Hijri date alongside the Gregorian one.
  final bool showHijri;

  AppFormats copyWith({
    String? locale,
    DigitShape? digitShape,
    bool? showHijri,
  }) =>
      AppFormats(
        locale: locale ?? this.locale,
        digitShape: digitShape ?? this.digitShape,
        showHijri: showHijri ?? this.showHijri,
      );

  // ------------------------------------------------------------------ money

  /// Formats an exact amount. The value never becomes a `double` on the way.
  String money(Money amount, {bool showCurrency = true}) => amount.format(
        locale: locale,
        digitShape: digitShape,
        showCurrency: showCurrency,
      );

  // ---------------------------------------------------------------- numbers

  /// A plain integer — counts, percentages, page numbers.
  String integer(int value) =>
      _shape(NumberFormat.decimalPattern(locale).format(value));

  /// A non-money decimal, e.g. a grade average.
  ///
  /// Money must never come through here: use [money], which keeps the value in
  /// integer minor units.
  String decimal(num value, {int fractionDigits = 2}) {
    final format = NumberFormat.decimalPattern(locale)
      ..minimumFractionDigits = fractionDigits
      ..maximumFractionDigits = fractionDigits;
    return _shape(format.format(value));
  }

  String percent(int value) => _shape('${NumberFormat.decimalPattern(locale).format(value)}%');

  // ------------------------------------------------------------------ dates

  /// Gregorian date, e.g. `٣ سبتمبر ٢٠٢٦` or `September 3, 2026`.
  String gregorianDate(DateTime date) =>
      _shape(DateFormat.yMMMMd(locale).format(date));

  String shortDate(DateTime date) =>
      _shape(DateFormat.yMd(locale).format(date));

  String time(DateTime date) => _shape(DateFormat.Hm(locale).format(date));

  String dateTime(DateTime date) =>
      '${gregorianDate(date)} ${time(date)}';

  String weekdayName(DateTime date) =>
      DateFormat.EEEE(locale).format(date);

  /// The date as configured: Gregorian, with the Hijri date appended when
  /// [showHijri] is on.
  String date(DateTime date) {
    final gregorian = gregorianDate(date);
    if (!showHijri) return gregorian;
    return '$gregorian (${hijriDate(date)})';
  }

  /// Hijri (Umm al-Qura) date.
  ///
  /// Composed from the calendar's integer fields rather than its own
  /// `toFormat`, because that helper rewrites digits to Arabic-Indic whenever
  /// its language is Arabic — which would quietly override the user's digit
  /// preference. Building the string here keeps [digitShape] authoritative.
  String hijriDate(DateTime date) {
    final language = locale.startsWith('ar') ? 'ar' : 'en';
    // `language` is static on the package. Set and read with no await between,
    // so nothing can interleave.
    HijriCalendar.language = language;
    final hijri = HijriCalendar.fromDate(date);

    final day = hijri.hDay.toString();
    final year = hijri.hYear.toString();
    final month = hijri.longMonthName;
    final suffix = language == 'ar' ? 'هـ' : 'AH';

    return _shape('$day $month $year $suffix');
  }

  String _shape(String value) => shapeDigits(value, digitShape);
}
