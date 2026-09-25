// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_student_assignments200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MobileStudentAssignments200Response
    extends MobileStudentAssignments200Response {
  @override
  final MobileStudentAssignments200ResponseData data;

  factory _$MobileStudentAssignments200Response([
    void Function(MobileStudentAssignments200ResponseBuilder)? updates,
  ]) =>
      (MobileStudentAssignments200ResponseBuilder()..update(updates))._build();

  _$MobileStudentAssignments200Response._({required this.data}) : super._();
  @override
  MobileStudentAssignments200Response rebuild(
    void Function(MobileStudentAssignments200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  MobileStudentAssignments200ResponseBuilder toBuilder() =>
      MobileStudentAssignments200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MobileStudentAssignments200Response && data == other.data;
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
      r'MobileStudentAssignments200Response',
    )..add('data', data)).toString();
  }
}

class MobileStudentAssignments200ResponseBuilder
    implements
        Builder<
          MobileStudentAssignments200Response,
          MobileStudentAssignments200ResponseBuilder
        > {
  _$MobileStudentAssignments200Response? _$v;

  MobileStudentAssignments200ResponseDataBuilder? _data;
  MobileStudentAssignments200ResponseDataBuilder get data =>
      _$this._data ??= MobileStudentAssignments200ResponseDataBuilder();
  set data(MobileStudentAssignments200ResponseDataBuilder? data) =>
      _$this._data = data;

  MobileStudentAssignments200ResponseBuilder() {
    MobileStudentAssignments200Response._defaults(this);
  }

  MobileStudentAssignments200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MobileStudentAssignments200Response other) {
    _$v = other as _$MobileStudentAssignments200Response;
  }

  @override
  void update(
    void Function(MobileStudentAssignments200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  MobileStudentAssignments200Response build() => _build();

  _$MobileStudentAssignments200Response _build() {
    _$MobileStudentAssignments200Response _$result;
    try {
      _$result =
          _$v ?? _$MobileStudentAssignments200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'MobileStudentAssignments200Response',
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
