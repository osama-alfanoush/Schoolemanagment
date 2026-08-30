// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_dashboard200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentDashboard200Response extends StudentDashboard200Response {
  @override
  final StudentDashboard200ResponseUpcomingAssignments upcomingAssignments;
  @override
  final BuiltList<Grade> recentGrades;
  @override
  final AttendanceRecord? todayAttendance;

  factory _$StudentDashboard200Response([
    void Function(StudentDashboard200ResponseBuilder)? updates,
  ]) => (StudentDashboard200ResponseBuilder()..update(updates))._build();

  _$StudentDashboard200Response._({
    required this.upcomingAssignments,
    required this.recentGrades,
    this.todayAttendance,
  }) : super._();
  @override
  StudentDashboard200Response rebuild(
    void Function(StudentDashboard200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StudentDashboard200ResponseBuilder toBuilder() =>
      StudentDashboard200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentDashboard200Response &&
        upcomingAssignments == other.upcomingAssignments &&
        recentGrades == other.recentGrades &&
        todayAttendance == other.todayAttendance;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, upcomingAssignments.hashCode);
    _$hash = $jc(_$hash, recentGrades.hashCode);
    _$hash = $jc(_$hash, todayAttendance.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StudentDashboard200Response')
          ..add('upcomingAssignments', upcomingAssignments)
          ..add('recentGrades', recentGrades)
          ..add('todayAttendance', todayAttendance))
        .toString();
  }
}

class StudentDashboard200ResponseBuilder
    implements
        Builder<
          StudentDashboard200Response,
          StudentDashboard200ResponseBuilder
        > {
  _$StudentDashboard200Response? _$v;

  StudentDashboard200ResponseUpcomingAssignmentsBuilder? _upcomingAssignments;
  StudentDashboard200ResponseUpcomingAssignmentsBuilder
  get upcomingAssignments => _$this._upcomingAssignments ??=
      StudentDashboard200ResponseUpcomingAssignmentsBuilder();
  set upcomingAssignments(
    StudentDashboard200ResponseUpcomingAssignmentsBuilder? upcomingAssignments,
  ) => _$this._upcomingAssignments = upcomingAssignments;

  ListBuilder<Grade>? _recentGrades;
  ListBuilder<Grade> get recentGrades =>
      _$this._recentGrades ??= ListBuilder<Grade>();
  set recentGrades(ListBuilder<Grade>? recentGrades) =>
      _$this._recentGrades = recentGrades;

  AttendanceRecordBuilder? _todayAttendance;
  AttendanceRecordBuilder get todayAttendance =>
      _$this._todayAttendance ??= AttendanceRecordBuilder();
  set todayAttendance(AttendanceRecordBuilder? todayAttendance) =>
      _$this._todayAttendance = todayAttendance;

  StudentDashboard200ResponseBuilder() {
    StudentDashboard200Response._defaults(this);
  }

  StudentDashboard200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _upcomingAssignments = $v.upcomingAssignments.toBuilder();
      _recentGrades = $v.recentGrades.toBuilder();
      _todayAttendance = $v.todayAttendance?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentDashboard200Response other) {
    _$v = other as _$StudentDashboard200Response;
  }

  @override
  void update(void Function(StudentDashboard200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StudentDashboard200Response build() => _build();

  _$StudentDashboard200Response _build() {
    _$StudentDashboard200Response _$result;
    try {
      _$result =
          _$v ??
          _$StudentDashboard200Response._(
            upcomingAssignments: upcomingAssignments.build(),
            recentGrades: recentGrades.build(),
            todayAttendance: _todayAttendance?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'upcomingAssignments';
        upcomingAssignments.build();
        _$failedField = 'recentGrades';
        recentGrades.build();
        _$failedField = 'todayAttendance';
        _todayAttendance?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'StudentDashboard200Response',
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
