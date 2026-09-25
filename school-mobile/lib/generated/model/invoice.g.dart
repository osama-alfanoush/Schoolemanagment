// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Invoice extends Invoice {
  @override
  final int id;
  @override
  final int studentUserId;
  @override
  final int? feeStructureId;
  @override
  final String invoiceNo;
  @override
  final String description;
  @override
  final String amount;
  @override
  final String paidAmount;
  @override
  final DateTime dueDate;
  @override
  final String status;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;
  @override
  final int? studentEnrollmentId;
  @override
  final int? billingPeriodId;
  @override
  final int? generationBatchId;
  @override
  final int generationVersion;
  @override
  final String credits;

  factory _$Invoice([void Function(InvoiceBuilder)? updates]) =>
      (InvoiceBuilder()..update(updates))._build();

  _$Invoice._({
    required this.id,
    required this.studentUserId,
    this.feeStructureId,
    required this.invoiceNo,
    required this.description,
    required this.amount,
    required this.paidAmount,
    required this.dueDate,
    required this.status,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
    this.studentEnrollmentId,
    this.billingPeriodId,
    this.generationBatchId,
    required this.generationVersion,
    required this.credits,
  }) : super._();
  @override
  Invoice rebuild(void Function(InvoiceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvoiceBuilder toBuilder() => InvoiceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Invoice &&
        id == other.id &&
        studentUserId == other.studentUserId &&
        feeStructureId == other.feeStructureId &&
        invoiceNo == other.invoiceNo &&
        description == other.description &&
        amount == other.amount &&
        paidAmount == other.paidAmount &&
        dueDate == other.dueDate &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId &&
        studentEnrollmentId == other.studentEnrollmentId &&
        billingPeriodId == other.billingPeriodId &&
        generationBatchId == other.generationBatchId &&
        generationVersion == other.generationVersion &&
        credits == other.credits;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, feeStructureId.hashCode);
    _$hash = $jc(_$hash, invoiceNo.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, paidAmount.hashCode);
    _$hash = $jc(_$hash, dueDate.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, studentEnrollmentId.hashCode);
    _$hash = $jc(_$hash, billingPeriodId.hashCode);
    _$hash = $jc(_$hash, generationBatchId.hashCode);
    _$hash = $jc(_$hash, generationVersion.hashCode);
    _$hash = $jc(_$hash, credits.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Invoice')
          ..add('id', id)
          ..add('studentUserId', studentUserId)
          ..add('feeStructureId', feeStructureId)
          ..add('invoiceNo', invoiceNo)
          ..add('description', description)
          ..add('amount', amount)
          ..add('paidAmount', paidAmount)
          ..add('dueDate', dueDate)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId)
          ..add('studentEnrollmentId', studentEnrollmentId)
          ..add('billingPeriodId', billingPeriodId)
          ..add('generationBatchId', generationBatchId)
          ..add('generationVersion', generationVersion)
          ..add('credits', credits))
        .toString();
  }
}

class InvoiceBuilder implements Builder<Invoice, InvoiceBuilder> {
  _$Invoice? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  int? _feeStructureId;
  int? get feeStructureId => _$this._feeStructureId;
  set feeStructureId(int? feeStructureId) =>
      _$this._feeStructureId = feeStructureId;

  String? _invoiceNo;
  String? get invoiceNo => _$this._invoiceNo;
  set invoiceNo(String? invoiceNo) => _$this._invoiceNo = invoiceNo;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _paidAmount;
  String? get paidAmount => _$this._paidAmount;
  set paidAmount(String? paidAmount) => _$this._paidAmount = paidAmount;

  DateTime? _dueDate;
  DateTime? get dueDate => _$this._dueDate;
  set dueDate(DateTime? dueDate) => _$this._dueDate = dueDate;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  int? _studentEnrollmentId;
  int? get studentEnrollmentId => _$this._studentEnrollmentId;
  set studentEnrollmentId(int? studentEnrollmentId) =>
      _$this._studentEnrollmentId = studentEnrollmentId;

  int? _billingPeriodId;
  int? get billingPeriodId => _$this._billingPeriodId;
  set billingPeriodId(int? billingPeriodId) =>
      _$this._billingPeriodId = billingPeriodId;

  int? _generationBatchId;
  int? get generationBatchId => _$this._generationBatchId;
  set generationBatchId(int? generationBatchId) =>
      _$this._generationBatchId = generationBatchId;

  int? _generationVersion;
  int? get generationVersion => _$this._generationVersion;
  set generationVersion(int? generationVersion) =>
      _$this._generationVersion = generationVersion;

  String? _credits;
  String? get credits => _$this._credits;
  set credits(String? credits) => _$this._credits = credits;

  InvoiceBuilder() {
    Invoice._defaults(this);
  }

  InvoiceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _studentUserId = $v.studentUserId;
      _feeStructureId = $v.feeStructureId;
      _invoiceNo = $v.invoiceNo;
      _description = $v.description;
      _amount = $v.amount;
      _paidAmount = $v.paidAmount;
      _dueDate = $v.dueDate;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _studentEnrollmentId = $v.studentEnrollmentId;
      _billingPeriodId = $v.billingPeriodId;
      _generationBatchId = $v.generationBatchId;
      _generationVersion = $v.generationVersion;
      _credits = $v.credits;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Invoice other) {
    _$v = other as _$Invoice;
  }

  @override
  void update(void Function(InvoiceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Invoice build() => _build();

  _$Invoice _build() {
    final _$result =
        _$v ??
        _$Invoice._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Invoice', 'id'),
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'Invoice',
            'studentUserId',
          ),
          feeStructureId: feeStructureId,
          invoiceNo: BuiltValueNullFieldError.checkNotNull(
            invoiceNo,
            r'Invoice',
            'invoiceNo',
          ),
          description: BuiltValueNullFieldError.checkNotNull(
            description,
            r'Invoice',
            'description',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'Invoice',
            'amount',
          ),
          paidAmount: BuiltValueNullFieldError.checkNotNull(
            paidAmount,
            r'Invoice',
            'paidAmount',
          ),
          dueDate: BuiltValueNullFieldError.checkNotNull(
            dueDate,
            r'Invoice',
            'dueDate',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'Invoice',
            'status',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'Invoice',
            'schoolId',
          ),
          studentEnrollmentId: studentEnrollmentId,
          billingPeriodId: billingPeriodId,
          generationBatchId: generationBatchId,
          generationVersion: BuiltValueNullFieldError.checkNotNull(
            generationVersion,
            r'Invoice',
            'generationVersion',
          ),
          credits: BuiltValueNullFieldError.checkNotNull(
            credits,
            r'Invoice',
            'credits',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
