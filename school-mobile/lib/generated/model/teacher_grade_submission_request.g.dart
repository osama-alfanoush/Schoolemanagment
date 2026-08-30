// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_grade_submission_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherGradeSubmissionRequest extends TeacherGradeSubmissionRequest {
  @override
  final num score;
  @override
  final String? feedback;

  factory _$TeacherGradeSubmissionRequest([
    void Function(TeacherGradeSubmissionRequestBuilder)? updates,
  ]) => (TeacherGradeSubmissionRequestBuilder()..update(updates))._build();

  _$TeacherGradeSubmissionRequest._({required this.score, this.feedback})
    : super._();
  @override
  TeacherGradeSubmissionRequest rebuild(
    void Function(TeacherGradeSubmissionRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherGradeSubmissionRequestBuilder toBuilder() =>
      TeacherGradeSubmissionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherGradeSubmissionRequest &&
        score == other.score &&
        feedback == other.feedback;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, feedback.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherGradeSubmissionRequest')
          ..add('score', score)
          ..add('feedback', feedback))
        .toString();
  }
}

class TeacherGradeSubmissionRequestBuilder
    implements
        Builder<
          TeacherGradeSubmissionRequest,
          TeacherGradeSubmissionRequestBuilder
        > {
  _$TeacherGradeSubmissionRequest? _$v;

  num? _score;
  num? get score => _$this._score;
  set score(num? score) => _$this._score = score;

  String? _feedback;
  String? get feedback => _$this._feedback;
  set feedback(String? feedback) => _$this._feedback = feedback;

  TeacherGradeSubmissionRequestBuilder() {
    TeacherGradeSubmissionRequest._defaults(this);
  }

  TeacherGradeSubmissionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _score = $v.score;
      _feedback = $v.feedback;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherGradeSubmissionRequest other) {
    _$v = other as _$TeacherGradeSubmissionRequest;
  }

  @override
  void update(void Function(TeacherGradeSubmissionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherGradeSubmissionRequest build() => _build();

  _$TeacherGradeSubmissionRequest _build() {
    final _$result =
        _$v ??
        _$TeacherGradeSubmissionRequest._(
          score: BuiltValueNullFieldError.checkNotNull(
            score,
            r'TeacherGradeSubmissionRequest',
            'score',
          ),
          feedback: feedback,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
