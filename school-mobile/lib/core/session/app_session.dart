import 'package:flutter/foundation.dart';

import 'app_role.dart';

/// Who is signed in, and which of their roles the app is currently showing.
///
/// Holds identity only. No token, no password, no national id — this object is
/// read by widgets and passed into router redirects, and anything on it is one
/// `toString()` away from a log line.
@immutable
class AppSession {
  AppSession({
    required this.userId,
    required this.displayName,
    required List<AppRole> roles,
    AppRole? activeRole,
  })  : roles = List<AppRole>.unmodifiable(
          AppRole.values.where(roles.toSet().contains),
        ),
        activeRole = _resolveActive(roles, activeRole);

  final String userId;

  /// First name or short name. Never the full record.
  final String displayName;

  /// Every mobile role this user holds, in canonical order.
  final List<AppRole> roles;

  /// The role whose shell is on screen. Null when the user holds no mobile
  /// role at all — an admin-only account that installed the app, say.
  final AppRole? activeRole;

  bool get hasMobileAccess => roles.isNotEmpty;

  bool get canSwitchRole => roles.length > 1;

  bool holds(AppRole role) => roles.contains(role);

  /// Move to another of this user's roles.
  ///
  /// Switching is a view change, not an identity change: it must never touch
  /// the token, so a two-role user never signs in twice.
  AppSession switchedTo(AppRole role) {
    if (!holds(role) || role == activeRole) return this;

    return AppSession(
      userId: userId,
      displayName: displayName,
      roles: roles,
      activeRole: role,
    );
  }

  static AppRole? _resolveActive(List<AppRole> roles, AppRole? requested) {
    final available = AppRole.values.where(roles.toSet().contains).toList();
    if (available.isEmpty) return null;
    if (requested != null && available.contains(requested)) return requested;

    return available.first;
  }

  @override
  bool operator ==(Object other) =>
      other is AppSession &&
      other.userId == userId &&
      other.displayName == displayName &&
      other.activeRole == activeRole &&
      listEquals(other.roles, roles);

  @override
  int get hashCode => Object.hash(userId, displayName, activeRole, Object.hashAll(roles));

  @override
  String toString() =>
      'AppSession(${activeRole?.wireName ?? 'no mobile role'}, roles: ${roles.length})';
}
