import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../session/session.dart';
import 'app_route.dart';
import 'app_screens.dart';
import 'screens/router_screens.dart';
import 'shells/role_shell.dart';

/// Builds the app's router.
///
/// Three things happen in [GoRouter.redirect] and nowhere else, so there is one
/// place to read when the app sends someone somewhere unexpected:
///
///  1. A build the server refuses is pinned to the upgrade screen.
///  2. Nobody reaches a role shell without a session, and nobody reaches a
///     shell for a role they do not hold — a deep link into another role's
///     screens lands on the user's own home instead of a blank page or a crash.
///  3. A signed-in user on a temporary password reaches nothing but the
///     change-password screen, matching what the server already enforces.
///  4. A link opened before the token store has been read is remembered, not
///     discarded, so a push tapped on a cold start still arrives.
GoRouter buildAppRouter({
  required SessionController controller,
  AppScreens screens = const AppScreens(),
  String initialLocation = '/',
  GlobalKey<NavigatorState>? navigatorKey,
  VoidCallback? onUpgradeCheckAgain,
}) {
  // Where the user was heading before we knew whether they were signed in.
  // Held here rather than on the controller: it is a routing detail, and the
  // session has no business remembering URLs.
  String? pendingLocation;

  String homeLocation() {
    final session = controller.state.session;
    final role = session?.activeRole;

    if (session == null) return AppRoute.signIn.path;
    if (role == null) return AppRoute.noMobileRole.path;

    return AppRoute.homeFor(role).path;
  }

  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: initialLocation,
    refreshListenable: controller,
    redirect: (context, state) {
      final session = controller.state;
      final target = state.uri.toString();
      final path = state.uri.path;

      // 1. The version gate outranks everything, including the session: a
      //    build the server will not serve must not reach a screen that calls
      //    it. The gate lifts by itself if the policy changes under us.
      if (session.mustUpgrade) {
        return path == AppRoute.upgrade.path ? null : AppRoute.upgrade.path;
      }
      if (path == AppRoute.upgrade.path) {
        return homeLocation();
      }

      // 2. Still reading the token store. Hold at the splash and keep the
      //    destination; bouncing to the login screen here is what makes an
      //    already-signed-in user see a login flash on every cold start.
      if (session.status == SessionStatus.unknown) {
        if (path == AppRoute.root.path) return null;
        pendingLocation = target;

        return AppRoute.root.path;
      }

      if (!session.isSignedIn) {
        if (path == AppRoute.signIn.path) return null;
        if (path != AppRoute.root.path) pendingLocation = target;

        return AppRoute.signIn.path;
      }

      final user = session.session!;

      // 3. Signed in, but no role with a phone app.
      if (!user.hasMobileAccess) {
        return path == AppRoute.noMobileRole.path
            ? null
            : AppRoute.noMobileRole.path;
      }
      if (path == AppRoute.noMobileRole.path) {
        return homeLocation();
      }

      // 4. A temporary password blocks everything, exactly as it does on the
      //    web: the server refuses every route but /auth/me, /auth/logout and
      //    /auth/change-password, so letting the user into a shell would only
      //    show them a screen of 403s.
      if (session.mustChangePassword) {
        return path == AppRoute.changePassword.path
            ? null
            : AppRoute.changePassword.path;
      }
      if (path == AppRoute.changePassword.path) {
        return homeLocation();
      }

      // 5. Landing paths resolve to the remembered destination, then home.
      if (path == AppRoute.root.path || path == AppRoute.signIn.path) {
        final saved = pendingLocation;
        pendingLocation = null;

        if (saved != null &&
            Uri.parse(saved).path != AppRoute.root.path &&
            Uri.parse(saved).path != AppRoute.signIn.path) {
          return saved;
        }

        return homeLocation();
      }

      // 6. A shell this user does not hold. Not an error to shout about — a
      //    stale push or an old link — so land them on their own home.
      final routeRole = _roleForPath(path);
      if (routeRole != null && !user.holds(routeRole)) {
        return homeLocation();
      }

      return null;
    },
    errorBuilder: (context, state) => NotFoundScreen(
      onGoHome: () => context.go(homeLocation()),
    ),
    routes: <RouteBase>[
      GoRoute(
        path: AppRoute.root.path,
        name: AppRoute.root.routeName,
        builder: (context, state) => const _SplashScreen(),
      ),
      GoRoute(
        path: AppRoute.signIn.path,
        name: AppRoute.signIn.routeName,
        builder: (context, state) =>
            screens.build(AppRoute.signIn, context, state),
      ),
      GoRoute(
        path: AppRoute.upgrade.path,
        name: AppRoute.upgrade.routeName,
        builder: (context, state) =>
            UpgradeScreen(onCheckAgain: onUpgradeCheckAgain),
      ),
      GoRoute(
        path: AppRoute.noMobileRole.path,
        name: AppRoute.noMobileRole.routeName,
        builder: (context, state) => const NoMobileRoleScreen(),
      ),
      GoRoute(
        path: AppRoute.changePassword.path,
        name: AppRoute.changePassword.routeName,
        builder: (context, state) =>
            screens.build(AppRoute.changePassword, context, state),
      ),
      GoRoute(
        path: AppRoute.devices.path,
        name: AppRoute.devices.routeName,
        builder: (context, state) =>
            screens.build(AppRoute.devices, context, state),
      ),
      GoRoute(
        path: AppRoute.diagnostics.path,
        name: AppRoute.diagnostics.routeName,
        builder: (context, state) =>
            screens.build(AppRoute.diagnostics, context, state),
      ),
      GoRoute(
        path: AppRoute.roleSwitch.path,
        name: AppRoute.roleSwitch.routeName,
        builder: (context, state) {
          final session = controller.state.session;
          if (session == null) return const _SplashScreen();

          return RoleSwitcherScreen(
            session: session,
            onSelect: (role) {
              controller.switchRole(role);
              context.go(AppRoute.homeFor(role).path);
            },
          );
        },
      ),
      _roleShell(
        role: AppRole.parent,
        controller: controller,
        branches: <List<AppRoute>>[
          <AppRoute>[AppRoute.parentHome, AppRoute.parentChild],
          <AppRoute>[AppRoute.parentFinance, AppRoute.parentInvoice],
          <AppRoute>[AppRoute.parentAcademics],
          <AppRoute>[AppRoute.parentMessages],
          <AppRoute>[AppRoute.parentProfile],
        ],
        screens: screens,
      ),
      _roleShell(
        role: AppRole.teacher,
        controller: controller,
        branches: <List<AppRoute>>[
          <AppRoute>[AppRoute.teacherToday],
          <AppRoute>[
            AppRoute.teacherClasses,
            AppRoute.teacherClassRoster,
            AppRoute.teacherAttendance,
            AppRoute.teacherGrades,
            AppRoute.teacherAssignments,
            AppRoute.teacherHandIns,
          ],
          <AppRoute>[AppRoute.teacherMessages, AppRoute.teacherAnnounce],
          <AppRoute>[AppRoute.teacherProfile],
        ],
        screens: screens,
      ),
      _roleShell(
        role: AppRole.student,
        controller: controller,
        branches: <List<AppRoute>>[
          <AppRoute>[AppRoute.studentHome],
          <AppRoute>[AppRoute.studentTimetable],
          <AppRoute>[AppRoute.studentAssignments],
          <AppRoute>[AppRoute.studentGrades],
          <AppRoute>[AppRoute.studentProfile],
        ],
        screens: screens,
      ),
    ],
  );
}

