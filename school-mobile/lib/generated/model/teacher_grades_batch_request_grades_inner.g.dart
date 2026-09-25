// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_grades_batch_request_grades_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherGradesBatchRequestGradesInner
    extends TeacherGradesBatchRequestGradesInner {
  @override
  final int gradeComponentId;
  @override
  final int studentUserId;
  @override
  final num score;
  @override
  final int? version;
  @override
  final String? reason;

  factory _$TeacherGradesBatchRequestGradesInner([
    void Function(TeacherGradesBatchRequestGradesInnerBuilder)? updates,
  ]) =>
      (TeacherGradesBatchRequestGradesInnerBuilder()..update(updates))._build();

  _$TeacherGradesBatchRequestGradesInner._({
    required this.gradeComponentId,
    required this.studentUserId,
    required this.score,
    this.version,
    this.reason,
  }) : super._();
  @override
  TeacherGradesBatchRequestGradesInner rebuild(
    void Function(TeacherGradesBatchRequestGradesInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherGradesBatchRequestGradesInnerBuilder toBuilder() =>
      TeacherGradesBatchRequestGradesInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherGradesBatchRequestGradesInner &&
        gradeComponentId == other.gradeComponentId &&
        studentUserId == other.studentUserId &&
        score == other.score &&
        version == other.version &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, gradeComponentId.hashCode);
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherGradesBatchRequestGradesInner')
          ..add('gradeComponentId', gradeComponentId)
          ..add('studentUserId', studentUserId)
          ..add('score', score)
          ..add('version', version)
          ..add('reason', reason))
        .toString();
  }
}

class TeacherGradesBatchRequestGradesInnerBuilder
    implements
        Builder<
          TeacherGradesBatchRequestGradesInner,
          TeacherGradesBatchRequestGradesInnerBuilder
        > {
  _$TeacherGradesBatchRequestGradesInner? _$v;

  int? _gradeComponentId;
  int? get gradeComponentId => _$this._gradeComponentId;
  set gradeComponentId(int? gradeComponentId) =>
      _$this._gradeComponentId = gradeComponentId;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  num? _score;
  num? get score => _$this._score;
  set score(num? score) => _$this._score = score;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  TeacherGradesBatchRequestGradesInnerBuilder() {
    TeacherGradesBatchRequestGradesInner._defaults(this);
  }

  TeacherGradesBatchRequestGradesInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _gradeComponentId = $v.gradeComponentId;
      _studentUserId = $v.studentUserId;
      _score = $v.score;
      _version = $v.version;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherGradesBatchRequestGradesInner other) {
    _$v = other as _$TeacherGradesBatchRequestGradesInner;
  }

  @override
  void update(
    void Function(TeacherGradesBatchRequestGradesInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherGradesBatchRequestGradesInner build() => _build();

  _$TeacherGradesBatchRequestGradesInner _build() {
    final _$result =
        _$v ??
        _$TeacherGradesBatchRequestGradesInner._(
          gradeComponentId: BuiltValueNullFieldError.checkNotNull(
            gradeComponentId,
            r'TeacherGradesBatchRequestGradesInner',
            'gradeComponentId',
          ),
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'TeacherGradesBatchRequestGradesInner',
            'studentUserId',
          ),
          score: BuiltValueNullFieldError.checkNotNull(
            score,
            r'TeacherGradesBatchRequestGradesInner',
            'score',
          ),
          version: version,
          reason: reason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
