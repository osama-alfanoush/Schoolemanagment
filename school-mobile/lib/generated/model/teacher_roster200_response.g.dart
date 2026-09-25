// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_roster200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherRoster200Response extends TeacherRoster200Response {
  @override
  final TeacherRoster200ResponseData data;

  factory _$TeacherRoster200Response([
    void Function(TeacherRoster200ResponseBuilder)? updates,
  ]) => (TeacherRoster200ResponseBuilder()..update(updates))._build();

  _$TeacherRoster200Response._({required this.data}) : super._();
  @override
  TeacherRoster200Response rebuild(
    void Function(TeacherRoster200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherRoster200ResponseBuilder toBuilder() =>
      TeacherRoster200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherRoster200Response && data == other.data;
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
      r'TeacherRoster200Response',
    )..add('data', data)).toString();
  }
}

class TeacherRoster200ResponseBuilder
    implements
        Builder<TeacherRoster200Response, TeacherRoster200ResponseBuilder> {
  _$TeacherRoster200Response? _$v;

  TeacherRoster200ResponseDataBuilder? _data;
  TeacherRoster200ResponseDataBuilder get data =>
      _$this._data ??= TeacherRoster200ResponseDataBuilder();
  set data(TeacherRoster200ResponseDataBuilder? data) => _$this._data = data;

  TeacherRoster200ResponseBuilder() {
    TeacherRoster200Response._defaults(this);
  }

  TeacherRoster200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherRoster200Response other) {
    _$v = other as _$TeacherRoster200Response;
  }

  @override
  void update(void Function(TeacherRoster200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherRoster200Response build() => _build();

  _$TeacherRoster200Response _build() {
    _$TeacherRoster200Response _$result;
    try {
      _$result = _$v ?? _$TeacherRoster200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherRoster200Response',
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
