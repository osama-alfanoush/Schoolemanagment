// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_assignments200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TeacherAssignments200Response extends TeacherAssignments200Response {
  @override
  final MobileStudentAssignments200ResponseDataAnyOf data;

  factory _$TeacherAssignments200Response([
    void Function(TeacherAssignments200ResponseBuilder)? updates,
  ]) => (TeacherAssignments200ResponseBuilder()..update(updates))._build();

  _$TeacherAssignments200Response._({required this.data}) : super._();
  @override
  TeacherAssignments200Response rebuild(
    void Function(TeacherAssignments200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  TeacherAssignments200ResponseBuilder toBuilder() =>
      TeacherAssignments200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TeacherAssignments200Response && data == other.data;
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
      r'TeacherAssignments200Response',
    )..add('data', data)).toString();
  }
}

class TeacherAssignments200ResponseBuilder
    implements
        Builder<
          TeacherAssignments200Response,
          TeacherAssignments200ResponseBuilder
        > {
  _$TeacherAssignments200Response? _$v;

  MobileStudentAssignments200ResponseDataAnyOfBuilder? _data;
  MobileStudentAssignments200ResponseDataAnyOfBuilder get data =>
      _$this._data ??= MobileStudentAssignments200ResponseDataAnyOfBuilder();
  set data(MobileStudentAssignments200ResponseDataAnyOfBuilder? data) =>
      _$this._data = data;

  TeacherAssignments200ResponseBuilder() {
    TeacherAssignments200Response._defaults(this);
  }

  TeacherAssignments200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TeacherAssignments200Response other) {
    _$v = other as _$TeacherAssignments200Response;
  }

  @override
  void update(void Function(TeacherAssignments200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TeacherAssignments200Response build() => _build();

  _$TeacherAssignments200Response _build() {
    _$TeacherAssignments200Response _$result;
    try {
      _$result = _$v ?? _$TeacherAssignments200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'TeacherAssignments200Response',
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
