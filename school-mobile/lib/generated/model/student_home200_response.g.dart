// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_home200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentHome200Response extends StudentHome200Response {
  @override
  final StudentHome200ResponseData data;

  factory _$StudentHome200Response([
    void Function(StudentHome200ResponseBuilder)? updates,
  ]) => (StudentHome200ResponseBuilder()..update(updates))._build();

  _$StudentHome200Response._({required this.data}) : super._();
  @override
  StudentHome200Response rebuild(
    void Function(StudentHome200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StudentHome200ResponseBuilder toBuilder() =>
      StudentHome200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentHome200Response && data == other.data;
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
      r'StudentHome200Response',
    )..add('data', data)).toString();
  }
}

class StudentHome200ResponseBuilder
    implements Builder<StudentHome200Response, StudentHome200ResponseBuilder> {
  _$StudentHome200Response? _$v;

  StudentHome200ResponseDataBuilder? _data;
  StudentHome200ResponseDataBuilder get data =>
      _$this._data ??= StudentHome200ResponseDataBuilder();
  set data(StudentHome200ResponseDataBuilder? data) => _$this._data = data;

  StudentHome200ResponseBuilder() {
    StudentHome200Response._defaults(this);
  }

  StudentHome200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentHome200Response other) {
    _$v = other as _$StudentHome200Response;
  }

  @override
  void update(void Function(StudentHome200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StudentHome200Response build() => _build();

  _$StudentHome200Response _build() {
    _$StudentHome200Response _$result;
    try {
      _$result = _$v ?? _$StudentHome200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'StudentHome200Response',
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
