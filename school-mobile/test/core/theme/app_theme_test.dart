import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/core/theme/theme.dart';

void main() {
  group('tokens', () {
    test('a full payload is applied', () {
      final tokens = ThemeTokens.fromJson(const <String, Object?>{
        'accentColor': '#B71C1C',
        'fontFamily': 'Cairo',
        'borderRadius': 20,
      });

      expect(tokens.accentColor, const Color(0xFFB71C1C));
      expect(tokens.fontFamily, 'Cairo');
      expect(tokens.borderRadius, 20.0);
    });

    test('missing tokens fall back to defaults without throwing', () {
      final empty = ThemeTokens.fromJson(const <String, Object?>{});

      expect(empty, ThemeTokens.fallback);
      expect(empty.accentColor, ThemeTokens.defaultAccent);
      expect(empty.fontFamily, ThemeTokens.defaultFontFamily);
      expect(empty.borderRadius, ThemeTokens.defaultBorderRadius);
    });

    test('malformed tokens fall back rather than throwing', () {
      final rubbish = ThemeTokens.fromJson(const <String, Object?>{
        'accentColor': 'not-a-colour',
        'fontFamily': '   ',
        'borderRadius': -5,
      });

      expect(rubbish, ThemeTokens.fallback);
      // Branding degrades quietly; money never does.
      expect(() => ThemeTokens.fromJson('nonsense'), returnsNormally);
      expect(() => ThemeTokens.fromJson(null), returnsNormally);
      expect(ThemeTokens.fromJson(null), ThemeTokens.fallback);
    });

    test('accepts an ARGB integer and a six-digit hex', () {
      expect(
        ThemeTokens.fromJson(const <String, Object?>{'accentColor': 0xFF00695C})
            .accentColor,
        const Color(0xFF00695C),
      );
      expect(
        ThemeTokens.fromJson(const <String, Object?>{'accentColor': '00695C'})
            .accentColor,
        const Color(0xFF00695C),
      );
    });
  });

  group('themes', () {
    test('the accent seeds the colour scheme and the radius reaches shapes', () {
      const tokens = ThemeTokens(
        accentColor: Color(0xFFB71C1C),
        fontFamily: 'Cairo',
        borderRadius: 20,
      );

      final theme = AppTheme.fromTokens(tokens, brightness: Brightness.light);

      expect(theme.useMaterial3, isTrue);
      expect(theme.textTheme.bodyLarge!.fontFamily, 'Cairo');
      expect(
        theme.colorScheme,
        ColorScheme.fromSeed(seedColor: const Color(0xFFB71C1C)),
      );

      final cardShape = theme.cardTheme.shape! as RoundedRectangleBorder;
      expect(cardShape.borderRadius, BorderRadius.circular(20));
    });

    test('light and dark differ in brightness but share the branding', () {
      const tokens = ThemeTokens(accentColor: Color(0xFFB71C1C));

      final light = AppTheme.light(tokens);
      final dark = AppTheme.dark(tokens);

      expect(light.colorScheme.brightness, Brightness.light);
      expect(dark.colorScheme.brightness, Brightness.dark);
      expect(light.textTheme.bodyLarge!.fontFamily, 'Tajawal');
      expect(dark.textTheme.bodyLarge!.fontFamily, 'Tajawal');
    });

    test('the defaults build a usable theme with Tajawal', () {
      final theme = AppTheme.light();

      expect(theme.textTheme.bodyLarge!.fontFamily, 'Tajawal');
      expect(theme.useMaterial3, isTrue);
    });
  });
}
