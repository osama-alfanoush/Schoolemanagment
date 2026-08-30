// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_inventory_report200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseInventoryReport200Response
    extends WarehouseInventoryReport200Response {
  @override
  final BuiltList<WarehouseInventoryReport200ResponseDataInner> data;

  factory _$WarehouseInventoryReport200Response([
    void Function(WarehouseInventoryReport200ResponseBuilder)? updates,
  ]) =>
      (WarehouseInventoryReport200ResponseBuilder()..update(updates))._build();

  _$WarehouseInventoryReport200Response._({required this.data}) : super._();
  @override
  WarehouseInventoryReport200Response rebuild(
    void Function(WarehouseInventoryReport200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseInventoryReport200ResponseBuilder toBuilder() =>
      WarehouseInventoryReport200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseInventoryReport200Response && data == other.data;
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
      r'WarehouseInventoryReport200Response',
    )..add('data', data)).toString();
  }
}

class WarehouseInventoryReport200ResponseBuilder
    implements
        Builder<
          WarehouseInventoryReport200Response,
          WarehouseInventoryReport200ResponseBuilder
        > {
  _$WarehouseInventoryReport200Response? _$v;

  ListBuilder<WarehouseInventoryReport200ResponseDataInner>? _data;
  ListBuilder<WarehouseInventoryReport200ResponseDataInner> get data =>
      _$this._data ??=
          ListBuilder<WarehouseInventoryReport200ResponseDataInner>();
  set data(ListBuilder<WarehouseInventoryReport200ResponseDataInner>? data) =>
      _$this._data = data;

  WarehouseInventoryReport200ResponseBuilder() {
    WarehouseInventoryReport200Response._defaults(this);
  }

  WarehouseInventoryReport200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseInventoryReport200Response other) {
    _$v = other as _$WarehouseInventoryReport200Response;
  }

  @override
  void update(
    void Function(WarehouseInventoryReport200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseInventoryReport200Response build() => _build();

  _$WarehouseInventoryReport200Response _build() {
    _$WarehouseInventoryReport200Response _$result;
    try {
      _$result =
          _$v ?? _$WarehouseInventoryReport200Response._(data: data.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'WarehouseInventoryReport200Response',
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
