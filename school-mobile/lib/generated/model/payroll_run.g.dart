// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_run.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PayrollRun extends PayrollRun {
  @override
  final int id;
  @override
  final String runNo;
  @override
  final int year;
  @override
  final int month;
  @override
  final String status;
  @override
  final String totalGross;
  @override
  final String totalDeductions;
  @override
  final String totalNet;
  @override
  final int? processedBy;
  @override
  final int? approvedBy;
  @override
  final DateTime? approvedAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String scopeKey;
  @override
  final int schoolId;
  @override
  final DateTime? periodStart;
  @override
  final DateTime? periodEnd;
  @override
  final int? createdBy;
  @override
  final DateTime? processedAt;
  @override
  final int? paidBy;
  @override
  final DateTime? paidAt;
  @override
  final int? accrualJournalBatchId;
  @override
  final int? paymentJournalBatchId;
  @override
  final int? reversedBy;
  @override
  final DateTime? reversedAt;
  @override
  final String? reversalReason;
  @override
  final BuiltList<JsonObject?>? policySnapshot;

  factory _$PayrollRun([void Function(PayrollRunBuilder)? updates]) =>
      (PayrollRunBuilder()..update(updates))._build();

  _$PayrollRun._({
    required this.id,
    required this.runNo,
    required this.year,
    required this.month,
    required this.status,
    required this.totalGross,
    required this.totalDeductions,
    required this.totalNet,
    this.processedBy,
    this.approvedBy,
    this.approvedAt,
    this.createdAt,
    this.updatedAt,
    required this.scopeKey,
    required this.schoolId,
    this.periodStart,
    this.periodEnd,
    this.createdBy,
    this.processedAt,
    this.paidBy,
    this.paidAt,
    this.accrualJournalBatchId,
    this.paymentJournalBatchId,
    this.reversedBy,
    this.reversedAt,
    this.reversalReason,
    this.policySnapshot,
  }) : super._();
  @override
  PayrollRun rebuild(void Function(PayrollRunBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PayrollRunBuilder toBuilder() => PayrollRunBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PayrollRun &&
        id == other.id &&
        runNo == other.runNo &&
        year == other.year &&
        month == other.month &&
        status == other.status &&
        totalGross == other.totalGross &&
        totalDeductions == other.totalDeductions &&
        totalNet == other.totalNet &&
        processedBy == other.processedBy &&
        approvedBy == other.approvedBy &&
        approvedAt == other.approvedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        scopeKey == other.scopeKey &&
        schoolId == other.schoolId &&
        periodStart == other.periodStart &&
        periodEnd == other.periodEnd &&
        createdBy == other.createdBy &&
        processedAt == other.processedAt &&
        paidBy == other.paidBy &&
        paidAt == other.paidAt &&
        accrualJournalBatchId == other.accrualJournalBatchId &&
        paymentJournalBatchId == other.paymentJournalBatchId &&
        reversedBy == other.reversedBy &&
        reversedAt == other.reversedAt &&
        reversalReason == other.reversalReason &&
        policySnapshot == other.policySnapshot;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, runNo.hashCode);
    _$hash = $jc(_$hash, year.hashCode);
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, totalGross.hashCode);
    _$hash = $jc(_$hash, totalDeductions.hashCode);
    _$hash = $jc(_$hash, totalNet.hashCode);
    _$hash = $jc(_$hash, processedBy.hashCode);
    _$hash = $jc(_$hash, approvedBy.hashCode);
    _$hash = $jc(_$hash, approvedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, scopeKey.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, periodStart.hashCode);
    _$hash = $jc(_$hash, periodEnd.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
    _$hash = $jc(_$hash, processedAt.hashCode);
    _$hash = $jc(_$hash, paidBy.hashCode);
    _$hash = $jc(_$hash, paidAt.hashCode);
    _$hash = $jc(_$hash, accrualJournalBatchId.hashCode);
    _$hash = $jc(_$hash, paymentJournalBatchId.hashCode);
    _$hash = $jc(_$hash, reversedBy.hashCode);
    _$hash = $jc(_$hash, reversedAt.hashCode);
    _$hash = $jc(_$hash, reversalReason.hashCode);
    _$hash = $jc(_$hash, policySnapshot.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PayrollRun')
          ..add('id', id)
          ..add('runNo', runNo)
          ..add('year', year)
          ..add('month', month)
          ..add('status', status)
          ..add('totalGross', totalGross)
          ..add('totalDeductions', totalDeductions)
          ..add('totalNet', totalNet)
          ..add('processedBy', processedBy)
          ..add('approvedBy', approvedBy)
          ..add('approvedAt', approvedAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('scopeKey', scopeKey)
          ..add('schoolId', schoolId)
          ..add('periodStart', periodStart)
          ..add('periodEnd', periodEnd)
          ..add('createdBy', createdBy)
          ..add('processedAt', processedAt)
          ..add('paidBy', paidBy)
          ..add('paidAt', paidAt)
          ..add('accrualJournalBatchId', accrualJournalBatchId)
          ..add('paymentJournalBatchId', paymentJournalBatchId)
          ..add('reversedBy', reversedBy)
          ..add('reversedAt', reversedAt)
          ..add('reversalReason', reversalReason)
          ..add('policySnapshot', policySnapshot))
        .toString();
  }
}

