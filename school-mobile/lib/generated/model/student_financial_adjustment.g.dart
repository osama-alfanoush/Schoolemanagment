// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_financial_adjustment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StudentFinancialAdjustment extends StudentFinancialAdjustment {
  @override
  final int id;
  @override
  final String adjustmentNo;
  @override
  final int studentUserId;
  @override
  final int? invoiceId;
  @override
  final String type;
  @override
  final String direction;
  @override
  final String calculationType;
  @override
  final String value;
  @override
  final String amount;
  @override
  final String reason;
  @override
  final String status;
  @override
  final int createdBy;
  @override
  final int? approvedBy;
  @override
  final int? postedBy;
  @override
  final int? reversedBy;
  @override
  final DateTime? approvedAt;
  @override
  final DateTime? postedAt;
  @override
  final DateTime? reversedAt;
  @override
  final String? reversalReason;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$StudentFinancialAdjustment([
    void Function(StudentFinancialAdjustmentBuilder)? updates,
  ]) => (StudentFinancialAdjustmentBuilder()..update(updates))._build();

  _$StudentFinancialAdjustment._({
    required this.id,
    required this.adjustmentNo,
    required this.studentUserId,
    this.invoiceId,
    required this.type,
    required this.direction,
    required this.calculationType,
    required this.value,
    required this.amount,
    required this.reason,
    required this.status,
    required this.createdBy,
    this.approvedBy,
    this.postedBy,
    this.reversedBy,
    this.approvedAt,
    this.postedAt,
    this.reversedAt,
    this.reversalReason,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  StudentFinancialAdjustment rebuild(
    void Function(StudentFinancialAdjustmentBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  StudentFinancialAdjustmentBuilder toBuilder() =>
      StudentFinancialAdjustmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StudentFinancialAdjustment &&
        id == other.id &&
        adjustmentNo == other.adjustmentNo &&
        studentUserId == other.studentUserId &&
        invoiceId == other.invoiceId &&
        type == other.type &&
        direction == other.direction &&
        calculationType == other.calculationType &&
        value == other.value &&
        amount == other.amount &&
        reason == other.reason &&
        status == other.status &&
        createdBy == other.createdBy &&
        approvedBy == other.approvedBy &&
        postedBy == other.postedBy &&
        reversedBy == other.reversedBy &&
        approvedAt == other.approvedAt &&
        postedAt == other.postedAt &&
        reversedAt == other.reversedAt &&
        reversalReason == other.reversalReason &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, adjustmentNo.hashCode);
    _$hash = $jc(_$hash, studentUserId.hashCode);
    _$hash = $jc(_$hash, invoiceId.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, direction.hashCode);
    _$hash = $jc(_$hash, calculationType.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, approvedBy.hashCode);
    _$hash = $jc(_$hash, postedBy.hashCode);
    _$hash = $jc(_$hash, reversedBy.hashCode);
    _$hash = $jc(_$hash, approvedAt.hashCode);
    _$hash = $jc(_$hash, postedAt.hashCode);
    _$hash = $jc(_$hash, reversedAt.hashCode);
    _$hash = $jc(_$hash, reversalReason.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StudentFinancialAdjustment')
          ..add('id', id)
          ..add('adjustmentNo', adjustmentNo)
          ..add('studentUserId', studentUserId)
          ..add('invoiceId', invoiceId)
          ..add('type', type)
          ..add('direction', direction)
          ..add('calculationType', calculationType)
          ..add('value', value)
          ..add('amount', amount)
          ..add('reason', reason)
          ..add('status', status)
          ..add('createdBy', createdBy)
          ..add('approvedBy', approvedBy)
          ..add('postedBy', postedBy)
          ..add('reversedBy', reversedBy)
          ..add('approvedAt', approvedAt)
          ..add('postedAt', postedAt)
          ..add('reversedAt', reversedAt)
          ..add('reversalReason', reversalReason)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class StudentFinancialAdjustmentBuilder
    implements
        Builder<StudentFinancialAdjustment, StudentFinancialAdjustmentBuilder> {
  _$StudentFinancialAdjustment? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _adjustmentNo;
  String? get adjustmentNo => _$this._adjustmentNo;
  set adjustmentNo(String? adjustmentNo) => _$this._adjustmentNo = adjustmentNo;

  int? _studentUserId;
  int? get studentUserId => _$this._studentUserId;
  set studentUserId(int? studentUserId) =>
      _$this._studentUserId = studentUserId;

  int? _invoiceId;
  int? get invoiceId => _$this._invoiceId;
  set invoiceId(int? invoiceId) => _$this._invoiceId = invoiceId;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _direction;
  String? get direction => _$this._direction;
  set direction(String? direction) => _$this._direction = direction;

  String? _calculationType;
  String? get calculationType => _$this._calculationType;
  set calculationType(String? calculationType) =>
      _$this._calculationType = calculationType;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  int? _createdBy;
  int? get createdBy => _$this._createdBy;
  set createdBy(int? createdBy) => _$this._createdBy = createdBy;

  int? _approvedBy;
  int? get approvedBy => _$this._approvedBy;
  set approvedBy(int? approvedBy) => _$this._approvedBy = approvedBy;

  int? _postedBy;
  int? get postedBy => _$this._postedBy;
  set postedBy(int? postedBy) => _$this._postedBy = postedBy;

  int? _reversedBy;
  int? get reversedBy => _$this._reversedBy;
  set reversedBy(int? reversedBy) => _$this._reversedBy = reversedBy;

  DateTime? _approvedAt;
  DateTime? get approvedAt => _$this._approvedAt;
  set approvedAt(DateTime? approvedAt) => _$this._approvedAt = approvedAt;

  DateTime? _postedAt;
  DateTime? get postedAt => _$this._postedAt;
  set postedAt(DateTime? postedAt) => _$this._postedAt = postedAt;

  DateTime? _reversedAt;
  DateTime? get reversedAt => _$this._reversedAt;
  set reversedAt(DateTime? reversedAt) => _$this._reversedAt = reversedAt;

  String? _reversalReason;
  String? get reversalReason => _$this._reversalReason;
  set reversalReason(String? reversalReason) =>
      _$this._reversalReason = reversalReason;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  StudentFinancialAdjustmentBuilder() {
    StudentFinancialAdjustment._defaults(this);
  }

  StudentFinancialAdjustmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _adjustmentNo = $v.adjustmentNo;
      _studentUserId = $v.studentUserId;
      _invoiceId = $v.invoiceId;
      _type = $v.type;
      _direction = $v.direction;
      _calculationType = $v.calculationType;
      _value = $v.value;
      _amount = $v.amount;
      _reason = $v.reason;
      _status = $v.status;
      _createdBy = $v.createdBy;
      _approvedBy = $v.approvedBy;
      _postedBy = $v.postedBy;
      _reversedBy = $v.reversedBy;
      _approvedAt = $v.approvedAt;
      _postedAt = $v.postedAt;
      _reversedAt = $v.reversedAt;
      _reversalReason = $v.reversalReason;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StudentFinancialAdjustment other) {
    _$v = other as _$StudentFinancialAdjustment;
  }

  @override
  void update(void Function(StudentFinancialAdjustmentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StudentFinancialAdjustment build() => _build();

  _$StudentFinancialAdjustment _build() {
    final _$result =
        _$v ??
        _$StudentFinancialAdjustment._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'StudentFinancialAdjustment',
            'id',
          ),
          adjustmentNo: BuiltValueNullFieldError.checkNotNull(
            adjustmentNo,
            r'StudentFinancialAdjustment',
            'adjustmentNo',
          ),
          studentUserId: BuiltValueNullFieldError.checkNotNull(
            studentUserId,
            r'StudentFinancialAdjustment',
            'studentUserId',
          ),
          invoiceId: invoiceId,
          type: BuiltValueNullFieldError.checkNotNull(
            type,
            r'StudentFinancialAdjustment',
            'type',
          ),
          direction: BuiltValueNullFieldError.checkNotNull(
            direction,
            r'StudentFinancialAdjustment',
            'direction',
          ),
          calculationType: BuiltValueNullFieldError.checkNotNull(
            calculationType,
            r'StudentFinancialAdjustment',
            'calculationType',
          ),
          value: BuiltValueNullFieldError.checkNotNull(
            value,
            r'StudentFinancialAdjustment',
            'value',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'StudentFinancialAdjustment',
            'amount',
          ),
          reason: BuiltValueNullFieldError.checkNotNull(
            reason,
            r'StudentFinancialAdjustment',
            'reason',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'StudentFinancialAdjustment',
            'status',
          ),
          createdBy: BuiltValueNullFieldError.checkNotNull(
            createdBy,
            r'StudentFinancialAdjustment',
            'createdBy',
          ),
          approvedBy: approvedBy,
          postedBy: postedBy,
          reversedBy: reversedBy,
          approvedAt: approvedAt,
          postedAt: postedAt,
          reversedAt: reversedAt,
          reversalReason: reversalReason,
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'StudentFinancialAdjustment',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
