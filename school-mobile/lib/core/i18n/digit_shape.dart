/// Which numerals the user sees.
///
/// This is a presentation preference, independent of locale: an Arabic speaker
/// may well prefer Western digits, and `intl`'s `ar` data emits Western digits
/// anyway, so the choice has to be applied explicitly rather than inferred.
enum DigitShape {
  /// 0 1 2 3 — the default.
  western,

  /// ٠ ١ ٢ ٣ (U+0660–U+0669).
  arabicIndic,
}

/// First Arabic-Indic digit, U+0660.
const int _arabicIndicZero = 0x0660;
const int _westernZero = 0x30;

/// Rewrites the digits in [input] to [shape], leaving everything else — group
/// and decimal separators, currency codes, month names — untouched.
///
/// Converts in both directions, so a string that already contains Arabic-Indic
/// digits is normalised back to Western when that is what was asked for.
String shapeDigits(String input, DigitShape shape) {
  final buffer = StringBuffer();
  for (final rune in input.runes) {
    buffer.writeCharCode(_shapeRune(rune, shape));
  }
  return buffer.toString();
}

int _shapeRune(int rune, DigitShape shape) {
  final isWestern = rune >= _westernZero && rune <= _westernZero + 9;
  final isArabicIndic =
      rune >= _arabicIndicZero && rune <= _arabicIndicZero + 9;

  switch (shape) {
    case DigitShape.western:
      return isArabicIndic ? rune - _arabicIndicZero + _westernZero : rune;
    case DigitShape.arabicIndic:
      return isWestern ? rune - _westernZero + _arabicIndicZero : rune;
  }
}