class PayrollRunBuilder implements Builder<PayrollRun, PayrollRunBuilder> {
  _$PayrollRun? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _runNo;
  String? get runNo => _$this._runNo;
  set runNo(String? runNo) => _$this._runNo = runNo;

  int? _year;
  int? get year => _$this._year;
  set year(int? year) => _$this._year = year;

  int? _month;
  int? get month => _$this._month;
  set month(int? month) => _$this._month = month;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _totalGross;
  String? get totalGross => _$this._totalGross;
  set totalGross(String? totalGross) => _$this._totalGross = totalGross;

  String? _totalDeductions;
  String? get totalDeductions => _$this._totalDeductions;
  set totalDeductions(String? totalDeductions) =>
      _$this._totalDeductions = totalDeductions;

  String? _totalNet;
  String? get totalNet => _$this._totalNet;
  set totalNet(String? totalNet) => _$this._totalNet = totalNet;

  int? _processedBy;
  int? get processedBy => _$this._processedBy;
  set processedBy(int? processedBy) => _$this._processedBy = processedBy;

  int? _approvedBy;
  int? get approvedBy => _$this._approvedBy;
  set approvedBy(int? approvedBy) => _$this._approvedBy = approvedBy;

  DateTime? _approvedAt;
  DateTime? get approvedAt => _$this._approvedAt;
  set approvedAt(DateTime? approvedAt) => _$this._approvedAt = approvedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  String? _scopeKey;
  String? get scopeKey => _$this._scopeKey;
  set scopeKey(String? scopeKey) => _$this._scopeKey = scopeKey;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  DateTime? _periodStart;
  DateTime? get periodStart => _$this._periodStart;
  set periodStart(DateTime? periodStart) => _$this._periodStart = periodStart;

  DateTime? _periodEnd;
  DateTime? get periodEnd => _$this._periodEnd;
  set periodEnd(DateTime? periodEnd) => _$this._periodEnd = periodEnd;

  int? _createdBy;
  int? get createdBy => _$this._createdBy;
  set createdBy(int? createdBy) => _$this._createdBy = createdBy;

  DateTime? _processedAt;
  DateTime? get processedAt => _$this._processedAt;
  set processedAt(DateTime? processedAt) => _$this._processedAt = processedAt;

  int? _paidBy;
  int? get paidBy => _$this._paidBy;
  set paidBy(int? paidBy) => _$this._paidBy = paidBy;

  DateTime? _paidAt;
  DateTime? get paidAt => _$this._paidAt;
  set paidAt(DateTime? paidAt) => _$this._paidAt = paidAt;

  int? _accrualJournalBatchId;
  int? get accrualJournalBatchId => _$this._accrualJournalBatchId;
  set accrualJournalBatchId(int? accrualJournalBatchId) =>
      _$this._accrualJournalBatchId = accrualJournalBatchId;

  int? _paymentJournalBatchId;
  int? get paymentJournalBatchId => _$this._paymentJournalBatchId;
  set paymentJournalBatchId(int? paymentJournalBatchId) =>
      _$this._paymentJournalBatchId = paymentJournalBatchId;

