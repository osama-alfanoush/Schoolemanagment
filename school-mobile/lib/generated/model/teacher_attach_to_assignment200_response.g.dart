// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_attach_to_assignment200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherAttachToAssignment200Response
    extends TeacherAttachToAssignment200Response {
  @override
  final TeacherAttachToAssignment200ResponseData data;

  factory _$TeacherAttachToAssignment200Response([
    void Function(TeacherAttachToAssignment200ResponseBuilder)? updates,
  ]) =>
      (TeacherAttachToAssignment200ResponseBuilder()..update(updates))._build();

  _$TeacherAttachToAssignment200Response._({required this.data}) : super._();
  @override
  TeacherAttachToAssignment200Response rebuild(
    void Function(TeacherAttachToAssignment200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherAttachToAssignment200ResponseBuilder toBuilder() =>
      TeacherAttachToAssignment200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherAttachToAssignment200Response && data == other.data;
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
      r'TeacherAttachToAssignment200Response',
    )..add('data', data)).toString();
  }
}

class TeacherAttachToAssignment200ResponseBuilder
    implements
        Builder<
          TeacherAttachToAssignment200Response,
          TeacherAttachToAssignment200ResponseBuilder
        > {
  _$TeacherAttachToAssignment200Response? _$v;

  TeacherAttachToAssignment200ResponseDataBuilder? _data;
  TeacherAttachToAssignment200ResponseDataBuilder get data =>
      _$this._data ??= TeacherAttachToAssignment200ResponseDataBuilder();
  set data(TeacherAttachToAssignment200ResponseDataBuilder? data) =>
      _$this._data = data;

  TeacherAttachToAssignment200ResponseBuilder() {
    TeacherAttachToAssignment200Response._defaults(this);
  }

  TeacherAttachToAssignment200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherAttachToAssignment200Response other) {
    _$v = other as _$TeacherAttachToAssignment200Response;
  }

  @override
  void update(
    void Function(TeacherAttachToAssignment200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherAttachToAssignment200Response build() => _build();

  _$TeacherAttachToAssignment200Response _build() {
    _$TeacherAttachToAssignment200Response _$result;
    try {
      _$result =
          _$v ?? _$TeacherAttachToAssignment200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherAttachToAssignment200Response',
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
