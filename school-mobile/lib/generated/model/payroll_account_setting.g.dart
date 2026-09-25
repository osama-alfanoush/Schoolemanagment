// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_account_setting.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PayrollAccountSetting extends PayrollAccountSetting {
  @override
  final int id;
  @override
  final String scopeKey;
  @override
  final int schoolId;
  @override
  final String salaryExpenseCode;
  @override
  final String salaryExpenseName;
  @override
  final String employerInsuranceExpenseCode;
  @override
  final String employerInsuranceExpenseName;
  @override
  final String payrollPayableCode;
  @override
  final String payrollPayableName;
  @override
  final String socialInsurancePayableCode;
  @override
  final String socialInsurancePayableName;
  @override
  final String deductionsPayableCode;
  @override
  final String deductionsPayableName;
  @override
  final String employeeAdvancesReceivableCode;
  @override
  final String employeeAdvancesReceivableName;
  @override
  final String cashBankCode;
  @override
  final String cashBankName;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  factory _$PayrollAccountSetting([
    void Function(PayrollAccountSettingBuilder)? updates,
  ]) => (PayrollAccountSettingBuilder()..update(updates))._build();

  _$PayrollAccountSetting._({
    required this.id,
    required this.scopeKey,
    required this.schoolId,
    required this.salaryExpenseCode,
    required this.salaryExpenseName,
    required this.employerInsuranceExpenseCode,
    required this.employerInsuranceExpenseName,
    required this.payrollPayableCode,
    required this.payrollPayableName,
    required this.socialInsurancePayableCode,
    required this.socialInsurancePayableName,
    required this.deductionsPayableCode,
    required this.deductionsPayableName,
    required this.employeeAdvancesReceivableCode,
    required this.employeeAdvancesReceivableName,
    required this.cashBankCode,
    required this.cashBankName,
    this.createdAt,
    this.updatedAt,
  }) : super._();
  @override
  PayrollAccountSetting rebuild(
    void Function(PayrollAccountSettingBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PayrollAccountSettingBuilder toBuilder() =>
      PayrollAccountSettingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PayrollAccountSetting &&
        id == other.id &&
        scopeKey == other.scopeKey &&
        schoolId == other.schoolId &&
        salaryExpenseCode == other.salaryExpenseCode &&
        salaryExpenseName == other.salaryExpenseName &&
        employerInsuranceExpenseCode == other.employerInsuranceExpenseCode &&
        employerInsuranceExpenseName == other.employerInsuranceExpenseName &&
        payrollPayableCode == other.payrollPayableCode &&
        payrollPayableName == other.payrollPayableName &&
        socialInsurancePayableCode == other.socialInsurancePayableCode &&
        socialInsurancePayableName == other.socialInsurancePayableName &&
        deductionsPayableCode == other.deductionsPayableCode &&
        deductionsPayableName == other.deductionsPayableName &&
        employeeAdvancesReceivableCode ==
            other.employeeAdvancesReceivableCode &&
        employeeAdvancesReceivableName ==
            other.employeeAdvancesReceivableName &&
        cashBankCode == other.cashBankCode &&
        cashBankName == other.cashBankName &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, scopeKey.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, salaryExpenseCode.hashCode);
    _$hash = $jc(_$hash, salaryExpenseName.hashCode);
    _$hash = $jc(_$hash, employerInsuranceExpenseCode.hashCode);
    _$hash = $jc(_$hash, employerInsuranceExpenseName.hashCode);
    _$hash = $jc(_$hash, payrollPayableCode.hashCode);
    _$hash = $jc(_$hash, payrollPayableName.hashCode);
    _$hash = $jc(_$hash, socialInsurancePayableCode.hashCode);
    _$hash = $jc(_$hash, socialInsurancePayableName.hashCode);
    _$hash = $jc(_$hash, deductionsPayableCode.hashCode);
    _$hash = $jc(_$hash, deductionsPayableName.hashCode);
    _$hash = $jc(_$hash, employeeAdvancesReceivableCode.hashCode);
    _$hash = $jc(_$hash, employeeAdvancesReceivableName.hashCode);
    _$hash = $jc(_$hash, cashBankCode.hashCode);
    _$hash = $jc(_$hash, cashBankName.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PayrollAccountSetting')
          ..add('id', id)
          ..add('scopeKey', scopeKey)
          ..add('schoolId', schoolId)
          ..add('salaryExpenseCode', salaryExpenseCode)
          ..add('salaryExpenseName', salaryExpenseName)
          ..add('employerInsuranceExpenseCode', employerInsuranceExpenseCode)
          ..add('employerInsuranceExpenseName', employerInsuranceExpenseName)
          ..add('payrollPayableCode', payrollPayableCode)
          ..add('payrollPayableName', payrollPayableName)
          ..add('socialInsurancePayableCode', socialInsurancePayableCode)
          ..add('socialInsurancePayableName', socialInsurancePayableName)
          ..add('deductionsPayableCode', deductionsPayableCode)
          ..add('deductionsPayableName', deductionsPayableName)
          ..add(
            'employeeAdvancesReceivableCode',
            employeeAdvancesReceivableCode,
          )
          ..add(
            'employeeAdvancesReceivableName',
            employeeAdvancesReceivableName,
          )
          ..add('cashBankCode', cashBankCode)
          ..add('cashBankName', cashBankName)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class PayrollAccountSettingBuilder
    implements Builder<PayrollAccountSetting, PayrollAccountSettingBuilder> {
  _$PayrollAccountSetting? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _scopeKey;
  String? get scopeKey => _$this._scopeKey;
  set scopeKey(String? scopeKey) => _$this._scopeKey = scopeKey;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  String? _salaryExpenseCode;
  String? get salaryExpenseCode => _$this._salaryExpenseCode;
  set salaryExpenseCode(String? salaryExpenseCode) =>
      _$this._salaryExpenseCode = salaryExpenseCode;

  String? _salaryExpenseName;
  String? get salaryExpenseName => _$this._salaryExpenseName;
  set salaryExpenseName(String? salaryExpenseName) =>
      _$this._salaryExpenseName = salaryExpenseName;

  String? _employerInsuranceExpenseCode;
  String? get employerInsuranceExpenseCode =>
      _$this._employerInsuranceExpenseCode;
  set employerInsuranceExpenseCode(String? employerInsuranceExpenseCode) =>
      _$this._employerInsuranceExpenseCode = employerInsuranceExpenseCode;

  String? _employerInsuranceExpenseName;
  String? get employerInsuranceExpenseName =>
      _$this._employerInsuranceExpenseName;
  set employerInsuranceExpenseName(String? employerInsuranceExpenseName) =>
      _$this._employerInsuranceExpenseName = employerInsuranceExpenseName;

  String? _payrollPayableCode;
  String? get payrollPayableCode => _$this._payrollPayableCode;
  set payrollPayableCode(String? payrollPayableCode) =>
      _$this._payrollPayableCode = payrollPayableCode;

  String? _payrollPayableName;
  String? get payrollPayableName => _$this._payrollPayableName;
  set payrollPayableName(String? payrollPayableName) =>
      _$this._payrollPayableName = payrollPayableName;

  String? _socialInsurancePayableCode;
  String? get socialInsurancePayableCode => _$this._socialInsurancePayableCode;
  set socialInsurancePayableCode(String? socialInsurancePayableCode) =>
      _$this._socialInsurancePayableCode = socialInsurancePayableCode;

  String? _socialInsurancePayableName;
  String? get socialInsurancePayableName => _$this._socialInsurancePayableName;
  set socialInsurancePayableName(String? socialInsurancePayableName) =>
      _$this._socialInsurancePayableName = socialInsurancePayableName;

  String? _deductionsPayableCode;
  String? get deductionsPayableCode => _$this._deductionsPayableCode;
  set deductionsPayableCode(String? deductionsPayableCode) =>
      _$this._deductionsPayableCode = deductionsPayableCode;

  String? _deductionsPayableName;
  String? get deductionsPayableName => _$this._deductionsPayableName;
  set deductionsPayableName(String? deductionsPayableName) =>
      _$this._deductionsPayableName = deductionsPayableName;

  String? _employeeAdvancesReceivableCode;
  String? get employeeAdvancesReceivableCode =>
      _$this._employeeAdvancesReceivableCode;
  set employeeAdvancesReceivableCode(String? employeeAdvancesReceivableCode) =>
      _$this._employeeAdvancesReceivableCode = employeeAdvancesReceivableCode;

  String? _employeeAdvancesReceivableName;
  String? get employeeAdvancesReceivableName =>
      _$this._employeeAdvancesReceivableName;
  set employeeAdvancesReceivableName(String? employeeAdvancesReceivableName) =>
      _$this._employeeAdvancesReceivableName = employeeAdvancesReceivableName;

  String? _cashBankCode;
  String? get cashBankCode => _$this._cashBankCode;
  set cashBankCode(String? cashBankCode) => _$this._cashBankCode = cashBankCode;

  String? _cashBankName;
  String? get cashBankName => _$this._cashBankName;
  set cashBankName(String? cashBankName) => _$this._cashBankName = cashBankName;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  PayrollAccountSettingBuilder() {
    PayrollAccountSetting._defaults(this);
  }

  PayrollAccountSettingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _scopeKey = $v.scopeKey;
      _schoolId = $v.schoolId;
      _salaryExpenseCode = $v.salaryExpenseCode;
      _salaryExpenseName = $v.salaryExpenseName;
      _employerInsuranceExpenseCode = $v.employerInsuranceExpenseCode;
      _employerInsuranceExpenseName = $v.employerInsuranceExpenseName;
      _payrollPayableCode = $v.payrollPayableCode;
      _payrollPayableName = $v.payrollPayableName;
      _socialInsurancePayableCode = $v.socialInsurancePayableCode;
      _socialInsurancePayableName = $v.socialInsurancePayableName;
      _deductionsPayableCode = $v.deductionsPayableCode;
      _deductionsPayableName = $v.deductionsPayableName;
      _employeeAdvancesReceivableCode = $v.employeeAdvancesReceivableCode;
      _employeeAdvancesReceivableName = $v.employeeAdvancesReceivableName;
      _cashBankCode = $v.cashBankCode;
      _cashBankName = $v.cashBankName;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PayrollAccountSetting other) {
    _$v = other as _$PayrollAccountSetting;
  }

  @override
  void update(void Function(PayrollAccountSettingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PayrollAccountSetting build() => _build();

  _$PayrollAccountSetting _build() {
    final _$result =
        _$v ??
        _$PayrollAccountSetting._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'PayrollAccountSetting',
            'id',
          ),
          scopeKey: BuiltValueNullFieldError.checkNotNull(
            scopeKey,
            r'PayrollAccountSetting',
            'scopeKey',
          ),
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'PayrollAccountSetting',
            'schoolId',
          ),
          salaryExpenseCode: BuiltValueNullFieldError.checkNotNull(
            salaryExpenseCode,
            r'PayrollAccountSetting',
            'salaryExpenseCode',
          ),
          salaryExpenseName: BuiltValueNullFieldError.checkNotNull(
            salaryExpenseName,
            r'PayrollAccountSetting',
            'salaryExpenseName',
          ),
          employerInsuranceExpenseCode: BuiltValueNullFieldError.checkNotNull(
            employerInsuranceExpenseCode,
            r'PayrollAccountSetting',
            'employerInsuranceExpenseCode',
          ),
          employerInsuranceExpenseName: BuiltValueNullFieldError.checkNotNull(
            employerInsuranceExpenseName,
            r'PayrollAccountSetting',
            'employerInsuranceExpenseName',
          ),
          payrollPayableCode: BuiltValueNullFieldError.checkNotNull(
            payrollPayableCode,
            r'PayrollAccountSetting',
            'payrollPayableCode',
          ),
          payrollPayableName: BuiltValueNullFieldError.checkNotNull(
            payrollPayableName,
            r'PayrollAccountSetting',
            'payrollPayableName',
          ),
          socialInsurancePayableCode: BuiltValueNullFieldError.checkNotNull(
            socialInsurancePayableCode,
            r'PayrollAccountSetting',
            'socialInsurancePayableCode',
          ),
          socialInsurancePayableName: BuiltValueNullFieldError.checkNotNull(
            socialInsurancePayableName,
            r'PayrollAccountSetting',
            'socialInsurancePayableName',
          ),
          deductionsPayableCode: BuiltValueNullFieldError.checkNotNull(
            deductionsPayableCode,
            r'PayrollAccountSetting',
            'deductionsPayableCode',
          ),
          deductionsPayableName: BuiltValueNullFieldError.checkNotNull(
            deductionsPayableName,
            r'PayrollAccountSetting',
            'deductionsPayableName',
          ),
          employeeAdvancesReceivableCode: BuiltValueNullFieldError.checkNotNull(
            employeeAdvancesReceivableCode,
            r'PayrollAccountSetting',
            'employeeAdvancesReceivableCode',
          ),
          employeeAdvancesReceivableName: BuiltValueNullFieldError.checkNotNull(
            employeeAdvancesReceivableName,
            r'PayrollAccountSetting',
            'employeeAdvancesReceivableName',
          ),
          cashBankCode: BuiltValueNullFieldError.checkNotNull(
            cashBankCode,
            r'PayrollAccountSetting',
            'cashBankCode',
          ),
          cashBankName: BuiltValueNullFieldError.checkNotNull(
            cashBankName,
            r'PayrollAccountSetting',
            'cashBankName',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
