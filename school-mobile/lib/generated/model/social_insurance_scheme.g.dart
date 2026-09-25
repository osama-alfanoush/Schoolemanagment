// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_insurance_scheme.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SocialInsuranceScheme extends SocialInsuranceScheme {
  @override
  final int id;
  @override
  final String scopeKey;
  @override
  final int schoolId;
  @override
  final String schemeCode;
  @override
  final String nameAr;
  @override
  final String nameEn;
  @override
  final String employeeRate;
  @override
  final String employerRate;
  @override
  final String calculationBase;
  @override
  final String? minimumWage;
  @override
  final String? maximumWage;
  @override
  final BuiltList<JsonObject?>? includedComponentCodes;
  @override
  final BuiltList<JsonObject?>? excludedComponentCodes;
  @override
  final DateTime effectiveFrom;
  @override
  final DateTime? effectiveTo;
  @override
  final String? employeePayableAccountCode;
  @override
  final String? employerExpenseAccountCode;
  @override
  final String? employerPayableAccountCode;
  @override
  final String roundingMode;
  @override
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  factory _$SocialInsuranceScheme([
    void Function(SocialInsuranceSchemeBuilder)? updates,
  ]) => (SocialInsuranceSchemeBuilder()..update(updates))._build();

  _$SocialInsuranceScheme._({
    required this.id,
    required this.scopeKey,
    required this.schoolId,
    required this.schemeCode,
    required this.nameAr,
    required this.nameEn,
    required this.employeeRate,
    required this.employerRate,
    required this.calculationBase,
    this.minimumWage,
    this.maximumWage,
    this.includedComponentCodes,
    this.excludedComponentCodes,
    required this.effectiveFrom,
    this.effectiveTo,
    this.employeePayableAccountCode,
    this.employerExpenseAccountCode,
    this.employerPayableAccountCode,
    required this.roundingMode,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  }) : super._();
  @override
  SocialInsuranceScheme rebuild(
    void Function(SocialInsuranceSchemeBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  SocialInsuranceSchemeBuilder toBuilder() =>
      SocialInsuranceSchemeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SocialInsuranceScheme &&
        id == other.id &&
        scopeKey == other.scopeKey &&
        schoolId == other.schoolId &&
        schemeCode == other.schemeCode &&
        nameAr == other.nameAr &&
        nameEn == other.nameEn &&
        employeeRate == other.employeeRate &&
        employerRate == other.employerRate &&
        calculationBase == other.calculationBase &&
        minimumWage == other.minimumWage &&
        maximumWage == other.maximumWage &&
        includedComponentCodes == other.includedComponentCodes &&
        excludedComponentCodes == other.excludedComponentCodes &&
        effectiveFrom == other.effectiveFrom &&
        effectiveTo == other.effectiveTo &&
        employeePayableAccountCode == other.employeePayableAccountCode &&
        employerExpenseAccountCode == other.employerExpenseAccountCode &&
        employerPayableAccountCode == other.employerPayableAccountCode &&
        roundingMode == other.roundingMode &&
        isActive == other.isActive &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, scopeKey.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, schemeCode.hashCode);
    _$hash = $jc(_$hash, nameAr.hashCode);
    _$hash = $jc(_$hash, nameEn.hashCode);
    _$hash = $jc(_$hash, employeeRate.hashCode);
    _$hash = $jc(_$hash, employerRate.hashCode);
    _$hash = $jc(_$hash, calculationBase.hashCode);
    _$hash = $jc(_$hash, minimumWage.hashCode);
    _$hash = $jc(_$hash, maximumWage.hashCode);
    _$hash = $jc(_$hash, includedComponentCodes.hashCode);
    _$hash = $jc(_$hash, excludedComponentCodes.hashCode);
    _$hash = $jc(_$hash, effectiveFrom.hashCode);
    _$hash = $jc(_$hash, effectiveTo.hashCode);
    _$hash = $jc(_$hash, employeePayableAccountCode.hashCode);
    _$hash = $jc(_$hash, employerExpenseAccountCode.hashCode);
    _$hash = $jc(_$hash, employerPayableAccountCode.hashCode);
    _$hash = $jc(_$hash, roundingMode.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SocialInsuranceScheme')
          ..add('id', id)
          ..add('scopeKey', scopeKey)
          ..add('schoolId', schoolId)
          ..add('schemeCode', schemeCode)
          ..add('nameAr', nameAr)
          ..add('nameEn', nameEn)
          ..add('employeeRate', employeeRate)
          ..add('employerRate', employerRate)
          ..add('calculationBase', calculationBase)
          ..add('minimumWage', minimumWage)
          ..add('maximumWage', maximumWage)
          ..add('includedComponentCodes', includedComponentCodes)
          ..add('excludedComponentCodes', excludedComponentCodes)
          ..add('effectiveFrom', effectiveFrom)
          ..add('effectiveTo', effectiveTo)
          ..add('employeePayableAccountCode', employeePayableAccountCode)
          ..add('employerExpenseAccountCode', employerExpenseAccountCode)
          ..add('employerPayableAccountCode', employerPayableAccountCode)
          ..add('roundingMode', roundingMode)
          ..add('isActive', isActive)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class SocialInsuranceSchemeBuilder
    implements Builder<SocialInsuranceScheme, SocialInsuranceSchemeBuilder> {
  _$SocialInsuranceScheme? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _scopeKey;
  String? get scopeKey => _$this._scopeKey;
  set scopeKey(String? scopeKey) => _$this._scopeKey = scopeKey;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  String? _schemeCode;
  String? get schemeCode => _$this._schemeCode;
  set schemeCode(String? schemeCode) => _$this._schemeCode = schemeCode;

  String? _nameAr;
  String? get nameAr => _$this._nameAr;
  set nameAr(String? nameAr) => _$this._nameAr = nameAr;

  String? _nameEn;
  String? get nameEn => _$this._nameEn;
  set nameEn(String? nameEn) => _$this._nameEn = nameEn;

  String? _employeeRate;
  String? get employeeRate => _$this._employeeRate;
  set employeeRate(String? employeeRate) => _$this._employeeRate = employeeRate;

  String? _employerRate;
  String? get employerRate => _$this._employerRate;
  set employerRate(String? employerRate) => _$this._employerRate = employerRate;

  String? _calculationBase;
  String? get calculationBase => _$this._calculationBase;
  set calculationBase(String? calculationBase) =>
      _$this._calculationBase = calculationBase;

  String? _minimumWage;
  String? get minimumWage => _$this._minimumWage;
  set minimumWage(String? minimumWage) => _$this._minimumWage = minimumWage;

  String? _maximumWage;
  String? get maximumWage => _$this._maximumWage;
  set maximumWage(String? maximumWage) => _$this._maximumWage = maximumWage;

  ListBuilder<JsonObject?>? _includedComponentCodes;
  ListBuilder<JsonObject?> get includedComponentCodes =>
      _$this._includedComponentCodes ??= ListBuilder<JsonObject?>();
  set includedComponentCodes(
    ListBuilder<JsonObject?>? includedComponentCodes,
  ) => _$this._includedComponentCodes = includedComponentCodes;

  ListBuilder<JsonObject?>? _excludedComponentCodes;
  ListBuilder<JsonObject?> get excludedComponentCodes =>
      _$this._excludedComponentCodes ??= ListBuilder<JsonObject?>();
  set excludedComponentCodes(
    ListBuilder<JsonObject?>? excludedComponentCodes,
  ) => _$this._excludedComponentCodes = excludedComponentCodes;

  DateTime? _effectiveFrom;
  DateTime? get effectiveFrom => _$this._effectiveFrom;
  set effectiveFrom(DateTime? effectiveFrom) =>
      _$this._effectiveFrom = effectiveFrom;

  DateTime? _effectiveTo;
  DateTime? get effectiveTo => _$this._effectiveTo;
  set effectiveTo(DateTime? effectiveTo) => _$this._effectiveTo = effectiveTo;

  String? _employeePayableAccountCode;
  String? get employeePayableAccountCode => _$this._employeePayableAccountCode;
  set employeePayableAccountCode(String? employeePayableAccountCode) =>
      _$this._employeePayableAccountCode = employeePayableAccountCode;

  String? _employerExpenseAccountCode;
  String? get employerExpenseAccountCode => _$this._employerExpenseAccountCode;
  set employerExpenseAccountCode(String? employerExpenseAccountCode) =>
      _$this._employerExpenseAccountCode = employerExpenseAccountCode;

  String? _employerPayableAccountCode;
  String? get employerPayableAccountCode => _$this._employerPayableAccountCode;
  set employerPayableAccountCode(String? employerPayableAccountCode) =>
      _$this._employerPayableAccountCode = employerPayableAccountCode;

  String? _roundingMode;
  String? get roundingMode => _$this._roundingMode;
  set roundingMode(String? roundingMode) => _$this._roundingMode = roundingMode;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  SocialInsuranceSchemeBuilder() {
    SocialInsuranceScheme._defaults(this);
  }

  SocialInsuranceSchemeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _scopeKey = $v.scopeKey;
      _schoolId = $v.schoolId;
      _schemeCode = $v.schemeCode;
      _nameAr = $v.nameAr;
      _nameEn = $v.nameEn;
      _employeeRate = $v.employeeRate;
      _employerRate = $v.employerRate;
      _calculationBase = $v.calculationBase;
      _minimumWage = $v.minimumWage;
      _maximumWage = $v.maximumWage;
      _includedComponentCodes = $v.includedComponentCodes?.toBuilder();
      _excludedComponentCodes = $v.excludedComponentCodes?.toBuilder();
      _effectiveFrom = $v.effectiveFrom;
      _effectiveTo = $v.effectiveTo;
      _employeePayableAccountCode = $v.employeePayableAccountCode;
      _employerExpenseAccountCode = $v.employerExpenseAccountCode;
      _employerPayableAccountCode = $v.employerPayableAccountCode;
      _roundingMode = $v.roundingMode;
      _isActive = $v.isActive;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SocialInsuranceScheme other) {
    _$v = other as _$SocialInsuranceScheme;
  }

  @override
  void update(void Function(SocialInsuranceSchemeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SocialInsuranceScheme build() => _build();

  _$SocialInsuranceScheme _build() {
    _$SocialInsuranceScheme _$result;
    try {
      _$result =
          _$v ??
          _$SocialInsuranceScheme._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'SocialInsuranceScheme',
              'id',
            ),
            scopeKey: BuiltValueNullFieldError.checkNotNull(
              scopeKey,
              r'SocialInsuranceScheme',
              'scopeKey',
            ),
            schoolId: BuiltValueNullFieldError.checkNotNull(
              schoolId,
              r'SocialInsuranceScheme',
              'schoolId',
            ),
            schemeCode: BuiltValueNullFieldError.checkNotNull(
              schemeCode,
              r'SocialInsuranceScheme',
              'schemeCode',
            ),
            nameAr: BuiltValueNullFieldError.checkNotNull(
              nameAr,
              r'SocialInsuranceScheme',
              'nameAr',
            ),
            nameEn: BuiltValueNullFieldError.checkNotNull(
              nameEn,
              r'SocialInsuranceScheme',
              'nameEn',
            ),
            employeeRate: BuiltValueNullFieldError.checkNotNull(
              employeeRate,
              r'SocialInsuranceScheme',
              'employeeRate',
            ),
            employerRate: BuiltValueNullFieldError.checkNotNull(
              employerRate,
              r'SocialInsuranceScheme',
              'employerRate',
            ),
            calculationBase: BuiltValueNullFieldError.checkNotNull(
              calculationBase,
              r'SocialInsuranceScheme',
              'calculationBase',
            ),
            minimumWage: minimumWage,
            maximumWage: maximumWage,
            includedComponentCodes: _includedComponentCodes?.build(),
            excludedComponentCodes: _excludedComponentCodes?.build(),
            effectiveFrom: BuiltValueNullFieldError.checkNotNull(
              effectiveFrom,
              r'SocialInsuranceScheme',
              'effectiveFrom',
            ),
            effectiveTo: effectiveTo,
            employeePayableAccountCode: employeePayableAccountCode,
            employerExpenseAccountCode: employerExpenseAccountCode,
            employerPayableAccountCode: employerPayableAccountCode,
            roundingMode: BuiltValueNullFieldError.checkNotNull(
              roundingMode,
              r'SocialInsuranceScheme',
              'roundingMode',
            ),
            isActive: BuiltValueNullFieldError.checkNotNull(
              isActive,
              r'SocialInsuranceScheme',
              'isActive',
            ),
            createdAt: createdAt,
            updatedAt: updatedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'includedComponentCodes';
        _includedComponentCodes?.build();
        _$failedField = 'excludedComponentCodes';
        _excludedComponentCodes?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'SocialInsuranceScheme',
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
