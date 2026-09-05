import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../core/api/token_store.dart';
import '../../core/db/app_database.dart';
import '../../core/db/tables.dart';
import '../../core/session/feature_flags.dart';

/// What a pilot support call actually needs.
///
/// During a pilot the useful question is never "what went wrong" — nobody on
/// the phone knows — it is "what state is this device in". This produces that
/// state as text a teacher can read out or paste into a message, and it is
/// built to be safe to paste anywhere.
///
/// **Nothing personal goes in it.** Not a name, not a mark, not a phone
/// number, not a payload, not a token. What goes in is counts, statuses,
/// endpoints and identifiers the school already knows. That constraint is what
/// makes it usable: a bundle someone has to redact before sending is a bundle
/// nobody sends.
@immutable
class SupportBundle {
  const SupportBundle({
    required this.appVersion,
    required this.deviceId,
    required this.generatedAt,
    required this.queue,
    required this.cachedScreens,
    required this.features,
    required this.recentFailures,
    this.baseUrl,
    this.userId,
  });

  final String appVersion;

  /// The app-generated device id — the same one the school sees in the device
  /// list, which is what makes a support call resolvable at all.
  final String? deviceId;

  final DateTime generatedAt;

  /// Outbox rows by status. Counts, never contents.
  final Map<String, int> queue;

  /// Which cached screens this device holds, by entity type. The *names*, so
  /// support can tell "never loaded" from "loaded and stale".
  final Map<String, int> cachedScreens;

  final Map<String, bool> features;

  /// The last few failures the sync engine recorded: endpoint and short
  /// reason, which are exactly what the drainer already stores and already
  /// keeps free of payloads.
  final List<String> recentFailures;

  final String? baseUrl;

  /// The signed-in user's id, not their name. The school can look it up; a
  /// stranger reading the bundle cannot.
  final String? userId;

  /// Renders the bundle as plain text.
  ///
  /// Plain text rather than JSON because it gets pasted into a message by
  /// someone who is not a developer, and a wall of braces gets truncated.
  String toText() {
    final lines = <String>[
      'School Suite — diagnostics',
      'generated: ${generatedAt.toUtc().toIso8601String()}',
      'app: $appVersion',
      if (baseUrl != null) 'server: $baseUrl',
      if (deviceId != null) 'device: $deviceId',
      if (userId != null) 'user id: $userId',
      '',
      'queued writes:',
      for (final entry in queue.entries) '  ${entry.key}: ${entry.value}',
      '',
      'cached screens:',
      if (cachedScreens.isEmpty)
        '  (none)'
      else
        for (final entry in cachedScreens.entries)
          '  ${entry.key}: ${entry.value}',
      '',
      'features:',
      if (features.isEmpty)
        '  (defaults)'
      else
        for (final entry in features.entries)
          '  ${entry.key}: ${entry.value ? 'on' : 'off'}',
      '',
      'recent failures:',
      if (recentFailures.isEmpty)
        '  (none)'
      else
        for (final failure in recentFailures) '  $failure',
    ];

    return lines.join('\n');
  }

  /// Machine-readable form, for a support tool rather than a person.
  Map<String, Object?> toJson() => <String, Object?>{
        'app_version': appVersion,
        'generated_at': generatedAt.toUtc().toIso8601String(),
        'base_url': baseUrl,
        'device_id': deviceId,
        'user_id': userId,
        'queue': queue,
        'cached_screens': cachedScreens,
        'features': features,
        'recent_failures': recentFailures,
      };

  @override
  String toString() => 'SupportBundle(${queue['pending'] ?? 0} pending)';
}

/// Builds a [SupportBundle] from what the device actually holds.
class SupportBundleBuilder {
  const SupportBundleBuilder({
    required this.database,
    required this.tokenStore,
    required this.appVersion,
    this.flags,
    this.baseUrl,
    this.userId,
  });

  final AppDatabase database;
  final TokenStore tokenStore;
  final String appVersion;
  final FeatureFlagStore? flags;
  final String? baseUrl;
  final String? userId;

  /// How many past failures to include. Enough to see a pattern, few enough
  /// that the bundle stays pasteable.
  static const int failureLimit = 10;

  Future<SupportBundle> build({DateTime? now}) async {
    final outbox = await database.allOutbox();

    final queue = <String, int>{
      for (final status in OutboxStatus.values)
        status.name: outbox.where((row) => row.status == status).length,
    };

    final failures = outbox
        .where((row) => row.lastError != null && row.lastError!.isNotEmpty)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return SupportBundle(
      appVersion: appVersion,
      // The device id, never the token. The id is what the school's device
      // list shows; the token is a credential.
      deviceId: await tokenStore.readDeviceId(),
      generatedAt: now ?? DateTime.now(),
      queue: queue,
      cachedScreens: await _cachedScreens(),
      features: flags?.flags.all ?? const <String, bool>{},
      recentFailures: <String>[
        for (final row in failures.take(failureLimit))
          // Endpoint and reason. The drainer already keeps the reason free of
          // response bodies, and the payload is never read here at all.
          '${row.endpoint} — ${row.lastError} (attempts: ${row.attempts})',
      ],
      baseUrl: baseUrl,
      userId: userId,
    );
  }

  Future<Map<String, int>> _cachedScreens() async {
    final rows = await database.select(database.localCache).get();
    final counts = <String, int>{};

    for (final row in rows) {
      // The entity *type* only. An entity id can be a student id, and a
      // support bundle is a thing people paste into group chats.
      counts[row.entityType] = (counts[row.entityType] ?? 0) + 1;
    }

    return counts;
  }
}

/// A bundle as JSON, for a support tool.
String supportBundleJson(SupportBundle bundle) =>
    const JsonEncoder.withIndent('  ').convert(bundle.toJson());
