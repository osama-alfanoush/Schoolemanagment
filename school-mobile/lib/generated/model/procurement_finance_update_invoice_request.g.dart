// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'procurement_finance_update_invoice_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProcurementFinanceUpdateInvoiceRequest
    extends ProcurementFinanceUpdateInvoiceRequest {
  @override
  final String? supplierInvoiceRef;
  @override
  final DateTime? invoiceDate;
  @override
  final DateTime? dueDate;
  @override
  final num? amount;
  @override
  final String? notes;

  factory _$ProcurementFinanceUpdateInvoiceRequest([
    void Function(ProcurementFinanceUpdateInvoiceRequestBuilder)? updates,
  ]) => (ProcurementFinanceUpdateInvoiceRequestBuilder()..update(updates))
      ._build();

  _$ProcurementFinanceUpdateInvoiceRequest._({
    this.supplierInvoiceRef,
    this.invoiceDate,
    this.dueDate,
    this.amount,
    this.notes,
  }) : super._();
  @override
  ProcurementFinanceUpdateInvoiceRequest rebuild(
    void Function(ProcurementFinanceUpdateInvoiceRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ProcurementFinanceUpdateInvoiceRequestBuilder toBuilder() =>
      ProcurementFinanceUpdateInvoiceRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProcurementFinanceUpdateInvoiceRequest &&
        supplierInvoiceRef == other.supplierInvoiceRef &&
        invoiceDate == other.invoiceDate &&
        dueDate == other.dueDate &&
        amount == other.amount &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
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
            r'ProcurementFinanceUpdateInvoiceRequest',
          )
          ..add('supplierInvoiceRef', supplierInvoiceRef)
          ..add('invoiceDate', invoiceDate)
          ..add('dueDate', dueDate)
          ..add('amount', amount)
          ..add('notes', notes))
        .toString();
  }
}

class ProcurementFinanceUpdateInvoiceRequestBuilder
    implements
        Builder<
          ProcurementFinanceUpdateInvoiceRequest,
          ProcurementFinanceUpdateInvoiceRequestBuilder
        > {
  _$ProcurementFinanceUpdateInvoiceRequest? _$v;

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

  ProcurementFinanceUpdateInvoiceRequestBuilder() {
    ProcurementFinanceUpdateInvoiceRequest._defaults(this);
  }

  ProcurementFinanceUpdateInvoiceRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
  void replace(ProcurementFinanceUpdateInvoiceRequest other) {
    _$v = other as _$ProcurementFinanceUpdateInvoiceRequest;
  }

  @override
  void update(
    void Function(ProcurementFinanceUpdateInvoiceRequestBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ProcurementFinanceUpdateInvoiceRequest build() => _build();

  _$ProcurementFinanceUpdateInvoiceRequest _build() {
    final _$result =
        _$v ??
        _$ProcurementFinanceUpdateInvoiceRequest._(
          supplierInvoiceRef: supplierInvoiceRef,
          invoiceDate: invoiceDate,
          dueDate: dueDate,
          amount: amount,
          notes: notes,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
