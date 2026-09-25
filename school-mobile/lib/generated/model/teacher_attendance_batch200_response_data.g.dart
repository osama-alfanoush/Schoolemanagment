// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_attendance_batch200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherAttendanceBatch200ResponseData
    extends TeacherAttendanceBatch200ResponseData {
  @override
  final int batchId;
  @override
  final int classRoomId;
  @override
  final String date;
  @override
  final int recordCount;
  @override
  final String? committedAt;
  @override
  final TeacherToday200ResponseDataAttendanceWindow attendanceWindow;

  factory _$TeacherAttendanceBatch200ResponseData([
    void Function(TeacherAttendanceBatch200ResponseDataBuilder)? updates,
  ]) => (TeacherAttendanceBatch200ResponseDataBuilder()..update(updates))
      ._build();

  _$TeacherAttendanceBatch200ResponseData._({
    required this.batchId,
    required this.classRoomId,
    required this.date,
    required this.recordCount,
    this.committedAt,
    required this.attendanceWindow,
  }) : super._();
  @override
  TeacherAttendanceBatch200ResponseData rebuild(
    void Function(TeacherAttendanceBatch200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherAttendanceBatch200ResponseDataBuilder toBuilder() =>
      TeacherAttendanceBatch200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherAttendanceBatch200ResponseData &&
        batchId == other.batchId &&
        classRoomId == other.classRoomId &&
        date == other.date &&
        recordCount == other.recordCount &&
        committedAt == other.committedAt &&
        attendanceWindow == other.attendanceWindow;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, batchId.hashCode);
    _$hash = $jc(_$hash, classRoomId.hashCode);
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, recordCount.hashCode);
    _$hash = $jc(_$hash, committedAt.hashCode);
    _$hash = $jc(_$hash, attendanceWindow.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'TeacherAttendanceBatch200ResponseData',
          )
          ..add('batchId', batchId)
          ..add('classRoomId', classRoomId)
          ..add('date', date)
          ..add('recordCount', recordCount)
          ..add('committedAt', committedAt)
          ..add('attendanceWindow', attendanceWindow))
        .toString();
  }
}

class TeacherAttendanceBatch200ResponseDataBuilder
    implements
        Builder<
          TeacherAttendanceBatch200ResponseData,
          TeacherAttendanceBatch200ResponseDataBuilder
        > {
  _$TeacherAttendanceBatch200ResponseData? _$v;

  int? _batchId;
  int? get batchId => _$this._batchId;
  set batchId(int? batchId) => _$this._batchId = batchId;

  int? _classRoomId;
  int? get classRoomId => _$this._classRoomId;
  set classRoomId(int? classRoomId) => _$this._classRoomId = classRoomId;

  String? _date;
  String? get date => _$this._date;
  set date(String? date) => _$this._date = date;

  int? _recordCount;
  int? get recordCount => _$this._recordCount;
  set recordCount(int? recordCount) => _$this._recordCount = recordCount;

  String? _committedAt;
  String? get committedAt => _$this._committedAt;
  set committedAt(String? committedAt) => _$this._committedAt = committedAt;

  TeacherToday200ResponseDataAttendanceWindowBuilder? _attendanceWindow;
  TeacherToday200ResponseDataAttendanceWindowBuilder get attendanceWindow =>
      _$this._attendanceWindow ??=
          TeacherToday200ResponseDataAttendanceWindowBuilder();
  set attendanceWindow(
    TeacherToday200ResponseDataAttendanceWindowBuilder? attendanceWindow,
  ) => _$this._attendanceWindow = attendanceWindow;

  TeacherAttendanceBatch200ResponseDataBuilder() {
    TeacherAttendanceBatch200ResponseData._defaults(this);
  }

  TeacherAttendanceBatch200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _batchId = $v.batchId;
      _classRoomId = $v.classRoomId;
      _date = $v.date;
      _recordCount = $v.recordCount;
      _committedAt = $v.committedAt;
      _attendanceWindow = $v.attendanceWindow.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherAttendanceBatch200ResponseData other) {
    _$v = other as _$TeacherAttendanceBatch200ResponseData;
  }

  @override
  void update(
    void Function(TeacherAttendanceBatch200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherAttendanceBatch200ResponseData build() => _build();

  _$TeacherAttendanceBatch200ResponseData _build() {
    _$TeacherAttendanceBatch200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$TeacherAttendanceBatch200ResponseData._(
            batchId: BuiltValueNullFieldError.checkNotNull(
              batchId,
              r'TeacherAttendanceBatch200ResponseData',
              'batchId',
            ),
            classRoomId: BuiltValueNullFieldError.checkNotNull(
              classRoomId,
              r'TeacherAttendanceBatch200ResponseData',
              'classRoomId',
            ),
            date: BuiltValueNullFieldError.checkNotNull(
              date,
              r'TeacherAttendanceBatch200ResponseData',
              'date',
            ),
            recordCount: BuiltValueNullFieldError.checkNotNull(
              recordCount,
              r'TeacherAttendanceBatch200ResponseData',
              'recordCount',
            ),
            committedAt: committedAt,
            attendanceWindow: attendanceWindow.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attendanceWindow';
        attendanceWindow.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherAttendanceBatch200ResponseData',
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
