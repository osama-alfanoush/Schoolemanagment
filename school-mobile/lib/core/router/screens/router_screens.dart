import 'package:flutter/material.dart';

import '../../i18n/generated/app_localizations.dart';
import '../../session/session.dart';
import '../app_route.dart';
import 'message_screen.dart';

/// Blocks the app when the server will not serve this build.
///
/// Terminal by design: there is no back gesture out of it and no navigation
/// bar, because a build the server refuses cannot be allowed to reach a screen
/// that talks to the server.
class UpgradeScreen extends StatelessWidget {
  const UpgradeScreen({this.onCheckAgain, super.key});

  final VoidCallback? onCheckAgain;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return PopScope(
      canPop: false,
      child: MessageScreen(
        key: const Key('upgrade-screen'),
        icon: Icons.system_update,
        title: l10n.upgradeRequiredTitle,
        body: l10n.upgradeRequiredBody,
        actionLabel: onCheckAgain == null ? null : l10n.upgradeCheckAgain,
        onAction: onCheckAgain,
        showAppBar: false,
      ),
    );
  }
}

/// Shown for a link the app does not recognise.
///
/// A push payload can name a screen this build does not have — an older
/// install, a campaign sent to the wrong audience, a typo in a template. The
/// only requirement is that it does not crash and offers a way out.
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({this.onGoHome, super.key});

  final VoidCallback? onGoHome;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return MessageScreen(
      key: const Key('not-found-screen'),
      icon: Icons.link_off,
      title: l10n.notFoundTitle,
      body: l10n.notFoundBody,
      actionLabel: onGoHome == null ? null : l10n.goHome,
      onAction: onGoHome,
    );
  }
}

/// Signed in, but holding no role that has a phone app.
class NoMobileRoleScreen extends StatelessWidget {
  const NoMobileRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return MessageScreen(
      key: const Key('no-mobile-role-screen'),
      icon: Icons.desktop_windows_outlined,
      title: l10n.noMobileRoleTitle,
      body: l10n.noMobileRoleBody,
    );
  }
}

/// Stands in wherever a feature order has not supplied a screen yet.
///
/// It names the route it is standing in for. A blank page would let a missing
/// wiring look like a working empty state, which is exactly the confusion that
/// costs an afternoon.
class UnbuiltScreen extends StatelessWidget {
  const UnbuiltScreen(this.route, {super.key});

  final AppRoute route;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return MessageScreen(
      key: Key('unbuilt-${route.routeName}'),
      icon: Icons.construction_outlined,
      title: l10n.screenNotBuiltTitle,
      body: '${l10n.screenNotBuiltBody}\n${route.routeName}',
    );
  }
}

/// Lets a user who holds several roles choose which one to view.
///
/// Switching is a view change. It never signs the user out and never touches
/// the token, so a teacher whose child attends the school moves between the
/// two sides of their life without typing a password.
class RoleSwitcherScreen extends StatelessWidget {
  const RoleSwitcherScreen({
    required this.session,
    required this.onSelect,
    super.key,
  });

  final AppSession session;
  final void Function(AppRole role) onSelect;

  static String labelFor(AppRole role, AppLocalizations l10n) => switch (role) {
        AppRole.parent => l10n.roleParent,
        AppRole.teacher => l10n.roleTeacher,
        AppRole.student => l10n.roleStudent,
      };

  static IconData iconFor(AppRole role) => switch (role) {
        AppRole.parent => Icons.family_restroom,
        AppRole.teacher => Icons.school_outlined,
        AppRole.student => Icons.backpack_outlined,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.switchRoleTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 8),
          children: <Widget>[
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(24, 8, 24, 16),
              child: Text(
                l10n.switchRoleBody,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            for (final role in session.roles)
              ListTile(
                key: Key('switch-to-${role.wireName}'),
                // 48dp minimum, held even when the label wraps at 200% scale.
                minTileHeight: 48,
                leading: Icon(iconFor(role)),
                title: Text(labelFor(role, l10n)),
                trailing: role == session.activeRole
                    ? const Icon(Icons.check)
                    : null,
                onTap: () => onSelect(role),
              ),
          ],
        ),
      ),
    );
  }
}
