// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_dashboard200_response_top_consumed_items_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseDashboard200ResponseTopConsumedItemsInner
    extends WarehouseDashboard200ResponseTopConsumedItemsInner {
  @override
  final String? itemName;
  @override
  final String? sku;
  @override
  final num totalOut;
  @override
  final String? unit;

  factory _$WarehouseDashboard200ResponseTopConsumedItemsInner([
    void Function(WarehouseDashboard200ResponseTopConsumedItemsInnerBuilder)?
    updates,
  ]) =>
      (WarehouseDashboard200ResponseTopConsumedItemsInnerBuilder()
            ..update(updates))
          ._build();

  _$WarehouseDashboard200ResponseTopConsumedItemsInner._({
    this.itemName,
    this.sku,
    required this.totalOut,
    this.unit,
  }) : super._();
  @override
  WarehouseDashboard200ResponseTopConsumedItemsInner rebuild(
    void Function(WarehouseDashboard200ResponseTopConsumedItemsInnerBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseDashboard200ResponseTopConsumedItemsInnerBuilder toBuilder() =>
      WarehouseDashboard200ResponseTopConsumedItemsInnerBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseDashboard200ResponseTopConsumedItemsInner &&
        itemName == other.itemName &&
        sku == other.sku &&
        totalOut == other.totalOut &&
        unit == other.unit;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, itemName.hashCode);
    _$hash = $jc(_$hash, sku.hashCode);
    _$hash = $jc(_$hash, totalOut.hashCode);
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'WarehouseDashboard200ResponseTopConsumedItemsInner',
          )
          ..add('itemName', itemName)
          ..add('sku', sku)
          ..add('totalOut', totalOut)
          ..add('unit', unit))
        .toString();
  }
}

class WarehouseDashboard200ResponseTopConsumedItemsInnerBuilder
    implements
        Builder<
          WarehouseDashboard200ResponseTopConsumedItemsInner,
          WarehouseDashboard200ResponseTopConsumedItemsInnerBuilder
        > {
  _$WarehouseDashboard200ResponseTopConsumedItemsInner? _$v;

  String? _itemName;
  String? get itemName => _$this._itemName;
  set itemName(String? itemName) => _$this._itemName = itemName;

  String? _sku;
  String? get sku => _$this._sku;
  set sku(String? sku) => _$this._sku = sku;

  num? _totalOut;
  num? get totalOut => _$this._totalOut;
  set totalOut(num? totalOut) => _$this._totalOut = totalOut;

  String? _unit;
  String? get unit => _$this._unit;
  set unit(String? unit) => _$this._unit = unit;

  WarehouseDashboard200ResponseTopConsumedItemsInnerBuilder() {
    WarehouseDashboard200ResponseTopConsumedItemsInner._defaults(this);
  }

  WarehouseDashboard200ResponseTopConsumedItemsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _itemName = $v.itemName;
      _sku = $v.sku;
      _totalOut = $v.totalOut;
      _unit = $v.unit;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseDashboard200ResponseTopConsumedItemsInner other) {
    _$v = other as _$WarehouseDashboard200ResponseTopConsumedItemsInner;
  }

  @override
  void update(
    void Function(WarehouseDashboard200ResponseTopConsumedItemsInnerBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseDashboard200ResponseTopConsumedItemsInner build() => _build();

  _$WarehouseDashboard200ResponseTopConsumedItemsInner _build() {
    final _$result =
        _$v ??
        _$WarehouseDashboard200ResponseTopConsumedItemsInner._(
          itemName: itemName,
          sku: sku,
          totalOut: BuiltValueNullFieldError.checkNotNull(
            totalOut,
            r'WarehouseDashboard200ResponseTopConsumedItemsInner',
            'totalOut',
          ),
          unit: unit,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
