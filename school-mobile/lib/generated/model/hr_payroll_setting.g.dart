// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hr_payroll_setting.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HrPayrollSetting extends HrPayrollSetting {
  @override
  final int id;
  @override
  final String scopeKey;
  @override
  final int schoolId;
  @override
  final BuiltList<JsonObject?>? contractAlertDays;
  @override
  final String prorationPolicy;
  @override
  final String negativeNetPolicy;
  @override
  final String currency;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  factory _$HrPayrollSetting([
    void Function(HrPayrollSettingBuilder)? updates,
  ]) => (HrPayrollSettingBuilder()..update(updates))._build();

  _$HrPayrollSetting._({
    required this.id,
    required this.scopeKey,
    required this.schoolId,
    this.contractAlertDays,
    required this.prorationPolicy,
    required this.negativeNetPolicy,
    required this.currency,
    this.createdAt,
    this.updatedAt,
  }) : super._();
  @override
  HrPayrollSetting rebuild(void Function(HrPayrollSettingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HrPayrollSettingBuilder toBuilder() =>
      HrPayrollSettingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HrPayrollSetting &&
        id == other.id &&
        scopeKey == other.scopeKey &&
        schoolId == other.schoolId &&
        contractAlertDays == other.contractAlertDays &&
        prorationPolicy == other.prorationPolicy &&
        negativeNetPolicy == other.negativeNetPolicy &&
        currency == other.currency &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, scopeKey.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jc(_$hash, contractAlertDays.hashCode);
    _$hash = $jc(_$hash, prorationPolicy.hashCode);
    _$hash = $jc(_$hash, negativeNetPolicy.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HrPayrollSetting')
          ..add('id', id)
          ..add('scopeKey', scopeKey)
          ..add('schoolId', schoolId)
          ..add('contractAlertDays', contractAlertDays)
          ..add('prorationPolicy', prorationPolicy)
          ..add('negativeNetPolicy', negativeNetPolicy)
          ..add('currency', currency)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class HrPayrollSettingBuilder
    implements Builder<HrPayrollSetting, HrPayrollSettingBuilder> {
  _$HrPayrollSetting? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _scopeKey;
  String? get scopeKey => _$this._scopeKey;
  set scopeKey(String? scopeKey) => _$this._scopeKey = scopeKey;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  ListBuilder<JsonObject?>? _contractAlertDays;
  ListBuilder<JsonObject?> get contractAlertDays =>
      _$this._contractAlertDays ??= ListBuilder<JsonObject?>();
  set contractAlertDays(ListBuilder<JsonObject?>? contractAlertDays) =>
      _$this._contractAlertDays = contractAlertDays;

  String? _prorationPolicy;
  String? get prorationPolicy => _$this._prorationPolicy;
  set prorationPolicy(String? prorationPolicy) =>
      _$this._prorationPolicy = prorationPolicy;

  String? _negativeNetPolicy;
  String? get negativeNetPolicy => _$this._negativeNetPolicy;
  set negativeNetPolicy(String? negativeNetPolicy) =>
      _$this._negativeNetPolicy = negativeNetPolicy;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  HrPayrollSettingBuilder() {
    HrPayrollSetting._defaults(this);
  }

  HrPayrollSettingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _scopeKey = $v.scopeKey;
      _schoolId = $v.schoolId;
      _contractAlertDays = $v.contractAlertDays?.toBuilder();
      _prorationPolicy = $v.prorationPolicy;
      _negativeNetPolicy = $v.negativeNetPolicy;
      _currency = $v.currency;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HrPayrollSetting other) {
    _$v = other as _$HrPayrollSetting;
  }

  @override
  void update(void Function(HrPayrollSettingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HrPayrollSetting build() => _build();

  _$HrPayrollSetting _build() {
    _$HrPayrollSetting _$result;
    try {
      _$result =
          _$v ??
          _$HrPayrollSetting._(
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'HrPayrollSetting',
              'id',
            ),
            scopeKey: BuiltValueNullFieldError.checkNotNull(
              scopeKey,
              r'HrPayrollSetting',
              'scopeKey',
            ),
            schoolId: BuiltValueNullFieldError.checkNotNull(
              schoolId,
              r'HrPayrollSetting',
              'schoolId',
            ),
            contractAlertDays: _contractAlertDays?.build(),
            prorationPolicy: BuiltValueNullFieldError.checkNotNull(
              prorationPolicy,
              r'HrPayrollSetting',
              'prorationPolicy',
            ),
            negativeNetPolicy: BuiltValueNullFieldError.checkNotNull(
              negativeNetPolicy,
              r'HrPayrollSetting',
              'negativeNetPolicy',
            ),
            currency: BuiltValueNullFieldError.checkNotNull(
              currency,
              r'HrPayrollSetting',
              'currency',
            ),
            createdAt: createdAt,
            updatedAt: updatedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'contractAlertDays';
        _contractAlertDays?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'HrPayrollSetting',
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
