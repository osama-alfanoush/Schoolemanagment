// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_report_card200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentReportCard200Response extends StudentReportCard200Response {
  @override
  final User? student;
  @override
  final JsonObject? grades;
  @override
  final String generatedAt;

  factory _$StudentReportCard200Response([
    void Function(StudentReportCard200ResponseBuilder)? updates,
  ]) => (StudentReportCard200ResponseBuilder()..update(updates))._build();

  _$StudentReportCard200Response._({
    this.student,
    this.grades,
    required this.generatedAt,
  }) : super._();
  @override
  StudentReportCard200Response rebuild(
    void Function(StudentReportCard200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StudentReportCard200ResponseBuilder toBuilder() =>
      StudentReportCard200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentReportCard200Response &&
        student == other.student &&
        grades == other.grades &&
        generatedAt == other.generatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, student.hashCode);
    _$hash = $jc(_$hash, grades.hashCode);
    _$hash = $jc(_$hash, generatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StudentReportCard200Response')
          ..add('student', student)
          ..add('grades', grades)
          ..add('generatedAt', generatedAt))
        .toString();
  }
}

class StudentReportCard200ResponseBuilder
    implements
        Builder<
          StudentReportCard200Response,
          StudentReportCard200ResponseBuilder
        > {
  _$StudentReportCard200Response? _$v;

  UserBuilder? _student;
  UserBuilder get student => _$this._student ??= UserBuilder();
  set student(UserBuilder? student) => _$this._student = student;

  JsonObject? _grades;
  JsonObject? get grades => _$this._grades;
  set grades(JsonObject? grades) => _$this._grades = grades;

  String? _generatedAt;
  String? get generatedAt => _$this._generatedAt;
  set generatedAt(String? generatedAt) => _$this._generatedAt = generatedAt;

  StudentReportCard200ResponseBuilder() {
    StudentReportCard200Response._defaults(this);
  }

  StudentReportCard200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _student = $v.student?.toBuilder();
      _grades = $v.grades;
      _generatedAt = $v.generatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentReportCard200Response other) {
    _$v = other as _$StudentReportCard200Response;
  }

  @override
  void update(void Function(StudentReportCard200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StudentReportCard200Response build() => _build();

  _$StudentReportCard200Response _build() {
    _$StudentReportCard200Response _$result;
    try {
      _$result =
          _$v ??
          _$StudentReportCard200Response._(
            student: _student?.build(),
            grades: grades,
            generatedAt: BuiltValueNullFieldError.checkNotNull(
              generatedAt,
              r'StudentReportCard200Response',
              'generatedAt',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'student';
        _student?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'StudentReportCard200Response',
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
