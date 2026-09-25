// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_dashboard_kpis200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminDashboardKpis200ResponseData
    extends AdminDashboardKpis200ResponseData {
  @override
  final int students;
  @override
  final int teachers;
  @override
  final int staff;
  @override
  final JsonObject? academicYear;
  @override
  final num todayAttendanceRate;
  @override
  final int pendingHrRequests;
  @override
  final JsonObject? outstandingFees;

  factory _$AdminDashboardKpis200ResponseData([
    void Function(AdminDashboardKpis200ResponseDataBuilder)? updates,
  ]) => (AdminDashboardKpis200ResponseDataBuilder()..update(updates))._build();

  _$AdminDashboardKpis200ResponseData._({
    required this.students,
    required this.teachers,
    required this.staff,
    this.academicYear,
    required this.todayAttendanceRate,
    required this.pendingHrRequests,
    this.outstandingFees,
  }) : super._();
  @override
  AdminDashboardKpis200ResponseData rebuild(
    void Function(AdminDashboardKpis200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminDashboardKpis200ResponseDataBuilder toBuilder() =>
      AdminDashboardKpis200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminDashboardKpis200ResponseData &&
        students == other.students &&
        teachers == other.teachers &&
        staff == other.staff &&
        academicYear == other.academicYear &&
        todayAttendanceRate == other.todayAttendanceRate &&
        pendingHrRequests == other.pendingHrRequests &&
        outstandingFees == other.outstandingFees;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, students.hashCode);
    _$hash = $jc(_$hash, teachers.hashCode);
    _$hash = $jc(_$hash, staff.hashCode);
    _$hash = $jc(_$hash, academicYear.hashCode);
    _$hash = $jc(_$hash, todayAttendanceRate.hashCode);
    _$hash = $jc(_$hash, pendingHrRequests.hashCode);
    _$hash = $jc(_$hash, outstandingFees.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminDashboardKpis200ResponseData')
          ..add('students', students)
          ..add('teachers', teachers)
          ..add('staff', staff)
          ..add('academicYear', academicYear)
          ..add('todayAttendanceRate', todayAttendanceRate)
          ..add('pendingHrRequests', pendingHrRequests)
          ..add('outstandingFees', outstandingFees))
        .toString();
  }
}

class AdminDashboardKpis200ResponseDataBuilder
    implements
        Builder<
          AdminDashboardKpis200ResponseData,
          AdminDashboardKpis200ResponseDataBuilder
        > {
  _$AdminDashboardKpis200ResponseData? _$v;

  int? _students;
  int? get students => _$this._students;
  set students(int? students) => _$this._students = students;

  int? _teachers;
  int? get teachers => _$this._teachers;
  set teachers(int? teachers) => _$this._teachers = teachers;

  int? _staff;
  int? get staff => _$this._staff;
  set staff(int? staff) => _$this._staff = staff;

  JsonObject? _academicYear;
  JsonObject? get academicYear => _$this._academicYear;
  set academicYear(JsonObject? academicYear) =>
      _$this._academicYear = academicYear;

  num? _todayAttendanceRate;
  num? get todayAttendanceRate => _$this._todayAttendanceRate;
  set todayAttendanceRate(num? todayAttendanceRate) =>
      _$this._todayAttendanceRate = todayAttendanceRate;

  int? _pendingHrRequests;
  int? get pendingHrRequests => _$this._pendingHrRequests;
  set pendingHrRequests(int? pendingHrRequests) =>
      _$this._pendingHrRequests = pendingHrRequests;

  JsonObject? _outstandingFees;
  JsonObject? get outstandingFees => _$this._outstandingFees;
  set outstandingFees(JsonObject? outstandingFees) =>
      _$this._outstandingFees = outstandingFees;

  AdminDashboardKpis200ResponseDataBuilder() {
    AdminDashboardKpis200ResponseData._defaults(this);
  }

  AdminDashboardKpis200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _students = $v.students;
      _teachers = $v.teachers;
      _staff = $v.staff;
      _academicYear = $v.academicYear;
      _todayAttendanceRate = $v.todayAttendanceRate;
      _pendingHrRequests = $v.pendingHrRequests;
      _outstandingFees = $v.outstandingFees;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminDashboardKpis200ResponseData other) {
    _$v = other as _$AdminDashboardKpis200ResponseData;
  }

  @override
  void update(
    void Function(AdminDashboardKpis200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminDashboardKpis200ResponseData build() => _build();

  _$AdminDashboardKpis200ResponseData _build() {
    final _$result =
        _$v ??
        _$AdminDashboardKpis200ResponseData._(
          students: BuiltValueNullFieldError.checkNotNull(
            students,
            r'AdminDashboardKpis200ResponseData',
            'students',
          ),
          teachers: BuiltValueNullFieldError.checkNotNull(
            teachers,
            r'AdminDashboardKpis200ResponseData',
            'teachers',
          ),
          staff: BuiltValueNullFieldError.checkNotNull(
            staff,
            r'AdminDashboardKpis200ResponseData',
            'staff',
          ),
          academicYear: academicYear,
          todayAttendanceRate: BuiltValueNullFieldError.checkNotNull(
            todayAttendanceRate,
            r'AdminDashboardKpis200ResponseData',
            'todayAttendanceRate',
          ),
          pendingHrRequests: BuiltValueNullFieldError.checkNotNull(
            pendingHrRequests,
            r'AdminDashboardKpis200ResponseData',
            'pendingHrRequests',
          ),
          outstandingFees: outstandingFees,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
