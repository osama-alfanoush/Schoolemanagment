// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Installment extends Installment {
  @override
  final int id;
  @override
  final int paymentPlanId;
  @override
  final int sequenceNo;
  @override
  final DateTime dueDate;
  @override
  final String amount;
  @override
  final String paidAmount;
  @override
  final String status;
  @override
  final int? paymentId;
  @override
  final DateTime? paidAt;
  @override
  final DateTime? reminderSentAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$Installment([void Function(InstallmentBuilder)? updates]) =>
      (InstallmentBuilder()..update(updates))._build();

  _$Installment._({
    required this.id,
    required this.paymentPlanId,
    required this.sequenceNo,
    required this.dueDate,
    required this.amount,
    required this.paidAmount,
    required this.status,
    this.paymentId,
    this.paidAt,
    this.reminderSentAt,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  Installment rebuild(void Function(InstallmentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InstallmentBuilder toBuilder() => InstallmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Installment &&
        id == other.id &&
        paymentPlanId == other.paymentPlanId &&
        sequenceNo == other.sequenceNo &&
        dueDate == other.dueDate &&
        amount == other.amount &&
        paidAmount == other.paidAmount &&
        status == other.status &&
        paymentId == other.paymentId &&
        paidAt == other.paidAt &&
        reminderSentAt == other.reminderSentAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, paymentPlanId.hashCode);
    _$hash = $jc(_$hash, sequenceNo.hashCode);
    _$hash = $jc(_$hash, dueDate.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, paidAmount.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, paymentId.hashCode);
    _$hash = $jc(_$hash, paidAt.hashCode);
    _$hash = $jc(_$hash, reminderSentAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Installment')
          ..add('id', id)
          ..add('paymentPlanId', paymentPlanId)
          ..add('sequenceNo', sequenceNo)
          ..add('dueDate', dueDate)
          ..add('amount', amount)
          ..add('paidAmount', paidAmount)
          ..add('status', status)
          ..add('paymentId', paymentId)
          ..add('paidAt', paidAt)
          ..add('reminderSentAt', reminderSentAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class InstallmentBuilder implements Builder<Installment, InstallmentBuilder> {
  _$Installment? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _paymentPlanId;
  int? get paymentPlanId => _$this._paymentPlanId;
  set paymentPlanId(int? paymentPlanId) =>
      _$this._paymentPlanId = paymentPlanId;

  int? _sequenceNo;
  int? get sequenceNo => _$this._sequenceNo;
  set sequenceNo(int? sequenceNo) => _$this._sequenceNo = sequenceNo;

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

  int? _paymentId;
  int? get paymentId => _$this._paymentId;
  set paymentId(int? paymentId) => _$this._paymentId = paymentId;

  DateTime? _paidAt;
  DateTime? get paidAt => _$this._paidAt;
  set paidAt(DateTime? paidAt) => _$this._paidAt = paidAt;

  DateTime? _reminderSentAt;
  DateTime? get reminderSentAt => _$this._reminderSentAt;
  set reminderSentAt(DateTime? reminderSentAt) =>
      _$this._reminderSentAt = reminderSentAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  InstallmentBuilder() {
    Installment._defaults(this);
  }

  InstallmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _paymentPlanId = $v.paymentPlanId;
      _sequenceNo = $v.sequenceNo;
      _dueDate = $v.dueDate;
      _amount = $v.amount;
      _paidAmount = $v.paidAmount;
      _status = $v.status;
      _paymentId = $v.paymentId;
      _paidAt = $v.paidAt;
      _reminderSentAt = $v.reminderSentAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Installment other) {
    _$v = other as _$Installment;
  }

  @override
  void update(void Function(InstallmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Installment build() => _build();

  _$Installment _build() {
    final _$result =
        _$v ??
        _$Installment._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'Installment', 'id'),
          paymentPlanId: BuiltValueNullFieldError.checkNotNull(
            paymentPlanId,
            r'Installment',
            'paymentPlanId',
          ),
          sequenceNo: BuiltValueNullFieldError.checkNotNull(
            sequenceNo,
            r'Installment',
            'sequenceNo',
          ),
          dueDate: BuiltValueNullFieldError.checkNotNull(
            dueDate,
            r'Installment',
            'dueDate',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'Installment',
            'amount',
          ),
          paidAmount: BuiltValueNullFieldError.checkNotNull(
            paidAmount,
            r'Installment',
            'paidAmount',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'Installment',
            'status',
          ),
          paymentId: paymentId,
          paidAt: paidAt,
          reminderSentAt: reminderSentAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'Installment',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
