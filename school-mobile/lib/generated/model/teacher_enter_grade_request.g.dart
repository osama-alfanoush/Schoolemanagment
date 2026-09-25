// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_enter_grade_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherEnterGradeRequest extends TeacherEnterGradeRequest {
  @override
  final int studentUserId;
  @override
  final int gradeComponentId;
  @override
  final num score;
  @override
  final int? version;
  @override
  final String? reason;

  factory _$TeacherEnterGradeRequest([
    void Function(TeacherEnterGradeRequestBuilder)? updates,
  ]) => (TeacherEnterGradeRequestBuilder()..update(updates))._build();

  _$TeacherEnterGradeRequest._({
    required this.studentUserId,
    required this.gradeComponentId,
    required this.score,
    this.version,
    this.reason,
  }) : super._();
  @override
  TeacherEnterGradeRequest rebuild(
    void Function(TeacherEnterGradeRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherEnterGradeRequestBuilder toBuilder() =>
      TeacherEnterGradeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherEnterGradeRequest &&
        studentUserId == other.studentUserId &&
        gradeComponentId == other.gradeComponentId &&
        score == other.score &&
        version == other.version &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, gradeComponentId.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherEnterGradeRequest')
          ..add('studentUserId', studentUserId)
          ..add('gradeComponentId', gradeComponentId)
          ..add('score', score)
          ..add('version', version)
          ..add('reason', reason))
        .toString();
  }
}

class TeacherEnterGradeRequestBuilder
    implements
        Builder<TeacherEnterGradeRequest, TeacherEnterGradeRequestBuilder> {
  _$TeacherEnterGradeRequest? _$v;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  int? _gradeComponentId;
  int? get gradeComponentId => _$this._gradeComponentId;
  set gradeComponentId(int? gradeComponentId) =>
      _$this._gradeComponentId = gradeComponentId;

  num? _score;
  num? get score => _$this._score;
  set score(num? score) => _$this._score = score;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  TeacherEnterGradeRequestBuilder() {
    TeacherEnterGradeRequest._defaults(this);
  }

  TeacherEnterGradeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentUserId = $v.studentUserId;
      _gradeComponentId = $v.gradeComponentId;
      _score = $v.score;
      _version = $v.version;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherEnterGradeRequest other) {
    _$v = other as _$TeacherEnterGradeRequest;
  }

  @override
  void update(void Function(TeacherEnterGradeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherEnterGradeRequest build() => _build();

  _$TeacherEnterGradeRequest _build() {
    final _$result =
        _$v ??
        _$TeacherEnterGradeRequest._(
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'TeacherEnterGradeRequest',
            'studentUserId',
          ),
          gradeComponentId: BuiltValueNullFieldError.checkNotNull(
            gradeComponentId,
            r'TeacherEnterGradeRequest',
            'gradeComponentId',
          ),
          score: BuiltValueNullFieldError.checkNotNull(
            score,
            r'TeacherEnterGradeRequest',
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
