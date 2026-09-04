import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/api/api_error.dart';
import '../../../core/db/app_database.dart';
import '../domain/parent_home.dart';

/// What a cache-first read produced.
class CachedHome {
  const CachedHome({required this.home, required this.fromCache, this.fetchedAt});

  final ParentHome home;

  /// True when this came off disk rather than off the wire.
  final bool fromCache;

  final DateTime? fetchedAt;
}

/// Reads the parent home screen, cache first.
///
/// The order is deliberate: hand back whatever is on disk immediately, then go
/// to the network. A parent opening the app at the school gate on a bad
/// connection sees last night's numbers at once and a spinner never; the
/// alternative — network first, cache as a fallback — shows a blank screen for
/// as long as the request takes, which on 3G is the whole interaction.
///
/// Nothing here writes a failure to the cache. A 500 must not overwrite the
/// last good copy, because then the next cold start has nothing to show.
class ParentHomeRepository {
  ParentHomeRepository({required this.dio, required this.database});

  final Dio dio;
  final AppDatabase database;

  /// Cache key. One row per account is enough: the payload is the whole screen.
  static const String entityType = 'parent_home';
  static const String entityId = 'current';

  /// The last good copy, or null.
  Future<CachedHome?> cached() async {
    final row = await database.readCache(entityType, entityId);
    if (row == null) return null;

    try {
      return CachedHome(
        home: ParentHome.fromJson(jsonDecode(row.payloadJson)),
        fromCache: true,
        fetchedAt: row.fetchedAt,
      );
    } on FormatException {
      // A cache row we cannot read is worse than none: drop it rather than
      // failing the screen on every open from here on.
      await database.deleteCache(entityType, entityId);

      return null;
    }
  }

  /// Fetches, stores and returns the live copy.
  ///
  /// Throws [ApiError] on failure, leaving the cached copy untouched.
  Future<CachedHome> refresh() async {
    final Response<Object?> response;
    try {
      response = await dio.get<Object?>('/mobile/v1/parent/home');
    } on DioException catch (error) {
      throw apiErrorOf(error.error) ?? const UnknownError();
    }

    // A 304 means the cached copy is still current — the server said so, which
    // is a stronger statement than a guessed expiry. It is therefore *not*
    // stale: the content came off disk, but its freshness was just confirmed,
    // and labelling it "last updated yesterday" would be wrong.
    if (response.statusCode == 304) {
      final existing = await cached();
      if (existing != null) {
        return CachedHome(
          home: existing.home,
          fromCache: false,
          fetchedAt: DateTime.now(),
        );
      }
    }

    final body = response.data;
    final home = ParentHome.fromJson(body);

    await database.upsertCache(
      entityType: entityType,
      entityId: entityId,
      payloadJson: jsonEncode(body),
      etag: response.headers.value('ETag'),
    );

    return CachedHome(home: home, fromCache: false, fetchedAt: DateTime.now());
  }
}
