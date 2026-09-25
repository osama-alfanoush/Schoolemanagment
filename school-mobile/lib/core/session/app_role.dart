/// A role that has its own mobile experience.
///
/// The server knows more roles than these — admin, finance, hr, warehouse,
/// procurement — but none of them has a phone app. They are filtered out on
/// the way in rather than modelled here, so nothing downstream has to decide
/// what a finance shell would look like.
///
/// Roles are **not exclusive**. A teacher whose own child attends the school
/// is ordinary, and treating the first role as the only one is what makes such
/// a user re-install the app to see their child's fees.
enum AppRole {
  parent('parent'),
  teacher('teacher'),
  student('student');

  const AppRole(this.wireName);

  /// The value the API uses for this role.
  final String wireName;

  static AppRole? fromWire(Object? name) {
    if (name is! String) return null;
    final normalized = name.trim().toLowerCase();

    for (final role in AppRole.values) {
      if (role.wireName == normalized) return role;
    }
    return null;
  }

  /// Every mobile role in [names], deduplicated and in declaration order.
  ///
  /// Declaration order is the presentation order everywhere — the role
  /// switcher, the default role — so the app cannot reorder itself because the
  /// server returned the same roles in a different sequence.
  static List<AppRole> allFromWire(Iterable<Object?>? names) {
    if (names == null) return const <AppRole>[];

    final found = <AppRole>{};
    for (final name in names) {
      final role = AppRole.fromWire(name);
      if (role != null) found.add(role);
    }

    return AppRole.values.where(found.contains).toList(growable: false);
  }
}
