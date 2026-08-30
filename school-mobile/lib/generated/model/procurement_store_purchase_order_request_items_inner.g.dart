// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_store_purchase_order_request_items_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProcurementStorePurchaseOrderRequestItemsInner
    extends ProcurementStorePurchaseOrderRequestItemsInner {
  @override
  final int warehouseItemId;
  @override
  final String? description;
  @override
  final num quantityOrdered;
  @override
  final String unit;
  @override
  final num unitCost;
  @override
  final String? warehouseLocation;

  factory _$ProcurementStorePurchaseOrderRequestItemsInner([
    void Function(ProcurementStorePurchaseOrderRequestItemsInnerBuilder)?
    updates,
  ]) =>
      (ProcurementStorePurchaseOrderRequestItemsInnerBuilder()..update(updates))
          ._build();

  _$ProcurementStorePurchaseOrderRequestItemsInner._({
    required this.warehouseItemId,
    this.description,
    required this.quantityOrdered,
    required this.unit,
    required this.unitCost,
    this.warehouseLocation,
  }) : super._();
  @override
  ProcurementStorePurchaseOrderRequestItemsInner rebuild(
    void Function(ProcurementStorePurchaseOrderRequestItemsInnerBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementStorePurchaseOrderRequestItemsInnerBuilder toBuilder() =>
      ProcurementStorePurchaseOrderRequestItemsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementStorePurchaseOrderRequestItemsInner &&
        warehouseItemId == other.warehouseItemId &&
        description == other.description &&
        quantityOrdered == other.quantityOrdered &&
        unit == other.unit &&
        unitCost == other.unitCost &&
        warehouseLocation == other.warehouseLocation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, warehouseItemId.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, quantityOrdered.hashCode);
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jc(_$hash, unitCost.hashCode);
    _$hash = $jc(_$hash, warehouseLocation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ProcurementStorePurchaseOrderRequestItemsInner',
          )
          ..add('warehouseItemId', warehouseItemId)
          ..add('description', description)
          ..add('quantityOrdered', quantityOrdered)
          ..add('unit', unit)
          ..add('unitCost', unitCost)
          ..add('warehouseLocation', warehouseLocation))
        .toString();
  }
}

class ProcurementStorePurchaseOrderRequestItemsInnerBuilder
    implements
        Builder<
          ProcurementStorePurchaseOrderRequestItemsInner,
          ProcurementStorePurchaseOrderRequestItemsInnerBuilder
        > {
  _$ProcurementStorePurchaseOrderRequestItemsInner? _$v;

  int? _warehouseItemId;
  int? get warehouseItemId => _$this._warehouseItemId;
  set warehouseItemId(int? warehouseItemId) =>
      _$this._warehouseItemId = warehouseItemId;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  num? _quantityOrdered;
  num? get quantityOrdered => _$this._quantityOrdered;
  set quantityOrdered(num? quantityOrdered) =>
      _$this._quantityOrdered = quantityOrdered;

  String? _unit;
  String? get unit => _$this._unit;
  set unit(String? unit) => _$this._unit = unit;

  num? _unitCost;
  num? get unitCost => _$this._unitCost;
  set unitCost(num? unitCost) => _$this._unitCost = unitCost;

  String? _warehouseLocation;
  String? get warehouseLocation => _$this._warehouseLocation;
  set warehouseLocation(String? warehouseLocation) =>
      _$this._warehouseLocation = warehouseLocation;

  ProcurementStorePurchaseOrderRequestItemsInnerBuilder() {
    ProcurementStorePurchaseOrderRequestItemsInner._defaults(this);
  }

  ProcurementStorePurchaseOrderRequestItemsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _warehouseItemId = $v.warehouseItemId;
      _description = $v.description;
      _quantityOrdered = $v.quantityOrdered;
      _unit = $v.unit;
      _unitCost = $v.unitCost;
      _warehouseLocation = $v.warehouseLocation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcurementStorePurchaseOrderRequestItemsInner other) {
    _$v = other as _$ProcurementStorePurchaseOrderRequestItemsInner;
  }

  @override
  void update(
    void Function(ProcurementStorePurchaseOrderRequestItemsInnerBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementStorePurchaseOrderRequestItemsInner build() => _build();

  _$ProcurementStorePurchaseOrderRequestItemsInner _build() {
    final _$result =
        _$v ??
        _$ProcurementStorePurchaseOrderRequestItemsInner._(
          warehouseItemId: BuiltValueNullFieldError.checkNotNull(
            warehouseItemId,
            r'ProcurementStorePurchaseOrderRequestItemsInner',
            'warehouseItemId',
          ),
          description: description,
          quantityOrdered: BuiltValueNullFieldError.checkNotNull(
            quantityOrdered,
            r'ProcurementStorePurchaseOrderRequestItemsInner',
            'quantityOrdered',
          ),
          unit: BuiltValueNullFieldError.checkNotNull(
            unit,
            r'ProcurementStorePurchaseOrderRequestItemsInner',
            'unit',
          ),
          unitCost: BuiltValueNullFieldError.checkNotNull(
            unitCost,
            r'ProcurementStorePurchaseOrderRequestItemsInner',
            'unitCost',
          ),
          warehouseLocation: warehouseLocation,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
