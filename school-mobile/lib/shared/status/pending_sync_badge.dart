import 'package:flutter/material.dart';

import '../../core/i18n/generated/app_localizations.dart';
import '../../core/i18n/i18n_scope.dart';
import '../../core/sync/sync_status.dart';
import '../layout/dimens.dart';

/// How much work the device still owes the server.
///
/// Reads [SyncStatus] straight from the outbox rather than a screen-local
/// guess. That is the whole point: a teacher must be able to tell "saved on my
/// phone" from "saved at the school", and the only honest source for that is
/// the queue itself.
///
/// Rows the engine gave up on are shown separately and never folded into the
/// pending count — a dead row is not work in progress, and rolling the two
/// together is how a rejected attendance submission disappears quietly.
class PendingSyncBadge extends StatelessWidget {
  const PendingSyncBadge({
    required this.status,
    this.onTap,
    super.key,
  });

  final SyncStatus status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final formats = AppI18nScope.of(context);
    final theme = Theme.of(context);

    final hasPending = status.pendingCount > 0;
    final hasDead = status.deadCount > 0;

    if (!hasPending && !hasDead) return const SizedBox.shrink();

    final chips = <Widget>[
      if (hasPending)
        _SyncChip(
          key: const Key('pending-sync-chip'),
          icon: status.state == SyncState.draining
              ? Icons.sync
              : Icons.cloud_upload_outlined,
          label: formats.integer(status.pendingCount),
          semanticLabel: l10n.pendingSyncCount(status.pendingCount),
          tooltip: l10n.pendingSyncTooltip,
          background: theme.colorScheme.secondaryContainer,
          foreground: theme.colorScheme.onSecondaryContainer,
          onTap: onTap,
        ),
      if (hasDead)
        _SyncChip(
          key: const Key('failed-sync-chip'),
          icon: Icons.report_gmailerrorred_outlined,
          label: formats.integer(status.deadCount),
          semanticLabel: l10n.failedSyncCount(status.deadCount),
          tooltip: l10n.failedSyncTooltip,
          background: theme.colorScheme.errorContainer,
          foreground: theme.colorScheme.onErrorContainer,
          onTap: onTap,
        ),
    ];

    return Wrap(
      key: const Key('pending-sync-badge'),
      spacing: Dimens.gapSmall,
      runSpacing: 4,
      children: chips,
    );
  }
}

class _SyncChip extends StatelessWidget {
  const _SyncChip({
    required this.icon,
    required this.label,
    required this.semanticLabel,
    required this.tooltip,
    required this.background,
    required this.foreground,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final String semanticLabel;
  final String tooltip;
  final Color background;
  final Color foreground;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Tooltip(
      message: tooltip,
      child: Semantics(
        label: semanticLabel,
        button: onTap != null,
        excludeSemantics: true,
        child: Material(
          color: background,
          borderRadius: BorderRadius.circular(Dimens.minTapTarget / 2),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(Dimens.minTapTarget / 2),
            child: ConstrainedBox(
              // A badge that can be tapped has to be tappable: 48dp even
              // though the glyph and two digits inside are much smaller.
              constraints: const BoxConstraints(
                minHeight: Dimens.minTapTarget,
                minWidth: Dimens.minTapTarget,
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: Dimens.gap,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(icon, size: 18, color: foreground),
                    const SizedBox(width: 6),
                    Text(
                      label,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: foreground,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
