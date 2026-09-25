import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../core/api/api_error.dart';
import '../../../core/auth/secure_random.dart';
import '../../../core/db/app_database.dart';
import '../../parent/domain/academics.dart';
import '../domain/student_record.dart';

/// A cache-first read and where it came from.
@immutable
class StudentCached<T> {
  const StudentCached({
    required this.value,
    required this.fromCache,
    this.fetchedAt,
  });

  final T value;
  final bool fromCache;
  final DateTime? fetchedAt;
}

/// Everything the student app reads and the one thing it writes.
///
/// **There is no method here that takes a student id.** Not one. The server
/// resolves the student from the token and accepts no such parameter, so a
/// client method that took one could only ever pass it to be ignored — and its
/// existence would invite the next person to add the parameter server-side.
/// Cross-student access is the highest-risk failure on this surface, and the
/// client's contribution to preventing it is to have nowhere to put the id.
///
/// There is likewise nothing here that reads another student: no classmates,
/// no ranking, no peer messaging.
class StudentRepository {
  StudentRepository({required this.dio, required this.database});

  final Dio dio;
  final AppDatabase database;

  static const String homeEntity = 'student_home';
  static const String timetableEntity = 'student_timetable';
  static const String assignmentsEntity = 'student_assignments';
  static const String gradesEntity = 'student_grades';
  static const String attendanceEntity = 'student_attendance';

  /// Where a hand-in's idempotency key lives between attempts.
  ///
  /// Minted once per hand-in and kept until the server accepts it, so a retry
  /// after a timeout — including one after the app was killed — is the same
  /// hand-in rather than a second one.
  static const String handInKeyEntity = 'student_hand_in_key';

  static const String _mine = 'me';

  /* ---------- reads ---------- */

  Future<StudentCached<StudentHome>?> cachedHome() =>
      _cached(homeEntity, StudentHome.fromJson);

  Future<StudentCached<StudentHome>> refreshHome() => _refresh(
        path: '/mobile/v1/student/home',
        entityType: homeEntity,
        parse: StudentHome.fromJson,
      );

  Future<StudentCached<StudentTimetable>?> cachedTimetable() =>
      _cached(timetableEntity, StudentTimetable.fromJson);

  Future<StudentCached<StudentTimetable>> refreshTimetable() => _refresh(
        path: '/mobile/v1/student/timetable',
        entityType: timetableEntity,
        parse: StudentTimetable.fromJson,
      );

  Future<StudentCached<List<StudentAssignment>>?> cachedAssignments() =>
      _cached(assignmentsEntity, StudentAssignment.listFrom);

  Future<StudentCached<List<StudentAssignment>>> refreshAssignments() =>
      _refresh(
        path: '/mobile/v1/student/assignments',
        entityType: assignmentsEntity,
        parse: StudentAssignment.listFrom,
      );

  Future<StudentCached<List<SubjectGrades>>?> cachedGrades() =>
      _cached(gradesEntity, SubjectGrades.listFrom);

  Future<StudentCached<List<SubjectGrades>>> refreshGrades() => _refresh(
        path: '/mobile/v1/student/grades',
        entityType: gradesEntity,
        parse: SubjectGrades.listFrom,
      );

  Future<StudentCached<ChildAttendance>?> cachedAttendance() =>
      _cached(attendanceEntity, ChildAttendance.fromJson);

  Future<StudentCached<ChildAttendance>> refreshAttendance() => _refresh(
        path: '/mobile/v1/student/attendance',
        entityType: attendanceEntity,
        parse: ChildAttendance.fromJson,
      );

  /* ---------- the one write ---------- */

  /// The key this hand-in is using, minting one if it has none.
  ///
  /// Persisted rather than held in memory: the retry that matters most is the
  /// one after the app was killed mid-upload, and a fresh key there would
  /// produce a second hand-in for the same work.
  Future<String> handInKey(int assignmentId) async {
    final row = await database.readCache(handInKeyEntity, '$assignmentId');
    if (row != null && row.payloadJson.isNotEmpty) return row.payloadJson;

    final key = randomUuidV4();
    await database.upsertCache(
      entityType: handInKeyEntity,
      entityId: '$assignmentId',
      payloadJson: key,
    );

    return key;
  }

  /// Hands in work. Returns what the server recorded.
  ///
  /// Not queued to the outbox. A hand-in carries a file the queue cannot hold,
  /// and — more to the point — a student must never be shown "handed in" for
  /// something sitting on their own phone. Deadlines are decided at the school.
  Future<HandInState> handIn({
    required int assignmentId,
    String? text,
    String? filePath,
    String? fileName,
    void Function(int sent, int total)? onProgress,
  }) async {
    final key = await handInKey(assignmentId);

    // Text alone goes as JSON; anything with a file goes as multipart. Sending
    // multipart for both would work, but a text-only hand-in is the common
    // case and JSON keeps it small on a school connection.
    final Object body;
    if (filePath == null) {
      body = <String, Object?>{'content_text': text};
    } else {
      final fields = <String, Object?>{
        'file': await MultipartFile.fromFile(filePath, filename: fileName),
      };
      if (text != null) fields['content_text'] = text;
      body = FormData.fromMap(fields);
    }

    try {
      final response = await dio.post<Object?>(
        '/mobile/v1/student/assignments/$assignmentId/submit',
        data: body,
        options: Options(
          headers: <String, Object?>{'Idempotency-Key': key},
          validateStatus: (status) => status == 200 || status == 201,
        ),
        onSendProgress: onProgress,
      );

      // Accepted, so the key has done its job and the next hand-in for this
      // assignment is a genuinely new one.
      await database.deleteCache(handInKeyEntity, '$assignmentId');

      final answer = response.data;
      final data = answer is Map ? answer['data'] ?? answer : answer;

      return handInStateOf(data is Map ? data['status'] : null);
    } on DioException catch (error) {
      throw apiErrorOf(error.error) ?? const UnknownError();
    }
  }

  /* ---------- plumbing ---------- */

  Future<StudentCached<T>?> _cached<T>(
    String entityType,
    T Function(Object?) parse,
  ) async {
    final row = await database.readCache(entityType, _mine);
    if (row == null) return null;

    try {
      return StudentCached<T>(
        value: parse(jsonDecode(row.payloadJson)),
        fromCache: true,
        fetchedAt: row.fetchedAt,
      );
    } on FormatException {
      await database.deleteCache(entityType, _mine);

      return null;
    }
  }

  Future<StudentCached<T>> _refresh<T>({
    required String path,
    required String entityType,
    required T Function(Object?) parse,
  }) async {
    final Response<Object?> response;
    try {
      // No query parameters at all. There is nothing to scope: the token is
      // the scope.
      response = await dio.get<Object?>(path);
    } on DioException catch (error) {
      throw apiErrorOf(error.error) ?? const UnknownError();
    }

    if (response.statusCode == 304) {
      final existing = await _cached(entityType, parse);
      if (existing != null) {
        return StudentCached<T>(
          value: existing.value,
          fromCache: false,
          fetchedAt: DateTime.now(),
        );
      }
    }

    final body = response.data;

    await database.upsertCache(
      entityType: entityType,
      entityId: _mine,
      payloadJson: jsonEncode(body),
      etag: response.headers.value('ETag'),
    );

    return StudentCached<T>(
      value: parse(body),
      fromCache: false,
      fetchedAt: DateTime.now(),
    );
  }
}
