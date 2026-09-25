// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_component.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PayrollComponent extends PayrollComponent {
  @override
  final int id;
  @override
  final String scopeKey;
  @override
  final int schoolId;
  @override
  final String code;
  @override
  final String nameAr;
  @override
  final String nameEn;
  @override
  final String category;
  @override
  final String calculationType;
  @override
  final String? percentageBase;
  @override
  final String? amount;
  @override
  final String? rate;
  @override
  final String? minimumAmount;
  @override
  final String? maximumAmount;
  @override
  final String roundingMode;
  @override
  final bool isRecurring;
  @override
  final DateTime effectiveFrom;
  @override
  final DateTime? effectiveTo;
  @override
  final bool isSocialInsuranceBase;
  @override
  final bool isTaxable;
  @override
  final bool showOnPayslip;
  @override
  final String? debitAccountCode;
  @override
  final String? creditAccountCode;
  @override
  final bool isActive;
  @override
  final int priority;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  factory _$PayrollComponent([
    void Function(PayrollComponentBuilder)? updates,
  ]) => (PayrollComponentBuilder()..update(updates))._build();

  _$PayrollComponent._({
    required this.id,
    required this.scopeKey,
    required this.schoolId,
    required this.code,
    required this.nameAr,
    required this.nameEn,
    required this.category,
    required this.calculationType,
    this.percentageBase,
    this.amount,
    this.rate,
    this.minimumAmount,
    this.maximumAmount,
    required this.roundingMode,
    required this.isRecurring,
    required this.effectiveFrom,
    this.effectiveTo,
    required this.isSocialInsuranceBase,
    required this.isTaxable,
    required this.showOnPayslip,
    this.debitAccountCode,
    this.creditAccountCode,
    required this.isActive,
    required this.priority,
    this.createdAt,
    this.updatedAt,
  }) : super._();
  @override
  PayrollComponent rebuild(void Function(PayrollComponentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PayrollComponentBuilder toBuilder() =>
      PayrollComponentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PayrollComponent &&
        id == other.id &&
        scopeKey == other.scopeKey &&
        schoolId == other.schoolId &&
        code == other.code &&
        nameAr == other.nameAr &&
        nameEn == other.nameEn &&
        category == other.category &&
        calculationType == other.calculationType &&
        percentageBase == other.percentageBase &&
        amount == other.amount &&
        rate == other.rate &&
        minimumAmount == other.minimumAmount &&
        maximumAmount == other.maximumAmount &&
        roundingMode == other.roundingMode &&
        isRecurring == other.isRecurring &&
        effectiveFrom == other.effectiveFrom &&
        effectiveTo == other.effectiveTo &&
        isSocialInsuranceBase == other.isSocialInsuranceBase &&
        isTaxable == other.isTaxable &&
        showOnPayslip == other.showOnPayslip &&
        debitAccountCode == other.debitAccountCode &&
        creditAccountCode == other.creditAccountCode &&
        isActive == other.isActive &&
        priority == other.priority &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, scopeKey.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, nameAr.hashCode);
    _$hash = $jc(_$hash, nameEn.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, calculationType.hashCode);
    _$hash = $jc(_$hash, percentageBase.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, rate.hashCode);
    _$hash = $jc(_$hash, minimumAmount.hashCode);
    _$hash = $jc(_$hash, maximumAmount.hashCode);
    _$hash = $jc(_$hash, roundingMode.hashCode);
    _$hash = $jc(_$hash, isRecurring.hashCode);
    _$hash = $jc(_$hash, effectiveFrom.hashCode);
    _$hash = $jc(_$hash, effectiveTo.hashCode);
    _$hash = $jc(_$hash, isSocialInsuranceBase.hashCode);
    _$hash = $jc(_$hash, isTaxable.hashCode);
    _$hash = $jc(_$hash, showOnPayslip.hashCode);
    _$hash = $jc(_$hash, debitAccountCode.hashCode);
    _$hash = $jc(_$hash, creditAccountCode.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, priority.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PayrollComponent')
          ..add('id', id)
          ..add('scopeKey', scopeKey)
          ..add('schoolId', schoolId)
          ..add('code', code)
          ..add('nameAr', nameAr)
          ..add('nameEn', nameEn)
          ..add('category', category)
          ..add('calculationType', calculationType)
          ..add('percentageBase', percentageBase)
          ..add('amount', amount)
          ..add('rate', rate)
          ..add('minimumAmount', minimumAmount)
          ..add('maximumAmount', maximumAmount)
          ..add('roundingMode', roundingMode)
          ..add('isRecurring', isRecurring)
          ..add('effectiveFrom', effectiveFrom)
          ..add('effectiveTo', effectiveTo)
          ..add('isSocialInsuranceBase', isSocialInsuranceBase)
          ..add('isTaxable', isTaxable)
          ..add('showOnPayslip', showOnPayslip)
          ..add('debitAccountCode', debitAccountCode)
          ..add('creditAccountCode', creditAccountCode)
          ..add('isActive', isActive)
          ..add('priority', priority)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class PayrollComponentBuilder
    implements Builder<PayrollComponent, PayrollComponentBuilder> {
  _$PayrollComponent? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _scopeKey;
  String? get scopeKey => _$this._scopeKey;
  set scopeKey(String? scopeKey) => _$this._scopeKey = scopeKey;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  String? _nameAr;
  String? get nameAr => _$this._nameAr;
  set nameAr(String? nameAr) => _$this._nameAr = nameAr;

  String? _nameEn;
  String? get nameEn => _$this._nameEn;
  set nameEn(String? nameEn) => _$this._nameEn = nameEn;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _calculationType;
  String? get calculationType => _$this._calculationType;
  set calculationType(String? calculationType) =>
      _$this._calculationType = calculationType;

  String? _percentageBase;
  String? get percentageBase => _$this._percentageBase;
  set percentageBase(String? percentageBase) =>
      _$this._percentageBase = percentageBase;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _rate;
  String? get rate => _$this._rate;
  set rate(String? rate) => _$this._rate = rate;

  String? _minimumAmount;
  String? get minimumAmount => _$this._minimumAmount;
  set minimumAmount(String? minimumAmount) =>
      _$this._minimumAmount = minimumAmount;

  String? _maximumAmount;
  String? get maximumAmount => _$this._maximumAmount;
  set maximumAmount(String? maximumAmount) =>
      _$this._maximumAmount = maximumAmount;

  String? _roundingMode;
  String? get roundingMode => _$this._roundingMode;
  set roundingMode(String? roundingMode) => _$this._roundingMode = roundingMode;

  bool? _isRecurring;
  bool? get isRecurring => _$this._isRecurring;
  set isRecurring(bool? isRecurring) => _$this._isRecurring = isRecurring;

  DateTime? _effectiveFrom;
  DateTime? get effectiveFrom => _$this._effectiveFrom;
  set effectiveFrom(DateTime? effectiveFrom) =>
      _$this._effectiveFrom = effectiveFrom;

  DateTime? _effectiveTo;
  DateTime? get effectiveTo => _$this._effectiveTo;
  set effectiveTo(DateTime? effectiveTo) => _$this._effectiveTo = effectiveTo;

  bool? _isSocialInsuranceBase;
  bool? get isSocialInsuranceBase => _$this._isSocialInsuranceBase;
  set isSocialInsuranceBase(bool? isSocialInsuranceBase) =>
      _$this._isSocialInsuranceBase = isSocialInsuranceBase;

  bool? _isTaxable;
  bool? get isTaxable => _$this._isTaxable;
  set isTaxable(bool? isTaxable) => _$this._isTaxable = isTaxable;

  bool? _showOnPayslip;
  bool? get showOnPayslip => _$this._showOnPayslip;
  set showOnPayslip(bool? showOnPayslip) =>
      _$this._showOnPayslip = showOnPayslip;

  String? _debitAccountCode;
  String? get debitAccountCode => _$this._debitAccountCode;
  set debitAccountCode(String? debitAccountCode) =>
      _$this._debitAccountCode = debitAccountCode;

  String? _creditAccountCode;
  String? get creditAccountCode => _$this._creditAccountCode;
  set creditAccountCode(String? creditAccountCode) =>
      _$this._creditAccountCode = creditAccountCode;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  int? _priority;
  int? get priority => _$this._priority;
  set priority(int? priority) => _$this._priority = priority;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  PayrollComponentBuilder() {
    PayrollComponent._defaults(this);
  }

  PayrollComponentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _scopeKey = $v.scopeKey;
      _schoolId = $v.schoolId;
      _code = $v.code;
      _nameAr = $v.nameAr;
      _nameEn = $v.nameEn;
      _category = $v.category;
      _calculationType = $v.calculationType;
      _percentageBase = $v.percentageBase;
      _amount = $v.amount;
      _rate = $v.rate;
      _minimumAmount = $v.minimumAmount;
      _maximumAmount = $v.maximumAmount;
      _roundingMode = $v.roundingMode;
      _isRecurring = $v.isRecurring;
      _effectiveFrom = $v.effectiveFrom;
      _effectiveTo = $v.effectiveTo;
      _isSocialInsuranceBase = $v.isSocialInsuranceBase;
      _isTaxable = $v.isTaxable;
      _showOnPayslip = $v.showOnPayslip;
      _debitAccountCode = $v.debitAccountCode;
      _creditAccountCode = $v.creditAccountCode;
      _isActive = $v.isActive;
      _priority = $v.priority;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PayrollComponent other) {
    _$v = other as _$PayrollComponent;
  }

  @override
  void update(void Function(PayrollComponentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PayrollComponent build() => _build();

  _$PayrollComponent _build() {
    final _$result =
        _$v ??
        _$PayrollComponent._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'PayrollComponent',
            'id',
          ),
          scopeKey: BuiltValueNullFieldError.checkNotNull(
            scopeKey,
            r'PayrollComponent',
            'scopeKey',
          ),
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'PayrollComponent',
            'schoolId',
          ),
          code: BuiltValueNullFieldError.checkNotNull(
            code,
            r'PayrollComponent',
            'code',
          ),
          nameAr: BuiltValueNullFieldError.checkNotNull(
            nameAr,
            r'PayrollComponent',
            'nameAr',
          ),
          nameEn: BuiltValueNullFieldError.checkNotNull(
            nameEn,
            r'PayrollComponent',
            'nameEn',
          ),
          category: BuiltValueNullFieldError.checkNotNull(
            category,
            r'PayrollComponent',
            'category',
          ),
          calculationType: BuiltValueNullFieldError.checkNotNull(
            calculationType,
            r'PayrollComponent',
            'calculationType',
          ),
          percentageBase: percentageBase,
          amount: amount,
          rate: rate,
          minimumAmount: minimumAmount,
          maximumAmount: maximumAmount,
          roundingMode: BuiltValueNullFieldError.checkNotNull(
            roundingMode,
            r'PayrollComponent',
            'roundingMode',
          ),
          isRecurring: BuiltValueNullFieldError.checkNotNull(
            isRecurring,
            r'PayrollComponent',
            'isRecurring',
          ),
          effectiveFrom: BuiltValueNullFieldError.checkNotNull(
            effectiveFrom,
            r'PayrollComponent',
            'effectiveFrom',
          ),
          effectiveTo: effectiveTo,
          isSocialInsuranceBase: BuiltValueNullFieldError.checkNotNull(
            isSocialInsuranceBase,
            r'PayrollComponent',
            'isSocialInsuranceBase',
          ),
          isTaxable: BuiltValueNullFieldError.checkNotNull(
            isTaxable,
            r'PayrollComponent',
            'isTaxable',
          ),
          showOnPayslip: BuiltValueNullFieldError.checkNotNull(
            showOnPayslip,
            r'PayrollComponent',
            'showOnPayslip',
          ),
          debitAccountCode: debitAccountCode,
          creditAccountCode: creditAccountCode,
          isActive: BuiltValueNullFieldError.checkNotNull(
            isActive,
            r'PayrollComponent',
            'isActive',
          ),
          priority: BuiltValueNullFieldError.checkNotNull(
            priority,
            r'PayrollComponent',
            'priority',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
