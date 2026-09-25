// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_grades_batch_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherGradesBatchRequest extends TeacherGradesBatchRequest {
  @override
  final String idempotencyKey;
  @override
  final int classRoomId;
  @override
  final int subjectId;
  @override
  final BuiltList<TeacherGradesBatchRequestGradesInner> grades;

  factory _$TeacherGradesBatchRequest([
    void Function(TeacherGradesBatchRequestBuilder)? updates,
  ]) => (TeacherGradesBatchRequestBuilder()..update(updates))._build();

  _$TeacherGradesBatchRequest._({
    required this.idempotencyKey,
    required this.classRoomId,
    required this.subjectId,
    required this.grades,
  }) : super._();
  @override
  TeacherGradesBatchRequest rebuild(
    void Function(TeacherGradesBatchRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherGradesBatchRequestBuilder toBuilder() =>
      TeacherGradesBatchRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherGradesBatchRequest &&
        idempotencyKey == other.idempotencyKey &&
        classRoomId == other.classRoomId &&
        subjectId == other.subjectId &&
        grades == other.grades;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, subjectId.hashCode);
    _$hash = $jc(_$hash, grades.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherGradesBatchRequest')
          ..add('idempotencyKey', idempotencyKey)
          ..add('classRoomId', classRoomId)
          ..add('subjectId', subjectId)
          ..add('grades', grades))
        .toString();
  }
}

class TeacherGradesBatchRequestBuilder
    implements
        Builder<TeacherGradesBatchRequest, TeacherGradesBatchRequestBuilder> {
  _$TeacherGradesBatchRequest? _$v;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  int? _classRoomId;
  int? get classRoomId => _$this._classRoomId;
  set classRoomId(int? classRoomId) => _$this._classRoomId = classRoomId;

  int? _subjectId;
  int? get subjectId => _$this._subjectId;
  set subjectId(int? subjectId) => _$this._subjectId = subjectId;

  ListBuilder<TeacherGradesBatchRequestGradesInner>? _grades;
  ListBuilder<TeacherGradesBatchRequestGradesInner> get grades =>
      _$this._grades ??= ListBuilder<TeacherGradesBatchRequestGradesInner>();
  set grades(ListBuilder<TeacherGradesBatchRequestGradesInner>? grades) =>
      _$this._grades = grades;

  TeacherGradesBatchRequestBuilder() {
    TeacherGradesBatchRequest._defaults(this);
  }

  TeacherGradesBatchRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _idempotencyKey = $v.idempotencyKey;
      _classRoomId = $v.classRoomId;
      _subjectId = $v.subjectId;
      _grades = $v.grades.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherGradesBatchRequest other) {
    _$v = other as _$TeacherGradesBatchRequest;
  }

  @override
  void update(void Function(TeacherGradesBatchRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherGradesBatchRequest build() => _build();

  _$TeacherGradesBatchRequest _build() {
    _$TeacherGradesBatchRequest _$result;
    try {
      _$result =
          _$v ??
          _$TeacherGradesBatchRequest._(
            idempotencyKey: BuiltValueNullFieldError.checkNotNull(
              idempotencyKey,
              r'TeacherGradesBatchRequest',
              'idempotencyKey',
            ),
            classRoomId: BuiltValueNullFieldError.checkNotNull(
              classRoomId,
              r'TeacherGradesBatchRequest',
              'classRoomId',
            ),
            subjectId: BuiltValueNullFieldError.checkNotNull(
              subjectId,
              r'TeacherGradesBatchRequest',
              'subjectId',
            ),
            grades: grades.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'grades';
        grades.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherGradesBatchRequest',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
