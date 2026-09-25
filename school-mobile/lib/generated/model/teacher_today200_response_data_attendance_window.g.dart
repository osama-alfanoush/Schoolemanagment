// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_today200_response_data_attendance_window.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherToday200ResponseDataAttendanceWindow
    extends TeacherToday200ResponseDataAttendanceWindow {
  @override
  final bool open;
  @override
  final int hours;
  @override
  final String closesAt;
  @override
  final String? reason;

  factory _$TeacherToday200ResponseDataAttendanceWindow([
    void Function(TeacherToday200ResponseDataAttendanceWindowBuilder)? updates,
  ]) => (TeacherToday200ResponseDataAttendanceWindowBuilder()..update(updates))
      ._build();

  _$TeacherToday200ResponseDataAttendanceWindow._({
    required this.open,
    required this.hours,
    required this.closesAt,
    this.reason,
  }) : super._();
  @override
  TeacherToday200ResponseDataAttendanceWindow rebuild(
    void Function(TeacherToday200ResponseDataAttendanceWindowBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherToday200ResponseDataAttendanceWindowBuilder toBuilder() =>
      TeacherToday200ResponseDataAttendanceWindowBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherToday200ResponseDataAttendanceWindow &&
        open == other.open &&
        hours == other.hours &&
        closesAt == other.closesAt &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, open.hashCode);
    _$hash = $jc(_$hash, hours.hashCode);
    _$hash = $jc(_$hash, closesAt.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'TeacherToday200ResponseDataAttendanceWindow',
          )
          ..add('open', open)
          ..add('hours', hours)
          ..add('closesAt', closesAt)
          ..add('reason', reason))
        .toString();
  }
}

class TeacherToday200ResponseDataAttendanceWindowBuilder
    implements
        Builder<
          TeacherToday200ResponseDataAttendanceWindow,
          TeacherToday200ResponseDataAttendanceWindowBuilder
        > {
  _$TeacherToday200ResponseDataAttendanceWindow? _$v;

  bool? _open;
  bool? get open => _$this._open;
  set open(bool? open) => _$this._open = open;

  int? _hours;
  int? get hours => _$this._hours;
  set hours(int? hours) => _$this._hours = hours;

  String? _closesAt;
  String? get closesAt => _$this._closesAt;
  set closesAt(String? closesAt) => _$this._closesAt = closesAt;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  TeacherToday200ResponseDataAttendanceWindowBuilder() {
    TeacherToday200ResponseDataAttendanceWindow._defaults(this);
  }

  TeacherToday200ResponseDataAttendanceWindowBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _open = $v.open;
      _hours = $v.hours;
      _closesAt = $v.closesAt;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherToday200ResponseDataAttendanceWindow other) {
    _$v = other as _$TeacherToday200ResponseDataAttendanceWindow;
  }

  @override
  void update(
    void Function(TeacherToday200ResponseDataAttendanceWindowBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherToday200ResponseDataAttendanceWindow build() => _build();

  _$TeacherToday200ResponseDataAttendanceWindow _build() {
    final _$result =
        _$v ??
        _$TeacherToday200ResponseDataAttendanceWindow._(
          open: BuiltValueNullFieldError.checkNotNull(
            open,
            r'TeacherToday200ResponseDataAttendanceWindow',
            'open',
          ),
          hours: BuiltValueNullFieldError.checkNotNull(
            hours,
            r'TeacherToday200ResponseDataAttendanceWindow',
            'hours',
          ),
          closesAt: BuiltValueNullFieldError.checkNotNull(
            closesAt,
            r'TeacherToday200ResponseDataAttendanceWindow',
            'closesAt',
          ),
          reason: reason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
