// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_payment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SupplierPayment extends SupplierPayment {
  @override
  final int id;
  @override
  final int supplierInvoiceId;
  @override
  final String amount;
  @override
  final String method;
  @override
  final String? reference;
  @override
  final int recordedBy;
  @override
  final int? approvedBy;
  @override
  final DateTime paidAt;
  @override
  final String? note;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$SupplierPayment([void Function(SupplierPaymentBuilder)? updates]) =>
      (SupplierPaymentBuilder()..update(updates))._build();

  _$SupplierPayment._({
    required this.id,
    required this.supplierInvoiceId,
    required this.amount,
    required this.method,
    this.reference,
    required this.recordedBy,
    this.approvedBy,
    required this.paidAt,
    this.note,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  SupplierPayment rebuild(void Function(SupplierPaymentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SupplierPaymentBuilder toBuilder() => SupplierPaymentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SupplierPayment &&
        id == other.id &&
        supplierInvoiceId == other.supplierInvoiceId &&
        amount == other.amount &&
        method == other.method &&
        reference == other.reference &&
        recordedBy == other.recordedBy &&
        approvedBy == other.approvedBy &&
        paidAt == other.paidAt &&
        note == other.note &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, supplierInvoiceId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, method.hashCode);
    _$hash = $jc(_$hash, reference.hashCode);
    _$hash = $jc(_$hash, recordedBy.hashCode);
    _$hash = $jc(_$hash, approvedBy.hashCode);
    _$hash = $jc(_$hash, paidAt.hashCode);
    _$hash = $jc(_$hash, note.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SupplierPayment')
          ..add('id', id)
          ..add('supplierInvoiceId', supplierInvoiceId)
          ..add('amount', amount)
          ..add('method', method)
          ..add('reference', reference)
          ..add('recordedBy', recordedBy)
          ..add('approvedBy', approvedBy)
          ..add('paidAt', paidAt)
          ..add('note', note)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class SupplierPaymentBuilder
    implements Builder<SupplierPayment, SupplierPaymentBuilder> {
  _$SupplierPayment? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _supplierInvoiceId;
  int? get supplierInvoiceId => _$this._supplierInvoiceId;
  set supplierInvoiceId(int? supplierInvoiceId) =>
      _$this._supplierInvoiceId = supplierInvoiceId;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _method;
  String? get method => _$this._method;
  set method(String? method) => _$this._method = method;

  String? _reference;
  String? get reference => _$this._reference;
  set reference(String? reference) => _$this._reference = reference;

  int? _recordedBy;
  int? get recordedBy => _$this._recordedBy;
  set recordedBy(int? recordedBy) => _$this._recordedBy = recordedBy;

  int? _approvedBy;
  int? get approvedBy => _$this._approvedBy;
  set approvedBy(int? approvedBy) => _$this._approvedBy = approvedBy;

  DateTime? _paidAt;
  DateTime? get paidAt => _$this._paidAt;
  set paidAt(DateTime? paidAt) => _$this._paidAt = paidAt;

  String? _note;
  String? get note => _$this._note;
  set note(String? note) => _$this._note = note;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  SupplierPaymentBuilder() {
    SupplierPayment._defaults(this);
  }

  SupplierPaymentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _supplierInvoiceId = $v.supplierInvoiceId;
      _amount = $v.amount;
      _method = $v.method;
      _reference = $v.reference;
      _recordedBy = $v.recordedBy;
      _approvedBy = $v.approvedBy;
      _paidAt = $v.paidAt;
      _note = $v.note;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SupplierPayment other) {
    _$v = other as _$SupplierPayment;
  }

  @override
  void update(void Function(SupplierPaymentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SupplierPayment build() => _build();

  _$SupplierPayment _build() {
    final _$result =
        _$v ??
        _$SupplierPayment._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'SupplierPayment',
            'id',
          ),
          supplierInvoiceId: BuiltValueNullFieldError.checkNotNull(
            supplierInvoiceId,
            r'SupplierPayment',
            'supplierInvoiceId',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'SupplierPayment',
            'amount',
          ),
          method: BuiltValueNullFieldError.checkNotNull(
            method,
            r'SupplierPayment',
            'method',
          ),
          reference: reference,
          recordedBy: BuiltValueNullFieldError.checkNotNull(
            recordedBy,
            r'SupplierPayment',
            'recordedBy',
          ),
          approvedBy: approvedBy,
          paidAt: BuiltValueNullFieldError.checkNotNull(
            paidAt,
            r'SupplierPayment',
            'paidAt',
          ),
          note: note,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'SupplierPayment',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
