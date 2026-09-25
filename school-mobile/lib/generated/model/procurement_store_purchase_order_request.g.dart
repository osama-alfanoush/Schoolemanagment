// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_store_purchase_order_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProcurementStorePurchaseOrderRequest
    extends ProcurementStorePurchaseOrderRequest {
  @override
  final int supplierId;
  @override
  final DateTime orderDate;
  @override
  final DateTime? expectedDate;
  @override
  final num? tax;
  @override
  final String? notes;
  @override
  final int? purchaseRequestId;
  @override
  final BuiltList<ProcurementStorePurchaseOrderRequestItemsInner> items;

  factory _$ProcurementStorePurchaseOrderRequest([
    void Function(ProcurementStorePurchaseOrderRequestBuilder)? updates,
  ]) =>
      (ProcurementStorePurchaseOrderRequestBuilder()..update(updates))._build();

  _$ProcurementStorePurchaseOrderRequest._({
    required this.supplierId,
    required this.orderDate,
    this.expectedDate,
    this.tax,
    this.notes,
    this.purchaseRequestId,
    required this.items,
  }) : super._();
  @override
  ProcurementStorePurchaseOrderRequest rebuild(
    void Function(ProcurementStorePurchaseOrderRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementStorePurchaseOrderRequestBuilder toBuilder() =>
      ProcurementStorePurchaseOrderRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementStorePurchaseOrderRequest &&
        supplierId == other.supplierId &&
        orderDate == other.orderDate &&
        expectedDate == other.expectedDate &&
        tax == other.tax &&
        notes == other.notes &&
        purchaseRequestId == other.purchaseRequestId &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, supplierId.hashCode);
    _$hash = $jc(_$hash, orderDate.hashCode);
    _$hash = $jc(_$hash, expectedDate.hashCode);
    _$hash = $jc(_$hash, tax.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, purchaseRequestId.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProcurementStorePurchaseOrderRequest')
          ..add('supplierId', supplierId)
          ..add('orderDate', orderDate)
          ..add('expectedDate', expectedDate)
          ..add('tax', tax)
          ..add('notes', notes)
          ..add('purchaseRequestId', purchaseRequestId)
          ..add('items', items))
        .toString();
  }
}

class ProcurementStorePurchaseOrderRequestBuilder
    implements
        Builder<
          ProcurementStorePurchaseOrderRequest,
          ProcurementStorePurchaseOrderRequestBuilder
        > {
  _$ProcurementStorePurchaseOrderRequest? _$v;

  int? _supplierId;
  int? get supplierId => _$this._supplierId;
  set supplierId(int? supplierId) => _$this._supplierId = supplierId;

  DateTime? _orderDate;
  DateTime? get orderDate => _$this._orderDate;
  set orderDate(DateTime? orderDate) => _$this._orderDate = orderDate;

  DateTime? _expectedDate;
  DateTime? get expectedDate => _$this._expectedDate;
  set expectedDate(DateTime? expectedDate) =>
      _$this._expectedDate = expectedDate;

  num? _tax;
  num? get tax => _$this._tax;
  set tax(num? tax) => _$this._tax = tax;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  int? _purchaseRequestId;
  int? get purchaseRequestId => _$this._purchaseRequestId;
  set purchaseRequestId(int? purchaseRequestId) =>
      _$this._purchaseRequestId = purchaseRequestId;

  ListBuilder<ProcurementStorePurchaseOrderRequestItemsInner>? _items;
  ListBuilder<ProcurementStorePurchaseOrderRequestItemsInner> get items =>
      _$this._items ??=
          ListBuilder<ProcurementStorePurchaseOrderRequestItemsInner>();
  set items(
    ListBuilder<ProcurementStorePurchaseOrderRequestItemsInner>? items,
  ) => _$this._items = items;

  ProcurementStorePurchaseOrderRequestBuilder() {
    ProcurementStorePurchaseOrderRequest._defaults(this);
  }

  ProcurementStorePurchaseOrderRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _supplierId = $v.supplierId;
      _orderDate = $v.orderDate;
      _expectedDate = $v.expectedDate;
      _tax = $v.tax;
      _notes = $v.notes;
      _purchaseRequestId = $v.purchaseRequestId;
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcurementStorePurchaseOrderRequest other) {
    _$v = other as _$ProcurementStorePurchaseOrderRequest;
  }

  @override
  void update(
    void Function(ProcurementStorePurchaseOrderRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementStorePurchaseOrderRequest build() => _build();

  _$ProcurementStorePurchaseOrderRequest _build() {
    _$ProcurementStorePurchaseOrderRequest _$result;
    try {
      _$result =
          _$v ??
          _$ProcurementStorePurchaseOrderRequest._(
            supplierId: BuiltValueNullFieldError.checkNotNull(
              supplierId,
              r'ProcurementStorePurchaseOrderRequest',
              'supplierId',
            ),
            orderDate: BuiltValueNullFieldError.checkNotNull(
              orderDate,
              r'ProcurementStorePurchaseOrderRequest',
              'orderDate',
            ),
            expectedDate: expectedDate,
            tax: tax,
            notes: notes,
            purchaseRequestId: purchaseRequestId,
            items: items.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ProcurementStorePurchaseOrderRequest',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
