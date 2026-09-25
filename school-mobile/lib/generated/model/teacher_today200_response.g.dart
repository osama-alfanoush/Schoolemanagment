// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_today200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherToday200Response extends TeacherToday200Response {
  @override
  final TeacherToday200ResponseData data;

  factory _$TeacherToday200Response([
    void Function(TeacherToday200ResponseBuilder)? updates,
  ]) => (TeacherToday200ResponseBuilder()..update(updates))._build();

  _$TeacherToday200Response._({required this.data}) : super._();
  @override
  TeacherToday200Response rebuild(
    void Function(TeacherToday200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherToday200ResponseBuilder toBuilder() =>
      TeacherToday200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherToday200Response && data == other.data;
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
      r'TeacherToday200Response',
    )..add('data', data)).toString();
  }
}

class TeacherToday200ResponseBuilder
    implements
        Builder<TeacherToday200Response, TeacherToday200ResponseBuilder> {
  _$TeacherToday200Response? _$v;

  TeacherToday200ResponseDataBuilder? _data;
  TeacherToday200ResponseDataBuilder get data =>
      _$this._data ??= TeacherToday200ResponseDataBuilder();
  set data(TeacherToday200ResponseDataBuilder? data) => _$this._data = data;

  TeacherToday200ResponseBuilder() {
    TeacherToday200Response._defaults(this);
  }

  TeacherToday200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherToday200Response other) {
    _$v = other as _$TeacherToday200Response;
  }

  @override
  void update(void Function(TeacherToday200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherToday200Response build() => _build();

  _$TeacherToday200Response _build() {
    _$TeacherToday200Response _$result;
    try {
      _$result = _$v ?? _$TeacherToday200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherToday200Response',
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
