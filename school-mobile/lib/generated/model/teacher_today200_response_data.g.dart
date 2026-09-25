// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_today200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherToday200ResponseData extends TeacherToday200ResponseData {
  @override
  final String date;
  @override
  final TeacherToday200ResponseDataAttendanceWindow attendanceWindow;
  @override
  final BuiltList<TeacherToday200ResponseDataPeriodsInner> periods;
  @override
  final BuiltList<String> classes;

  factory _$TeacherToday200ResponseData([
    void Function(TeacherToday200ResponseDataBuilder)? updates,
  ]) => (TeacherToday200ResponseDataBuilder()..update(updates))._build();

  _$TeacherToday200ResponseData._({
    required this.date,
    required this.attendanceWindow,
    required this.periods,
    required this.classes,
  }) : super._();
  @override
  TeacherToday200ResponseData rebuild(
    void Function(TeacherToday200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherToday200ResponseDataBuilder toBuilder() =>
      TeacherToday200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherToday200ResponseData &&
        date == other.date &&
        attendanceWindow == other.attendanceWindow &&
        periods == other.periods &&
        classes == other.classes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, date.hashCode);
    _$hash = $jc(_$hash, attendanceWindow.hashCode);
    _$hash = $jc(_$hash, periods.hashCode);
    _$hash = $jc(_$hash, classes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TeacherToday200ResponseData')
          ..add('date', date)
          ..add('attendanceWindow', attendanceWindow)
          ..add('periods', periods)
          ..add('classes', classes))
        .toString();
  }
}

class TeacherToday200ResponseDataBuilder
    implements
        Builder<
          TeacherToday200ResponseData,
          TeacherToday200ResponseDataBuilder
        > {
  _$TeacherToday200ResponseData? _$v;

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

  ListBuilder<TeacherToday200ResponseDataPeriodsInner>? _periods;
  ListBuilder<TeacherToday200ResponseDataPeriodsInner> get periods =>
      _$this._periods ??=
          ListBuilder<TeacherToday200ResponseDataPeriodsInner>();
  set periods(ListBuilder<TeacherToday200ResponseDataPeriodsInner>? periods) =>
      _$this._periods = periods;

  ListBuilder<String>? _classes;
  ListBuilder<String> get classes => _$this._classes ??= ListBuilder<String>();
  set classes(ListBuilder<String>? classes) => _$this._classes = classes;

  TeacherToday200ResponseDataBuilder() {
    TeacherToday200ResponseData._defaults(this);
  }

  TeacherToday200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _date = $v.date;
      _attendanceWindow = $v.attendanceWindow.toBuilder();
      _periods = $v.periods.toBuilder();
      _classes = $v.classes.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherToday200ResponseData other) {
    _$v = other as _$TeacherToday200ResponseData;
  }

  @override
  void update(void Function(TeacherToday200ResponseDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherToday200ResponseData build() => _build();

  _$TeacherToday200ResponseData _build() {
    _$TeacherToday200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$TeacherToday200ResponseData._(
            date: BuiltValueNullFieldError.checkNotNull(
              date,
              r'TeacherToday200ResponseData',
              'date',
            ),
            attendanceWindow: attendanceWindow.build(),
            periods: periods.build(),
            classes: classes.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attendanceWindow';
        attendanceWindow.build();
        _$failedField = 'periods';
        periods.build();
        _$failedField = 'classes';
        classes.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherToday200ResponseData',
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
