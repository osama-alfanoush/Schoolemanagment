import 'package:flutter/material.dart';

import 'theme_tokens.dart';

/// Builds the app's Material 3 themes from [ThemeTokens].
class AppTheme {
  const AppTheme._();

  static ThemeData light([ThemeTokens tokens = ThemeTokens.fallback]) =>
      fromTokens(tokens, brightness: Brightness.light);

  static ThemeData dark([ThemeTokens tokens = ThemeTokens.fallback]) =>
      fromTokens(tokens, brightness: Brightness.dark);

  /// One theme from one set of tokens.
  ///
  /// The accent seeds the whole Material 3 colour scheme, and the radius is
  /// applied to every rounded component so a school's branding is consistent
  /// rather than showing up on a couple of buttons.
  static ThemeData fromTokens(
    ThemeTokens tokens, {
    required Brightness brightness,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: tokens.accentColor,
      brightness: brightness,
    );
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(tokens.borderRadius),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: tokens.fontFamily,
      cardTheme: CardThemeData(shape: shape),
      dialogTheme: DialogThemeData(shape: shape),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(shape: shape),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(shape: shape),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(shape: shape),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.borderRadius),
        ),
      ),
    );
  }
}
