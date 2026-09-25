import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/i18n/i18n.dart';

/// Proves on a real device that theming, localization, money and dates are all
/// wired up: every value below is produced by the layers those orders built.
///
/// Reachable from the security screen once a session exists. It grants nothing
/// and reads nothing from the server.
class VerificationScreen extends StatelessWidget {
  const VerificationScreen({
    required this.baseUrl,
    super.key,
    this.onToggleDigitShape,
  });

  /// The compile-time API base URL, passed in rather than read here so this
  /// screen has no opinion about where the app is configured.
  final String baseUrl;

  final VoidCallback? onToggleDigitShape;

  /// 12500 fils = 12.500 JOD. A three-decimal currency, shown with three.
  static const Money sampleAmount = Money.jod(12500);

  /// Fixed so the screen renders the same on every run.
  static final DateTime sampleDate = DateTime(2026, 9, 3);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formats = AppI18nScope.of(context);
    final locale = Localizations.localeOf(context);
    final direction = Directionality.of(context);

    final flavor = appFlavor ?? l10n.notConfigured;
    final shownBaseUrl = baseUrl.isEmpty ? l10n.notConfigured : baseUrl;
    final digitShapeName = formats.digitShape == DigitShape.western
        ? l10n.digitShapeWestern
        : l10n.digitShapeArabicIndic;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: SafeArea(
        // Scrollable so the content still fits when text is scaled to 200%.
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                l10n.appTitle,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              _VerificationValue(label: l10n.activeFlavor, value: flavor),
              _VerificationValue(label: l10n.apiBaseUrl, value: shownBaseUrl),
              _VerificationValue(
                label: l10n.currentLocale,
                value: locale.languageCode,
              ),
              _VerificationValue(
                label: l10n.textDirection,
                value: direction == TextDirection.rtl ? 'RTL' : 'LTR',
              ),
              _VerificationValue(
                key: const Key('verification-amount'),
                label: l10n.sampleAmount,
                value: formats.money(sampleAmount),
              ),
              _VerificationValue(
                key: const Key('verification-date'),
                label: l10n.sampleDate,
                value: formats.date(sampleDate),
              ),
              _VerificationValue(
                key: const Key('verification-digit-shape'),
                label: l10n.digitShape,
                value: digitShapeName,
              ),
              const SizedBox(height: 24),
              FilledButton(
                key: const Key('toggle-digit-shape'),
                onPressed: onToggleDigitShape,
                child: Text(l10n.digitShape),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A labelled value, stacked rather than laid out in a row so that neither
/// half is squeezed when the text scale grows.
class _VerificationValue extends StatelessWidget {
  const _VerificationValue({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            textAlign: TextAlign.start,
            style: theme.textTheme.labelMedium,
          ),
          Text(
            value,
            textAlign: TextAlign.start,
            style: theme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
