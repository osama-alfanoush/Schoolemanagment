import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'app_route.dart';
import 'screens/router_screens.dart';

typedef RouteScreenBuilder = Widget Function(
  BuildContext context,
  GoRouterState state,
);

/// What to render at each route.
///
/// The router owns the route table; feature orders own the screens. They meet
/// here, so a later order can add the parent home screen without editing
/// anything under `lib/core/router/` — which matters because `lib/core/` is
/// frozen at the end of this phase.
///
/// A route with no builder falls back to [UnbuiltScreen], which names the route
/// it is standing in for.
@immutable
class AppScreens {
  const AppScreens([
    this._builders = const <AppRoute, RouteScreenBuilder>{},
  ]);

  final Map<AppRoute, RouteScreenBuilder> _builders;

  bool hasScreenFor(AppRoute route) => _builders.containsKey(route);

  Widget build(AppRoute route, BuildContext context, GoRouterState state) {
    final builder = _builders[route];

    return builder == null ? UnbuiltScreen(route) : builder(context, state);
  }

  /// A copy with [builder] registered for [route].
  AppScreens withScreen(AppRoute route, RouteScreenBuilder builder) =>
      AppScreens(<AppRoute, RouteScreenBuilder>{..._builders, route: builder});

  /// A copy with several screens registered at once.
  AppScreens withScreens(Map<AppRoute, RouteScreenBuilder> builders) =>
      AppScreens(<AppRoute, RouteScreenBuilder>{..._builders, ...builders});
}
