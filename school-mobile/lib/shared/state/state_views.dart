import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/api/api_error.dart';
import '../../core/i18n/generated/app_localizations.dart';
import '../layout/dimens.dart';

/// Shared frame for the three states a screen can be in instead of showing
/// content. Centred, width-capped, and always scrollable — a state screen that
/// cannot be read at 200% text scale is worse than no state screen.
class StatePanel extends StatelessWidget {
  const StatePanel({
    required this.child,
    this.padding = const EdgeInsetsDirectional.all(Dimens.gapLarge),
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          // Always draggable and always at least a viewport tall, so the
          // pull-to-refresh gesture still works over a one-line empty state.
          // A retry you can only reach on a long list is not a retry.
          physics: const AlwaysScrollableScrollPhysics(),
          padding: padding,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight.isFinite
                  ? constraints.maxHeight - padding.vertical
                  : 0,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: Dimens.contentMaxWidth),
                child: child,
              ),
            ),
          ),
        ),
      );
}

/// Work in progress.
///
/// Announced to the screen reader as well as drawn, so a blind parent is told
/// the app is busy rather than left on a silent screen.
class LoadingView extends StatelessWidget {
  const LoadingView({this.message, super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final label = message ?? l10n.loading;

    return Semantics(
      liveRegion: true,
      label: label,
      child: StatePanel(
        key: const Key('loading-view'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const CircularProgressIndicator(),
            const SizedBox(height: Dimens.gap),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

/// Nothing to show — and that is the truth, not a failure.
class EmptyView extends StatelessWidget {
  const EmptyView({
    this.title,
    this.body,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String? title;
  final String? body;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final label = actionLabel;

    return StatePanel(
      key: const Key('empty-view'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(icon, size: 48, color: theme.colorScheme.outline),
          const SizedBox(height: Dimens.gap),
          Text(
            title ?? l10n.emptyTitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: Dimens.gapSmall),
          Text(
            body ?? l10n.emptyBody,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
          if (label != null && onAction != null) ...<Widget>[
            const SizedBox(height: Dimens.gapLarge),
            _TapTarget(child: FilledButton(onPressed: onAction, child: Text(label))),
          ],
        ],
      ),
    );
  }
}

/// A failed load, with the server's correlation id on screen.
///
/// The request id is the point of this widget. A parent who phones the school
/// office can read it out, and support can find the exact request instead of
/// guessing from "it didn't work this morning". It is copyable for the same
/// reason — reading a hex string down a phone line is how digits get lost.
///
/// Nothing else from the failure is rendered: [ApiError.message] is the
/// server's own message or a fixed string, and never a body, header or token.
class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.error,
    this.onRetry,
    super.key,
  });

  final ApiError error;
  final VoidCallback? onRetry;

  bool get _isOffline => error is OfflineError;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final requestId = error.requestId;

    return StatePanel(
      key: const Key('error-view'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(
            _isOffline ? Icons.wifi_off : Icons.error_outline,
            size: 48,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: Dimens.gap),
          Text(
            _isOffline ? l10n.errorOfflineTitle : l10n.errorTitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: Dimens.gapSmall),
          Text(
            _isOffline ? l10n.errorOfflineBody : error.message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
          if (requestId != null) ...<Widget>[
            const SizedBox(height: Dimens.gapLarge),
            RequestIdCard(requestId: requestId),
          ],
          if (onRetry != null) ...<Widget>[
            const SizedBox(height: Dimens.gapLarge),
            _TapTarget(
              child: FilledButton(
                key: const Key('error-retry'),
                onPressed: onRetry,
                child: Text(l10n.retry),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// The correlation id, labelled and copyable.
class RequestIdCard extends StatelessWidget {
  const RequestIdCard({required this.requestId, super.key});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Card(
      key: const Key('request-id-card'),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          Dimens.gutter,
          Dimens.gap,
          Dimens.gapSmall,
          Dimens.gap,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(l10n.requestIdLabel, style: theme.textTheme.labelMedium),
            const SizedBox(height: 4),
            Row(
              children: <Widget>[
                Expanded(
                  child: SelectableText(
                    requestId,
                    // Latin, always: an id is not a sentence and must not be
                    // mirrored or digit-shaped, or it stops matching the logs.
                    textDirection: TextDirection.ltr,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
                    ),
                  ),
                ),
                IconButton(
                  key: const Key('copy-request-id'),
                  tooltip: l10n.requestIdLabel,
                  onPressed: () => Clipboard.setData(ClipboardData(text: requestId)),
                  icon: const Icon(Icons.copy_outlined),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(l10n.requestIdHint, style: theme.textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

/// Holds a control to the minimum tap target, whatever its natural height.
class _TapTarget extends StatelessWidget {
  const _TapTarget({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(minHeight: Dimens.minTapTarget),
        child: child,
      );
}
