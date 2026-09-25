import 'package:flutter/material.dart';

import '../../core/i18n/generated/app_localizations.dart';
import '../layout/dimens.dart';

/// Tells the user the app is showing saved data, not live data.
///
/// Takes a plain flag rather than watching a connectivity plugin: the app layer
/// already owns that stream (`SyncTrigger.bindConnectivity`), and a widget that
/// reaches for the platform itself cannot be tested without a device.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({required this.isOffline, super.key});

  final bool isOffline;

  @override
  Widget build(BuildContext context) {
    if (!isOffline) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Semantics(
      liveRegion: true,
      child: Material(
        key: const Key('offline-banner'),
        color: theme.colorScheme.tertiaryContainer,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: Dimens.gutter,
            vertical: Dimens.gapSmall,
          ),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.cloud_off,
                size: 20,
                color: theme.colorScheme.onTertiaryContainer,
              ),
              const SizedBox(width: Dimens.gap),
              Expanded(
                child: Text(
                  l10n.offlineBanner,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onTertiaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// When the content on screen was last refreshed from the server.
///
/// Shown wherever a screen renders from cache. "Yesterday's attendance,
/// labelled as yesterday's" is honest; the same data unlabelled is a lie the
/// user only discovers at the school gate.
class StalenessLabel extends StatelessWidget {
  const StalenessLabel({required this.formattedTime, super.key});

  /// Already formatted by `AppFormats`, so the digit shape is the user's.
  final String formattedTime;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Padding(
      key: const Key('staleness-label'),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: Dimens.gutter,
        vertical: 4,
      ),
      child: Text(
        l10n.lastUpdated(formattedTime),
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.outline,
        ),
      ),
    );
  }
}
