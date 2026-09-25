// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_update_purchase_order_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProcurementUpdatePurchaseOrderRequest
    extends ProcurementUpdatePurchaseOrderRequest {
  @override
  final DateTime? expectedDate;
  @override
  final num? tax;
  @override
  final String? notes;
  @override
  final BuiltList<ProcurementUpdatePurchaseOrderRequestItemsInner>? items;

  factory _$ProcurementUpdatePurchaseOrderRequest([
    void Function(ProcurementUpdatePurchaseOrderRequestBuilder)? updates,
  ]) => (ProcurementUpdatePurchaseOrderRequestBuilder()..update(updates))
      ._build();

  _$ProcurementUpdatePurchaseOrderRequest._({
    this.expectedDate,
    this.tax,
    this.notes,
    this.items,
  }) : super._();
  @override
  ProcurementUpdatePurchaseOrderRequest rebuild(
    void Function(ProcurementUpdatePurchaseOrderRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementUpdatePurchaseOrderRequestBuilder toBuilder() =>
      ProcurementUpdatePurchaseOrderRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementUpdatePurchaseOrderRequest &&
        expectedDate == other.expectedDate &&
        tax == other.tax &&
        notes == other.notes &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, expectedDate.hashCode);
    _$hash = $jc(_$hash, tax.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ProcurementUpdatePurchaseOrderRequest',
          )
          ..add('expectedDate', expectedDate)
          ..add('tax', tax)
          ..add('notes', notes)
          ..add('items', items))
        .toString();
  }
}

class ProcurementUpdatePurchaseOrderRequestBuilder
    implements
        Builder<
          ProcurementUpdatePurchaseOrderRequest,
          ProcurementUpdatePurchaseOrderRequestBuilder
        > {
  _$ProcurementUpdatePurchaseOrderRequest? _$v;

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

  ListBuilder<ProcurementUpdatePurchaseOrderRequestItemsInner>? _items;
  ListBuilder<ProcurementUpdatePurchaseOrderRequestItemsInner> get items =>
      _$this._items ??=
          ListBuilder<ProcurementUpdatePurchaseOrderRequestItemsInner>();
  set items(
    ListBuilder<ProcurementUpdatePurchaseOrderRequestItemsInner>? items,
  ) => _$this._items = items;

  ProcurementUpdatePurchaseOrderRequestBuilder() {
    ProcurementUpdatePurchaseOrderRequest._defaults(this);
  }

  ProcurementUpdatePurchaseOrderRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _expectedDate = $v.expectedDate;
      _tax = $v.tax;
      _notes = $v.notes;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcurementUpdatePurchaseOrderRequest other) {
    _$v = other as _$ProcurementUpdatePurchaseOrderRequest;
  }

  @override
  void update(
    void Function(ProcurementUpdatePurchaseOrderRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementUpdatePurchaseOrderRequest build() => _build();

  _$ProcurementUpdatePurchaseOrderRequest _build() {
    _$ProcurementUpdatePurchaseOrderRequest _$result;
    try {
      _$result =
          _$v ??
          _$ProcurementUpdatePurchaseOrderRequest._(
            expectedDate: expectedDate,
            tax: tax,
            notes: notes,
            items: _items?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ProcurementUpdatePurchaseOrderRequest',
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
