// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_academics_attendance200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentAcademicsAttendance200ResponseData
    extends ParentAcademicsAttendance200ResponseData {
  @override
  final int studentUserId;
  @override
  final String from;
  @override
  final String to;
  @override
  final int recordedDays;
  @override
  final int absentDays;
  @override
  final int lateDays;
  @override
  final int? presentPercent;
  @override
  final BuiltList<ParentAcademicsAttendance200ResponseDataDaysInner> days;

  factory _$ParentAcademicsAttendance200ResponseData([
    void Function(ParentAcademicsAttendance200ResponseDataBuilder)? updates,
  ]) => (ParentAcademicsAttendance200ResponseDataBuilder()..update(updates))
      ._build();

  _$ParentAcademicsAttendance200ResponseData._({
    required this.studentUserId,
    required this.from,
    required this.to,
    required this.recordedDays,
    required this.absentDays,
    required this.lateDays,
    this.presentPercent,
    required this.days,
  }) : super._();
  @override
  ParentAcademicsAttendance200ResponseData rebuild(
    void Function(ParentAcademicsAttendance200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentAcademicsAttendance200ResponseDataBuilder toBuilder() =>
      ParentAcademicsAttendance200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentAcademicsAttendance200ResponseData &&
        studentUserId == other.studentUserId &&
        from == other.from &&
        to == other.to &&
        recordedDays == other.recordedDays &&
        absentDays == other.absentDays &&
        lateDays == other.lateDays &&
        presentPercent == other.presentPercent &&
        days == other.days;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, from.hashCode);
    _$hash = $jc(_$hash, to.hashCode);
    _$hash = $jc(_$hash, recordedDays.hashCode);
    _$hash = $jc(_$hash, absentDays.hashCode);
    _$hash = $jc(_$hash, lateDays.hashCode);
    _$hash = $jc(_$hash, presentPercent.hashCode);
    _$hash = $jc(_$hash, days.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ParentAcademicsAttendance200ResponseData',
          )
          ..add('studentUserId', studentUserId)
          ..add('from', from)
          ..add('to', to)
          ..add('recordedDays', recordedDays)
          ..add('absentDays', absentDays)
          ..add('lateDays', lateDays)
          ..add('presentPercent', presentPercent)
          ..add('days', days))
        .toString();
  }
}

class ParentAcademicsAttendance200ResponseDataBuilder
    implements
        Builder<
          ParentAcademicsAttendance200ResponseData,
          ParentAcademicsAttendance200ResponseDataBuilder
        > {
  _$ParentAcademicsAttendance200ResponseData? _$v;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  String? _from;
  String? get from => _$this._from;
  set from(String? from) => _$this._from = from;

  String? _to;
  String? get to => _$this._to;
  set to(String? to) => _$this._to = to;

  int? _recordedDays;
  int? get recordedDays => _$this._recordedDays;
  set recordedDays(int? recordedDays) => _$this._recordedDays = recordedDays;

  int? _absentDays;
  int? get absentDays => _$this._absentDays;
  set absentDays(int? absentDays) => _$this._absentDays = absentDays;

  int? _lateDays;
  int? get lateDays => _$this._lateDays;
  set lateDays(int? lateDays) => _$this._lateDays = lateDays;

  int? _presentPercent;
  int? get presentPercent => _$this._presentPercent;
  set presentPercent(int? presentPercent) =>
      _$this._presentPercent = presentPercent;

  ListBuilder<ParentAcademicsAttendance200ResponseDataDaysInner>? _days;
  ListBuilder<ParentAcademicsAttendance200ResponseDataDaysInner> get days =>
      _$this._days ??=
          ListBuilder<ParentAcademicsAttendance200ResponseDataDaysInner>();
  set days(
    ListBuilder<ParentAcademicsAttendance200ResponseDataDaysInner>? days,
  ) => _$this._days = days;

  ParentAcademicsAttendance200ResponseDataBuilder() {
    ParentAcademicsAttendance200ResponseData._defaults(this);
  }

  ParentAcademicsAttendance200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentUserId = $v.studentUserId;
      _from = $v.from;
      _to = $v.to;
      _recordedDays = $v.recordedDays;
      _absentDays = $v.absentDays;
      _lateDays = $v.lateDays;
      _presentPercent = $v.presentPercent;
      _days = $v.days.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentAcademicsAttendance200ResponseData other) {
    _$v = other as _$ParentAcademicsAttendance200ResponseData;
  }

  @override
  void update(
    void Function(ParentAcademicsAttendance200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentAcademicsAttendance200ResponseData build() => _build();

  _$ParentAcademicsAttendance200ResponseData _build() {
    _$ParentAcademicsAttendance200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$ParentAcademicsAttendance200ResponseData._(
            studentUserId: BuiltValueNullFieldError.checkNotNull(
              studentUserId,
              r'ParentAcademicsAttendance200ResponseData',
              'studentUserId',
            ),
            from: BuiltValueNullFieldError.checkNotNull(
              from,
              r'ParentAcademicsAttendance200ResponseData',
              'from',
            ),
            to: BuiltValueNullFieldError.checkNotNull(
              to,
              r'ParentAcademicsAttendance200ResponseData',
              'to',
            ),
            recordedDays: BuiltValueNullFieldError.checkNotNull(
              recordedDays,
              r'ParentAcademicsAttendance200ResponseData',
              'recordedDays',
            ),
            absentDays: BuiltValueNullFieldError.checkNotNull(
              absentDays,
              r'ParentAcademicsAttendance200ResponseData',
              'absentDays',
            ),
            lateDays: BuiltValueNullFieldError.checkNotNull(
              lateDays,
              r'ParentAcademicsAttendance200ResponseData',
              'lateDays',
            ),
            presentPercent: presentPercent,
            days: days.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'days';
        days.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentAcademicsAttendance200ResponseData',
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
