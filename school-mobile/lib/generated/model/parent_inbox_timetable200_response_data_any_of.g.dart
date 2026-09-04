// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_timetable200_response_data_any_of.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxTimetable200ResponseDataAnyOf
    extends ParentInboxTimetable200ResponseDataAnyOf {
  @override
  final int studentUserId;
  @override
  final String today;
  @override
  final String days;

  factory _$ParentInboxTimetable200ResponseDataAnyOf([
    void Function(ParentInboxTimetable200ResponseDataAnyOfBuilder)? updates,
  ]) => (ParentInboxTimetable200ResponseDataAnyOfBuilder()..update(updates))
      ._build();

  _$ParentInboxTimetable200ResponseDataAnyOf._({
    required this.studentUserId,
    required this.today,
    required this.days,
  }) : super._();
  @override
  ParentInboxTimetable200ResponseDataAnyOf rebuild(
    void Function(ParentInboxTimetable200ResponseDataAnyOfBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxTimetable200ResponseDataAnyOfBuilder toBuilder() =>
      ParentInboxTimetable200ResponseDataAnyOfBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxTimetable200ResponseDataAnyOf &&
        studentUserId == other.studentUserId &&
        today == other.today &&
        days == other.days;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, today.hashCode);
    _$hash = $jc(_$hash, days.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ParentInboxTimetable200ResponseDataAnyOf',
          )
          ..add('studentUserId', studentUserId)
          ..add('today', today)
          ..add('days', days))
        .toString();
  }
}

class ParentInboxTimetable200ResponseDataAnyOfBuilder
    implements
        Builder<
          ParentInboxTimetable200ResponseDataAnyOf,
          ParentInboxTimetable200ResponseDataAnyOfBuilder
        > {
  _$ParentInboxTimetable200ResponseDataAnyOf? _$v;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  String? _today;
  String? get today => _$this._today;
  set today(String? today) => _$this._today = today;

  String? _days;
  String? get days => _$this._days;
  set days(String? days) => _$this._days = days;

  ParentInboxTimetable200ResponseDataAnyOfBuilder() {
    ParentInboxTimetable200ResponseDataAnyOf._defaults(this);
  }

  ParentInboxTimetable200ResponseDataAnyOfBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentUserId = $v.studentUserId;
      _today = $v.today;
      _days = $v.days;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxTimetable200ResponseDataAnyOf other) {
    _$v = other as _$ParentInboxTimetable200ResponseDataAnyOf;
  }

  @override
  void update(
    void Function(ParentInboxTimetable200ResponseDataAnyOfBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxTimetable200ResponseDataAnyOf build() => _build();

  _$ParentInboxTimetable200ResponseDataAnyOf _build() {
    final _$result =
        _$v ??
        _$ParentInboxTimetable200ResponseDataAnyOf._(
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'ParentInboxTimetable200ResponseDataAnyOf',
            'studentUserId',
          ),
          today: BuiltValueNullFieldError.checkNotNull(
            today,
            r'ParentInboxTimetable200ResponseDataAnyOf',
            'today',
          ),
          days: BuiltValueNullFieldError.checkNotNull(
            days,
            r'ParentInboxTimetable200ResponseDataAnyOf',
            'days',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
