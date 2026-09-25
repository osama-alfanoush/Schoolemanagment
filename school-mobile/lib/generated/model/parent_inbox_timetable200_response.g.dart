// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_inbox_timetable200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentInboxTimetable200Response
    extends ParentInboxTimetable200Response {
  @override
  final ParentInboxTimetable200ResponseData data;

  factory _$ParentInboxTimetable200Response([
    void Function(ParentInboxTimetable200ResponseBuilder)? updates,
  ]) => (ParentInboxTimetable200ResponseBuilder()..update(updates))._build();

  _$ParentInboxTimetable200Response._({required this.data}) : super._();
  @override
  ParentInboxTimetable200Response rebuild(
    void Function(ParentInboxTimetable200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentInboxTimetable200ResponseBuilder toBuilder() =>
      ParentInboxTimetable200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentInboxTimetable200Response && data == other.data;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'ParentInboxTimetable200Response',
    )..add('data', data)).toString();
  }
}

class ParentInboxTimetable200ResponseBuilder
    implements
        Builder<
          ParentInboxTimetable200Response,
          ParentInboxTimetable200ResponseBuilder
        > {
  _$ParentInboxTimetable200Response? _$v;

  ParentInboxTimetable200ResponseDataBuilder? _data;
  ParentInboxTimetable200ResponseDataBuilder get data =>
      _$this._data ??= ParentInboxTimetable200ResponseDataBuilder();
  set data(ParentInboxTimetable200ResponseDataBuilder? data) =>
      _$this._data = data;

  ParentInboxTimetable200ResponseBuilder() {
    ParentInboxTimetable200Response._defaults(this);
  }

  ParentInboxTimetable200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentInboxTimetable200Response other) {
    _$v = other as _$ParentInboxTimetable200Response;
  }

  @override
  void update(void Function(ParentInboxTimetable200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentInboxTimetable200Response build() => _build();

  _$ParentInboxTimetable200Response _build() {
    _$ParentInboxTimetable200Response _$result;
    try {
      _$result = _$v ?? _$ParentInboxTimetable200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentInboxTimetable200Response',
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
