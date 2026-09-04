// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_timetable200_response_data_any_of1.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxTimetable200ResponseDataAnyOf1
    extends ParentInboxTimetable200ResponseDataAnyOf1 {
  @override
  final int studentUserId;
  @override
  final BuiltList<String> days;

  factory _$ParentInboxTimetable200ResponseDataAnyOf1([
    void Function(ParentInboxTimetable200ResponseDataAnyOf1Builder)? updates,
  ]) => (ParentInboxTimetable200ResponseDataAnyOf1Builder()..update(updates))
      ._build();

  _$ParentInboxTimetable200ResponseDataAnyOf1._({
    required this.studentUserId,
    required this.days,
  }) : super._();
  @override
  ParentInboxTimetable200ResponseDataAnyOf1 rebuild(
    void Function(ParentInboxTimetable200ResponseDataAnyOf1Builder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxTimetable200ResponseDataAnyOf1Builder toBuilder() =>
      ParentInboxTimetable200ResponseDataAnyOf1Builder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxTimetable200ResponseDataAnyOf1 &&
        studentUserId == other.studentUserId &&
        days == other.days;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, days.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ParentInboxTimetable200ResponseDataAnyOf1',
          )
          ..add('studentUserId', studentUserId)
          ..add('days', days))
        .toString();
  }
}

class ParentInboxTimetable200ResponseDataAnyOf1Builder
    implements
        Builder<
          ParentInboxTimetable200ResponseDataAnyOf1,
          ParentInboxTimetable200ResponseDataAnyOf1Builder
        > {
  _$ParentInboxTimetable200ResponseDataAnyOf1? _$v;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  ListBuilder<String>? _days;
  ListBuilder<String> get days => _$this._days ??= ListBuilder<String>();
  set days(ListBuilder<String>? days) => _$this._days = days;

  ParentInboxTimetable200ResponseDataAnyOf1Builder() {
    ParentInboxTimetable200ResponseDataAnyOf1._defaults(this);
  }

  ParentInboxTimetable200ResponseDataAnyOf1Builder get _$this {
    final $v = _$v;
    if ($v != null) {
      _studentUserId = $v.studentUserId;
      _days = $v.days.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxTimetable200ResponseDataAnyOf1 other) {
    _$v = other as _$ParentInboxTimetable200ResponseDataAnyOf1;
  }

  @override
  void update(
    void Function(ParentInboxTimetable200ResponseDataAnyOf1Builder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxTimetable200ResponseDataAnyOf1 build() => _build();

  _$ParentInboxTimetable200ResponseDataAnyOf1 _build() {
    _$ParentInboxTimetable200ResponseDataAnyOf1 _$result;
    try {
      _$result =
          _$v ??
          _$ParentInboxTimetable200ResponseDataAnyOf1._(
            studentUserId: BuiltValueNullFieldError.checkNotNull(
              studentUserId,
              r'ParentInboxTimetable200ResponseDataAnyOf1',
              'studentUserId',
            ),
            days: days.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'days';
        days.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentInboxTimetable200ResponseDataAnyOf1',
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
