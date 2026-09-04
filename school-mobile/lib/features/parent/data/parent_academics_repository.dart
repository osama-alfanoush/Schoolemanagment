import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/api/api_error.dart';
import '../../../core/api/token_refresh_coordinator.dart';
import '../../../core/auth/secure_random.dart';
import '../../../core/db/app_database.dart';
import '../domain/academics.dart';

/// What a cache-first academics read produced.
class CachedAcademics {
  const CachedAcademics({
    required this.academics,
    required this.fromCache,
    this.fetchedAt,
  });

  final ChildAcademics academics;
  final bool fromCache;
  final DateTime? fetchedAt;
}

/// A child's attendance, marks and report cards — cache first.
///
/// Same rule as the home screen: hand back what is on disk immediately, then
/// revalidate. A parent checking why their child was marked absent is often
/// doing it in a school corridor with one bar of signal, and a blank screen for
/// the length of three requests is the whole interaction.
///
/// The three calls are cached as one payload because they are read as one
/// screen. Caching them separately would let the screen render a fresh
/// attendance month beside last week's marks.
class ParentAcademicsRepository {
  ParentAcademicsRepository({required this.dio, required this.database});

  final Dio dio;
  final AppDatabase database;

  static const String entityType = 'parent_academics';

  Future<CachedAcademics?> cached(int studentId) async {
    final row = await database.readCache(entityType, '$studentId');
    if (row == null) return null;

    try {
      return CachedAcademics(
        academics: _decode(jsonDecode(row.payloadJson)),
        fromCache: true,
        fetchedAt: row.fetchedAt,
      );
    } on FormatException {
      // A row we cannot read is worse than none: drop it rather than failing
      // the screen on every open from here on.
      await database.deleteCache(entityType, '$studentId');

      return null;
    }
  }

  /// Fetches all three, stores them as one payload, and returns them.
  ///
  /// Throws [ApiError] on failure, leaving the cached copy untouched — a 500
  /// that wipes the cache leaves the next cold start with nothing.
  Future<CachedAcademics> refresh(int studentId) async {
    final attendance = await _get('/mobile/v1/parent/children/$studentId/attendance');
    final grades = await _get('/mobile/v1/parent/children/$studentId/grades');
    final cards = await _get('/mobile/v1/parent/children/$studentId/report-cards');

    final payload = <String, Object?>{
      'attendance': attendance,
      'grades': grades,
      'report_cards': cards,
    };

    await database.upsertCache(
      entityType: entityType,
      entityId: '$studentId',
      payloadJson: jsonEncode(payload),
    );

    return CachedAcademics(
      academics: _decode(payload),
      fromCache: false,
      fetchedAt: DateTime.now(),
    );
  }

  /// Files a guardian's explanation for one absence.
  ///
  /// Idempotent on a key held for the attempt, so a phone that retries does not
  /// file the same explanation twice. Online only: unlike a teacher's register
  /// this is a message to the school, and a message queued for hours and
  /// delivered after the absence has already been resolved is noise.
  Future<void> explainAbsence(int recordId, String reason) async {
    final key = await _explanationKey(recordId);

    try {
      await dio.post<Object?>(
        '/mobile/v1/parent/attendance/$recordId/explain',
        data: <String, Object?>{'reason': reason},
        options: Options(
          headers: <String, Object?>{'Idempotency-Key': key},
          contentType: Headers.jsonContentType,
          validateStatus: (status) =>
              status == HttpStatus.ok || status == HttpStatus.created,
        ),
      );
    } on DioException catch (error) {
      throw apiErrorOf(error.error) ?? const UnknownError();
    }

    await database.deleteCache('attendance_explanation', '$recordId');
  }

  Future<String> _explanationKey(int recordId) async {
    final existing =
        await database.readCache('attendance_explanation', '$recordId');

    if (existing != null) {
      final decoded = jsonDecode(existing.payloadJson);
      final key = decoded is Map ? decoded['key'] : null;
      if (key is String && key.isNotEmpty) return key;
    }

    final key = randomUuidV4();
    await database.upsertCache(
      entityType: 'attendance_explanation',
      entityId: '$recordId',
      payloadJson: jsonEncode(<String, Object?>{'key': key}),
    );

    return key;
  }

  Future<Object?> _get(String path) async {
    try {
      return (await dio.get<Object?>(path)).data;
    } on DioException catch (error) {
      throw apiErrorOf(error.error) ?? UnknownError(
        requestId: requestIdOf(error.response),
      );
    }
  }

  static ChildAcademics _decode(Object? payload) {
    final map = payload is Map ? payload : const <String, Object?>{};

    return ChildAcademics(
      attendance: ChildAttendance.fromJson(map['attendance']),
      subjects: SubjectGrades.listFrom(map['grades']),
      reportCards: IssuedReportCard.listFrom(map['report_cards']),
    );
  }
}