/// One role's shell: an indexed stack of branches, each keeping its own
/// navigation state so a half-marked roster survives a trip to another tab.
StatefulShellRoute _roleShell({
  required AppRole role,
  required SessionController controller,
  required List<List<AppRoute>> branches,
  required AppScreens screens,
}) {
  assert(
    branches.length == ShellDestinations.forRole(role).length,
    'Branch count must match the tab count for ${role.wireName}.',
  );

  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) => RoleShell(
      navigationShell: navigationShell,
      destinations: ShellDestinations.forRole(role),
      controller: controller,
    ),
    branches: <StatefulShellBranch>[
      for (final branch in branches)
        StatefulShellBranch(
          routes: <RouteBase>[
            GoRoute(
              path: branch.first.path,
              name: branch.first.routeName,
              builder: (context, state) =>
                  screens.build(branch.first, context, state),
              routes: <RouteBase>[
                for (final child in branch.skip(1))
                  GoRoute(
                    path: child.relativeTo(branch.first),
                    name: child.routeName,
                    builder: (context, state) =>
                        screens.build(child, context, state),
                  ),
              ],
            ),
          ],
        ),
    ],
  );
}

/// Which role's shell a path belongs to, or null for a route outside them all.
AppRole? _roleForPath(String path) {
  for (final role in AppRole.values) {
    final home = AppRoute.homeFor(role).path;
    if (path == home || path.startsWith('$home/')) return role;
  }

  return null;
}

/// Shown for the moment between launch and knowing who is signed in.
class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) => const Scaffold(
        key: Key('splash-screen'),
        body: Center(child: CircularProgressIndicator()),
      );
}
