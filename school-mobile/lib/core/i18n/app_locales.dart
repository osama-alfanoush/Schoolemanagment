import 'package:flutter/widgets.dart';

/// The locales this app ships, in priority order.
class AppLocales {
  const AppLocales._();

  /// Arabic is the default and the fallback — it is first in [supported], so
  /// Flutter resolves to it whenever the device asks for anything else.
  static const Locale arabic = Locale('ar');
  static const Locale english = Locale('en');

  static const List<Locale> supported = <Locale>[arabic, english];

  static const Locale fallback = arabic;

  /// Picks the locale to run in.
  ///
  /// Matches on language only: `ar_JO`, `ar_EG` and bare `ar` all get Arabic.
  /// Anything unrecognised falls back to Arabic rather than English.
  static Locale resolve(Locale? device, Iterable<Locale> supportedLocales) {
    if (device == null) return fallback;
    for (final locale in supportedLocales) {
      if (locale.languageCode == device.languageCode) return locale;
    }
    return fallback;
  }

  /// True when [locale] is written right to left.
  static bool isRtl(Locale locale) => locale.languageCode == 'ar';
}
