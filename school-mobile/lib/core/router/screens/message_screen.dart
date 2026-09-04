import 'package:flutter/material.dart';

/// A centred title, explanation and optional action.
///
/// Every terminal screen the router owns — upgrade, not-found, no-role, and the
/// placeholder that stands in for a feature not built yet — is this widget with
/// different words, so they behave identically under RTL and at 200% text
/// scale instead of each getting it wrong in its own way.
class MessageScreen extends StatelessWidget {
  const MessageScreen({
    required this.title,
    required this.body,
    this.icon,
    this.actionLabel,
    this.onAction,
    this.showAppBar = true,
    super.key,
  });

  final String title;
  final String body;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final label = actionLabel;

    return Scaffold(
      appBar: showAppBar ? AppBar(title: Text(title)) : null,
      body: SafeArea(
        child: Center(
          // Scrollable so nothing is cut off once the system text scale grows;
          // a blocking screen that cannot be read is a support call.
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (icon != null) ...<Widget>[
                  Icon(icon, size: 48, color: theme.colorScheme.primary),
                  const SizedBox(height: 16),
                ],
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 12),
                Text(
                  body,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium,
                ),
                if (label != null) ...<Widget>[
                  const SizedBox(height: 24),
                  ConstrainedBox(
                    // 48dp is the minimum tap target; a shorter button is a
                    // miss on a phone held one-handed.
                    constraints: const BoxConstraints(minHeight: 48),
                    child: FilledButton(
                      onPressed: onAction,
                      child: Text(label),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
