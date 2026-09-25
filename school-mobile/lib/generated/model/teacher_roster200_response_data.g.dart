// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_roster200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherRoster200ResponseData extends TeacherRoster200ResponseData {
  @override
  final int classRoomId;
  @override
  final String date;
  @override
  final TeacherToday200ResponseDataAttendanceWindow attendanceWindow;
  @override
  final BuiltList<TeacherRoster200ResponseDataStudentsInner> students;

  factory _$TeacherRoster200ResponseData([
    void Function(TeacherRoster200ResponseDataBuilder)? updates,
  ]) => (TeacherRoster200ResponseDataBuilder()..update(updates))._build();

  _$TeacherRoster200ResponseData._({
    required this.classRoomId,
    required this.date,
    required this.attendanceWindow,
    required this.students,
  }) : super._();
  @override
  TeacherRoster200ResponseData rebuild(
    void Function(TeacherRoster200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherRoster200ResponseDataBuilder toBuilder() =>
      TeacherRoster200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherRoster200ResponseData &&
        classRoomId == other.classRoomId &&
        date == other.date &&
        attendanceWindow == other.attendanceWindow &&
        students == other.students;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, attendanceWindow.hashCode);
    _$hash = $jc(_$hash, students.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherRoster200ResponseData')
          ..add('classRoomId', classRoomId)
          ..add('date', date)
          ..add('attendanceWindow', attendanceWindow)
          ..add('students', students))
        .toString();
  }
}

class TeacherRoster200ResponseDataBuilder
    implements
        Builder<
          TeacherRoster200ResponseData,
          TeacherRoster200ResponseDataBuilder
        > {
  _$TeacherRoster200ResponseData? _$v;

  int? _classRoomId;
  int? get classRoomId => _$this._classRoomId;
  set classRoomId(int? classRoomId) => _$this._classRoomId = classRoomId;

  String? _date;
  String? get date => _$this._date;
  set date(String? date) => _$this._date = date;

  TeacherToday200ResponseDataAttendanceWindowBuilder? _attendanceWindow;
  TeacherToday200ResponseDataAttendanceWindowBuilder get attendanceWindow =>
      _$this._attendanceWindow ??=
          TeacherToday200ResponseDataAttendanceWindowBuilder();
  set attendanceWindow(
    TeacherToday200ResponseDataAttendanceWindowBuilder? attendanceWindow,
  ) => _$this._attendanceWindow = attendanceWindow;

  ListBuilder<TeacherRoster200ResponseDataStudentsInner>? _students;
  ListBuilder<TeacherRoster200ResponseDataStudentsInner> get students =>
      _$this._students ??=
          ListBuilder<TeacherRoster200ResponseDataStudentsInner>();
  set students(
    ListBuilder<TeacherRoster200ResponseDataStudentsInner>? students,
  ) => _$this._students = students;

  TeacherRoster200ResponseDataBuilder() {
    TeacherRoster200ResponseData._defaults(this);
  }

  TeacherRoster200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _classRoomId = $v.classRoomId;
      _date = $v.date;
      _attendanceWindow = $v.attendanceWindow.toBuilder();
      _students = $v.students.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherRoster200ResponseData other) {
    _$v = other as _$TeacherRoster200ResponseData;
  }

  @override
  void update(void Function(TeacherRoster200ResponseDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherRoster200ResponseData build() => _build();

  _$TeacherRoster200ResponseData _build() {
    _$TeacherRoster200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$TeacherRoster200ResponseData._(
            classRoomId: BuiltValueNullFieldError.checkNotNull(
              classRoomId,
              r'TeacherRoster200ResponseData',
              'classRoomId',
            ),
            date: BuiltValueNullFieldError.checkNotNull(
              date,
              r'TeacherRoster200ResponseData',
              'date',
            ),
            attendanceWindow: attendanceWindow.build(),
            students: students.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attendanceWindow';
        attendanceWindow.build();
        _$failedField = 'students';
        students.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherRoster200ResponseData',
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
