// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_of_account.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChartOfAccount extends ChartOfAccount {
  @override
  final int id;
  @override
  final String accountCode;
  @override
  final String accountName;
  @override
  final String accountType;
  @override
  final String? description;
  @override
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int schoolId;

  factory _$ChartOfAccount([void Function(ChartOfAccountBuilder)? updates]) =>
      (ChartOfAccountBuilder()..update(updates))._build();

  _$ChartOfAccount._({
    required this.id,
    required this.accountCode,
    required this.accountName,
    required this.accountType,
    this.description,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    required this.schoolId,
  }) : super._();
  @override
  ChartOfAccount rebuild(void Function(ChartOfAccountBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChartOfAccountBuilder toBuilder() => ChartOfAccountBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChartOfAccount &&
        id == other.id &&
        accountCode == other.accountCode &&
        accountName == other.accountName &&
        accountType == other.accountType &&
        description == other.description &&
        isActive == other.isActive &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        schoolId == other.schoolId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, accountCode.hashCode);
    _$hash = $jc(_$hash, accountName.hashCode);
    _$hash = $jc(_$hash, accountType.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, schoolId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChartOfAccount')
          ..add('id', id)
          ..add('accountCode', accountCode)
          ..add('accountName', accountName)
          ..add('accountType', accountType)
          ..add('description', description)
          ..add('isActive', isActive)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('schoolId', schoolId))
        .toString();
  }
}

class ChartOfAccountBuilder
    implements Builder<ChartOfAccount, ChartOfAccountBuilder> {
  _$ChartOfAccount? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _accountCode;
  String? get accountCode => _$this._accountCode;
  set accountCode(String? accountCode) => _$this._accountCode = accountCode;

  String? _accountName;
  String? get accountName => _$this._accountName;
  set accountName(String? accountName) => _$this._accountName = accountName;

  String? _accountType;
  String? get accountType => _$this._accountType;
  set accountType(String? accountType) => _$this._accountType = accountType;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _schoolId;
  int? get schoolId => _$this._schoolId;
  set schoolId(int? schoolId) => _$this._schoolId = schoolId;

  ChartOfAccountBuilder() {
    ChartOfAccount._defaults(this);
  }

  ChartOfAccountBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _accountCode = $v.accountCode;
      _accountName = $v.accountName;
      _accountType = $v.accountType;
      _description = $v.description;
      _isActive = $v.isActive;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _schoolId = $v.schoolId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChartOfAccount other) {
    _$v = other as _$ChartOfAccount;
  }

  @override
  void update(void Function(ChartOfAccountBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChartOfAccount build() => _build();

  _$ChartOfAccount _build() {
    final _$result =
        _$v ??
        _$ChartOfAccount._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'ChartOfAccount',
            'id',
          ),
          accountCode: BuiltValueNullFieldError.checkNotNull(
            accountCode,
            r'ChartOfAccount',
            'accountCode',
          ),
          accountName: BuiltValueNullFieldError.checkNotNull(
            accountName,
            r'ChartOfAccount',
            'accountName',
          ),
          accountType: BuiltValueNullFieldError.checkNotNull(
            accountType,
            r'ChartOfAccount',
            'accountType',
          ),
          description: description,
          isActive: BuiltValueNullFieldError.checkNotNull(
            isActive,
            r'ChartOfAccount',
            'isActive',
          ),
          createdAt: createdAt,
          updatedAt: updatedAt,
          schoolId: BuiltValueNullFieldError.checkNotNull(
            schoolId,
            r'ChartOfAccount',
            'schoolId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
