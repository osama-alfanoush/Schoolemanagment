// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PayrollRecord extends PayrollRecord {
  @override
  final int id;
  @override
  final int staffUserId;
  @override
  final int year;
  @override
  final int month;
  @override
  final String baseSalary;
  @override
  final String allowances;
  @override
  final String deductions;
  @override
  final String advanceDeduction;
  @override
  final String netPay;
  @override
  final String status;
  @override
  final DateTime? paidAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int? payrollRunId;
  @override
  final String totalEarnings;
  @override
  final String grossSalary;
  @override
  final String insurableWage;
  @override
  final String employeeSocialInsurance;
  @override
  final String employerSocialInsurance;
  @override
  final String employerContributions;
  @override
  final String otherDeductions;
  @override
  final String employerCost;
  @override
  final BuiltList<JsonObject?>? contractSnapshot;
  @override
  final BuiltList<JsonObject?>? socialInsuranceSnapshot;
  @override
  final BuiltList<JsonObject?>? calculationSnapshot;
  @override
  final int schoolId;

  factory _$PayrollRecord([void Function(PayrollRecordBuilder)? updates]) =>
      (PayrollRecordBuilder()..update(updates))._build();

  _$PayrollRecord._({
    required this.id,
    required this.staffUserId,
    required this.year,
    required this.month,
    required this.baseSalary,
    required this.allowances,
    required this.deductions,
    required this.advanceDeduction,
    required this.netPay,
    required this.status,
    this.paidAt,
    this.createdAt,
    this.updatedAt,
    this.payrollRunId,
    required this.totalEarnings,
    required this.grossSalary,
    required this.insurableWage,
    required this.employeeSocialInsurance,
    required this.employerSocialInsurance,
    required this.employerContributions,
    required this.otherDeductions,
    required this.employerCost,
    this.contractSnapshot,
    this.socialInsuranceSnapshot,
    this.calculationSnapshot,
    required this.schoolId,
  }) : super._();
  @override
  PayrollRecord rebuild(void Function(PayrollRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PayrollRecordBuilder toBuilder() => PayrollRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PayrollRecord &&
        id == other.id &&
        staffUserId == other.staffUserId &&
        year == other.year &&
        month == other.month &&
        baseSalary == other.baseSalary &&
        allowances == other.allowances &&
        deductions == other.deductions &&
        advanceDeduction == other.advanceDeduction &&
        netPay == other.netPay &&
        status == other.status &&
        paidAt == other.paidAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        payrollRunId == other.payrollRunId &&
        totalEarnings == other.totalEarnings &&
        grossSalary == other.grossSalary &&
        insurableWage == other.insurableWage &&
        employeeSocialInsurance == other.employeeSocialInsurance &&
        employerSocialInsurance == other.employerSocialInsurance &&
        employerContributions == other.employerContributions &&
        otherDeductions == other.otherDeductions &&
        employerCost == other.employerCost &&
        contractSnapshot == other.contractSnapshot &&
        socialInsuranceSnapshot == other.socialInsuranceSnapshot &&
        calculationSnapshot == other.calculationSnapshot &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, staffUserId.hashCode);
    _$hash = $jc(_$hash, year.hashCode);
    _$hash = $jc(_$hash, month.hashCode);
    _$hash = $jc(_$hash, baseSalary.hashCode);
    _$hash = $jc(_$hash, allowances.hashCode);
    _$hash = $jc(_$hash, deductions.hashCode);
    _$hash = $jc(_$hash, advanceDeduction.hashCode);
    _$hash = $jc(_$hash, netPay.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, paidAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, payrollRunId.hashCode);
    _$hash = $jc(_$hash, totalEarnings.hashCode);
    _$hash = $jc(_$hash, grossSalary.hashCode);
    _$hash = $jc(_$hash, insurableWage.hashCode);
    _$hash = $jc(_$hash, employeeSocialInsurance.hashCode);
    _$hash = $jc(_$hash, employerSocialInsurance.hashCode);
    _$hash = $jc(_$hash, employerContributions.hashCode);
    _$hash = $jc(_$hash, otherDeductions.hashCode);
    _$hash = $jc(_$hash, employerCost.hashCode);
    _$hash = $jc(_$hash, contractSnapshot.hashCode);
    _$hash = $jc(_$hash, socialInsuranceSnapshot.hashCode);
    _$hash = $jc(_$hash, calculationSnapshot.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PayrollRecord')
          ..add('id', id)
          ..add('staffUserId', staffUserId)
          ..add('year', year)
          ..add('month', month)
          ..add('baseSalary', baseSalary)
          ..add('allowances', allowances)
          ..add('deductions', deductions)
          ..add('advanceDeduction', advanceDeduction)
          ..add('netPay', netPay)
          ..add('status', status)
          ..add('paidAt', paidAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('payrollRunId', payrollRunId)
          ..add('totalEarnings', totalEarnings)
          ..add('grossSalary', grossSalary)
          ..add('insurableWage', insurableWage)
          ..add('employeeSocialInsurance', employeeSocialInsurance)
          ..add('employerSocialInsurance', employerSocialInsurance)
          ..add('employerContributions', employerContributions)
          ..add('otherDeductions', otherDeductions)
          ..add('employerCost', employerCost)
          ..add('contractSnapshot', contractSnapshot)
          ..add('socialInsuranceSnapshot', socialInsuranceSnapshot)
          ..add('calculationSnapshot', calculationSnapshot)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class PayrollRecordBuilder
    implements Builder<PayrollRecord, PayrollRecordBuilder> {
  _$PayrollRecord? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _staffUserId;
  int? get staffUserId => _$this._staffUserId;
  set staffUserId(int? staffUserId) => _$this._staffUserId = staffUserId;

  int? _year;
  int? get year => _$this._year;
  set year(int? year) => _$this._year = year;

  int? _month;
  int? get month => _$this._month;
  set month(int? month) => _$this._month = month;

  String? _baseSalary;
  String? get baseSalary => _$this._baseSalary;
  set baseSalary(String? baseSalary) => _$this._baseSalary = baseSalary;

  String? _allowances;
  String? get allowances => _$this._allowances;
  set allowances(String? allowances) => _$this._allowances = allowances;

  String? _deductions;
  String? get deductions => _$this._deductions;
  set deductions(String? deductions) => _$this._deductions = deductions;

  String? _advanceDeduction;
  String? get advanceDeduction => _$this._advanceDeduction;
  set advanceDeduction(String? advanceDeduction) =>
      _$this._advanceDeduction = advanceDeduction;

  String? _netPay;
  String? get netPay => _$this._netPay;
  set netPay(String? netPay) => _$this._netPay = netPay;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  DateTime? _paidAt;
  DateTime? get paidAt => _$this._paidAt;
  set paidAt(DateTime? paidAt) => _$this._paidAt = paidAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _payrollRunId;
  int? get payrollRunId => _$this._payrollRunId;
  set payrollRunId(int? payrollRunId) => _$this._payrollRunId = payrollRunId;

  String? _totalEarnings;
  String? get totalEarnings => _$this._totalEarnings;
  set totalEarnings(String? totalEarnings) =>
      _$this._totalEarnings = totalEarnings;

  String? _grossSalary;
  String? get grossSalary => _$this._grossSalary;
  set grossSalary(String? grossSalary) => _$this._grossSalary = grossSalary;

  String? _insurableWage;
  String? get insurableWage => _$this._insurableWage;
  set insurableWage(String? insurableWage) =>
      _$this._insurableWage = insurableWage;

  String? _employeeSocialInsurance;
  String? get employeeSocialInsurance => _$this._employeeSocialInsurance;
  set employeeSocialInsurance(String? employeeSocialInsurance) =>
      _$this._employeeSocialInsurance = employeeSocialInsurance;

  String? _employerSocialInsurance;
  String? get employerSocialInsurance => _$this._employerSocialInsurance;
  set employerSocialInsurance(String? employerSocialInsurance) =>
      _$this._employerSocialInsurance = employerSocialInsurance;

  String? _employerContributions;
  String? get employerContributions => _$this._employerContributions;
  set employerContributions(String? employerContributions) =>
      _$this._employerContributions = employerContributions;

  String? _otherDeductions;
  String? get otherDeductions => _$this._otherDeductions;
  set otherDeductions(String? otherDeductions) =>
      _$this._otherDeductions = otherDeductions;

  String? _employerCost;
  String? get employerCost => _$this._employerCost;
  set employerCost(String? employerCost) => _$this._employerCost = employerCost;

  ListBuilder<JsonObject?>? _contractSnapshot;
  ListBuilder<JsonObject?> get contractSnapshot =>
      _$this._contractSnapshot ??= ListBuilder<JsonObject?>();
  set contractSnapshot(ListBuilder<JsonObject?>? contractSnapshot) =>
      _$this._contractSnapshot = contractSnapshot;

  ListBuilder<JsonObject?>? _socialInsuranceSnapshot;
  ListBuilder<JsonObject?> get socialInsuranceSnapshot =>
      _$this._socialInsuranceSnapshot ??= ListBuilder<JsonObject?>();
  set socialInsuranceSnapshot(
    ListBuilder<JsonObject?>? socialInsuranceSnapshot,
  ) => _$this._socialInsuranceSnapshot = socialInsuranceSnapshot;

  ListBuilder<JsonObject?>? _calculationSnapshot;
  ListBuilder<JsonObject?> get calculationSnapshot =>
      _$this._calculationSnapshot ??= ListBuilder<JsonObject?>();
  set calculationSnapshot(ListBuilder<JsonObject?>? calculationSnapshot) =>
      _$this._calculationSnapshot = calculationSnapshot;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  PayrollRecordBuilder() {
    PayrollRecord._defaults(this);
  }

  PayrollRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _staffUserId = $v.staffUserId;
      _year = $v.year;
      _month = $v.month;
      _baseSalary = $v.baseSalary;
      _allowances = $v.allowances;
      _deductions = $v.deductions;
      _advanceDeduction = $v.advanceDeduction;
      _netPay = $v.netPay;
      _status = $v.status;
      _paidAt = $v.paidAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _payrollRunId = $v.payrollRunId;
      _totalEarnings = $v.totalEarnings;
      _grossSalary = $v.grossSalary;
      _insurableWage = $v.insurableWage;
      _employeeSocialInsurance = $v.employeeSocialInsurance;
      _employerSocialInsurance = $v.employerSocialInsurance;
      _employerContributions = $v.employerContributions;
      _otherDeductions = $v.otherDeductions;
      _employerCost = $v.employerCost;
      _contractSnapshot = $v.contractSnapshot?.toBuilder();
      _socialInsuranceSnapshot = $v.socialInsuranceSnapshot?.toBuilder();
      _calculationSnapshot = $v.calculationSnapshot?.toBuilder();
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PayrollRecord other) {
    _$v = other as _$PayrollRecord;
  }

  @override
  void update(void Function(PayrollRecordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PayrollRecord build() => _build();

  _$PayrollRecord _build() {
    _$PayrollRecord _$result;
    try {
      _$result =
          _$v ??
          _$PayrollRecord._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'PayrollRecord',
              'id',
            ),
            staffUserId: BuiltValueNullFieldError.checkNotNull(
              staffUserId,
              r'PayrollRecord',
              'staffUserId',
            ),
            year: BuiltValueNullFieldError.checkNotNull(
              year,
              r'PayrollRecord',
              'year',
            ),
            month: BuiltValueNullFieldError.checkNotNull(
              month,
              r'PayrollRecord',
              'month',
            ),
            baseSalary: BuiltValueNullFieldError.checkNotNull(
              baseSalary,
              r'PayrollRecord',
              'baseSalary',
            ),
            allowances: BuiltValueNullFieldError.checkNotNull(
              allowances,
              r'PayrollRecord',
              'allowances',
            ),
            deductions: BuiltValueNullFieldError.checkNotNull(
              deductions,
              r'PayrollRecord',
              'deductions',
            ),
            advanceDeduction: BuiltValueNullFieldError.checkNotNull(
              advanceDeduction,
              r'PayrollRecord',
              'advanceDeduction',
            ),
            netPay: BuiltValueNullFieldError.checkNotNull(
              netPay,
              r'PayrollRecord',
              'netPay',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'PayrollRecord',
              'status',
            ),
            paidAt: paidAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            payrollRunId: payrollRunId,
            totalEarnings: BuiltValueNullFieldError.checkNotNull(
              totalEarnings,
              r'PayrollRecord',
              'totalEarnings',
            ),
            grossSalary: BuiltValueNullFieldError.checkNotNull(
              grossSalary,
              r'PayrollRecord',
              'grossSalary',
            ),
            insurableWage: BuiltValueNullFieldError.checkNotNull(
              insurableWage,
              r'PayrollRecord',
              'insurableWage',
            ),
            employeeSocialInsurance: BuiltValueNullFieldError.checkNotNull(
              employeeSocialInsurance,
              r'PayrollRecord',
              'employeeSocialInsurance',
            ),
            employerSocialInsurance: BuiltValueNullFieldError.checkNotNull(
              employerSocialInsurance,
              r'PayrollRecord',
              'employerSocialInsurance',
            ),
            employerContributions: BuiltValueNullFieldError.checkNotNull(
              employerContributions,
              r'PayrollRecord',
              'employerContributions',
            ),
            otherDeductions: BuiltValueNullFieldError.checkNotNull(
              otherDeductions,
              r'PayrollRecord',
              'otherDeductions',
            ),
            employerCost: BuiltValueNullFieldError.checkNotNull(
              employerCost,
              r'PayrollRecord',
              'employerCost',
            ),
            contractSnapshot: _contractSnapshot?.build(),
            socialInsuranceSnapshot: _socialInsuranceSnapshot?.build(),
            calculationSnapshot: _calculationSnapshot?.build(),
            schoolId: BuiltValueNullFieldError.checkNotNull(
              schoolId,
              r'PayrollRecord',
              'schoolId',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'contractSnapshot';
        _contractSnapshot?.build();
        _$failedField = 'socialInsuranceSnapshot';
        _socialInsuranceSnapshot?.build();
        _$failedField = 'calculationSnapshot';
        _calculationSnapshot?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'PayrollRecord',
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
