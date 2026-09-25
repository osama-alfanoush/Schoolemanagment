// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_submissions200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherSubmissions200Response extends TeacherSubmissions200Response {
  @override
  final TeacherSubmissions200ResponseData data;

  factory _$TeacherSubmissions200Response([
    void Function(TeacherSubmissions200ResponseBuilder)? updates,
  ]) => (TeacherSubmissions200ResponseBuilder()..update(updates))._build();

  _$TeacherSubmissions200Response._({required this.data}) : super._();
  @override
  TeacherSubmissions200Response rebuild(
    void Function(TeacherSubmissions200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherSubmissions200ResponseBuilder toBuilder() =>
      TeacherSubmissions200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherSubmissions200Response && data == other.data;
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
      r'TeacherSubmissions200Response',
    )..add('data', data)).toString();
  }
}

class TeacherSubmissions200ResponseBuilder
    implements
        Builder<
          TeacherSubmissions200Response,
          TeacherSubmissions200ResponseBuilder
        > {
  _$TeacherSubmissions200Response? _$v;

  TeacherSubmissions200ResponseDataBuilder? _data;
  TeacherSubmissions200ResponseDataBuilder get data =>
      _$this._data ??= TeacherSubmissions200ResponseDataBuilder();
  set data(TeacherSubmissions200ResponseDataBuilder? data) =>
      _$this._data = data;

  TeacherSubmissions200ResponseBuilder() {
    TeacherSubmissions200Response._defaults(this);
  }

  TeacherSubmissions200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherSubmissions200Response other) {
    _$v = other as _$TeacherSubmissions200Response;
  }

  @override
  void update(void Function(TeacherSubmissions200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherSubmissions200Response build() => _build();

  _$TeacherSubmissions200Response _build() {
    _$TeacherSubmissions200Response _$result;
    try {
      _$result = _$v ?? _$TeacherSubmissions200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherSubmissions200Response',
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
