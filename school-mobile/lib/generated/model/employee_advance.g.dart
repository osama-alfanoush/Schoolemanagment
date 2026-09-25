// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_advance.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EmployeeAdvance extends EmployeeAdvance {
  @override
  final int id;
  @override
  final String advanceNo;
  @override
  final int staffProfileId;
  @override
  final String originalAmount;
  @override
  final String remainingBalance;
  @override
  final String reason;
  @override
  final DateTime requestedAt;
  @override
  final DateTime? approvedAt;
  @override
  final DateTime? disbursedAt;
  @override
  final String? disbursementMethod;
  @override
  final int installmentCount;
  @override
  final String installmentAmount;
  @override
  final DateTime firstDeductionMonth;
  @override
  final String status;
  @override
  final String? receivableAccountCode;
  @override
  final String? cashAccountCode;
  @override
  final int? requestedBy;
  @override
  final int? approvedBy;
  @override
  final int? disbursedBy;
  @override
  final int? journalBatchId;
  @override
  final BuiltList<JsonObject?>? attachments;
  @override
  final String? notes;
  @override
  final String? closureReason;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$EmployeeAdvance([void Function(EmployeeAdvanceBuilder)? updates]) =>
      (EmployeeAdvanceBuilder()..update(updates))._build();

  _$EmployeeAdvance._({
    required this.id,
    required this.advanceNo,
    required this.staffProfileId,
    required this.originalAmount,
    required this.remainingBalance,
    required this.reason,
    required this.requestedAt,
    this.approvedAt,
    this.disbursedAt,
    this.disbursementMethod,
    required this.installmentCount,
    required this.installmentAmount,
    required this.firstDeductionMonth,
    required this.status,
    this.receivableAccountCode,
    this.cashAccountCode,
    this.requestedBy,
    this.approvedBy,
    this.disbursedBy,
    this.journalBatchId,
    this.attachments,
    this.notes,
    this.closureReason,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  EmployeeAdvance rebuild(void Function(EmployeeAdvanceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EmployeeAdvanceBuilder toBuilder() => EmployeeAdvanceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EmployeeAdvance &&
        id == other.id &&
        advanceNo == other.advanceNo &&
        staffProfileId == other.staffProfileId &&
        originalAmount == other.originalAmount &&
        remainingBalance == other.remainingBalance &&
        reason == other.reason &&
        requestedAt == other.requestedAt &&
        approvedAt == other.approvedAt &&
        disbursedAt == other.disbursedAt &&
        disbursementMethod == other.disbursementMethod &&
        installmentCount == other.installmentCount &&
        installmentAmount == other.installmentAmount &&
        firstDeductionMonth == other.firstDeductionMonth &&
        status == other.status &&
        receivableAccountCode == other.receivableAccountCode &&
        cashAccountCode == other.cashAccountCode &&
        requestedBy == other.requestedBy &&
        approvedBy == other.approvedBy &&
        disbursedBy == other.disbursedBy &&
        journalBatchId == other.journalBatchId &&
        attachments == other.attachments &&
        notes == other.notes &&
        closureReason == other.closureReason &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, advanceNo.hashCode);
    _$hash = $jc(_$hash, staffProfileId.hashCode);
    _$hash = $jc(_$hash, originalAmount.hashCode);
    _$hash = $jc(_$hash, remainingBalance.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, requestedAt.hashCode);
    _$hash = $jc(_$hash, approvedAt.hashCode);
    _$hash = $jc(_$hash, disbursedAt.hashCode);
    _$hash = $jc(_$hash, disbursementMethod.hashCode);
    _$hash = $jc(_$hash, installmentCount.hashCode);
    _$hash = $jc(_$hash, installmentAmount.hashCode);
    _$hash = $jc(_$hash, firstDeductionMonth.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, receivableAccountCode.hashCode);
    _$hash = $jc(_$hash, cashAccountCode.hashCode);
    _$hash = $jc(_$hash, requestedBy.hashCode);
    _$hash = $jc(_$hash, approvedBy.hashCode);
    _$hash = $jc(_$hash, disbursedBy.hashCode);
    _$hash = $jc(_$hash, journalBatchId.hashCode);
    _$hash = $jc(_$hash, attachments.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jc(_$hash, closureReason.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EmployeeAdvance')
          ..add('id', id)
          ..add('advanceNo', advanceNo)
          ..add('staffProfileId', staffProfileId)
          ..add('originalAmount', originalAmount)
          ..add('remainingBalance', remainingBalance)
          ..add('reason', reason)
          ..add('requestedAt', requestedAt)
          ..add('approvedAt', approvedAt)
          ..add('disbursedAt', disbursedAt)
          ..add('disbursementMethod', disbursementMethod)
          ..add('installmentCount', installmentCount)
          ..add('installmentAmount', installmentAmount)
          ..add('firstDeductionMonth', firstDeductionMonth)
          ..add('status', status)
          ..add('receivableAccountCode', receivableAccountCode)
          ..add('cashAccountCode', cashAccountCode)
          ..add('requestedBy', requestedBy)
          ..add('approvedBy', approvedBy)
          ..add('disbursedBy', disbursedBy)
          ..add('journalBatchId', journalBatchId)
          ..add('attachments', attachments)
          ..add('notes', notes)
          ..add('closureReason', closureReason)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class EmployeeAdvanceBuilder
    implements Builder<EmployeeAdvance, EmployeeAdvanceBuilder> {
  _$EmployeeAdvance? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _advanceNo;
  String? get advanceNo => _$this._advanceNo;
  set advanceNo(String? advanceNo) => _$this._advanceNo = advanceNo;

  int? _staffProfileId;
  int? get staffProfileId => _$this._staffProfileId;
  set staffProfileId(int? staffProfileId) =>
      _$this._staffProfileId = staffProfileId;

  String? _originalAmount;
  String? get originalAmount => _$this._originalAmount;
  set originalAmount(String? originalAmount) =>
      _$this._originalAmount = originalAmount;

  String? _remainingBalance;
  String? get remainingBalance => _$this._remainingBalance;
  set remainingBalance(String? remainingBalance) =>
      _$this._remainingBalance = remainingBalance;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  DateTime? _requestedAt;
  DateTime? get requestedAt => _$this._requestedAt;
  set requestedAt(DateTime? requestedAt) => _$this._requestedAt = requestedAt;

  DateTime? _approvedAt;
  DateTime? get approvedAt => _$this._approvedAt;
  set approvedAt(DateTime? approvedAt) => _$this._approvedAt = approvedAt;

  DateTime? _disbursedAt;
  DateTime? get disbursedAt => _$this._disbursedAt;
  set disbursedAt(DateTime? disbursedAt) => _$this._disbursedAt = disbursedAt;

  String? _disbursementMethod;
  String? get disbursementMethod => _$this._disbursementMethod;
  set disbursementMethod(String? disbursementMethod) =>
      _$this._disbursementMethod = disbursementMethod;

  int? _installmentCount;
  int? get installmentCount => _$this._installmentCount;
  set installmentCount(int? installmentCount) =>
      _$this._installmentCount = installmentCount;

  String? _installmentAmount;
  String? get installmentAmount => _$this._installmentAmount;
  set installmentAmount(String? installmentAmount) =>
      _$this._installmentAmount = installmentAmount;

  DateTime? _firstDeductionMonth;
  DateTime? get firstDeductionMonth => _$this._firstDeductionMonth;
  set firstDeductionMonth(DateTime? firstDeductionMonth) =>
      _$this._firstDeductionMonth = firstDeductionMonth;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _receivableAccountCode;
  String? get receivableAccountCode => _$this._receivableAccountCode;
  set receivableAccountCode(String? receivableAccountCode) =>
      _$this._receivableAccountCode = receivableAccountCode;

  String? _cashAccountCode;
  String? get cashAccountCode => _$this._cashAccountCode;
  set cashAccountCode(String? cashAccountCode) =>
      _$this._cashAccountCode = cashAccountCode;

  int? _requestedBy;
  int? get requestedBy => _$this._requestedBy;
  set requestedBy(int? requestedBy) => _$this._requestedBy = requestedBy;

  int? _approvedBy;
  int? get approvedBy => _$this._approvedBy;
  set approvedBy(int? approvedBy) => _$this._approvedBy = approvedBy;

  int? _disbursedBy;
  int? get disbursedBy => _$this._disbursedBy;
  set disbursedBy(int? disbursedBy) => _$this._disbursedBy = disbursedBy;

  int? _journalBatchId;
  int? get journalBatchId => _$this._journalBatchId;
  set journalBatchId(int? journalBatchId) =>
      _$this._journalBatchId = journalBatchId;

  ListBuilder<JsonObject?>? _attachments;
  ListBuilder<JsonObject?> get attachments =>
      _$this._attachments ??= ListBuilder<JsonObject?>();
  set attachments(ListBuilder<JsonObject?>? attachments) =>
      _$this._attachments = attachments;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  String? _closureReason;
  String? get closureReason => _$this._closureReason;
  set closureReason(String? closureReason) =>
      _$this._closureReason = closureReason;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  EmployeeAdvanceBuilder() {
    EmployeeAdvance._defaults(this);
  }

  EmployeeAdvanceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _advanceNo = $v.advanceNo;
      _staffProfileId = $v.staffProfileId;
      _originalAmount = $v.originalAmount;
      _remainingBalance = $v.remainingBalance;
      _reason = $v.reason;
      _requestedAt = $v.requestedAt;
      _approvedAt = $v.approvedAt;
      _disbursedAt = $v.disbursedAt;
      _disbursementMethod = $v.disbursementMethod;
      _installmentCount = $v.installmentCount;
      _installmentAmount = $v.installmentAmount;
      _firstDeductionMonth = $v.firstDeductionMonth;
      _status = $v.status;
      _receivableAccountCode = $v.receivableAccountCode;
      _cashAccountCode = $v.cashAccountCode;
      _requestedBy = $v.requestedBy;
      _approvedBy = $v.approvedBy;
      _disbursedBy = $v.disbursedBy;
      _journalBatchId = $v.journalBatchId;
      _attachments = $v.attachments?.toBuilder();
      _notes = $v.notes;
      _closureReason = $v.closureReason;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EmployeeAdvance other) {
    _$v = other as _$EmployeeAdvance;
  }

  @override
  void update(void Function(EmployeeAdvanceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EmployeeAdvance build() => _build();

  _$EmployeeAdvance _build() {
    _$EmployeeAdvance _$result;
    try {
      _$result =
          _$v ??
          _$EmployeeAdvance._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'EmployeeAdvance',
              'id',
            ),
            advanceNo: BuiltValueNullFieldError.checkNotNull(
              advanceNo,
              r'EmployeeAdvance',
              'advanceNo',
            ),
            staffProfileId: BuiltValueNullFieldError.checkNotNull(
              staffProfileId,
              r'EmployeeAdvance',
              'staffProfileId',
            ),
            originalAmount: BuiltValueNullFieldError.checkNotNull(
              originalAmount,
              r'EmployeeAdvance',
              'originalAmount',
            ),
            remainingBalance: BuiltValueNullFieldError.checkNotNull(
              remainingBalance,
              r'EmployeeAdvance',
              'remainingBalance',
            ),
            reason: BuiltValueNullFieldError.checkNotNull(
              reason,
              r'EmployeeAdvance',
              'reason',
            ),
            requestedAt: BuiltValueNullFieldError.checkNotNull(
              requestedAt,
              r'EmployeeAdvance',
              'requestedAt',
            ),
            approvedAt: approvedAt,
            disbursedAt: disbursedAt,
            disbursementMethod: disbursementMethod,
            installmentCount: BuiltValueNullFieldError.checkNotNull(
              installmentCount,
              r'EmployeeAdvance',
              'installmentCount',
            ),
            installmentAmount: BuiltValueNullFieldError.checkNotNull(
              installmentAmount,
              r'EmployeeAdvance',
              'installmentAmount',
            ),
            firstDeductionMonth: BuiltValueNullFieldError.checkNotNull(
              firstDeductionMonth,
              r'EmployeeAdvance',
              'firstDeductionMonth',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'EmployeeAdvance',
              'status',
            ),
            receivableAccountCode: receivableAccountCode,
            cashAccountCode: cashAccountCode,
            requestedBy: requestedBy,
            approvedBy: approvedBy,
            disbursedBy: disbursedBy,
            journalBatchId: journalBatchId,
            attachments: _attachments?.build(),
            notes: notes,
            closureReason: closureReason,
            createdAt: createdAt,
            updatedAt: updatedAt,
            schoolId: BuiltValueNullFieldError.checkNotNull(
              schoolId,
              r'EmployeeAdvance',
              'schoolId',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'attachments';
        _attachments?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'EmployeeAdvance',
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
