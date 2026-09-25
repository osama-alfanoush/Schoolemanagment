import 'package:flutter/material.dart';

/// Branding the server can override per school.
///
/// Deliberately **lenient** where [Money] is strict: a missing or malformed
/// token falls back to the default rather than throwing. A wrong accent colour
/// is cosmetic, whereas a wrong fee is not — so branding degrades quietly and
/// money never does.
///
/// Nothing here fetches. Wiring this to the bootstrap call is a later order.
@immutable
class ThemeTokens {
  const ThemeTokens({
    this.accentColor = defaultAccent,
    this.fontFamily = defaultFontFamily,
    this.borderRadius = defaultBorderRadius,
  });

  /// Teal that reads well against both Material 3 surfaces.
  static const Color defaultAccent = Color(0xFF00695C);
  static const String defaultFontFamily = 'Tajawal';
  static const double defaultBorderRadius = 12;

  /// The built-in branding, used before the server has said otherwise.
  static const ThemeTokens fallback = ThemeTokens();

  final Color accentColor;
  final String fontFamily;
  final double borderRadius;

  /// Reads server tokens, substituting the default for anything absent or
  /// unusable. Never throws.
  factory ThemeTokens.fromJson(Object? json) {
    if (json is! Map) return fallback;

    return ThemeTokens(
      accentColor: _parseColor(json['accentColor']) ?? defaultAccent,
      fontFamily: _parseFontFamily(json['fontFamily']) ?? defaultFontFamily,
      borderRadius: _parseRadius(json['borderRadius']) ?? defaultBorderRadius,
    );
  }

  /// Accepts `"#RRGGBB"`, `"#AARRGGBB"` or an ARGB integer.
  static Color? _parseColor(Object? raw) {
    if (raw is int) return Color(raw);
    if (raw is! String) return null;

    var hex = raw.trim();
    if (hex.startsWith('#')) hex = hex.substring(1);
    if (hex.length == 6) hex = 'FF$hex';
    if (hex.length != 8) return null;

    final value = int.tryParse(hex, radix: 16);
    return value == null ? null : Color(value);
  }

  static String? _parseFontFamily(Object? raw) {
    if (raw is! String) return null;
    final trimmed = raw.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static double? _parseRadius(Object? raw) {
    final double value;
    if (raw is int) {
      value = raw.toDouble();
    } else if (raw is double) {
      value = raw;
    } else {
      return null;
    }
    // A negative or absurd radius would break layout; treat it as absent.
    if (value.isNaN || value < 0 || value > 64) return null;
    return value;
  }

  ThemeTokens copyWith({
    Color? accentColor,
    String? fontFamily,
    double? borderRadius,
  }) =>
      ThemeTokens(
        accentColor: accentColor ?? this.accentColor,
        fontFamily: fontFamily ?? this.fontFamily,
        borderRadius: borderRadius ?? this.borderRadius,
      );

  @override
  bool operator ==(Object other) =>
      other is ThemeTokens &&
      other.accentColor == accentColor &&
      other.fontFamily == fontFamily &&
      other.borderRadius == borderRadius;

  @override
  int get hashCode => Object.hash(accentColor, fontFamily, borderRadius);

  @override
  String toString() =>
      'ThemeTokens($accentColor, $fontFamily, r$borderRadius)';
}
