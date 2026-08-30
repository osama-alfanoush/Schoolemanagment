// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_store_item_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseStoreItemRequest extends WarehouseStoreItemRequest {
  @override
  final String name;
  @override
  final int categoryId;
  @override
  final String unit;
  @override
  final num minStockQty;
  @override
  final String? location;
  @override
  final String? description;
  @override
  final String? sku;

  factory _$WarehouseStoreItemRequest([
    void Function(WarehouseStoreItemRequestBuilder)? updates,
  ]) => (WarehouseStoreItemRequestBuilder()..update(updates))._build();

  _$WarehouseStoreItemRequest._({
    required this.name,
    required this.categoryId,
    required this.unit,
    required this.minStockQty,
    this.location,
    this.description,
    this.sku,
  }) : super._();
  @override
  WarehouseStoreItemRequest rebuild(
    void Function(WarehouseStoreItemRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseStoreItemRequestBuilder toBuilder() =>
      WarehouseStoreItemRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseStoreItemRequest &&
        name == other.name &&
        categoryId == other.categoryId &&
        unit == other.unit &&
        minStockQty == other.minStockQty &&
        location == other.location &&
        description == other.description &&
        sku == other.sku;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, categoryId.hashCode);
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jc(_$hash, minStockQty.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, sku.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WarehouseStoreItemRequest')
          ..add('name', name)
          ..add('categoryId', categoryId)
          ..add('unit', unit)
          ..add('minStockQty', minStockQty)
          ..add('location', location)
          ..add('description', description)
          ..add('sku', sku))
        .toString();
  }
}

class WarehouseStoreItemRequestBuilder
    implements
        Builder<WarehouseStoreItemRequest, WarehouseStoreItemRequestBuilder> {
  _$WarehouseStoreItemRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  int? _categoryId;
  int? get categoryId => _$this._categoryId;
  set categoryId(int? categoryId) => _$this._categoryId = categoryId;

  String? _unit;
  String? get unit => _$this._unit;
  set unit(String? unit) => _$this._unit = unit;

  num? _minStockQty;
  num? get minStockQty => _$this._minStockQty;
  set minStockQty(num? minStockQty) => _$this._minStockQty = minStockQty;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _sku;
  String? get sku => _$this._sku;
  set sku(String? sku) => _$this._sku = sku;

  WarehouseStoreItemRequestBuilder() {
    WarehouseStoreItemRequest._defaults(this);
  }

  WarehouseStoreItemRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _categoryId = $v.categoryId;
      _unit = $v.unit;
      _minStockQty = $v.minStockQty;
      _location = $v.location;
      _description = $v.description;
      _sku = $v.sku;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseStoreItemRequest other) {
    _$v = other as _$WarehouseStoreItemRequest;
  }

  @override
  void update(void Function(WarehouseStoreItemRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseStoreItemRequest build() => _build();

  _$WarehouseStoreItemRequest _build() {
    final _$result =
        _$v ??
        _$WarehouseStoreItemRequest._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'WarehouseStoreItemRequest',
            'name',
          ),
          categoryId: BuiltValueNullFieldError.checkNotNull(
            categoryId,
            r'WarehouseStoreItemRequest',
            'categoryId',
          ),
          unit: BuiltValueNullFieldError.checkNotNull(
            unit,
            r'WarehouseStoreItemRequest',
            'unit',
          ),
          minStockQty: BuiltValueNullFieldError.checkNotNull(
            minStockQty,
            r'WarehouseStoreItemRequest',
            'minStockQty',
          ),
          location: location,
          description: description,
          sku: sku,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
