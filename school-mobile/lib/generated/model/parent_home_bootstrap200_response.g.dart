// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_home_bootstrap200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentHomeBootstrap200Response extends ParentHomeBootstrap200Response {
  @override
  final ParentHomeBootstrap200ResponseData data;

  factory _$ParentHomeBootstrap200Response([
    void Function(ParentHomeBootstrap200ResponseBuilder)? updates,
  ]) => (ParentHomeBootstrap200ResponseBuilder()..update(updates))._build();

  _$ParentHomeBootstrap200Response._({required this.data}) : super._();
  @override
  ParentHomeBootstrap200Response rebuild(
    void Function(ParentHomeBootstrap200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentHomeBootstrap200ResponseBuilder toBuilder() =>
      ParentHomeBootstrap200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentHomeBootstrap200Response && data == other.data;
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
      r'ParentHomeBootstrap200Response',
    )..add('data', data)).toString();
  }
}

class ParentHomeBootstrap200ResponseBuilder
    implements
        Builder<
          ParentHomeBootstrap200Response,
          ParentHomeBootstrap200ResponseBuilder
        > {
  _$ParentHomeBootstrap200Response? _$v;

  ParentHomeBootstrap200ResponseDataBuilder? _data;
  ParentHomeBootstrap200ResponseDataBuilder get data =>
      _$this._data ??= ParentHomeBootstrap200ResponseDataBuilder();
  set data(ParentHomeBootstrap200ResponseDataBuilder? data) =>
      _$this._data = data;

  ParentHomeBootstrap200ResponseBuilder() {
    ParentHomeBootstrap200Response._defaults(this);
  }

  ParentHomeBootstrap200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentHomeBootstrap200Response other) {
    _$v = other as _$ParentHomeBootstrap200Response;
  }

  @override
  void update(void Function(ParentHomeBootstrap200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ParentHomeBootstrap200Response build() => _build();

  _$ParentHomeBootstrap200Response _build() {
    _$ParentHomeBootstrap200Response _$result;
    try {
      _$result = _$v ?? _$ParentHomeBootstrap200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ParentHomeBootstrap200Response',
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
