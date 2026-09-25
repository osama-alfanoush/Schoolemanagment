// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_index_categories200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseIndexCategories200Response
    extends WarehouseIndexCategories200Response {
  @override
  final BuiltList<WarehouseCategory> data;

  factory _$WarehouseIndexCategories200Response([
    void Function(WarehouseIndexCategories200ResponseBuilder)? updates,
  ]) =>
      (WarehouseIndexCategories200ResponseBuilder()..update(updates))._build();

  _$WarehouseIndexCategories200Response._({required this.data}) : super._();
  @override
  WarehouseIndexCategories200Response rebuild(
    void Function(WarehouseIndexCategories200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseIndexCategories200ResponseBuilder toBuilder() =>
      WarehouseIndexCategories200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseIndexCategories200Response && data == other.data;
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
      r'WarehouseIndexCategories200Response',
    )..add('data', data)).toString();
  }
}

class WarehouseIndexCategories200ResponseBuilder
    implements
        Builder<
          WarehouseIndexCategories200Response,
          WarehouseIndexCategories200ResponseBuilder
        > {
  _$WarehouseIndexCategories200Response? _$v;

  ListBuilder<WarehouseCategory>? _data;
  ListBuilder<WarehouseCategory> get data =>
      _$this._data ??= ListBuilder<WarehouseCategory>();
  set data(ListBuilder<WarehouseCategory>? data) => _$this._data = data;

  WarehouseIndexCategories200ResponseBuilder() {
    WarehouseIndexCategories200Response._defaults(this);
  }

  WarehouseIndexCategories200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseIndexCategories200Response other) {
    _$v = other as _$WarehouseIndexCategories200Response;
  }

  @override
  void update(
    void Function(WarehouseIndexCategories200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseIndexCategories200Response build() => _build();

  _$WarehouseIndexCategories200Response _build() {
    _$WarehouseIndexCategories200Response _$result;
    try {
      _$result =
          _$v ?? _$WarehouseIndexCategories200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'WarehouseIndexCategories200Response',
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
