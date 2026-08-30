// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_my_classes200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherMyClasses200Response extends TeacherMyClasses200Response {
  @override
  final BuiltList<ClassRoom> data;

  factory _$TeacherMyClasses200Response([
    void Function(TeacherMyClasses200ResponseBuilder)? updates,
  ]) => (TeacherMyClasses200ResponseBuilder()..update(updates))._build();

  _$TeacherMyClasses200Response._({required this.data}) : super._();
  @override
  TeacherMyClasses200Response rebuild(
    void Function(TeacherMyClasses200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherMyClasses200ResponseBuilder toBuilder() =>
      TeacherMyClasses200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherMyClasses200Response && data == other.data;
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
      r'TeacherMyClasses200Response',
    )..add('data', data)).toString();
  }
}

class TeacherMyClasses200ResponseBuilder
    implements
        Builder<
          TeacherMyClasses200Response,
          TeacherMyClasses200ResponseBuilder
        > {
  _$TeacherMyClasses200Response? _$v;

  ListBuilder<ClassRoom>? _data;
  ListBuilder<ClassRoom> get data => _$this._data ??= ListBuilder<ClassRoom>();
  set data(ListBuilder<ClassRoom>? data) => _$this._data = data;

  TeacherMyClasses200ResponseBuilder() {
    TeacherMyClasses200Response._defaults(this);
  }

  TeacherMyClasses200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherMyClasses200Response other) {
    _$v = other as _$TeacherMyClasses200Response;
  }

  @override
  void update(void Function(TeacherMyClasses200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherMyClasses200Response build() => _build();

  _$TeacherMyClasses200Response _build() {
    _$TeacherMyClasses200Response _$result;
    try {
      _$result = _$v ?? _$TeacherMyClasses200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherMyClasses200Response',
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
