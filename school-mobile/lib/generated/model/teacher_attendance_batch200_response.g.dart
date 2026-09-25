// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_attendance_batch200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherAttendanceBatch200Response
    extends TeacherAttendanceBatch200Response {
  @override
  final TeacherAttendanceBatch200ResponseData data;

  factory _$TeacherAttendanceBatch200Response([
    void Function(TeacherAttendanceBatch200ResponseBuilder)? updates,
  ]) => (TeacherAttendanceBatch200ResponseBuilder()..update(updates))._build();

  _$TeacherAttendanceBatch200Response._({required this.data}) : super._();
  @override
  TeacherAttendanceBatch200Response rebuild(
    void Function(TeacherAttendanceBatch200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherAttendanceBatch200ResponseBuilder toBuilder() =>
      TeacherAttendanceBatch200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherAttendanceBatch200Response && data == other.data;
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
      r'TeacherAttendanceBatch200Response',
    )..add('data', data)).toString();
  }
}

class TeacherAttendanceBatch200ResponseBuilder
    implements
        Builder<
          TeacherAttendanceBatch200Response,
          TeacherAttendanceBatch200ResponseBuilder
        > {
  _$TeacherAttendanceBatch200Response? _$v;

  TeacherAttendanceBatch200ResponseDataBuilder? _data;
  TeacherAttendanceBatch200ResponseDataBuilder get data =>
      _$this._data ??= TeacherAttendanceBatch200ResponseDataBuilder();
  set data(TeacherAttendanceBatch200ResponseDataBuilder? data) =>
      _$this._data = data;

  TeacherAttendanceBatch200ResponseBuilder() {
    TeacherAttendanceBatch200Response._defaults(this);
  }

  TeacherAttendanceBatch200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherAttendanceBatch200Response other) {
    _$v = other as _$TeacherAttendanceBatch200Response;
  }

  @override
  void update(
    void Function(TeacherAttendanceBatch200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  TeacherAttendanceBatch200Response build() => _build();

  _$TeacherAttendanceBatch200Response _build() {
    _$TeacherAttendanceBatch200Response _$result;
    try {
      _$result =
          _$v ?? _$TeacherAttendanceBatch200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherAttendanceBatch200Response',
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
