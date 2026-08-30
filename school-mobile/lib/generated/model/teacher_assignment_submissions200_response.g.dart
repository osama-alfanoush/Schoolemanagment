// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_assignment_submissions200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherAssignmentSubmissions200Response
    extends TeacherAssignmentSubmissions200Response {
  @override
  final Assignment assignment;
  @override
  final BuiltList<User> students;

  factory _$TeacherAssignmentSubmissions200Response([
    void Function(TeacherAssignmentSubmissions200ResponseBuilder)? updates,
  ]) => (TeacherAssignmentSubmissions200ResponseBuilder()..update(updates))
      ._build();

  _$TeacherAssignmentSubmissions200Response._({
    required this.assignment,
    required this.students,
  }) : super._();
  @override
  TeacherAssignmentSubmissions200Response rebuild(
    void Function(TeacherAssignmentSubmissions200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherAssignmentSubmissions200ResponseBuilder toBuilder() =>
      TeacherAssignmentSubmissions200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherAssignmentSubmissions200Response &&
        assignment == other.assignment &&
        students == other.students;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, assignment.hashCode);
    _$hash = $jc(_$hash, students.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'TeacherAssignmentSubmissions200Response',
          )
          ..add('assignment', assignment)
          ..add('students', students))
        .toString();
  }
}

class TeacherAssignmentSubmissions200ResponseBuilder
    implements
        Builder<
          TeacherAssignmentSubmissions200Response,
          TeacherAssignmentSubmissions200ResponseBuilder
        > {
  _$TeacherAssignmentSubmissions200Response? _$v;

  AssignmentBuilder? _assignment;
  AssignmentBuilder get assignment =>
      _$this._assignment ??= AssignmentBuilder();
  set assignment(AssignmentBuilder? assignment) =>
      _$this._assignment = assignment;

  ListBuilder<User>? _students;
  ListBuilder<User> get students => _$this._students ??= ListBuilder<User>();
  set students(ListBuilder<User>? students) => _$this._students = students;

  TeacherAssignmentSubmissions200ResponseBuilder() {
    TeacherAssignmentSubmissions200Response._defaults(this);
  }

  TeacherAssignmentSubmissions200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _assignment = $v.assignment.toBuilder();
      _students = $v.students.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherAssignmentSubmissions200Response other) {
    _$v = other as _$TeacherAssignmentSubmissions200Response;
  }

  @override
  void update(
    void Function(TeacherAssignmentSubmissions200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherAssignmentSubmissions200Response build() => _build();

  _$TeacherAssignmentSubmissions200Response _build() {
    _$TeacherAssignmentSubmissions200Response _$result;
    try {
      _$result =
          _$v ??
          _$TeacherAssignmentSubmissions200Response._(
            assignment: assignment.build(),
            students: students.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'assignment';
        assignment.build();
        _$failedField = 'students';
        students.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherAssignmentSubmissions200Response',
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
