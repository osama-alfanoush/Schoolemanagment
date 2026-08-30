// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_update_purchase_order_request_items_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProcurementUpdatePurchaseOrderRequestItemsInner
    extends ProcurementUpdatePurchaseOrderRequestItemsInner {
  @override
  final int? warehouseItemId;
  @override
  final String? description;
  @override
  final num? quantityOrdered;
  @override
  final String? unit;
  @override
  final num? unitCost;
  @override
  final String? warehouseLocation;

  factory _$ProcurementUpdatePurchaseOrderRequestItemsInner([
    void Function(ProcurementUpdatePurchaseOrderRequestItemsInnerBuilder)?
    updates,
  ]) =>
      (ProcurementUpdatePurchaseOrderRequestItemsInnerBuilder()
            ..update(updates))
          ._build();

  _$ProcurementUpdatePurchaseOrderRequestItemsInner._({
    this.warehouseItemId,
    this.description,
    this.quantityOrdered,
    this.unit,
    this.unitCost,
    this.warehouseLocation,
  }) : super._();
  @override
  ProcurementUpdatePurchaseOrderRequestItemsInner rebuild(
    void Function(ProcurementUpdatePurchaseOrderRequestItemsInnerBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementUpdatePurchaseOrderRequestItemsInnerBuilder toBuilder() =>
      ProcurementUpdatePurchaseOrderRequestItemsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementUpdatePurchaseOrderRequestItemsInner &&
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
            r'ProcurementUpdatePurchaseOrderRequestItemsInner',
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

class ProcurementUpdatePurchaseOrderRequestItemsInnerBuilder
    implements
        Builder<
          ProcurementUpdatePurchaseOrderRequestItemsInner,
          ProcurementUpdatePurchaseOrderRequestItemsInnerBuilder
        > {
  _$ProcurementUpdatePurchaseOrderRequestItemsInner? _$v;

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

  ProcurementUpdatePurchaseOrderRequestItemsInnerBuilder() {
    ProcurementUpdatePurchaseOrderRequestItemsInner._defaults(this);
  }

  ProcurementUpdatePurchaseOrderRequestItemsInnerBuilder get _$this {
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
  void replace(ProcurementUpdatePurchaseOrderRequestItemsInner other) {
    _$v = other as _$ProcurementUpdatePurchaseOrderRequestItemsInner;
  }

  @override
  void update(
    void Function(ProcurementUpdatePurchaseOrderRequestItemsInnerBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementUpdatePurchaseOrderRequestItemsInner build() => _build();

  _$ProcurementUpdatePurchaseOrderRequestItemsInner _build() {
    final _$result =
        _$v ??
        _$ProcurementUpdatePurchaseOrderRequestItemsInner._(
          warehouseItemId: warehouseItemId,
          description: description,
          quantityOrdered: quantityOrdered,
          unit: unit,
          unitCost: unitCost,
          warehouseLocation: warehouseLocation,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
