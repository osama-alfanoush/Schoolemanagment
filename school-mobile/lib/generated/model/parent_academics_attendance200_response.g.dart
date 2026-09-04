// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_academics_attendance200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentAcademicsAttendance200Response
    extends ParentAcademicsAttendance200Response {
  @override
  final ParentAcademicsAttendance200ResponseData data;

  factory _$ParentAcademicsAttendance200Response([
    void Function(ParentAcademicsAttendance200ResponseBuilder)? updates,
  ]) =>
      (ParentAcademicsAttendance200ResponseBuilder()..update(updates))._build();

  _$ParentAcademicsAttendance200Response._({required this.data}) : super._();
  @override
  ParentAcademicsAttendance200Response rebuild(
    void Function(ParentAcademicsAttendance200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentAcademicsAttendance200ResponseBuilder toBuilder() =>
      ParentAcademicsAttendance200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentAcademicsAttendance200Response && data == other.data;
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
      r'ParentAcademicsAttendance200Response',
    )..add('data', data)).toString();
  }
}

class ParentAcademicsAttendance200ResponseBuilder
    implements
        Builder<
          ParentAcademicsAttendance200Response,
          ParentAcademicsAttendance200ResponseBuilder
        > {
  _$ParentAcademicsAttendance200Response? _$v;

  ParentAcademicsAttendance200ResponseDataBuilder? _data;
  ParentAcademicsAttendance200ResponseDataBuilder get data =>
      _$this._data ??= ParentAcademicsAttendance200ResponseDataBuilder();
  set data(ParentAcademicsAttendance200ResponseDataBuilder? data) =>
      _$this._data = data;

  ParentAcademicsAttendance200ResponseBuilder() {
    ParentAcademicsAttendance200Response._defaults(this);
  }

  ParentAcademicsAttendance200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentAcademicsAttendance200Response other) {
    _$v = other as _$ParentAcademicsAttendance200Response;
  }

  @override
  void update(
    void Function(ParentAcademicsAttendance200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentAcademicsAttendance200Response build() => _build();

  _$ParentAcademicsAttendance200Response _build() {
    _$ParentAcademicsAttendance200Response _$result;
    try {
      _$result =
          _$v ?? _$ParentAcademicsAttendance200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentAcademicsAttendance200Response',
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
