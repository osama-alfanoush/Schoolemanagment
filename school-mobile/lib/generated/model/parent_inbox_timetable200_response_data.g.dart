// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_timetable200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxTimetable200ResponseData
    extends ParentInboxTimetable200ResponseData {
  @override
  final AnyOf anyOf;

  factory _$ParentInboxTimetable200ResponseData([
    void Function(ParentInboxTimetable200ResponseDataBuilder)? updates,
  ]) =>
      (ParentInboxTimetable200ResponseDataBuilder()..update(updates))._build();

  _$ParentInboxTimetable200ResponseData._({required this.anyOf}) : super._();
  @override
  ParentInboxTimetable200ResponseData rebuild(
    void Function(ParentInboxTimetable200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxTimetable200ResponseDataBuilder toBuilder() =>
      ParentInboxTimetable200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxTimetable200ResponseData && anyOf == other.anyOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, anyOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ParentInboxTimetable200ResponseData',
    )..add('anyOf', anyOf)).toString();
  }
}

class ParentInboxTimetable200ResponseDataBuilder
    implements
        Builder<
          ParentInboxTimetable200ResponseData,
          ParentInboxTimetable200ResponseDataBuilder
        > {
  _$ParentInboxTimetable200ResponseData? _$v;

  AnyOf? _anyOf;
  AnyOf? get anyOf => _$this._anyOf;
  set anyOf(AnyOf? anyOf) => _$this._anyOf = anyOf;

  ParentInboxTimetable200ResponseDataBuilder() {
    ParentInboxTimetable200ResponseData._defaults(this);
  }

  ParentInboxTimetable200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _anyOf = $v.anyOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxTimetable200ResponseData other) {
    _$v = other as _$ParentInboxTimetable200ResponseData;
  }

  @override
  void update(
    void Function(ParentInboxTimetable200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxTimetable200ResponseData build() => _build();

  _$ParentInboxTimetable200ResponseData _build() {
    final _$result =
        _$v ??
        _$ParentInboxTimetable200ResponseData._(
          anyOf: BuiltValueNullFieldError.checkNotNull(
            anyOf,
            r'ParentInboxTimetable200ResponseData',
            'anyOf',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
