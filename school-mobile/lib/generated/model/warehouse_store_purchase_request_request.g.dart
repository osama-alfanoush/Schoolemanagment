// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_store_purchase_request_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseStorePurchaseRequestRequest
    extends WarehouseStorePurchaseRequestRequest {
  @override
  final int itemId;
  @override
  final num quantityRequested;
  @override
  final String unit;
  @override
  final String? justification;
  @override
  final num? estimatedCost;

  factory _$WarehouseStorePurchaseRequestRequest([
    void Function(WarehouseStorePurchaseRequestRequestBuilder)? updates,
  ]) =>
      (WarehouseStorePurchaseRequestRequestBuilder()..update(updates))._build();

  _$WarehouseStorePurchaseRequestRequest._({
    required this.itemId,
    required this.quantityRequested,
    required this.unit,
    this.justification,
    this.estimatedCost,
  }) : super._();
  @override
  WarehouseStorePurchaseRequestRequest rebuild(
    void Function(WarehouseStorePurchaseRequestRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseStorePurchaseRequestRequestBuilder toBuilder() =>
      WarehouseStorePurchaseRequestRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseStorePurchaseRequestRequest &&
        itemId == other.itemId &&
        quantityRequested == other.quantityRequested &&
        unit == other.unit &&
        justification == other.justification &&
        estimatedCost == other.estimatedCost;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, itemId.hashCode);
    _$hash = $jc(_$hash, quantityRequested.hashCode);
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jc(_$hash, justification.hashCode);
    _$hash = $jc(_$hash, estimatedCost.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WarehouseStorePurchaseRequestRequest')
          ..add('itemId', itemId)
          ..add('quantityRequested', quantityRequested)
          ..add('unit', unit)
          ..add('justification', justification)
          ..add('estimatedCost', estimatedCost))
        .toString();
  }
}

class WarehouseStorePurchaseRequestRequestBuilder
    implements
        Builder<
          WarehouseStorePurchaseRequestRequest,
          WarehouseStorePurchaseRequestRequestBuilder
        > {
  _$WarehouseStorePurchaseRequestRequest? _$v;

  int? _itemId;
  int? get itemId => _$this._itemId;
  set itemId(int? itemId) => _$this._itemId = itemId;

  num? _quantityRequested;
  num? get quantityRequested => _$this._quantityRequested;
  set quantityRequested(num? quantityRequested) =>
      _$this._quantityRequested = quantityRequested;

  String? _unit;
  String? get unit => _$this._unit;
  set unit(String? unit) => _$this._unit = unit;

  String? _justification;
  String? get justification => _$this._justification;
  set justification(String? justification) =>
      _$this._justification = justification;

  num? _estimatedCost;
  num? get estimatedCost => _$this._estimatedCost;
  set estimatedCost(num? estimatedCost) =>
      _$this._estimatedCost = estimatedCost;

  WarehouseStorePurchaseRequestRequestBuilder() {
    WarehouseStorePurchaseRequestRequest._defaults(this);
  }

  WarehouseStorePurchaseRequestRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _itemId = $v.itemId;
      _quantityRequested = $v.quantityRequested;
      _unit = $v.unit;
      _justification = $v.justification;
      _estimatedCost = $v.estimatedCost;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseStorePurchaseRequestRequest other) {
    _$v = other as _$WarehouseStorePurchaseRequestRequest;
  }

  @override
  void update(
    void Function(WarehouseStorePurchaseRequestRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseStorePurchaseRequestRequest build() => _build();

  _$WarehouseStorePurchaseRequestRequest _build() {
    final _$result =
        _$v ??
        _$WarehouseStorePurchaseRequestRequest._(
          itemId: BuiltValueNullFieldError.checkNotNull(
            itemId,
            r'WarehouseStorePurchaseRequestRequest',
            'itemId',
          ),
          quantityRequested: BuiltValueNullFieldError.checkNotNull(
            quantityRequested,
            r'WarehouseStorePurchaseRequestRequest',
            'quantityRequested',
          ),
          unit: BuiltValueNullFieldError.checkNotNull(
            unit,
            r'WarehouseStorePurchaseRequestRequest',
            'unit',
          ),
          justification: justification,
          estimatedCost: estimatedCost,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
