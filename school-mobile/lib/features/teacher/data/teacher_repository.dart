import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/api/api_error.dart';
import '../../../core/auth/secure_random.dart';
import '../../../core/db/app_database.dart';
import '../../../core/db/tables.dart';
import '../domain/attendance_draft.dart';
import '../domain/gradebook.dart';
import '../domain/publishing.dart';
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
  static const String gradebookEntity = 'teacher_gradebook';
  static const String assignmentsEntity = 'teacher_assignments';

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

  /* ---------- gradebook ---------- */

  Future<Cached<MarkSheet>?> cachedMarkSheet(int classId, int subjectId) =>
      _cached(gradebookEntity, '$classId:$subjectId', MarkSheet.fromJson);

  Future<Cached<MarkSheet>> refreshMarkSheet(int classId, int subjectId) =>
      _refresh(
        path: '/mobile/v1/teacher/gradebook/$classId/$subjectId',
        query: const <String, Object?>{},
        entityType: gradebookEntity,
        entityId: '$classId:$subjectId',
        parse: MarkSheet.fromJson,
      );

  /// Queues a column of marks.
  ///
  /// Enqueue, not send, for the same reason attendance is: a staff room with
  /// no signal is where marks actually get entered.
  Future<OutboxEntry> queueGrades(GradeDraft draft) => database.enqueue(
        endpoint: TeacherEndpoints.gradesBatch,
        method: 'POST',
        payloadJson: jsonEncode(draft.toPayload()),
        idempotencyKey: randomUuidV4(),
      );

  /// Grade items with a batch still owed to the server for this class.
  ///
  /// Read from the queue, never from a flag the screen sets: a queued mark
  /// must not be shown as saved, and only the queue knows.
  Future<Set<int>> queuedGradeItems(int classRoomId, int subjectId) async {
    final queued = <int>{};

    for (final entry in await database.allOutbox()) {
      if (entry.endpoint != TeacherEndpoints.gradesBatch) continue;
      if (entry.status == OutboxStatus.succeeded ||
          entry.status == OutboxStatus.dead) {
        continue;
      }

      final payload = _decode(entry.payloadJson);
      if (payload == null) continue;
      if (int.tryParse('${payload['class_room_id']}') != classRoomId) continue;
      if (int.tryParse('${payload['subject_id']}') != subjectId) continue;

      final grades = payload['grades'];
      if (grades is! Iterable) continue;

      for (final grade in grades) {
        if (grade is! Map) continue;
        final itemId = int.tryParse('${grade['grade_component_id']}');
        if (itemId != null) queued.add(itemId);
      }
    }

    return queued;
  }

  /// Grade batches for this class and subject the engine gave up on.
  Future<List<RejectedSubmission>> rejectedGrades(
    int classRoomId,
    int subjectId,
  ) async {
    final dead = (await database.allOutbox())
        .where((entry) =>
            entry.endpoint == TeacherEndpoints.gradesBatch &&
            entry.status == OutboxStatus.dead)
        .map(RejectedSubmission.of)
        .where((row) =>
            row.classRoomId == classRoomId && row.subjectId == subjectId)
        .toList()
      ..sort((a, b) => b.outboxRowId.compareTo(a.outboxRowId));

    return dead;
  }

  /* ---------- assignments and notices ---------- */

  /// Homework for this teacher's classes, with hand-in counts.
  ///
  /// Cached like every other read, so the list is there in a corridor. The
  /// *writes* below are deliberately not queued: see [createAssignment].
  Future<Cached<List<TeacherAssignment>>?> cachedAssignments() =>
      _cached(assignmentsEntity, 'mine', TeacherAssignment.listFrom);

  Future<Cached<List<TeacherAssignment>>> refreshAssignments() => _refresh(
        path: '/mobile/v1/teacher/assignments',
        query: const <String, Object?>{},
        entityType: assignmentsEntity,
        entityId: 'mine',
        parse: TeacherAssignment.listFrom,
      );

  /// Creates a draft.
  ///
  /// Not queued to the outbox, unlike attendance and grades. Those exist
  /// because a classroom has no signal and the work cannot wait; homework can.
  /// Queueing it would also mean an attachment with no assignment id to attach
  /// to, and a publish that fires days later. The screen says so plainly
  /// rather than pretending to save something it has not.
  Future<TeacherAssignment?> createAssignment({
    required int classRoomId,
    required int subjectId,
    required String title,
    required String instructions,
    required DateTime dueAt,
  }) async {
    try {
      final response = await dio.post<Object?>(
        '/mobile/v1/teacher/assignments',
        data: <String, Object?>{
          'class_room_id': classRoomId,
          'subject_id': subjectId,
          'title': title,
          'instructions': instructions,
          'due_at': dueAt.toUtc().toIso8601String(),
        },
        options: Options(
          headers: <String, Object?>{'Idempotency-Key': randomUuidV4()},
          contentType: Headers.jsonContentType,
        ),
      );

      return TeacherAssignment.fromEnvelope(response.data);
    } on DioException catch (error) {
      throw apiErrorOf(error.error) ?? const UnknownError();
    }
  }

  /// Uploads an attachment, reporting progress as it goes.
  ///
  /// The assignment already exists, so a failure here loses the file and
  /// nothing else. [onProgress] is what makes the failure visible rather than
  /// a spinner that stops: the screen shows how far it got and offers a retry.
  Future<TeacherAssignment?> attach({
    required int assignmentId,
    required String filePath,
    required String fileName,
    void Function(int sent, int total)? onProgress,
  }) async {
    try {
      final response = await dio.post<Object?>(
        '/mobile/v1/teacher/assignments/$assignmentId/attachment',
        data: FormData.fromMap(<String, Object?>{
          'file': await MultipartFile.fromFile(filePath, filename: fileName),
        }),
        onSendProgress: onProgress,
      );

      return TeacherAssignment.fromEnvelope(response.data);
    } on DioException catch (error) {
      throw apiErrorOf(error.error) ?? const UnknownError();
    }
  }

  /// Publishes a draft. The server treats a second publish as a no-op.
  Future<TeacherAssignment?> publish(int assignmentId) async {
    try {
      final response = await dio.post<Object?>(
        '/mobile/v1/teacher/assignments/$assignmentId/publish',
      );

      return TeacherAssignment.fromEnvelope(response.data);
    } on DioException catch (error) {
      throw apiErrorOf(error.error) ?? const UnknownError();
    }
  }

  Future<HandInReport> handIns(int assignmentId) async {
    try {
      final response = await dio.get<Object?>(
        '/mobile/v1/teacher/assignments/$assignmentId/submissions',
      );

      return HandInReport.fromJson(response.data);
    } on DioException catch (error) {
      throw apiErrorOf(error.error) ?? const UnknownError();
    }
  }

  Future<AnnouncementOptions> announcementOptions() async {
    try {
      final response = await dio.get<Object?>(
        '/mobile/v1/teacher/announcement-templates',
      );

      return AnnouncementOptions.fromJson(response.data);
    } on DioException catch (error) {
      throw apiErrorOf(error.error) ?? const UnknownError();
    }
  }

  /// Sends one approved notice.
  ///
  /// Never queued. A notice queued at four in the afternoon and drained at
  /// midnight would arrive exactly when the school's hours exist to prevent,
  /// and the hours are the point.
  Future<void> announce({
    required String templateKey,
    required String detail,
    required String audience,
  }) async {
    try {
      await dio.post<Object?>(
        '/mobile/v1/teacher/announcements',
        data: <String, Object?>{
          'template_key': templateKey,
          'detail': detail,
          'audience': audience,
        },
        options: Options(
          headers: <String, Object?>{'Idempotency-Key': randomUuidV4()},
          contentType: Headers.jsonContentType,
        ),
      );
    } on DioException catch (error) {
      throw AnnounceFailure(_announceRefusalOf(error));
    }
  }

  static AnnounceRefusal _announceRefusalOf(DioException error) {
    final status = error.response?.statusCode;

    if (status == 409) return AnnounceRefusal.outsideHours;
    if (status == 422) return AnnounceRefusal.notAllowed;
    if (status == 403) return AnnounceRefusal.notPermitted;

    final mapped = apiErrorOf(error.error);
    if (mapped is OfflineError || mapped is TimeoutError) {
      return AnnounceRefusal.offline;
    }

    return AnnounceRefusal.failed;
  }

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
  Future<List<RejectedSubmission>> rejectedAttendance() async {
    final dead = (await database.allOutbox())
        .where((entry) =>
            entry.endpoint == TeacherEndpoints.attendanceBatch &&
            entry.status == OutboxStatus.dead)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return dead.map(RejectedSubmission.of).toList();
  }

  /// Queues a whole class's marks.
  ///
  /// Enqueue, not send. The screen never touches the network: a teacher in a
  /// classroom with no signal must be able to finish the register and walk
  /// away, and the drain happens whenever the phone next has a connection.
  ///
  /// A fresh key per submission. Re-submitting after spotting a mistake is a
  /// correction, not a replay, and it has to reach the server as its own
  /// batch; the queue drains in creation order and the server upserts by
  /// student and date, so the correction lands last and wins.
  Future<OutboxEntry> queueAttendance(AttendanceDraft draft) => database.enqueue(
        endpoint: TeacherEndpoints.attendanceBatch,
        method: 'POST',
        payloadJson: jsonEncode(draft.toPayload()),
        idempotencyKey: randomUuidV4(),
      );

  /// Whether a batch for this class and date is still owed to the server.
  Future<bool> hasQueuedAttendance(int classRoomId, String date) async =>
      (await queuedAttendance(date)).contains(classRoomId);

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

