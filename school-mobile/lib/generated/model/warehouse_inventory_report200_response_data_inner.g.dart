// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_inventory_report200_response_data_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseInventoryReport200ResponseDataInner
    extends WarehouseInventoryReport200ResponseDataInner {
  @override
  final int id;
  @override
  final String name;
  @override
  final String sku;
  @override
  final String category;
  @override
  final String unit;
  @override
  final num currentQty;
  @override
  final num minStockQty;
  @override
  final String isLowStock;

  factory _$WarehouseInventoryReport200ResponseDataInner([
    void Function(WarehouseInventoryReport200ResponseDataInnerBuilder)? updates,
  ]) => (WarehouseInventoryReport200ResponseDataInnerBuilder()..update(updates))
      ._build();

  _$WarehouseInventoryReport200ResponseDataInner._({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.unit,
    required this.currentQty,
    required this.minStockQty,
    required this.isLowStock,
  }) : super._();
  @override
  WarehouseInventoryReport200ResponseDataInner rebuild(
    void Function(WarehouseInventoryReport200ResponseDataInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseInventoryReport200ResponseDataInnerBuilder toBuilder() =>
      WarehouseInventoryReport200ResponseDataInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseInventoryReport200ResponseDataInner &&
        id == other.id &&
        name == other.name &&
        sku == other.sku &&
        category == other.category &&
        unit == other.unit &&
        currentQty == other.currentQty &&
        minStockQty == other.minStockQty &&
        isLowStock == other.isLowStock;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, sku.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jc(_$hash, currentQty.hashCode);
    _$hash = $jc(_$hash, minStockQty.hashCode);
    _$hash = $jc(_$hash, isLowStock.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'WarehouseInventoryReport200ResponseDataInner',
          )
          ..add('id', id)
          ..add('name', name)
          ..add('sku', sku)
          ..add('category', category)
          ..add('unit', unit)
          ..add('currentQty', currentQty)
          ..add('minStockQty', minStockQty)
          ..add('isLowStock', isLowStock))
        .toString();
  }
}

class WarehouseInventoryReport200ResponseDataInnerBuilder
    implements
        Builder<
          WarehouseInventoryReport200ResponseDataInner,
          WarehouseInventoryReport200ResponseDataInnerBuilder
        > {
  _$WarehouseInventoryReport200ResponseDataInner? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _sku;
  String? get sku => _$this._sku;
  set sku(String? sku) => _$this._sku = sku;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _unit;
  String? get unit => _$this._unit;
  set unit(String? unit) => _$this._unit = unit;

  num? _currentQty;
  num? get currentQty => _$this._currentQty;
  set currentQty(num? currentQty) => _$this._currentQty = currentQty;

  num? _minStockQty;
  num? get minStockQty => _$this._minStockQty;
  set minStockQty(num? minStockQty) => _$this._minStockQty = minStockQty;

  String? _isLowStock;
  String? get isLowStock => _$this._isLowStock;
  set isLowStock(String? isLowStock) => _$this._isLowStock = isLowStock;

  WarehouseInventoryReport200ResponseDataInnerBuilder() {
    WarehouseInventoryReport200ResponseDataInner._defaults(this);
  }

  WarehouseInventoryReport200ResponseDataInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _sku = $v.sku;
      _category = $v.category;
      _unit = $v.unit;
      _currentQty = $v.currentQty;
      _minStockQty = $v.minStockQty;
      _isLowStock = $v.isLowStock;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseInventoryReport200ResponseDataInner other) {
    _$v = other as _$WarehouseInventoryReport200ResponseDataInner;
  }

  @override
  void update(
    void Function(WarehouseInventoryReport200ResponseDataInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseInventoryReport200ResponseDataInner build() => _build();

  _$WarehouseInventoryReport200ResponseDataInner _build() {
    final _$result =
        _$v ??
        _$WarehouseInventoryReport200ResponseDataInner._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'WarehouseInventoryReport200ResponseDataInner',
            'id',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'WarehouseInventoryReport200ResponseDataInner',
            'name',
          ),
          sku: BuiltValueNullFieldError.checkNotNull(
            sku,
            r'WarehouseInventoryReport200ResponseDataInner',
            'sku',
          ),
          category: BuiltValueNullFieldError.checkNotNull(
            category,
            r'WarehouseInventoryReport200ResponseDataInner',
            'category',
          ),
          unit: BuiltValueNullFieldError.checkNotNull(
            unit,
            r'WarehouseInventoryReport200ResponseDataInner',
            'unit',
          ),
          currentQty: BuiltValueNullFieldError.checkNotNull(
            currentQty,
            r'WarehouseInventoryReport200ResponseDataInner',
            'currentQty',
          ),
          minStockQty: BuiltValueNullFieldError.checkNotNull(
            minStockQty,
            r'WarehouseInventoryReport200ResponseDataInner',
            'minStockQty',
          ),
          isLowStock: BuiltValueNullFieldError.checkNotNull(
            isLowStock,
            r'WarehouseInventoryReport200ResponseDataInner',
            'isLowStock',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
