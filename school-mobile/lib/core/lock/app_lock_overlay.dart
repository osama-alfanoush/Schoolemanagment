import 'package:flutter/material.dart';

import '../i18n/generated/app_localizations.dart';
import 'app_lock_controller.dart';
import 'biometric_gate.dart';

/// Covers the app while the lock is engaged.
///
/// Sits above the router rather than on a route of its own, so there is no
/// navigation state that could be manipulated to get behind it: while locked,
/// the app's screens are not in the tree at all.
///
/// The only two ways off this screen are a successful OS prompt and signing
/// out. There is deliberately no "continue" — a lock with a skip button is
/// decoration.
class AppLockOverlay extends StatefulWidget {
  const AppLockOverlay({
    required this.controller,
    required this.onSignOut,
    required this.child,
    super.key,
  });

  final AppLockController controller;

  /// Ends the session. The only alternative to unlocking.
  final VoidCallback onSignOut;

  final Widget child;

  @override
  State<AppLockOverlay> createState() => _AppLockOverlayState();
}

class _AppLockOverlayState extends State<AppLockOverlay> {
  UnlockOutcome? _lastOutcome;
  bool _prompting = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onLockChanged);

    // Already locked when this mounted — the app was relaunched behind the
    // lock, or the overlay was rebuilt. Waiting for a change notification that
    // has already happened would leave the prompt unshown.
    if (widget.controller.isLocked) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _prompt());
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onLockChanged);
    super.dispose();
  }

  void _onLockChanged() {
    if (!widget.controller.isLocked) {
      _lastOutcome = null;
      return;
    }

    // Prompt as soon as the lock engages, so returning to the app puts the
    // fingerprint sheet up rather than a screen with a button to press.
    WidgetsBinding.instance.addPostFrameCallback((_) => _prompt());
  }

  Future<void> _prompt() async {
    if (_prompting || !mounted || !widget.controller.isLocked) return;

    setState(() => _prompting = true);
    final l10n = AppLocalizations.of(context);

    final outcome = await widget.controller.unlock(reason: l10n.appLockReason);

    if (!mounted) return;
    setState(() {
      _prompting = false;
      _lastOutcome = outcome;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        if (!widget.controller.isLocked) return widget.child;

        return _LockScreen(
          outcome: _lastOutcome,
          busy: _prompting,
          onUnlock: _prompt,
          onSignOut: widget.onSignOut,
        );
      },
    );
  }
}

class _LockScreen extends StatelessWidget {
  const _LockScreen({
    required this.outcome,
    required this.busy,
    required this.onUnlock,
    required this.onSignOut,
  });

  final UnlockOutcome? outcome;
  final bool busy;
  final VoidCallback onUnlock;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final message = switch (outcome) {
      null || UnlockOutcome.succeeded || UnlockOutcome.cancelled => null,
      UnlockOutcome.failed => l10n.appLockFailed,
      UnlockOutcome.temporarilyLockedOut => l10n.appLockLockedOut,
      UnlockOutcome.unavailable => l10n.appLockUnavailable,
    };

    return PopScope(
      canPop: false,
      child: Scaffold(
        key: const Key('app-lock-screen'),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.lock_outline,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.appLockTitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.appLockBody,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                  if (message != null) ...<Widget>[
                    const SizedBox(height: 16),
                    Semantics(
                      liveRegion: true,
                      child: Text(
                        key: const Key('app-lock-message'),
                        message,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: theme.colorScheme.error),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48),
                    child: FilledButton.icon(
                      key: const Key('app-lock-unlock'),
                      onPressed: busy ? null : onUnlock,
                      icon: const Icon(Icons.fingerprint),
                      label: Text(l10n.appLockUnlockAction),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48),
                    child: TextButton(
                      key: const Key('app-lock-sign-out'),
                      onPressed: onSignOut,
                      child: Text(l10n.signOut),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
