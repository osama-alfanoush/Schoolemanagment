import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/api/api_error.dart';
import '../../../core/db/app_database.dart';
import '../../../core/db/tables.dart';
import '../domain/roster.dart';
import '../domain/teacher_day.dart';

/// A cache-first read and where it came from.
class Cached<T> {
  const Cached({required this.value, required this.fromCache, this.fetchedAt});

  final T value;

  /// True when this came off disk rather than off the wire.
  final bool fromCache;

  final DateTime? fetchedAt;
}

/// Endpoints the teacher app queues writes to.
///
/// Named here rather than inlined at the call sites because the today screen
/// has to recognise a queued attendance batch by its endpoint, and a string
/// that appears in two places is a string that eventually differs in one.
class TeacherEndpoints {
  const TeacherEndpoints._();

  static const String attendanceBatch = '/mobile/v1/teacher/attendance/batch';
  static const String gradesBatch = '/mobile/v1/teacher/grades/batch';
}

/// The teacher's day, class list and rosters, cache first.
///
/// The order is deliberate: hand back whatever is on disk immediately, then go
/// to the network. A teacher opens the roster in a corridor between lessons,
/// and a screen that waits for a request is a screen they close.
///
/// Nothing here writes a failure to the cache. A 500 must not overwrite the
/// last good copy, because then the next cold start has nothing to show.
class TeacherRepository {
  TeacherRepository({required this.dio, required this.database});

  final Dio dio;
  final AppDatabase database;

  static const String todayEntity = 'teacher_today';
  static const String rosterEntity = 'teacher_roster';

  /* ---------- today ---------- */

  Future<Cached<TeacherDay>?> cachedToday(String date) =>
      _cached(todayEntity, date, TeacherDay.fromJson);

  Future<Cached<TeacherDay>> refreshToday(String date) => _refresh(
        path: '/mobile/v1/teacher/today',
        query: <String, Object?>{'date': date},
        entityType: todayEntity,
        entityId: date,
        parse: TeacherDay.fromJson,
      );

  /* ---------- roster ---------- */

  Future<Cached<ClassRoster>?> cachedRoster(int classId, String date) =>
      _cached(rosterEntity, '$classId:$date', ClassRoster.fromJson);

  Future<Cached<ClassRoster>> refreshRoster(int classId, String date) => _refresh(
        path: '/mobile/v1/teacher/roster/$classId',
        query: <String, Object?>{'date': date},
        entityType: rosterEntity,
        entityId: '$classId:$date',
        parse: ClassRoster.fromJson,
      );

  /* ---------- outbox ---------- */

  /// Class ids with an attendance batch for [date] still owed to the server.
  ///
  /// Read from the outbox itself rather than from a flag the screen sets when
  /// it queues something. A screen-local flag is a guess: it is wrong after a
  /// restart, wrong on a second device, and wrong the moment a drain succeeds
  /// while the screen is not looking. The queue is the only honest source for
  /// "saved on my phone but not at the school".
  Future<Set<int>> queuedAttendance(String date) async {
    final queued = <int>{};

    for (final entry in await database.allOutbox()) {
      if (entry.endpoint != TeacherEndpoints.attendanceBatch) continue;

      // A dead row is not work in progress. Folding it in here would show a
      // rejected submission as pending forever; it is surfaced separately.
      if (entry.status == OutboxStatus.succeeded ||
          entry.status == OutboxStatus.dead) {
        continue;
      }

      final payload = _decode(entry.payloadJson);
      if (payload == null) continue;
      if ('${payload['date']}' != date) continue;

      final classRoomId = int.tryParse('${payload['class_room_id']}');
      if (classRoomId != null) queued.add(classRoomId);
    }

    return queued;
  }

  /// Attendance batches the engine gave up on, newest first.
  ///
  /// Never merged into the pending count: a teacher has to be able to tell
  /// "still sending" from "this was rejected and nobody has it".
  Future<List<OutboxEntry>> rejectedAttendance() async {
    final dead = (await database.allOutbox())
        .where((entry) =>
            entry.endpoint == TeacherEndpoints.attendanceBatch &&
            entry.status == OutboxStatus.dead)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return dead;
  }

  static Map<String, Object?>? _decode(String payloadJson) {
    try {
      final decoded = jsonDecode(payloadJson);

      return decoded is Map ? decoded.cast<String, Object?>() : null;
    } on FormatException {
      return null;
    }
  }

  /* ---------- plumbing ---------- */

  Future<Cached<T>?> _cached<T>(
    String entityType,
    String entityId,
    T Function(Object?) parse,
  ) async {
    final row = await database.readCache(entityType, entityId);
    if (row == null) return null;

    try {
      return Cached<T>(
        value: parse(jsonDecode(row.payloadJson)),
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

  Future<Cached<T>> _refresh<T>({
    required String path,
    required Map<String, Object?> query,
    required String entityType,
    required String entityId,
    required T Function(Object?) parse,
  }) async {
    final Response<Object?> response;
    try {
      response = await dio.get<Object?>(path, queryParameters: query);
    } on DioException catch (error) {
      throw apiErrorOf(error.error) ?? const UnknownError();
    }

    // A 304 means the cached copy is still current — the server said so, which
    // is a stronger statement than a guessed expiry. It is therefore *not*
    // stale: the content came off disk, but its freshness was just confirmed.
    if (response.statusCode == 304) {
      final existing = await _cached(entityType, entityId, parse);
      if (existing != null) {
        return Cached<T>(
          value: existing.value,
          fromCache: false,
          fetchedAt: DateTime.now(),
        );
      }
    }

    final body = response.data;

    await database.upsertCache(
      entityType: entityType,
      entityId: entityId,
      payloadJson: jsonEncode(body),
      etag: response.headers.value('ETag'),
    );

    return Cached<T>(
      value: parse(body),
      fromCache: false,
      fetchedAt: DateTime.now(),
    );
  }
}
