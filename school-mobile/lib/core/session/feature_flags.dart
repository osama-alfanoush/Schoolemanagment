import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../db/app_database.dart';

/// Which parts of the app this school has switched on.
///
/// Read from the server, cached on disk, and **defaulting to on**. That
/// default matters: a pilot phone that cannot reach the server on the first
/// morning must show the app, not an empty shell. A flag is a way for the
/// school to turn something *off* — a payment surface that is not ready, a
/// student app the school has not rolled out yet — and treating an unreachable
/// server as "everything off" would turn one bad connection into an outage.
@immutable
class FeatureFlags {
  const FeatureFlags(this._flags);

  /// Everything on. The state before the first successful bootstrap.
  const FeatureFlags.allOn() : _flags = const <String, bool>{};

  final Map<String, bool> _flags;

  /// Whether [name] is on. Unknown flags are on.
  ///
  /// A build that has never heard of a flag the server sends must not break,
  /// and a flag the server has stopped sending must not silently disable a
  /// screen that is still shipped.
  bool isOn(String name) => _flags[name] ?? true;

  Map<String, bool> get all => Map<String, bool>.unmodifiable(_flags);

  static FeatureFlags fromJson(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) return const FeatureFlags.allOn();

    final features = data['features'];
    if (features is! Map) return const FeatureFlags.allOn();

    return FeatureFlags(<String, bool>{
      for (final entry in features.entries) '${entry.key}': entry.value == true,
    });
  }

  @override
  bool operator ==(Object other) =>
      other is FeatureFlags && mapEquals(other._flags, _flags);

  @override
  int get hashCode => Object.hashAll(<Object?>[
        for (final entry in _flags.entries) ...<Object?>[entry.key, entry.value],
      ]);

  @override
  String toString() => 'FeatureFlags($_flags)';
}

/// Fetches and caches the school's flags.
///
/// Cached like every other read, so a cold start on a bad connection uses what
/// the school said last time rather than a guess.
class FeatureFlagStore extends ChangeNotifier {
  FeatureFlagStore({required this.dio, required this.database});

  final Dio dio;
  final AppDatabase database;

  static const String entityType = 'mobile_features';
  static const String entityId = 'current';

  FeatureFlags _flags = const FeatureFlags.allOn();

  FeatureFlags get flags => _flags;

  bool isOn(String name) => _flags.isOn(name);

  /// Loads from disk, then revalidates.
  Future<void> load() async {
    final row = await database.readCache(entityType, entityId);
    if (row != null) {
      try {
        _flags = FeatureFlags.fromJson(jsonDecode(row.payloadJson));
        notifyListeners();
      } on FormatException {
        await database.deleteCache(entityType, entityId);
      }
    }

    await refresh();
  }

  /// Goes to the server. A failure leaves the cached flags alone.
  Future<void> refresh() async {
    final Response<Object?> response;
    try {
      response = await dio.get<Object?>('/mobile/v1/session/bootstrap');
    } on DioException {
      // Unreachable is not "everything off". The last known answer stands.
      return;
    }

    final body = response.data;
    _flags = FeatureFlags.fromJson(body);

    await database.upsertCache(
      entityType: entityType,
      entityId: entityId,
      payloadJson: jsonEncode(body),
      etag: response.headers.value('ETag'),
    );

    notifyListeners();
  }
}

/// The flag names the app knows about.
///
/// Named constants rather than string literals at the call sites: a typo in a
/// literal reads as "unknown flag", which defaults to on, which is exactly the
/// failure a school would not notice.
class Features {
  const Features._();

  /// The fee and payment surface.
  static const String parentPayments = 'parent_payments';

  /// Guardian messaging.
  static const String parentMessages = 'parent_messages';

  /// The offline register.
  static const String teacherAttendance = 'teacher_attendance';

  /// The student app as a whole.
  static const String studentApp = 'student_app';
}
