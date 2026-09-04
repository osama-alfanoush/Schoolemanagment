import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../i18n/generated/app_localizations.dart';
import '../../session/session.dart';
import '../app_route.dart';
import '../screens/router_screens.dart';

/// One tab of a role shell.
@immutable
class ShellDestination {
  const ShellDestination({
    required this.route,
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final AppRoute route;
  final IconData icon;
  final IconData selectedIcon;

  /// Resolved at build time so the label follows the active locale.
  final String Function(AppLocalizations l10n) label;
}

/// The frame every role's screens live inside.
///
/// One widget for all three roles rather than three near-copies: the tab bar,
/// the role switcher and the soft-upgrade banner then behave identically
/// everywhere, and a fix to any of them is a fix everywhere.
class RoleShell extends StatelessWidget {
  const RoleShell({
    required this.navigationShell,
    required this.destinations,
    required this.controller,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<ShellDestination> destinations;
  final SessionController controller;

  @override
  Widget build(BuildContext context) {
    // Rebuilt from the controller directly, not from the router: switching
    // roles and dismissing the upgrade banner both change the shell's chrome
    // without changing the route, and a router refresh alone leaves the old
    // chrome on screen.
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) => _buildShell(context),
    );
  }

  Widget _buildShell(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final session = controller.state.session;

    return Scaffold(
      body: Column(
        children: <Widget>[
          if (controller.state.shouldSuggestUpgrade)
            _SoftUpgradeBanner(
              onDismiss: controller.dismissRecommendedUpgrade,
            ),
          Expanded(child: navigationShell),
        ],
      ),
      floatingActionButton: session != null && session.canSwitchRole
          ? FloatingActionButton(
              key: const Key('role-switch-button'),
              tooltip: l10n.switchRoleTitle,
              onPressed: () => context.goNamed(AppRoute.roleSwitch.routeName),
              child: Icon(RoleSwitcherScreen.iconFor(
                session.activeRole ?? session.roles.first,
              )),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        // Labels always visible: an icon-only bar in Arabic is a guessing game.
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) => navigationShell.goBranch(
          index,
          // Tapping the tab you are already on returns it to its root, which is
          // what every user expects and what gets someone out of a dead end.
          initialLocation: index == navigationShell.currentIndex,
        ),
        destinations: <NavigationDestination>[
          for (final destination in destinations)
            NavigationDestination(
              key: Key('tab-${destination.route.routeName}'),
              icon: Icon(destination.icon),
              selectedIcon: Icon(destination.selectedIcon),
              label: destination.label(l10n),
            ),
        ],
      ),
    );
  }
}

/// Non-blocking notice that a newer build exists.
class _SoftUpgradeBanner extends StatelessWidget {
  const _SoftUpgradeBanner({required this.onDismiss});

  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Material(
      key: const Key('soft-upgrade-banner'),
      color: theme.colorScheme.secondaryContainer,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 8, 8),
          child: Row(
            children: <Widget>[
              Icon(Icons.info_outline, color: theme.colorScheme.onSecondaryContainer),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.upgradeRecommendedBody,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
              TextButton(
                key: const Key('soft-upgrade-dismiss'),
                onPressed: onDismiss,
                child: Text(l10n.later),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The tab bars, one list per role.
///
/// Kept beside the shell rather than in the route table so that the order of
/// the tabs and the order of the shell branches cannot drift apart.
abstract final class ShellDestinations {
  static const List<ShellDestination> parent = <ShellDestination>[
    ShellDestination(
      route: AppRoute.parentHome,
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: _navHome,
    ),
    ShellDestination(
      route: AppRoute.parentFinance,
      icon: Icons.receipt_long_outlined,
      selectedIcon: Icons.receipt_long,
      label: _navFees,
    ),
    ShellDestination(
      route: AppRoute.parentAcademics,
      icon: Icons.menu_book_outlined,
      selectedIcon: Icons.menu_book,
      label: _navAcademics,
    ),
    ShellDestination(
      route: AppRoute.parentMessages,
      icon: Icons.forum_outlined,
      selectedIcon: Icons.forum,
      label: _navMessages,
    ),
    ShellDestination(
      route: AppRoute.parentProfile,
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      label: _navProfile,
    ),
  ];

  static const List<ShellDestination> teacher = <ShellDestination>[
    ShellDestination(
      route: AppRoute.teacherToday,
      icon: Icons.today_outlined,
      selectedIcon: Icons.today,
      label: _navToday,
    ),
    ShellDestination(
      route: AppRoute.teacherClasses,
      icon: Icons.groups_outlined,
      selectedIcon: Icons.groups,
      label: _navClasses,
    ),
    ShellDestination(
      route: AppRoute.teacherMessages,
      icon: Icons.forum_outlined,
      selectedIcon: Icons.forum,
      label: _navMessages,
    ),
    ShellDestination(
      route: AppRoute.teacherProfile,
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      label: _navProfile,
    ),
  ];

  static const List<ShellDestination> student = <ShellDestination>[
    ShellDestination(
      route: AppRoute.studentHome,
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: _navHome,
    ),
    ShellDestination(
      route: AppRoute.studentTimetable,
      icon: Icons.calendar_month_outlined,
      selectedIcon: Icons.calendar_month,
      label: _navTimetable,
    ),
    ShellDestination(
      route: AppRoute.studentAssignments,
      icon: Icons.assignment_outlined,
      selectedIcon: Icons.assignment,
      label: _navAssignments,
    ),
    ShellDestination(
      route: AppRoute.studentGrades,
      icon: Icons.grade_outlined,
      selectedIcon: Icons.grade,
      label: _navGrades,
    ),
    ShellDestination(
      route: AppRoute.studentProfile,
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      label: _navProfile,
    ),
  ];

  static List<ShellDestination> forRole(AppRole role) => switch (role) {
        AppRole.parent => parent,
        AppRole.teacher => teacher,
        AppRole.student => student,
      };
}

// Top-level functions rather than closures so the destination lists stay const.
String _navHome(AppLocalizations l10n) => l10n.navHome;
String _navFees(AppLocalizations l10n) => l10n.navFees;
String _navAcademics(AppLocalizations l10n) => l10n.navAcademics;
String _navMessages(AppLocalizations l10n) => l10n.navMessages;
String _navProfile(AppLocalizations l10n) => l10n.navProfile;
String _navToday(AppLocalizations l10n) => l10n.navToday;
String _navClasses(AppLocalizations l10n) => l10n.navClasses;
String _navTimetable(AppLocalizations l10n) => l10n.navTimetable;
String _navAssignments(AppLocalizations l10n) => l10n.navAssignments;
String _navGrades(AppLocalizations l10n) => l10n.navGrades;
