// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_gradebook200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherGradebook200Response extends TeacherGradebook200Response {
  @override
  final TeacherGradebook200ResponseData data;

  factory _$TeacherGradebook200Response([
    void Function(TeacherGradebook200ResponseBuilder)? updates,
  ]) => (TeacherGradebook200ResponseBuilder()..update(updates))._build();

  _$TeacherGradebook200Response._({required this.data}) : super._();
  @override
  TeacherGradebook200Response rebuild(
    void Function(TeacherGradebook200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherGradebook200ResponseBuilder toBuilder() =>
      TeacherGradebook200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherGradebook200Response && data == other.data;
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
      r'TeacherGradebook200Response',
    )..add('data', data)).toString();
  }
}

class TeacherGradebook200ResponseBuilder
    implements
        Builder<
          TeacherGradebook200Response,
          TeacherGradebook200ResponseBuilder
        > {
  _$TeacherGradebook200Response? _$v;

  TeacherGradebook200ResponseDataBuilder? _data;
  TeacherGradebook200ResponseDataBuilder get data =>
      _$this._data ??= TeacherGradebook200ResponseDataBuilder();
  set data(TeacherGradebook200ResponseDataBuilder? data) => _$this._data = data;

  TeacherGradebook200ResponseBuilder() {
    TeacherGradebook200Response._defaults(this);
  }

  TeacherGradebook200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherGradebook200Response other) {
    _$v = other as _$TeacherGradebook200Response;
  }

  @override
  void update(void Function(TeacherGradebook200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherGradebook200Response build() => _build();

  _$TeacherGradebook200Response _build() {
    _$TeacherGradebook200Response _$result;
    try {
      _$result = _$v ?? _$TeacherGradebook200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherGradebook200Response',
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
