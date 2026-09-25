// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_store_counts_request_items_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WarehouseStoreCountsRequestItemsInner
    extends WarehouseStoreCountsRequestItemsInner {
  @override
  final int itemId;
  @override
  final num physicalQty;
  @override
  final String? notes;

  factory _$WarehouseStoreCountsRequestItemsInner([
    void Function(WarehouseStoreCountsRequestItemsInnerBuilder)? updates,
  ]) => (WarehouseStoreCountsRequestItemsInnerBuilder()..update(updates))
      ._build();

  _$WarehouseStoreCountsRequestItemsInner._({
    required this.itemId,
    required this.physicalQty,
    this.notes,
  }) : super._();
  @override
  WarehouseStoreCountsRequestItemsInner rebuild(
    void Function(WarehouseStoreCountsRequestItemsInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  WarehouseStoreCountsRequestItemsInnerBuilder toBuilder() =>
      WarehouseStoreCountsRequestItemsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WarehouseStoreCountsRequestItemsInner &&
        itemId == other.itemId &&
        physicalQty == other.physicalQty &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, itemId.hashCode);
    _$hash = $jc(_$hash, physicalQty.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'WarehouseStoreCountsRequestItemsInner',
          )
          ..add('itemId', itemId)
          ..add('physicalQty', physicalQty)
          ..add('notes', notes))
        .toString();
  }
}

class WarehouseStoreCountsRequestItemsInnerBuilder
    implements
        Builder<
          WarehouseStoreCountsRequestItemsInner,
          WarehouseStoreCountsRequestItemsInnerBuilder
        > {
  _$WarehouseStoreCountsRequestItemsInner? _$v;

  int? _itemId;
  int? get itemId => _$this._itemId;
  set itemId(int? itemId) => _$this._itemId = itemId;

  num? _physicalQty;
  num? get physicalQty => _$this._physicalQty;
  set physicalQty(num? physicalQty) => _$this._physicalQty = physicalQty;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  WarehouseStoreCountsRequestItemsInnerBuilder() {
    WarehouseStoreCountsRequestItemsInner._defaults(this);
  }

  WarehouseStoreCountsRequestItemsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _itemId = $v.itemId;
      _physicalQty = $v.physicalQty;
      _notes = $v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WarehouseStoreCountsRequestItemsInner other) {
    _$v = other as _$WarehouseStoreCountsRequestItemsInner;
  }

  @override
  void update(
    void Function(WarehouseStoreCountsRequestItemsInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  WarehouseStoreCountsRequestItemsInner build() => _build();

  _$WarehouseStoreCountsRequestItemsInner _build() {
    final _$result =
        _$v ??
        _$WarehouseStoreCountsRequestItemsInner._(
          itemId: BuiltValueNullFieldError.checkNotNull(
            itemId,
            r'WarehouseStoreCountsRequestItemsInner',
            'itemId',
          ),
          physicalQty: BuiltValueNullFieldError.checkNotNull(
            physicalQty,
            r'WarehouseStoreCountsRequestItemsInner',
            'physicalQty',
          ),
          notes: notes,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
