// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_home_home200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentHomeHome200Response extends ParentHomeHome200Response {
  @override
  final ParentHomeHome200ResponseData data;

  factory _$ParentHomeHome200Response([
    void Function(ParentHomeHome200ResponseBuilder)? updates,
  ]) => (ParentHomeHome200ResponseBuilder()..update(updates))._build();

  _$ParentHomeHome200Response._({required this.data}) : super._();
  @override
  ParentHomeHome200Response rebuild(
    void Function(ParentHomeHome200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentHomeHome200ResponseBuilder toBuilder() =>
      ParentHomeHome200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentHomeHome200Response && data == other.data;
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
      r'ParentHomeHome200Response',
    )..add('data', data)).toString();
  }
}

class ParentHomeHome200ResponseBuilder
    implements
        Builder<ParentHomeHome200Response, ParentHomeHome200ResponseBuilder> {
  _$ParentHomeHome200Response? _$v;

  ParentHomeHome200ResponseDataBuilder? _data;
  ParentHomeHome200ResponseDataBuilder get data =>
      _$this._data ??= ParentHomeHome200ResponseDataBuilder();
  set data(ParentHomeHome200ResponseDataBuilder? data) => _$this._data = data;

  ParentHomeHome200ResponseBuilder() {
    ParentHomeHome200Response._defaults(this);
  }

  ParentHomeHome200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentHomeHome200Response other) {
    _$v = other as _$ParentHomeHome200Response;
  }

  @override
  void update(void Function(ParentHomeHome200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentHomeHome200Response build() => _build();

  _$ParentHomeHome200Response _build() {
    _$ParentHomeHome200Response _$result;
    try {
      _$result = _$v ?? _$ParentHomeHome200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentHomeHome200Response',
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
