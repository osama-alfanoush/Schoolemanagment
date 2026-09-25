// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_academics_grades200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentAcademicsGrades200Response
    extends ParentAcademicsGrades200Response {
  @override
  final ParentAcademicsGrades200ResponseData data;

  factory _$ParentAcademicsGrades200Response([
    void Function(ParentAcademicsGrades200ResponseBuilder)? updates,
  ]) => (ParentAcademicsGrades200ResponseBuilder()..update(updates))._build();

  _$ParentAcademicsGrades200Response._({required this.data}) : super._();
  @override
  ParentAcademicsGrades200Response rebuild(
    void Function(ParentAcademicsGrades200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentAcademicsGrades200ResponseBuilder toBuilder() =>
      ParentAcademicsGrades200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentAcademicsGrades200Response && data == other.data;
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
      r'ParentAcademicsGrades200Response',
    )..add('data', data)).toString();
  }
}

class ParentAcademicsGrades200ResponseBuilder
    implements
        Builder<
          ParentAcademicsGrades200Response,
          ParentAcademicsGrades200ResponseBuilder
        > {
  _$ParentAcademicsGrades200Response? _$v;

  ParentAcademicsGrades200ResponseDataBuilder? _data;
  ParentAcademicsGrades200ResponseDataBuilder get data =>
      _$this._data ??= ParentAcademicsGrades200ResponseDataBuilder();
  set data(ParentAcademicsGrades200ResponseDataBuilder? data) =>
      _$this._data = data;

  ParentAcademicsGrades200ResponseBuilder() {
    ParentAcademicsGrades200Response._defaults(this);
  }

  ParentAcademicsGrades200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentAcademicsGrades200Response other) {
    _$v = other as _$ParentAcademicsGrades200Response;
  }

  @override
  void update(void Function(ParentAcademicsGrades200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentAcademicsGrades200Response build() => _build();

  _$ParentAcademicsGrades200Response _build() {
    _$ParentAcademicsGrades200Response _$result;
    try {
      _$result =
          _$v ?? _$ParentAcademicsGrades200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentAcademicsGrades200Response',
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
