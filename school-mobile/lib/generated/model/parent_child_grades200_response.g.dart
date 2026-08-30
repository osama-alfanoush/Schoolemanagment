// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_child_grades200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentChildGrades200Response extends ParentChildGrades200Response {
  @override
  final BuiltList<Grade> data;

  factory _$ParentChildGrades200Response([
    void Function(ParentChildGrades200ResponseBuilder)? updates,
  ]) => (ParentChildGrades200ResponseBuilder()..update(updates))._build();

  _$ParentChildGrades200Response._({required this.data}) : super._();
  @override
  ParentChildGrades200Response rebuild(
    void Function(ParentChildGrades200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentChildGrades200ResponseBuilder toBuilder() =>
      ParentChildGrades200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentChildGrades200Response && data == other.data;
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
      r'ParentChildGrades200Response',
    )..add('data', data)).toString();
  }
}

class ParentChildGrades200ResponseBuilder
    implements
        Builder<
          ParentChildGrades200Response,
          ParentChildGrades200ResponseBuilder
        > {
  _$ParentChildGrades200Response? _$v;

  ListBuilder<Grade>? _data;
  ListBuilder<Grade> get data => _$this._data ??= ListBuilder<Grade>();
  set data(ListBuilder<Grade>? data) => _$this._data = data;

  ParentChildGrades200ResponseBuilder() {
    ParentChildGrades200Response._defaults(this);
  }

  ParentChildGrades200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentChildGrades200Response other) {
    _$v = other as _$ParentChildGrades200Response;
  }

  @override
  void update(void Function(ParentChildGrades200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentChildGrades200Response build() => _build();

  _$ParentChildGrades200Response _build() {
    _$ParentChildGrades200Response _$result;
    try {
      _$result = _$v ?? _$ParentChildGrades200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentChildGrades200Response',
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
