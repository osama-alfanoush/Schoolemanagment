// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_consumption_report200_response_data_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseConsumptionReport200ResponseDataInner
    extends WarehouseConsumptionReport200ResponseDataInner {
  @override
  final String itemName;
  @override
  final String sku;
  @override
  final String? department;
  @override
  final num totalQuantity;
  @override
  final String unit;

  factory _$WarehouseConsumptionReport200ResponseDataInner([
    void Function(WarehouseConsumptionReport200ResponseDataInnerBuilder)?
    updates,
  ]) =>
      (WarehouseConsumptionReport200ResponseDataInnerBuilder()..update(updates))
          ._build();

  _$WarehouseConsumptionReport200ResponseDataInner._({
    required this.itemName,
    required this.sku,
    this.department,
    required this.totalQuantity,
    required this.unit,
  }) : super._();
  @override
  WarehouseConsumptionReport200ResponseDataInner rebuild(
    void Function(WarehouseConsumptionReport200ResponseDataInnerBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseConsumptionReport200ResponseDataInnerBuilder toBuilder() =>
      WarehouseConsumptionReport200ResponseDataInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseConsumptionReport200ResponseDataInner &&
        itemName == other.itemName &&
        sku == other.sku &&
        department == other.department &&
        totalQuantity == other.totalQuantity &&
        unit == other.unit;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, itemName.hashCode);
    _$hash = $jc(_$hash, sku.hashCode);
    _$hash = $jc(_$hash, department.hashCode);
    _$hash = $jc(_$hash, totalQuantity.hashCode);
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'WarehouseConsumptionReport200ResponseDataInner',
          )
          ..add('itemName', itemName)
          ..add('sku', sku)
          ..add('department', department)
          ..add('totalQuantity', totalQuantity)
          ..add('unit', unit))
        .toString();
  }
}

class WarehouseConsumptionReport200ResponseDataInnerBuilder
    implements
        Builder<
          WarehouseConsumptionReport200ResponseDataInner,
          WarehouseConsumptionReport200ResponseDataInnerBuilder
        > {
  _$WarehouseConsumptionReport200ResponseDataInner? _$v;

  String? _itemName;
  String? get itemName => _$this._itemName;
  set itemName(String? itemName) => _$this._itemName = itemName;

  String? _sku;
  String? get sku => _$this._sku;
  set sku(String? sku) => _$this._sku = sku;

  String? _department;
  String? get department => _$this._department;
  set department(String? department) => _$this._department = department;

  num? _totalQuantity;
  num? get totalQuantity => _$this._totalQuantity;
  set totalQuantity(num? totalQuantity) =>
      _$this._totalQuantity = totalQuantity;

  String? _unit;
  String? get unit => _$this._unit;
  set unit(String? unit) => _$this._unit = unit;

  WarehouseConsumptionReport200ResponseDataInnerBuilder() {
    WarehouseConsumptionReport200ResponseDataInner._defaults(this);
  }

  WarehouseConsumptionReport200ResponseDataInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _itemName = $v.itemName;
      _sku = $v.sku;
      _department = $v.department;
      _totalQuantity = $v.totalQuantity;
      _unit = $v.unit;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseConsumptionReport200ResponseDataInner other) {
    _$v = other as _$WarehouseConsumptionReport200ResponseDataInner;
  }

  @override
  void update(
    void Function(WarehouseConsumptionReport200ResponseDataInnerBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseConsumptionReport200ResponseDataInner build() => _build();

  _$WarehouseConsumptionReport200ResponseDataInner _build() {
    final _$result =
        _$v ??
        _$WarehouseConsumptionReport200ResponseDataInner._(
          itemName: BuiltValueNullFieldError.checkNotNull(
            itemName,
            r'WarehouseConsumptionReport200ResponseDataInner',
            'itemName',
          ),
          sku: BuiltValueNullFieldError.checkNotNull(
            sku,
            r'WarehouseConsumptionReport200ResponseDataInner',
            'sku',
          ),
          department: department,
          totalQuantity: BuiltValueNullFieldError.checkNotNull(
            totalQuantity,
            r'WarehouseConsumptionReport200ResponseDataInner',
            'totalQuantity',
          ),
          unit: BuiltValueNullFieldError.checkNotNull(
            unit,
            r'WarehouseConsumptionReport200ResponseDataInner',
            'unit',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
