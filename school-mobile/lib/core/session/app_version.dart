import 'package:flutter/foundation.dart';

/// A `major.minor.patch` version, compared numerically.
///
/// String comparison would put `1.10.0` before `1.9.0` and let a stale build
/// past a minimum it does not meet, so the parts are held as integers.
@immutable
class AppVersion implements Comparable<AppVersion> {
  const AppVersion(this.major, [this.minor = 0, this.patch = 0]);

  final int major;
  final int minor;
  final int patch;

  /// Parses `1.4.2`, `1.4`, `1`, and tolerates a `+build` or `-suffix` tail
  /// (`1.4.2+37`, `1.4.2-beta`) by ignoring it. Returns null for anything else.
  static AppVersion? tryParse(Object? raw) {
    if (raw is! String) return null;

    final core = raw.trim().split(RegExp('[+-]')).first;
    if (core.isEmpty) return null;

    final parts = core.split('.');
    if (parts.length > 3) return null;

    final numbers = <int>[];
    for (final part in parts) {
      final value = int.tryParse(part);
      if (value == null || value < 0) return null;
      numbers.add(value);
    }

    return AppVersion(
      numbers[0],
      numbers.length > 1 ? numbers[1] : 0,
      numbers.length > 2 ? numbers[2] : 0,
    );
  }

  @override
  int compareTo(AppVersion other) {
    if (major != other.major) return major.compareTo(other.major);
    if (minor != other.minor) return minor.compareTo(other.minor);
    return patch.compareTo(other.patch);
  }

  bool operator <(AppVersion other) => compareTo(other) < 0;

  bool operator >(AppVersion other) => compareTo(other) > 0;

  @override
  bool operator ==(Object other) =>
      other is AppVersion &&
      other.major == major &&
      other.minor == minor &&
      other.patch == patch;

  @override
  int get hashCode => Object.hash(major, minor, patch);

  @override
  String toString() => '$major.$minor.$patch';
}

/// What the app should do about its own version.
enum UpgradeRequirement {
  /// Nothing to say.
  none,

  /// A newer build exists. Mention it; do not block.
  recommended,

  /// This build may not be used. Block everything behind the upgrade screen.
  required,
}

/// The server's version policy, as bootstrap reports it.
///
/// Every field is parsed leniently and a value that cannot be read is treated
/// as "no requirement". That direction is deliberate: failing closed would mean
/// one typo in a school's configuration bricks every installed copy of the app
/// at once, with no way for a parent to get past it. The gate is a product
/// control, not a security boundary — the token is the security boundary.
@immutable
class UpgradePolicy {
  const UpgradePolicy({
    this.minSupported,
    this.recommended,
    this.forceUpgrade = false,
  });

  /// No policy known yet, e.g. before the first bootstrap call.
  static const UpgradePolicy unknown = UpgradePolicy();

  final AppVersion? minSupported;
  final AppVersion? recommended;

  /// A kill switch the server can set independently of version arithmetic —
  /// for a build that is new enough but known broken.
  final bool forceUpgrade;

  factory UpgradePolicy.fromJson(Object? json) {
    if (json is! Map) return unknown;

    return UpgradePolicy(
      minSupported: AppVersion.tryParse(json['min_supported_version']),
      recommended: AppVersion.tryParse(json['recommended_version']),
      forceUpgrade: json['force_upgrade'] == true,
    );
  }

  UpgradeRequirement evaluate(AppVersion current) {
    if (forceUpgrade) return UpgradeRequirement.required;

    final minimum = minSupported;
    if (minimum != null && current < minimum) return UpgradeRequirement.required;

    final wanted = recommended;
    if (wanted != null && current < wanted) return UpgradeRequirement.recommended;

    return UpgradeRequirement.none;
  }

  @override
  bool operator ==(Object other) =>
      other is UpgradePolicy &&
      other.minSupported == minSupported &&
      other.recommended == recommended &&
      other.forceUpgrade == forceUpgrade;

  @override
  int get hashCode => Object.hash(minSupported, recommended, forceUpgrade);
}
