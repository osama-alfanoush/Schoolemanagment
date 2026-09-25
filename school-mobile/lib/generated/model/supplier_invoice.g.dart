// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_invoice.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SupplierInvoice extends SupplierInvoice {
  @override
  final int id;
  @override
  final String invoiceNo;
  @override
  final String? supplierInvoiceRef;
  @override
  final int supplierId;
  @override
  final int? purchaseOrderId;
  @override
  final DateTime invoiceDate;
  @override
  final DateTime dueDate;
  @override
  final String amount;
  @override
  final String paidAmount;
  @override
  final String status;
  @override
  final String? notes;
  @override
  final int createdBy;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final int schoolId;

  factory _$SupplierInvoice([void Function(SupplierInvoiceBuilder)? updates]) =>
      (SupplierInvoiceBuilder()..update(updates))._build();

  _$SupplierInvoice._({
    required this.id,
    required this.invoiceNo,
    this.supplierInvoiceRef,
    required this.supplierId,
    this.purchaseOrderId,
    required this.invoiceDate,
    required this.dueDate,
    required this.amount,
    required this.paidAmount,
    required this.status,
    this.notes,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.schoolId,
  }) : super._();
  @override
  SupplierInvoice rebuild(void Function(SupplierInvoiceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SupplierInvoiceBuilder toBuilder() => SupplierInvoiceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SupplierInvoice &&
        id == other.id &&
        invoiceNo == other.invoiceNo &&
        supplierInvoiceRef == other.supplierInvoiceRef &&
        supplierId == other.supplierId &&
        purchaseOrderId == other.purchaseOrderId &&
        invoiceDate == other.invoiceDate &&
        dueDate == other.dueDate &&
        amount == other.amount &&
        paidAmount == other.paidAmount &&
        status == other.status &&
        notes == other.notes &&
        createdBy == other.createdBy &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        deletedAt == other.deletedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, invoiceNo.hashCode);
    _$hash = $jc(_$hash, supplierInvoiceRef.hashCode);
    _$hash = $jc(_$hash, supplierId.hashCode);
    _$hash = $jc(_$hash, purchaseOrderId.hashCode);
    _$hash = $jc(_$hash, invoiceDate.hashCode);
    _$hash = $jc(_$hash, dueDate.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, paidAmount.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, deletedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SupplierInvoice')
          ..add('id', id)
          ..add('invoiceNo', invoiceNo)
          ..add('supplierInvoiceRef', supplierInvoiceRef)
          ..add('supplierId', supplierId)
          ..add('purchaseOrderId', purchaseOrderId)
          ..add('invoiceDate', invoiceDate)
          ..add('dueDate', dueDate)
          ..add('amount', amount)
          ..add('paidAmount', paidAmount)
          ..add('status', status)
          ..add('notes', notes)
          ..add('createdBy', createdBy)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('deletedAt', deletedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class SupplierInvoiceBuilder
    implements Builder<SupplierInvoice, SupplierInvoiceBuilder> {
  _$SupplierInvoice? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _invoiceNo;
  String? get invoiceNo => _$this._invoiceNo;
  set invoiceNo(String? invoiceNo) => _$this._invoiceNo = invoiceNo;

  String? _supplierInvoiceRef;
  String? get supplierInvoiceRef => _$this._supplierInvoiceRef;
  set supplierInvoiceRef(String? supplierInvoiceRef) =>
      _$this._supplierInvoiceRef = supplierInvoiceRef;

  int? _supplierId;
  int? get supplierId => _$this._supplierId;
  set supplierId(int? supplierId) => _$this._supplierId = supplierId;

  int? _purchaseOrderId;
  int? get purchaseOrderId => _$this._purchaseOrderId;
  set purchaseOrderId(int? purchaseOrderId) =>
      _$this._purchaseOrderId = purchaseOrderId;

  DateTime? _invoiceDate;
  DateTime? get invoiceDate => _$this._invoiceDate;
  set invoiceDate(DateTime? invoiceDate) => _$this._invoiceDate = invoiceDate;

  DateTime? _dueDate;
  DateTime? get dueDate => _$this._dueDate;
  set dueDate(DateTime? dueDate) => _$this._dueDate = dueDate;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _paidAmount;
  String? get paidAmount => _$this._paidAmount;
  set paidAmount(String? paidAmount) => _$this._paidAmount = paidAmount;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  int? _createdBy;
  int? get createdBy => _$this._createdBy;
  set createdBy(int? createdBy) => _$this._createdBy = createdBy;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  DateTime? _deletedAt;
  DateTime? get deletedAt => _$this._deletedAt;
  set deletedAt(DateTime? deletedAt) => _$this._deletedAt = deletedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  SupplierInvoiceBuilder() {
    SupplierInvoice._defaults(this);
  }

  SupplierInvoiceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _invoiceNo = $v.invoiceNo;
      _supplierInvoiceRef = $v.supplierInvoiceRef;
      _supplierId = $v.supplierId;
      _purchaseOrderId = $v.purchaseOrderId;
      _invoiceDate = $v.invoiceDate;
      _dueDate = $v.dueDate;
      _amount = $v.amount;
      _paidAmount = $v.paidAmount;
      _status = $v.status;
      _notes = $v.notes;
      _createdBy = $v.createdBy;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _deletedAt = $v.deletedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SupplierInvoice other) {
    _$v = other as _$SupplierInvoice;
  }

  @override
  void update(void Function(SupplierInvoiceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SupplierInvoice build() => _build();

  _$SupplierInvoice _build() {
    final _$result =
        _$v ??
        _$SupplierInvoice._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'SupplierInvoice',
            'id',
          ),
          invoiceNo: BuiltValueNullFieldError.checkNotNull(
            invoiceNo,
            r'SupplierInvoice',
            'invoiceNo',
          ),
          supplierInvoiceRef: supplierInvoiceRef,
          supplierId: BuiltValueNullFieldError.checkNotNull(
            supplierId,
            r'SupplierInvoice',
            'supplierId',
          ),
          purchaseOrderId: purchaseOrderId,
          invoiceDate: BuiltValueNullFieldError.checkNotNull(
            invoiceDate,
            r'SupplierInvoice',
            'invoiceDate',
          ),
          dueDate: BuiltValueNullFieldError.checkNotNull(
            dueDate,
            r'SupplierInvoice',
            'dueDate',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'SupplierInvoice',
            'amount',
          ),
          paidAmount: BuiltValueNullFieldError.checkNotNull(
            paidAmount,
            r'SupplierInvoice',
            'paidAmount',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'SupplierInvoice',
            'status',
          ),
          notes: notes,
          createdBy: BuiltValueNullFieldError.checkNotNull(
            createdBy,
            r'SupplierInvoice',
            'createdBy',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'SupplierInvoice',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
