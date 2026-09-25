// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseItem extends WarehouseItem {
  @override
  final int id;
  @override
  final String sku;
  @override
  final String name;
  @override
  final String? description;
  @override
  final int categoryId;
  @override
  final String unit;
  @override
  final String currentQty;
  @override
  final String minStockQty;
  @override
  final String? location;
  @override
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? unitCost;
  @override
  final String? lastUnitCost;
  @override
  final int? preferredSupplierId;
  @override
  final int schoolId;
  @override
  final String isLowStock;

  factory _$WarehouseItem([void Function(WarehouseItemBuilder)? updates]) =>
      (WarehouseItemBuilder()..update(updates))._build();

  _$WarehouseItem._({
    required this.id,
    required this.sku,
    required this.name,
    this.description,
    required this.categoryId,
    required this.unit,
    required this.currentQty,
    required this.minStockQty,
    this.location,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    this.unitCost,
    this.lastUnitCost,
    this.preferredSupplierId,
    required this.schoolId,
    required this.isLowStock,
  }) : super._();
  @override
  WarehouseItem rebuild(void Function(WarehouseItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WarehouseItemBuilder toBuilder() => WarehouseItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseItem &&
        id == other.id &&
        sku == other.sku &&
        name == other.name &&
        description == other.description &&
        categoryId == other.categoryId &&
        unit == other.unit &&
        currentQty == other.currentQty &&
        minStockQty == other.minStockQty &&
        location == other.location &&
        isActive == other.isActive &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        unitCost == other.unitCost &&
        lastUnitCost == other.lastUnitCost &&
        preferredSupplierId == other.preferredSupplierId &&
        schoolId == other.schoolId &&
        isLowStock == other.isLowStock;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, sku.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, categoryId.hashCode);
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jc(_$hash, currentQty.hashCode);
    _$hash = $jc(_$hash, minStockQty.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, unitCost.hashCode);
    _$hash = $jc(_$hash, lastUnitCost.hashCode);
    _$hash = $jc(_$hash, preferredSupplierId.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, isLowStock.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WarehouseItem')
          ..add('id', id)
          ..add('sku', sku)
          ..add('name', name)
          ..add('description', description)
          ..add('categoryId', categoryId)
          ..add('unit', unit)
          ..add('currentQty', currentQty)
          ..add('minStockQty', minStockQty)
          ..add('location', location)
          ..add('isActive', isActive)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('unitCost', unitCost)
          ..add('lastUnitCost', lastUnitCost)
          ..add('preferredSupplierId', preferredSupplierId)
          ..add('schoolId', schoolId)
          ..add('isLowStock', isLowStock))
        .toString();
  }
}

class WarehouseItemBuilder
    implements Builder<WarehouseItem, WarehouseItemBuilder> {
  _$WarehouseItem? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _sku;
  String? get sku => _$this._sku;
  set sku(String? sku) => _$this._sku = sku;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _categoryId;
  int? get categoryId => _$this._categoryId;
  set categoryId(int? categoryId) => _$this._categoryId = categoryId;

  String? _unit;
  String? get unit => _$this._unit;
  set unit(String? unit) => _$this._unit = unit;

  String? _currentQty;
  String? get currentQty => _$this._currentQty;
  set currentQty(String? currentQty) => _$this._currentQty = currentQty;

  String? _minStockQty;
  String? get minStockQty => _$this._minStockQty;
  set minStockQty(String? minStockQty) => _$this._minStockQty = minStockQty;

  String? _location;
  String? get location => _$this._location;
  set location(String? location) => _$this._location = location;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _unitCost;
  String? get unitCost => _$this._unitCost;
  set unitCost(String? unitCost) => _$this._unitCost = unitCost;

  String? _lastUnitCost;
  String? get lastUnitCost => _$this._lastUnitCost;
  set lastUnitCost(String? lastUnitCost) => _$this._lastUnitCost = lastUnitCost;

  int? _preferredSupplierId;
  int? get preferredSupplierId => _$this._preferredSupplierId;
  set preferredSupplierId(int? preferredSupplierId) =>
      _$this._preferredSupplierId = preferredSupplierId;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  String? _isLowStock;
  String? get isLowStock => _$this._isLowStock;
  set isLowStock(String? isLowStock) => _$this._isLowStock = isLowStock;

  WarehouseItemBuilder() {
    WarehouseItem._defaults(this);
  }

  WarehouseItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _sku = $v.sku;
      _name = $v.name;
      _description = $v.description;
      _categoryId = $v.categoryId;
      _unit = $v.unit;
      _currentQty = $v.currentQty;
      _minStockQty = $v.minStockQty;
      _location = $v.location;
      _isActive = $v.isActive;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _unitCost = $v.unitCost;
      _lastUnitCost = $v.lastUnitCost;
      _preferredSupplierId = $v.preferredSupplierId;
      _schoolId = $v.schoolId;
      _isLowStock = $v.isLowStock;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseItem other) {
    _$v = other as _$WarehouseItem;
  }

  @override
  void update(void Function(WarehouseItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseItem build() => _build();

  _$WarehouseItem _build() {
    final _$result =
        _$v ??
        _$WarehouseItem._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'WarehouseItem', 'id'),
          sku: BuiltValueNullFieldError.checkNotNull(
            sku,
            r'WarehouseItem',
            'sku',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'WarehouseItem',
            'name',
          ),
          description: description,
          categoryId: BuiltValueNullFieldError.checkNotNull(
            categoryId,
            r'WarehouseItem',
            'categoryId',
          ),
          unit: BuiltValueNullFieldError.checkNotNull(
            unit,
            r'WarehouseItem',
            'unit',
          ),
          currentQty: BuiltValueNullFieldError.checkNotNull(
            currentQty,
            r'WarehouseItem',
            'currentQty',
          ),
          minStockQty: BuiltValueNullFieldError.checkNotNull(
            minStockQty,
            r'WarehouseItem',
            'minStockQty',
          ),
          location: location,
          isActive: BuiltValueNullFieldError.checkNotNull(
            isActive,
            r'WarehouseItem',
            'isActive',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          unitCost: unitCost,
          lastUnitCost: lastUnitCost,
          preferredSupplierId: preferredSupplierId,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'WarehouseItem',
            'schoolId',
          ),
          isLowStock: BuiltValueNullFieldError.checkNotNull(
            isLowStock,
            r'WarehouseItem',
            'isLowStock',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
