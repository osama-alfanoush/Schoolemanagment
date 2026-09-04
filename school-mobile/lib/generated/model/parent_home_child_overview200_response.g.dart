// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_home_child_overview200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentHomeChildOverview200Response
    extends ParentHomeChildOverview200Response {
  @override
  final String? data;

  factory _$ParentHomeChildOverview200Response([
    void Function(ParentHomeChildOverview200ResponseBuilder)? updates,
  ]) => (ParentHomeChildOverview200ResponseBuilder()..update(updates))._build();

  _$ParentHomeChildOverview200Response._({this.data}) : super._();
  @override
  ParentHomeChildOverview200Response rebuild(
    void Function(ParentHomeChildOverview200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentHomeChildOverview200ResponseBuilder toBuilder() =>
      ParentHomeChildOverview200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentHomeChildOverview200Response && data == other.data;
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
      r'ParentHomeChildOverview200Response',
    )..add('data', data)).toString();
  }
}

class ParentHomeChildOverview200ResponseBuilder
    implements
        Builder<
          ParentHomeChildOverview200Response,
          ParentHomeChildOverview200ResponseBuilder
        > {
  _$ParentHomeChildOverview200Response? _$v;

  String? _data;
  String? get data => _$this._data;
  set data(String? data) => _$this._data = data;

  ParentHomeChildOverview200ResponseBuilder() {
    ParentHomeChildOverview200Response._defaults(this);
  }

  ParentHomeChildOverview200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ParentHomeChildOverview200Response other) {
    _$v = other as _$ParentHomeChildOverview200Response;
  }

  @override
  void update(
    void Function(ParentHomeChildOverview200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentHomeChildOverview200Response build() => _build();

  _$ParentHomeChildOverview200Response _build() {
    final _$result = _$v ?? _$ParentHomeChildOverview200Response._(data: data);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
