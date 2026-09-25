// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_gradebook200_response_data_students_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherGradebook200ResponseDataStudentsInner
    extends TeacherGradebook200ResponseDataStudentsInner {
  @override
  final int studentUserId;
  @override
  final String name;
  @override
  final StudentHome200ResponseDataAttendance grades;

  factory _$TeacherGradebook200ResponseDataStudentsInner([
    void Function(TeacherGradebook200ResponseDataStudentsInnerBuilder)? updates,
  ]) => (TeacherGradebook200ResponseDataStudentsInnerBuilder()..update(updates))
      ._build();

  _$TeacherGradebook200ResponseDataStudentsInner._({
    required this.studentUserId,
    required this.name,
    required this.grades,
  }) : super._();
  @override
  TeacherGradebook200ResponseDataStudentsInner rebuild(
    void Function(TeacherGradebook200ResponseDataStudentsInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherGradebook200ResponseDataStudentsInnerBuilder toBuilder() =>
      TeacherGradebook200ResponseDataStudentsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherGradebook200ResponseDataStudentsInner &&
        studentUserId == other.studentUserId &&
        name == other.name &&
        grades == other.grades;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, grades.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'TeacherGradebook200ResponseDataStudentsInner',
          )
          ..add('studentUserId', studentUserId)
          ..add('name', name)
          ..add('grades', grades))
        .toString();
  }
}

class TeacherGradebook200ResponseDataStudentsInnerBuilder
    implements
        Builder<
          TeacherGradebook200ResponseDataStudentsInner,
          TeacherGradebook200ResponseDataStudentsInnerBuilder
        > {
  _$TeacherGradebook200ResponseDataStudentsInner? _$v;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  StudentHome200ResponseDataAttendanceBuilder? _grades;
  StudentHome200ResponseDataAttendanceBuilder get grades =>
      _$this._grades ??= StudentHome200ResponseDataAttendanceBuilder();
  set grades(StudentHome200ResponseDataAttendanceBuilder? grades) =>
      _$this._grades = grades;

  TeacherGradebook200ResponseDataStudentsInnerBuilder() {
    TeacherGradebook200ResponseDataStudentsInner._defaults(this);
  }

  TeacherGradebook200ResponseDataStudentsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentUserId = $v.studentUserId;
      _name = $v.name;
      _grades = $v.grades.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherGradebook200ResponseDataStudentsInner other) {
    _$v = other as _$TeacherGradebook200ResponseDataStudentsInner;
  }

  @override
  void update(
    void Function(TeacherGradebook200ResponseDataStudentsInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherGradebook200ResponseDataStudentsInner build() => _build();

  _$TeacherGradebook200ResponseDataStudentsInner _build() {
    _$TeacherGradebook200ResponseDataStudentsInner _$result;
    try {
      _$result =
          _$v ??
          _$TeacherGradebook200ResponseDataStudentsInner._(
            studentUserId: BuiltValueNullFieldError.checkNotNull(
              studentUserId,
              r'TeacherGradebook200ResponseDataStudentsInner',
              'studentUserId',
            ),
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'TeacherGradebook200ResponseDataStudentsInner',
              'name',
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
          r'TeacherGradebook200ResponseDataStudentsInner',
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
