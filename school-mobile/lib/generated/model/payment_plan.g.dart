// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PaymentPlan extends PaymentPlan {
  @override
  final int id;
  @override
  final String planNo;
  @override
  final int studentUserId;
  @override
  final int? invoiceId;
  @override
  final String totalAmount;
  @override
  final String downPayment;
  @override
  final int numInstallments;
  @override
  final String frequency;
  @override
  final DateTime startDate;
  @override
  final String status;
  @override
  final int createdBy;
  @override
  final int? approvedBy;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final int schoolId;

  factory _$PaymentPlan([void Function(PaymentPlanBuilder)? updates]) =>
      (PaymentPlanBuilder()..update(updates))._build();

  _$PaymentPlan._({
    required this.id,
    required this.planNo,
    required this.studentUserId,
    this.invoiceId,
    required this.totalAmount,
    required this.downPayment,
    required this.numInstallments,
    required this.frequency,
    required this.startDate,
    required this.status,
    required this.createdBy,
    this.approvedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.schoolId,
  }) : super._();
  @override
  PaymentPlan rebuild(void Function(PaymentPlanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaymentPlanBuilder toBuilder() => PaymentPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PaymentPlan &&
        id == other.id &&
        planNo == other.planNo &&
        studentUserId == other.studentUserId &&
        invoiceId == other.invoiceId &&
        totalAmount == other.totalAmount &&
        downPayment == other.downPayment &&
        numInstallments == other.numInstallments &&
        frequency == other.frequency &&
        startDate == other.startDate &&
        status == other.status &&
        createdBy == other.createdBy &&
        approvedBy == other.approvedBy &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        deletedAt == other.deletedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, planNo.hashCode);
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, invoiceId.hashCode);
    _$hash = $jc(_$hash, totalAmount.hashCode);
    _$hash = $jc(_$hash, downPayment.hashCode);
    _$hash = $jc(_$hash, numInstallments.hashCode);
    _$hash = $jc(_$hash, frequency.hashCode);
    _$hash = $jc(_$hash, startDate.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, approvedBy.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, deletedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PaymentPlan')
          ..add('id', id)
          ..add('planNo', planNo)
          ..add('studentUserId', studentUserId)
          ..add('invoiceId', invoiceId)
          ..add('totalAmount', totalAmount)
          ..add('downPayment', downPayment)
          ..add('numInstallments', numInstallments)
          ..add('frequency', frequency)
          ..add('startDate', startDate)
          ..add('status', status)
          ..add('createdBy', createdBy)
          ..add('approvedBy', approvedBy)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('deletedAt', deletedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class PaymentPlanBuilder implements Builder<PaymentPlan, PaymentPlanBuilder> {
  _$PaymentPlan? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _planNo;
  String? get planNo => _$this._planNo;
  set planNo(String? planNo) => _$this._planNo = planNo;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  int? _invoiceId;
  int? get invoiceId => _$this._invoiceId;
  set invoiceId(int? invoiceId) => _$this._invoiceId = invoiceId;

  String? _totalAmount;
  String? get totalAmount => _$this._totalAmount;
  set totalAmount(String? totalAmount) => _$this._totalAmount = totalAmount;

  String? _downPayment;
  String? get downPayment => _$this._downPayment;
  set downPayment(String? downPayment) => _$this._downPayment = downPayment;

  int? _numInstallments;
  int? get numInstallments => _$this._numInstallments;
  set numInstallments(int? numInstallments) =>
      _$this._numInstallments = numInstallments;

  String? _frequency;
  String? get frequency => _$this._frequency;
  set frequency(String? frequency) => _$this._frequency = frequency;

  DateTime? _startDate;
  DateTime? get startDate => _$this._startDate;
  set startDate(DateTime? startDate) => _$this._startDate = startDate;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  int? _createdBy;
  int? get createdBy => _$this._createdBy;
  set createdBy(int? createdBy) => _$this._createdBy = createdBy;

  int? _approvedBy;
  int? get approvedBy => _$this._approvedBy;
  set approvedBy(int? approvedBy) => _$this._approvedBy = approvedBy;

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

  PaymentPlanBuilder() {
    PaymentPlan._defaults(this);
  }

  PaymentPlanBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _planNo = $v.planNo;
      _studentUserId = $v.studentUserId;
      _invoiceId = $v.invoiceId;
      _totalAmount = $v.totalAmount;
      _downPayment = $v.downPayment;
      _numInstallments = $v.numInstallments;
      _frequency = $v.frequency;
      _startDate = $v.startDate;
      _status = $v.status;
      _createdBy = $v.createdBy;
      _approvedBy = $v.approvedBy;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _deletedAt = $v.deletedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PaymentPlan other) {
    _$v = other as _$PaymentPlan;
  }

  @override
  void update(void Function(PaymentPlanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PaymentPlan build() => _build();

  _$PaymentPlan _build() {
    final _$result =
        _$v ??
        _$PaymentPlan._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'PaymentPlan', 'id'),
          planNo: BuiltValueNullFieldError.checkNotNull(
            planNo,
            r'PaymentPlan',
            'planNo',
          ),
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'PaymentPlan',
            'studentUserId',
          ),
          invoiceId: invoiceId,
          totalAmount: BuiltValueNullFieldError.checkNotNull(
            totalAmount,
            r'PaymentPlan',
            'totalAmount',
          ),
          downPayment: BuiltValueNullFieldError.checkNotNull(
            downPayment,
            r'PaymentPlan',
            'downPayment',
          ),
          numInstallments: BuiltValueNullFieldError.checkNotNull(
            numInstallments,
            r'PaymentPlan',
            'numInstallments',
          ),
          frequency: BuiltValueNullFieldError.checkNotNull(
            frequency,
            r'PaymentPlan',
            'frequency',
          ),
          startDate: BuiltValueNullFieldError.checkNotNull(
            startDate,
            r'PaymentPlan',
            'startDate',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'PaymentPlan',
            'status',
          ),
          createdBy: BuiltValueNullFieldError.checkNotNull(
            createdBy,
            r'PaymentPlan',
            'createdBy',
          ),
          approvedBy: approvedBy,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'PaymentPlan',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
