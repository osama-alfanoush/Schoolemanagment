// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_finance_store_invoice_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProcurementFinanceStoreInvoiceRequest
    extends ProcurementFinanceStoreInvoiceRequest {
  @override
  final int supplierId;
  @override
  final int? purchaseOrderId;
  @override
  final String? supplierInvoiceRef;
  @override
  final DateTime invoiceDate;
  @override
  final DateTime dueDate;
  @override
  final num amount;
  @override
  final String? notes;

  factory _$ProcurementFinanceStoreInvoiceRequest([
    void Function(ProcurementFinanceStoreInvoiceRequestBuilder)? updates,
  ]) => (ProcurementFinanceStoreInvoiceRequestBuilder()..update(updates))
      ._build();

  _$ProcurementFinanceStoreInvoiceRequest._({
    required this.supplierId,
    this.purchaseOrderId,
    this.supplierInvoiceRef,
    required this.invoiceDate,
    required this.dueDate,
    required this.amount,
    this.notes,
  }) : super._();
  @override
  ProcurementFinanceStoreInvoiceRequest rebuild(
    void Function(ProcurementFinanceStoreInvoiceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementFinanceStoreInvoiceRequestBuilder toBuilder() =>
      ProcurementFinanceStoreInvoiceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementFinanceStoreInvoiceRequest &&
        supplierId == other.supplierId &&
        purchaseOrderId == other.purchaseOrderId &&
        supplierInvoiceRef == other.supplierInvoiceRef &&
        invoiceDate == other.invoiceDate &&
        dueDate == other.dueDate &&
        amount == other.amount &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, supplierId.hashCode);
    _$hash = $jc(_$hash, purchaseOrderId.hashCode);
    _$hash = $jc(_$hash, supplierInvoiceRef.hashCode);
    _$hash = $jc(_$hash, invoiceDate.hashCode);
    _$hash = $jc(_$hash, dueDate.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ProcurementFinanceStoreInvoiceRequest',
          )
          ..add('supplierId', supplierId)
          ..add('purchaseOrderId', purchaseOrderId)
          ..add('supplierInvoiceRef', supplierInvoiceRef)
          ..add('invoiceDate', invoiceDate)
          ..add('dueDate', dueDate)
          ..add('amount', amount)
          ..add('notes', notes))
        .toString();
  }
}

class ProcurementFinanceStoreInvoiceRequestBuilder
    implements
        Builder<
          ProcurementFinanceStoreInvoiceRequest,
          ProcurementFinanceStoreInvoiceRequestBuilder
        > {
  _$ProcurementFinanceStoreInvoiceRequest? _$v;

  int? _supplierId;
  int? get supplierId => _$this._supplierId;
  set supplierId(int? supplierId) => _$this._supplierId = supplierId;

  int? _purchaseOrderId;
  int? get purchaseOrderId => _$this._purchaseOrderId;
  set purchaseOrderId(int? purchaseOrderId) =>
      _$this._purchaseOrderId = purchaseOrderId;

  String? _supplierInvoiceRef;
  String? get supplierInvoiceRef => _$this._supplierInvoiceRef;
  set supplierInvoiceRef(String? supplierInvoiceRef) =>
      _$this._supplierInvoiceRef = supplierInvoiceRef;

  DateTime? _invoiceDate;
  DateTime? get invoiceDate => _$this._invoiceDate;
  set invoiceDate(DateTime? invoiceDate) => _$this._invoiceDate = invoiceDate;

  DateTime? _dueDate;
  DateTime? get dueDate => _$this._dueDate;
  set dueDate(DateTime? dueDate) => _$this._dueDate = dueDate;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  ProcurementFinanceStoreInvoiceRequestBuilder() {
    ProcurementFinanceStoreInvoiceRequest._defaults(this);
  }

  ProcurementFinanceStoreInvoiceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _supplierId = $v.supplierId;
      _purchaseOrderId = $v.purchaseOrderId;
      _supplierInvoiceRef = $v.supplierInvoiceRef;
      _invoiceDate = $v.invoiceDate;
      _dueDate = $v.dueDate;
      _amount = $v.amount;
      _notes = $v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProcurementFinanceStoreInvoiceRequest other) {
    _$v = other as _$ProcurementFinanceStoreInvoiceRequest;
  }

  @override
  void update(
    void Function(ProcurementFinanceStoreInvoiceRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementFinanceStoreInvoiceRequest build() => _build();

  _$ProcurementFinanceStoreInvoiceRequest _build() {
    final _$result =
        _$v ??
        _$ProcurementFinanceStoreInvoiceRequest._(
          supplierId: BuiltValueNullFieldError.checkNotNull(
            supplierId,
            r'ProcurementFinanceStoreInvoiceRequest',
            'supplierId',
          ),
          purchaseOrderId: purchaseOrderId,
          supplierInvoiceRef: supplierInvoiceRef,
          invoiceDate: BuiltValueNullFieldError.checkNotNull(
            invoiceDate,
            r'ProcurementFinanceStoreInvoiceRequest',
            'invoiceDate',
          ),
          dueDate: BuiltValueNullFieldError.checkNotNull(
            dueDate,
            r'ProcurementFinanceStoreInvoiceRequest',
            'dueDate',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'ProcurementFinanceStoreInvoiceRequest',
            'amount',
          ),
          notes: notes,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
