import 'package:flutter/material.dart';

import '../../core/i18n/i18n_scope.dart';

/// Which form of a date to show.
enum DateStyle {
  /// Full date, with the Hijri date appended when the user asked for it.
  full,

  /// Numeric, for dense rows and tables.
  short,

  /// Date and time.
  dateTime,

  /// Weekday name alone.
  weekday,
}

/// Renders a date the way the user configured it.
///
/// Both preferences that make a date correct here — Arabic-Indic digits and the
/// Hijri calendar — live on `AppFormats`, so this widget reads them from the
/// scope rather than taking them as arguments. A screen that formats its own
/// dates is a screen that will still show Western digits after the user has
/// switched the whole app to Arabic-Indic.
class DateText extends StatelessWidget {
  const DateText(
    this.date, {
    this.style = DateStyle.full,
    this.textStyle,
    this.textAlign,
    super.key,
  });

  final DateTime date;
  final DateStyle style;
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final formats = AppI18nScope.of(context);

    final text = switch (style) {
      DateStyle.full => formats.date(date),
      DateStyle.short => formats.shortDate(date),
      DateStyle.dateTime => formats.dateTime(date),
      DateStyle.weekday => formats.weekdayName(date),
    };

    return Text(
      text,
      textAlign: textAlign,
      style: textStyle ?? Theme.of(context).textTheme.bodyMedium,
    );
  }
}
