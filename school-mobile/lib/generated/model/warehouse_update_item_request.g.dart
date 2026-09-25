// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_update_item_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseUpdateItemRequest extends WarehouseUpdateItemRequest {
  @override
  final String? name;
  @override
  final int? categoryId;
  @override
  final String? unit;
  @override
  final num? minStockQty;
  @override
  final String? location;
  @override
  final String? description;
  @override
  final String? sku;
  @override
  final bool? isActive;

  factory _$WarehouseUpdateItemRequest([
    void Function(WarehouseUpdateItemRequestBuilder)? updates,
  ]) => (WarehouseUpdateItemRequestBuilder()..update(updates))._build();

  _$WarehouseUpdateItemRequest._({
    this.name,
    this.categoryId,
    this.unit,
    this.minStockQty,
    this.location,
    this.description,
    this.sku,
    this.isActive,
  }) : super._();
  @override
  WarehouseUpdateItemRequest rebuild(
    void Function(WarehouseUpdateItemRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseUpdateItemRequestBuilder toBuilder() =>
      WarehouseUpdateItemRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseUpdateItemRequest &&
        name == other.name &&
        categoryId == other.categoryId &&
        unit == other.unit &&
        minStockQty == other.minStockQty &&
        location == other.location &&
        description == other.description &&
        sku == other.sku &&
        isActive == other.isActive;
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
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WarehouseUpdateItemRequest')
          ..add('name', name)
          ..add('categoryId', categoryId)
          ..add('unit', unit)
          ..add('minStockQty', minStockQty)
          ..add('location', location)
          ..add('description', description)
          ..add('sku', sku)
          ..add('isActive', isActive))
        .toString();
  }
}

class WarehouseUpdateItemRequestBuilder
    implements
        Builder<WarehouseUpdateItemRequest, WarehouseUpdateItemRequestBuilder> {
  _$WarehouseUpdateItemRequest? _$v;

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

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  WarehouseUpdateItemRequestBuilder() {
    WarehouseUpdateItemRequest._defaults(this);
  }

  WarehouseUpdateItemRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _categoryId = $v.categoryId;
      _unit = $v.unit;
      _minStockQty = $v.minStockQty;
      _location = $v.location;
      _description = $v.description;
      _sku = $v.sku;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseUpdateItemRequest other) {
    _$v = other as _$WarehouseUpdateItemRequest;
  }

  @override
  void update(void Function(WarehouseUpdateItemRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseUpdateItemRequest build() => _build();

  _$WarehouseUpdateItemRequest _build() {
    final _$result =
        _$v ??
        _$WarehouseUpdateItemRequest._(
          name: name,
          categoryId: categoryId,
          unit: unit,
          minStockQty: minStockQty,
          location: location,
          description: description,
          sku: sku,
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