/// A queued write the sync engine gave up on.
///
/// The "what" is read from the local row rather than from the server's reply:
/// the drainer deliberately never keeps a response body, because a body can
/// quote the values that were submitted. The class and date come from the
/// payload the teacher's own device wrote, and the "why" is derived from the
/// status code — enough to act on, with nothing personal travelling through a
/// log or an event.
@immutable
class RejectedSubmission {
  const RejectedSubmission({
    required this.outboxRowId,
    required this.reason,
    this.classRoomId,
    this.subjectId,
    this.date,
    this.recordCount,
    this.entries = const <Map<Object?, Object?>>[],
  });

  factory RejectedSubmission.of(OutboxEntry entry) {
    final payload = TeacherRepository._decode(entry.payloadJson);
    final records = payload?['records'] ?? payload?['grades'];

    return RejectedSubmission(
      outboxRowId: entry.id,
      reason: entry.lastError ?? '',
      classRoomId: int.tryParse('${payload?['class_room_id']}'),
      subjectId: int.tryParse('${payload?['subject_id']}'),
      date: payload?['date'] as String?,
      recordCount: records is Iterable ? records.length : null,
      entries: records is Iterable
          ? records.whereType<Map<Object?, Object?>>().toList()
          : const <Map<Object?, Object?>>[],
    );
  }

  final int outboxRowId;

  /// The drainer's short diagnostic, e.g. `HTTP 422`. Never a response body.
  final String reason;

  final int? classRoomId;
  final int? subjectId;
  final String? date;
  final int? recordCount;

  /// The rows this device tried to send, so the teacher can see exactly what
  /// was refused rather than being told only that something was. This is the
  /// teacher's own input on the teacher's own device -- nothing here came from
  /// the server, and nothing here is logged.
  final List<Map<Object?, Object?>> entries;

  /// The status the server answered with, where the reason carries one.
  int? get statusCode =>
      int.tryParse(RegExp(r'HTTP (\d{3})').firstMatch(reason)?.group(1) ?? '');
}