  int? _reversedBy;
  int? get reversedBy => _$this._reversedBy;
  set reversedBy(int? reversedBy) => _$this._reversedBy = reversedBy;

  DateTime? _reversedAt;
  DateTime? get reversedAt => _$this._reversedAt;
  set reversedAt(DateTime? reversedAt) => _$this._reversedAt = reversedAt;

  String? _reversalReason;
  String? get reversalReason => _$this._reversalReason;
  set reversalReason(String? reversalReason) =>
      _$this._reversalReason = reversalReason;

  ListBuilder<JsonObject?>? _policySnapshot;
  ListBuilder<JsonObject?> get policySnapshot =>
      _$this._policySnapshot ??= ListBuilder<JsonObject?>();
  set policySnapshot(ListBuilder<JsonObject?>? policySnapshot) =>
      _$this._policySnapshot = policySnapshot;

  PayrollRunBuilder() {
    PayrollRun._defaults(this);
  }

  PayrollRunBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _runNo = $v.runNo;
      _year = $v.year;
      _month = $v.month;
      _status = $v.status;
      _totalGross = $v.totalGross;
      _totalDeductions = $v.totalDeductions;
      _totalNet = $v.totalNet;
      _processedBy = $v.processedBy;
      _approvedBy = $v.approvedBy;
      _approvedAt = $v.approvedAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _scopeKey = $v.scopeKey;
      _schoolId = $v.schoolId;
      _periodStart = $v.periodStart;
      _periodEnd = $v.periodEnd;
      _createdBy = $v.createdBy;
      _processedAt = $v.processedAt;
      _paidBy = $v.paidBy;
      _paidAt = $v.paidAt;
      _accrualJournalBatchId = $v.accrualJournalBatchId;
      _paymentJournalBatchId = $v.paymentJournalBatchId;
      _reversedBy = $v.reversedBy;
      _reversedAt = $v.reversedAt;
      _reversalReason = $v.reversalReason;
      _policySnapshot = $v.policySnapshot?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PayrollRun other) {
    _$v = other as _$PayrollRun;
  }

  @override
  void update(void Function(PayrollRunBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PayrollRun build() => _build();

  _$PayrollRun _build() {
    _$PayrollRun _$result;
    try {
      _$result =
          _$v ??
          _$PayrollRun._(
            id: BuiltValueNullFieldError.checkNotNull(id, r'PayrollRun', 'id'),
            runNo: BuiltValueNullFieldError.checkNotNull(
              runNo,
              r'PayrollRun',
              'runNo',
            ),
            year: BuiltValueNullFieldError.checkNotNull(
              year,
              r'PayrollRun',
              'year',
            ),
            month: BuiltValueNullFieldError.checkNotNull(
              month,
              r'PayrollRun',
              'month',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'PayrollRun',
              'status',
            ),
            totalGross: BuiltValueNullFieldError.checkNotNull(
              totalGross,
              r'PayrollRun',
              'totalGross',
            ),
            totalDeductions: BuiltValueNullFieldError.checkNotNull(
              totalDeductions,
              r'PayrollRun',
              'totalDeductions',
            ),
            totalNet: BuiltValueNullFieldError.checkNotNull(
              totalNet,
              r'PayrollRun',
              'totalNet',
            ),
            processedBy: processedBy,
            approvedBy: approvedBy,
            approvedAt: approvedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            scopeKey: BuiltValueNullFieldError.checkNotNull(
              scopeKey,
              r'PayrollRun',
              'scopeKey',
            ),
            schoolId: BuiltValueNullFieldError.checkNotNull(
              schoolId,
              r'PayrollRun',
              'schoolId',
            ),
            periodStart: periodStart,
            periodEnd: periodEnd,
            createdBy: createdBy,
            processedAt: processedAt,
            paidBy: paidBy,
            paidAt: paidAt,
            accrualJournalBatchId: accrualJournalBatchId,
            paymentJournalBatchId: paymentJournalBatchId,
            reversedBy: reversedBy,
            reversedAt: reversedAt,
            reversalReason: reversalReason,
            policySnapshot: _policySnapshot?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'policySnapshot';
        _policySnapshot?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'PayrollRun',
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
