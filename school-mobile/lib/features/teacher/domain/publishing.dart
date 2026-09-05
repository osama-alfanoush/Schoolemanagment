import 'package:flutter/foundation.dart';

/// How a class is doing with one piece of homework.
@immutable
class SubmissionCounts {
  const SubmissionCounts({
    this.submitted = 0,
    this.late = 0,
    this.graded = 0,
    this.pending = 0,
  });

  final int submitted;
  final int late;
  final int graded;
  final int pending;

  int get handedIn => submitted + late + graded;

  static SubmissionCounts fromJson(Object? json) {
    if (json is! Map) return const SubmissionCounts();

    int at(String key) => int.tryParse('${json[key]}') ?? 0;

    return SubmissionCounts(
      submitted: at('submitted'),
      late: at('late'),
      graded: at('graded'),
      pending: at('pending'),
    );
  }
}

/// One assignment as the teacher's list shows it.
@immutable
class TeacherAssignment {
  const TeacherAssignment({
    required this.id,
    required this.classRoomId,
    required this.subjectId,
    required this.title,
    required this.isPublished,
    required this.hasAttachment,
    required this.counts,
    this.instructions,
    this.dueAt,
    this.classSize = 0,
  });

  final int id;
  final int classRoomId;
  final int subjectId;
  final String title;

  /// A draft is invisible to students and their families. The distinction is
  /// the point of the screen: an interrupted teacher must be able to stop
  /// halfway without thirty households being told.
  final bool isPublished;

  final bool hasAttachment;
  final SubmissionCounts counts;
  final String? instructions;
  final DateTime? dueAt;
  final int classSize;

  static TeacherAssignment? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['id']}');
    if (id == null) return null;

    return TeacherAssignment(
      id: id,
      classRoomId: int.tryParse('${json['class_room_id']}') ?? 0,
      subjectId: int.tryParse('${json['subject_id']}') ?? 0,
      title: '${json['title'] ?? ''}',
      isPublished: json['published'] == true,
      hasAttachment: json['has_attachment'] == true,
      counts: SubmissionCounts.fromJson(json['submission_counts']),
      instructions: json['instructions'] as String?,
      dueAt: DateTime.tryParse('${json['due_at']}'),
      classSize: int.tryParse('${json['class_size']}') ?? 0,
    );
  }

  static List<TeacherAssignment> listFrom(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) return const <TeacherAssignment>[];

    final rows = data['assignments'];

    return rows is Iterable
        ? rows
            .map(TeacherAssignment.tryFrom)
            .whereType<TeacherAssignment>()
            .toList()
        : const <TeacherAssignment>[];
  }

  static TeacherAssignment? fromEnvelope(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;

    return TeacherAssignment.tryFrom(data);
  }
}

/// Whether one student has handed in.
enum HandInStatus { pending, submitted, late, graded }

HandInStatus handInStatusOf(Object? value) => switch ('$value') {
      'submitted' => HandInStatus.submitted,
      'late' => HandInStatus.late,
      'graded' => HandInStatus.graded,
      // Absent means not handed in. A blank would read as "fine", which is
      // the opposite of what a teacher opens this screen to find out.
      _ => HandInStatus.pending,
    };

/// One student's hand-in.
@immutable
class HandIn {
  const HandIn({
    required this.studentUserId,
    required this.name,
    required this.status,
    this.score,
    this.hasFile = false,
  });

  final int studentUserId;
  final String name;
  final HandInStatus status;
  final String? score;
  final bool hasFile;

  static HandIn? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['student_user_id']}');
    if (id == null) return null;

    return HandIn(
      studentUserId: id,
      name: '${json['name'] ?? ''}',
      status: handInStatusOf(json['status']),
      score: json['score'] as String?,
      hasFile: json['has_file'] == true,
    );
  }
}

/// Who has handed in one assignment, and who has not.
@immutable
class HandInReport {
  const HandInReport({
    required this.assignmentId,
    required this.title,
    required this.students,
    required this.isPublished,
  });

  final int assignmentId;
  final String title;
  final List<HandIn> students;
  final bool isPublished;

  int get outstanding =>
      students.where((row) => row.status == HandInStatus.pending).length;

  static HandInReport fromJson(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) {
      return const HandInReport(
        assignmentId: 0,
        title: '',
        students: <HandIn>[],
        isPublished: false,
      );
    }

    final students = data['students'];

    return HandInReport(
      assignmentId: int.tryParse('${data['assignment_id']}') ?? 0,
      title: '${data['title'] ?? ''}',
      isPublished: data['published'] == true,
      students: students is Iterable
          ? students.map(HandIn.tryFrom).whereType<HandIn>().toList()
          : const <HandIn>[],
    );
  }
}

/// One notice a teacher may send, as the school worded it.
@immutable
class AnnouncementTemplate {
  const AnnouncementTemplate({
    required this.key,
    required this.title,
    required this.body,
  });

  final String key;
  final String title;

  /// Carries `:detail` where the teacher's sentence goes. Rendered from the
  /// server rather than held in the app, so a wording change does not need a
  /// release.
  final String body;

  String preview(String detail) => body.replaceAll(':detail', detail).trim();

  static AnnouncementTemplate? tryFrom(Object? json) {
    if (json is! Map) return null;

    final key = json['key'];
    if (key == null) return null;

    return AnnouncementTemplate(
      key: '$key',
      title: '${json['title'] ?? ''}',
      body: '${json['body'] ?? ''}',
    );
  }
}

/// The notices available, and whether they may be sent right now.
@immutable
class AnnouncementOptions {
  const AnnouncementOptions({
    required this.templates,
    required this.isOpenNow,
    this.from,
    this.to,
  });

  final List<AnnouncementTemplate> templates;

  /// The server's answer. The client shows the window too, but a send is
  /// refused by the server and the screen has to handle that either way.
  final bool isOpenNow;

  final String? from;
  final String? to;

  static AnnouncementOptions fromJson(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) {
      return const AnnouncementOptions(
        templates: <AnnouncementTemplate>[],
        isOpenNow: false,
      );
    }

    final templates = data['templates'];
    final window = data['window'];

    return AnnouncementOptions(
      templates: templates is Iterable
          ? templates
              .map(AnnouncementTemplate.tryFrom)
              .whereType<AnnouncementTemplate>()
              .toList()
          : const <AnnouncementTemplate>[],
      isOpenNow: data['open_now'] == true,
      from: window is Map ? window['from'] as String? : null,
      to: window is Map ? window['to'] as String? : null,
    );
  }
}

/// Why a notice was not sent.
enum AnnounceRefusal {
  /// Outside the school's configured hours.
  outsideHours,

  /// Not a template this school approved, or a detail that is too long.
  notAllowed,

  /// Not this teacher's class or guardian.
  notPermitted,

  offline,

  failed,
}

/// A notice that did not send.
class AnnounceFailure implements Exception {
  const AnnounceFailure(this.reason);

  final AnnounceRefusal reason;

  @override
  String toString() => 'AnnounceFailure(${reason.name})';
}

/// Where an attachment upload has got to.
sealed class UploadState {
  const UploadState();
}

class UploadIdle extends UploadState {
  const UploadIdle();
}

class UploadRunning extends UploadState {
  const UploadRunning(this.progress);

  /// 0..1, or null when the total size is unknown.
  final double? progress;
}

class UploadDone extends UploadState {
  const UploadDone();
}

/// A failure the teacher can see and retry. Never silent: the assignment
/// itself is already saved, so the only thing lost is the file.
class UploadFailed extends UploadState {
  const UploadFailed(this.isOffline);

  final bool isOffline;
}
