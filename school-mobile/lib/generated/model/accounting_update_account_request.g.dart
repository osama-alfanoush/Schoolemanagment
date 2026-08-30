// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_update_account_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccountingUpdateAccountRequestAccountTypeEnum
_$accountingUpdateAccountRequestAccountTypeEnum_asset =
    const AccountingUpdateAccountRequestAccountTypeEnum._('asset');
const AccountingUpdateAccountRequestAccountTypeEnum
_$accountingUpdateAccountRequestAccountTypeEnum_liability =
    const AccountingUpdateAccountRequestAccountTypeEnum._('liability');
const AccountingUpdateAccountRequestAccountTypeEnum
_$accountingUpdateAccountRequestAccountTypeEnum_equity =
    const AccountingUpdateAccountRequestAccountTypeEnum._('equity');
const AccountingUpdateAccountRequestAccountTypeEnum
_$accountingUpdateAccountRequestAccountTypeEnum_income =
    const AccountingUpdateAccountRequestAccountTypeEnum._('income');
const AccountingUpdateAccountRequestAccountTypeEnum
_$accountingUpdateAccountRequestAccountTypeEnum_expense =
    const AccountingUpdateAccountRequestAccountTypeEnum._('expense');

AccountingUpdateAccountRequestAccountTypeEnum
_$accountingUpdateAccountRequestAccountTypeEnumValueOf(String name) {
  switch (name) {
    case 'asset':
      return _$accountingUpdateAccountRequestAccountTypeEnum_asset;
    case 'liability':
      return _$accountingUpdateAccountRequestAccountTypeEnum_liability;
    case 'equity':
      return _$accountingUpdateAccountRequestAccountTypeEnum_equity;
    case 'income':
      return _$accountingUpdateAccountRequestAccountTypeEnum_income;
    case 'expense':
      return _$accountingUpdateAccountRequestAccountTypeEnum_expense;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AccountingUpdateAccountRequestAccountTypeEnum>
_$accountingUpdateAccountRequestAccountTypeEnumValues =
    BuiltSet<AccountingUpdateAccountRequestAccountTypeEnum>(
      const <AccountingUpdateAccountRequestAccountTypeEnum>[
        _$accountingUpdateAccountRequestAccountTypeEnum_asset,
        _$accountingUpdateAccountRequestAccountTypeEnum_liability,
        _$accountingUpdateAccountRequestAccountTypeEnum_equity,
        _$accountingUpdateAccountRequestAccountTypeEnum_income,
        _$accountingUpdateAccountRequestAccountTypeEnum_expense,
      ],
    );

Serializer<AccountingUpdateAccountRequestAccountTypeEnum>
_$accountingUpdateAccountRequestAccountTypeEnumSerializer =
    _$AccountingUpdateAccountRequestAccountTypeEnumSerializer();

class _$AccountingUpdateAccountRequestAccountTypeEnumSerializer
    implements
        PrimitiveSerializer<AccountingUpdateAccountRequestAccountTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'asset': 'asset',
    'liability': 'liability',
    'equity': 'equity',
    'income': 'income',
    'expense': 'expense',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'asset': 'asset',
    'liability': 'liability',
    'equity': 'equity',
    'income': 'income',
    'expense': 'expense',
  };

  @override
  final Iterable<Type> types = const <Type>[
    AccountingUpdateAccountRequestAccountTypeEnum,
  ];
  @override
  final String wireName = 'AccountingUpdateAccountRequestAccountTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AccountingUpdateAccountRequestAccountTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AccountingUpdateAccountRequestAccountTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AccountingUpdateAccountRequestAccountTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AccountingUpdateAccountRequest extends AccountingUpdateAccountRequest {
  @override
  final String? accountCode;
  @override
  final String? accountName;
  @override
  final AccountingUpdateAccountRequestAccountTypeEnum? accountType;
  @override
  final String? description;
  @override
  final bool? isActive;

  factory _$AccountingUpdateAccountRequest([
    void Function(AccountingUpdateAccountRequestBuilder)? updates,
  ]) => (AccountingUpdateAccountRequestBuilder()..update(updates))._build();

  _$AccountingUpdateAccountRequest._({
    this.accountCode,
    this.accountName,
    this.accountType,
    this.description,
    this.isActive,
  }) : super._();
  @override
  AccountingUpdateAccountRequest rebuild(
    void Function(AccountingUpdateAccountRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingUpdateAccountRequestBuilder toBuilder() =>
      AccountingUpdateAccountRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingUpdateAccountRequest &&
        accountCode == other.accountCode &&
        accountName == other.accountName &&
        accountType == other.accountType &&
        description == other.description &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountCode.hashCode);
    _$hash = $jc(_$hash, accountName.hashCode);
    _$hash = $jc(_$hash, accountType.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountingUpdateAccountRequest')
          ..add('accountCode', accountCode)
          ..add('accountName', accountName)
          ..add('accountType', accountType)
          ..add('description', description)
          ..add('isActive', isActive))
        .toString();
  }
}

class AccountingUpdateAccountRequestBuilder
    implements
        Builder<
          AccountingUpdateAccountRequest,
          AccountingUpdateAccountRequestBuilder
        > {
  _$AccountingUpdateAccountRequest? _$v;

  String? _accountCode;
  String? get accountCode => _$this._accountCode;
  set accountCode(String? accountCode) => _$this._accountCode = accountCode;

  String? _accountName;
  String? get accountName => _$this._accountName;
  set accountName(String? accountName) => _$this._accountName = accountName;

  AccountingUpdateAccountRequestAccountTypeEnum? _accountType;
  AccountingUpdateAccountRequestAccountTypeEnum? get accountType =>
      _$this._accountType;
  set accountType(AccountingUpdateAccountRequestAccountTypeEnum? accountType) =>
      _$this._accountType = accountType;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  AccountingUpdateAccountRequestBuilder() {
    AccountingUpdateAccountRequest._defaults(this);
  }

  AccountingUpdateAccountRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountCode = $v.accountCode;
      _accountName = $v.accountName;
      _accountType = $v.accountType;
      _description = $v.description;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingUpdateAccountRequest other) {
    _$v = other as _$AccountingUpdateAccountRequest;
  }

  @override
  void update(void Function(AccountingUpdateAccountRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountingUpdateAccountRequest build() => _build();

  _$AccountingUpdateAccountRequest _build() {
    final _$result =
        _$v ??
        _$AccountingUpdateAccountRequest._(
          accountCode: accountCode,
          accountName: accountName,
          accountType: accountType,
          description: description,
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
