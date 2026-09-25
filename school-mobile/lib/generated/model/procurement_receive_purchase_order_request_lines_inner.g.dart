// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_receive_purchase_order_request_lines_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProcurementReceivePurchaseOrderRequestLinesInner
    extends ProcurementReceivePurchaseOrderRequestLinesInner {
  @override
  final int purchaseOrderItemId;
  @override
  final num quantityReceived;
  @override
  final num? unitCost;
  @override
  final String? warehouseLocation;

  factory _$ProcurementReceivePurchaseOrderRequestLinesInner([
    void Function(ProcurementReceivePurchaseOrderRequestLinesInnerBuilder)?
    updates,
  ]) =>
      (ProcurementReceivePurchaseOrderRequestLinesInnerBuilder()
            ..update(updates))
          ._build();

  _$ProcurementReceivePurchaseOrderRequestLinesInner._({
    required this.purchaseOrderItemId,
    required this.quantityReceived,
    this.unitCost,
    this.warehouseLocation,
  }) : super._();
  @override
  ProcurementReceivePurchaseOrderRequestLinesInner rebuild(
    void Function(ProcurementReceivePurchaseOrderRequestLinesInnerBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementReceivePurchaseOrderRequestLinesInnerBuilder toBuilder() =>
      ProcurementReceivePurchaseOrderRequestLinesInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementReceivePurchaseOrderRequestLinesInner &&
        purchaseOrderItemId == other.purchaseOrderItemId &&
        quantityReceived == other.quantityReceived &&
        unitCost == other.unitCost &&
        warehouseLocation == other.warehouseLocation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, purchaseOrderItemId.hashCode);
    _$hash = $jc(_$hash, quantityReceived.hashCode);
    _$hash = $jc(_$hash, unitCost.hashCode);
    _$hash = $jc(_$hash, warehouseLocation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ProcurementReceivePurchaseOrderRequestLinesInner',
          )
          ..add('purchaseOrderItemId', purchaseOrderItemId)
          ..add('quantityReceived', quantityReceived)
          ..add('unitCost', unitCost)
          ..add('warehouseLocation', warehouseLocation))
        .toString();
  }
}

class ProcurementReceivePurchaseOrderRequestLinesInnerBuilder
    implements
        Builder<
          ProcurementReceivePurchaseOrderRequestLinesInner,
          ProcurementReceivePurchaseOrderRequestLinesInnerBuilder
        > {
  _$ProcurementReceivePurchaseOrderRequestLinesInner? _$v;

  int? _purchaseOrderItemId;
  int? get purchaseOrderItemId => _$this._purchaseOrderItemId;
  set purchaseOrderItemId(int? purchaseOrderItemId) =>
      _$this._purchaseOrderItemId = purchaseOrderItemId;

  num? _quantityReceived;
  num? get quantityReceived => _$this._quantityReceived;
  set quantityReceived(num? quantityReceived) =>
      _$this._quantityReceived = quantityReceived;

  num? _unitCost;
  num? get unitCost => _$this._unitCost;
  set unitCost(num? unitCost) => _$this._unitCost = unitCost;

  String? _warehouseLocation;
  String? get warehouseLocation => _$this._warehouseLocation;
  set warehouseLocation(String? warehouseLocation) =>
      _$this._warehouseLocation = warehouseLocation;

  ProcurementReceivePurchaseOrderRequestLinesInnerBuilder() {
    ProcurementReceivePurchaseOrderRequestLinesInner._defaults(this);
  }

  ProcurementReceivePurchaseOrderRequestLinesInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _purchaseOrderItemId = $v.purchaseOrderItemId;
      _quantityReceived = $v.quantityReceived;
      _unitCost = $v.unitCost;
      _warehouseLocation = $v.warehouseLocation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcurementReceivePurchaseOrderRequestLinesInner other) {
    _$v = other as _$ProcurementReceivePurchaseOrderRequestLinesInner;
  }

  @override
  void update(
    void Function(ProcurementReceivePurchaseOrderRequestLinesInnerBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementReceivePurchaseOrderRequestLinesInner build() => _build();

  _$ProcurementReceivePurchaseOrderRequestLinesInner _build() {
    final _$result =
        _$v ??
        _$ProcurementReceivePurchaseOrderRequestLinesInner._(
          purchaseOrderItemId: BuiltValueNullFieldError.checkNotNull(
            purchaseOrderItemId,
            r'ProcurementReceivePurchaseOrderRequestLinesInner',
            'purchaseOrderItemId',
          ),
          quantityReceived: BuiltValueNullFieldError.checkNotNull(
            quantityReceived,
            r'ProcurementReceivePurchaseOrderRequestLinesInner',
            'quantityReceived',
          ),
          unitCost: unitCost,
          warehouseLocation: warehouseLocation,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
