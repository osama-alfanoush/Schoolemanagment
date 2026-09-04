/// Layout constants the whole app measures against.
///
/// Written down once so "48dp minimum tap target" is a value a widget reads
/// rather than a rule each screen has to remember.
abstract final class Dimens {
  /// Minimum touch target. Material and the Android accessibility guidance
  /// both put it here, and a school app is used one-handed on a bus.
  static const double minTapTarget = 48;

  static const double gutter = 16;
  static const double gapSmall = 8;
  static const double gap = 12;
  static const double gapLarge = 24;

  /// Where a state screen (loading, empty, error) stops growing on a tablet.
  static const double contentMaxWidth = 560;
}
