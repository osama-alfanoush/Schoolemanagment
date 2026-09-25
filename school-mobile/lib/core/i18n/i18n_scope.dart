import 'package:flutter/widgets.dart';

import 'app_formats.dart';

/// Makes the active [AppFormats] — locale, digit shape, calendar flag —
/// available to every widget.
///
/// Reading formatting from one place is what keeps the digit preference
/// applying to money, dates and plain numbers alike, instead of only where a
/// call site remembered to pass it.
class AppI18nScope extends InheritedWidget {
  const AppI18nScope({
    required this.formats,
    required super.child,
    super.key,
  });

  final AppFormats formats;

  /// The formats in scope. Falls back to the defaults when no scope is
  /// present, so a widget test can pump a bare widget without wiring.
  static AppFormats of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppI18nScope>();
    return scope?.formats ?? const AppFormats();
  }

  @override
  bool updateShouldNotify(AppI18nScope oldWidget) =>
      oldWidget.formats.locale != formats.locale ||
      oldWidget.formats.digitShape != formats.digitShape ||
      oldWidget.formats.showHijri != formats.showHijri;
}
