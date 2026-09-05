import 'package:flutter/foundation.dart';

/// One assessment a class is marked on.
@immutable
class GradeItem {
  const GradeItem({
    required this.id,
    required this.name,
    this.type,
    this.maxScore,
    this.weight,
  });

  final int id;
  final String name;
  final String? type;

  /// Kept as the server's string. A mark is not money, but it is not a double
  /// either: parsing it to display it is how 18.50 becomes 18.5 on one screen
  /// and 18.499999 on another.
  final String? maxScore;
  final String? weight;

  double? get maxScoreValue => maxScore == null ? null : double.tryParse(maxScore!);

  static GradeItem? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['id']}');
    if (id == null) return null;

    return GradeItem(
      id: id,
      name: '${json['name'] ?? ''}',
      type: json['type'] as String?,
      maxScore: json['max_score'] as String?,
      weight: json['weight'] as String?,
    );
  }
}

/// One student's recorded mark for one item, with the version it was read at.
@immutable
class RecordedGrade {
  const RecordedGrade({
    required this.gradeItemId,
    required this.score,
    required this.version,
  });

  final int gradeItemId;
  final String score;

  /// What the optimistic write is checked against. Sending an edit without it
  /// would let a phone that has been offline since Tuesday overwrite a mark
  /// the head teacher corrected on Wednesday, with nobody told.
  final int version;

  static RecordedGrade? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['grade_component_id']}');
    if (id == null) return null;

    return RecordedGrade(
      gradeItemId: id,
      score: '${json['score'] ?? ''}',
      version: int.tryParse('${json['version']}') ?? 0,
    );
  }
}

/// A student on the mark sheet.
@immutable
class GradedStudent {
  const GradedStudent({
    required this.userId,
    required this.name,
    required this.grades,
  });

  final int userId;
  final String name;
  final List<RecordedGrade> grades;

  RecordedGrade? gradeFor(int gradeItemId) {
    for (final grade in grades) {
      if (grade.gradeItemId == gradeItemId) return grade;
    }

    return null;
  }

  static GradedStudent? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['student_user_id']}');
    if (id == null) return null;

    final grades = json['grades'];

    return GradedStudent(
      userId: id,
      name: '${json['name'] ?? ''}',
      grades: grades is Iterable
          ? grades.map(RecordedGrade.tryFrom).whereType<RecordedGrade>().toList()
          : const <RecordedGrade>[],
    );
  }
}

/// Where a gradebook is in the workflow, and whether it takes edits.
@immutable
class GradebookStatus {
  const GradebookStatus({
    required this.id,
    required this.state,
    required this.isEditable,
    this.reopenedUntil,
  });

  final int id;

  /// draft, submitted, approved, finalized, returned, reopened.
  final String state;

  /// The server's answer, never computed here. The reopen window is a
  /// timestamp, and a phone clock a day out would offer an editable sheet the
  /// server refuses.
  final bool isEditable;

  final DateTime? reopenedUntil;

  static GradebookStatus? tryFrom(Object? json) {
    if (json is! Map) return null;

    final id = int.tryParse('${json['id']}');
    if (id == null) return null;

    return GradebookStatus(
      id: id,
      state: '${json['state'] ?? ''}',
      isEditable: json['editable'] == true,
      reopenedUntil: DateTime.tryParse('${json['reopened_until']}'),
    );
  }
}

/// One class's mark sheet for one subject.
@immutable
class MarkSheet {
  const MarkSheet({
    required this.classRoomId,
    required this.subjectId,
    required this.items,
    required this.students,
    this.gradebook,
  });

  final int classRoomId;
  final int subjectId;
  final List<GradeItem> items;
  final List<GradedStudent> students;

  /// Null when no gradebook has been opened for this class and subject yet.
  /// Nothing can be entered until an administrator opens one, and saying so is
  /// better than an editable sheet with nowhere to go.
  final GradebookStatus? gradebook;

  bool get isEditable => gradebook?.isEditable ?? false;

  static MarkSheet fromJson(Object? json) {
    final data = json is Map ? json['data'] ?? json : json;
    if (data is! Map) {
      return const MarkSheet(
        classRoomId: 0,
        subjectId: 0,
        items: <GradeItem>[],
        students: <GradedStudent>[],
      );
    }

    final items = data['components'];
    final students = data['students'];

    return MarkSheet(
      classRoomId: int.tryParse('${data['class_room_id']}') ?? 0,
      subjectId: int.tryParse('${data['subject_id']}') ?? 0,
      gradebook: GradebookStatus.tryFrom(data['gradebook']),
      items: items is Iterable
          ? items.map(GradeItem.tryFrom).whereType<GradeItem>().toList()
          : const <GradeItem>[],
      students: students is Iterable
          ? students.map(GradedStudent.tryFrom).whereType<GradedStudent>().toList()
          : const <GradedStudent>[],
    );
  }
}

/// A column of marks a teacher has typed but not yet sent.
@immutable
class GradeDraft {
  const GradeDraft({
    required this.classRoomId,
    required this.subjectId,
    required this.gradeItemId,
    required this.scores,
    required this.versions,
  });

  factory GradeDraft.of(MarkSheet sheet, int gradeItemId) {
    final scores = <int, String>{};
    final versions = <int, int>{};

    for (final student in sheet.students) {
      final grade = student.gradeFor(gradeItemId);
      if (grade == null) continue;

      scores[student.userId] = grade.score;
      versions[student.userId] = grade.version;
    }

    return GradeDraft(
      classRoomId: sheet.classRoomId,
      subjectId: sheet.subjectId,
      gradeItemId: gradeItemId,
      scores: scores,
      versions: versions,
    );
  }

  final int classRoomId;
  final int subjectId;
  final int gradeItemId;

  /// What the teacher has typed, as typed. An empty entry is not a zero.
  final Map<int, String> scores;

  /// The version each score was read at, sent back so the server can refuse a
  /// stale edit rather than silently applying it.
  final Map<int, int> versions;

  GradeDraft withScore(int studentUserId, String score) {
    final next = <int, String>{...scores};
    if (score.trim().isEmpty) {
      next.remove(studentUserId);
    } else {
      next[studentUserId] = score.trim();
    }

    return GradeDraft(
      classRoomId: classRoomId,
      subjectId: subjectId,
      gradeItemId: gradeItemId,
      scores: next,
      versions: versions,
    );
  }

  /// Students whose entry is not a number the server will accept.
  ///
  /// Checked here so a typo is caught while the teacher is still looking at
  /// the column, rather than coming back as a rejection tomorrow.
  List<int> invalidEntries({double? maxScore}) => <int>[
        for (final entry in scores.entries)
          if (!_isValid(entry.value, maxScore)) entry.key,
      ];

  bool get isEmpty => scores.isEmpty;

  /// The body the batch endpoint expects. Only entered marks are sent: a blank
  /// cell is a mark not yet given, and writing a zero for it would be a lie.
  Map<String, Object?> toPayload() => <String, Object?>{
        'class_room_id': classRoomId,
        'subject_id': subjectId,
        'grades': <Object?>[
          for (final entry in scores.entries)
            <String, Object?>{
              'grade_component_id': gradeItemId,
              'student_user_id': entry.key,
              'score': double.parse(entry.value),
              if (versions[entry.key] != null) 'version': versions[entry.key],
            },
        ],
      };

  static bool _isValid(String value, double? maxScore) {
    final parsed = double.tryParse(value);
    if (parsed == null || parsed.isNaN || parsed < 0) return false;

    return maxScore == null || parsed <= maxScore;
  }
}
