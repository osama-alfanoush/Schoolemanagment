// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_child_report_card200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentChildReportCard200Response
    extends ParentChildReportCard200Response {
  @override
  final User? student;
  @override
  final ParentChildReportCard200ResponseGrades grades;
  @override
  final String generatedAt;

  factory _$ParentChildReportCard200Response([
    void Function(ParentChildReportCard200ResponseBuilder)? updates,
  ]) => (ParentChildReportCard200ResponseBuilder()..update(updates))._build();

  _$ParentChildReportCard200Response._({
    this.student,
    required this.grades,
    required this.generatedAt,
  }) : super._();
  @override
  ParentChildReportCard200Response rebuild(
    void Function(ParentChildReportCard200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentChildReportCard200ResponseBuilder toBuilder() =>
      ParentChildReportCard200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentChildReportCard200Response &&
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
    return (newBuiltValueToStringHelper(r'ParentChildReportCard200Response')
          ..add('student', student)
          ..add('grades', grades)
          ..add('generatedAt', generatedAt))
        .toString();
  }
}

class ParentChildReportCard200ResponseBuilder
    implements
        Builder<
          ParentChildReportCard200Response,
          ParentChildReportCard200ResponseBuilder
        > {
  _$ParentChildReportCard200Response? _$v;

  UserBuilder? _student;
  UserBuilder get student => _$this._student ??= UserBuilder();
  set student(UserBuilder? student) => _$this._student = student;

  ParentChildReportCard200ResponseGradesBuilder? _grades;
  ParentChildReportCard200ResponseGradesBuilder get grades =>
      _$this._grades ??= ParentChildReportCard200ResponseGradesBuilder();
  set grades(ParentChildReportCard200ResponseGradesBuilder? grades) =>
      _$this._grades = grades;

  String? _generatedAt;
  String? get generatedAt => _$this._generatedAt;
  set generatedAt(String? generatedAt) => _$this._generatedAt = generatedAt;

  ParentChildReportCard200ResponseBuilder() {
    ParentChildReportCard200Response._defaults(this);
  }

  ParentChildReportCard200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _student = $v.student?.toBuilder();
      _grades = $v.grades.toBuilder();
      _generatedAt = $v.generatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentChildReportCard200Response other) {
    _$v = other as _$ParentChildReportCard200Response;
  }

  @override
  void update(void Function(ParentChildReportCard200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentChildReportCard200Response build() => _build();

  _$ParentChildReportCard200Response _build() {
    _$ParentChildReportCard200Response _$result;
    try {
      _$result =
          _$v ??
          _$ParentChildReportCard200Response._(
            student: _student?.build(),
            grades: grades.build(),
            generatedAt: BuiltValueNullFieldError.checkNotNull(
              generatedAt,
              r'ParentChildReportCard200Response',
              'generatedAt',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'student';
        _student?.build();
        _$failedField = 'grades';
        grades.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentChildReportCard200Response',
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
