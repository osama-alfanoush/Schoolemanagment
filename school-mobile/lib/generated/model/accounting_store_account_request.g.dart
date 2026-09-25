// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_store_account_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AccountingStoreAccountRequestAccountTypeEnum
_$accountingStoreAccountRequestAccountTypeEnum_asset =
    const AccountingStoreAccountRequestAccountTypeEnum._('asset');
const AccountingStoreAccountRequestAccountTypeEnum
_$accountingStoreAccountRequestAccountTypeEnum_liability =
    const AccountingStoreAccountRequestAccountTypeEnum._('liability');
const AccountingStoreAccountRequestAccountTypeEnum
_$accountingStoreAccountRequestAccountTypeEnum_equity =
    const AccountingStoreAccountRequestAccountTypeEnum._('equity');
const AccountingStoreAccountRequestAccountTypeEnum
_$accountingStoreAccountRequestAccountTypeEnum_income =
    const AccountingStoreAccountRequestAccountTypeEnum._('income');
const AccountingStoreAccountRequestAccountTypeEnum
_$accountingStoreAccountRequestAccountTypeEnum_expense =
    const AccountingStoreAccountRequestAccountTypeEnum._('expense');

AccountingStoreAccountRequestAccountTypeEnum
_$accountingStoreAccountRequestAccountTypeEnumValueOf(String name) {
  switch (name) {
    case 'asset':
      return _$accountingStoreAccountRequestAccountTypeEnum_asset;
    case 'liability':
      return _$accountingStoreAccountRequestAccountTypeEnum_liability;
    case 'equity':
      return _$accountingStoreAccountRequestAccountTypeEnum_equity;
    case 'income':
      return _$accountingStoreAccountRequestAccountTypeEnum_income;
    case 'expense':
      return _$accountingStoreAccountRequestAccountTypeEnum_expense;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AccountingStoreAccountRequestAccountTypeEnum>
_$accountingStoreAccountRequestAccountTypeEnumValues =
    BuiltSet<AccountingStoreAccountRequestAccountTypeEnum>(
      const <AccountingStoreAccountRequestAccountTypeEnum>[
        _$accountingStoreAccountRequestAccountTypeEnum_asset,
        _$accountingStoreAccountRequestAccountTypeEnum_liability,
        _$accountingStoreAccountRequestAccountTypeEnum_equity,
        _$accountingStoreAccountRequestAccountTypeEnum_income,
        _$accountingStoreAccountRequestAccountTypeEnum_expense,
      ],
    );

Serializer<AccountingStoreAccountRequestAccountTypeEnum>
_$accountingStoreAccountRequestAccountTypeEnumSerializer =
    _$AccountingStoreAccountRequestAccountTypeEnumSerializer();

class _$AccountingStoreAccountRequestAccountTypeEnumSerializer
    implements
        PrimitiveSerializer<AccountingStoreAccountRequestAccountTypeEnum> {
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
    AccountingStoreAccountRequestAccountTypeEnum,
  ];
  @override
  final String wireName = 'AccountingStoreAccountRequestAccountTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AccountingStoreAccountRequestAccountTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AccountingStoreAccountRequestAccountTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AccountingStoreAccountRequestAccountTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AccountingStoreAccountRequest extends AccountingStoreAccountRequest {
  @override
  final String accountCode;
  @override
  final String accountName;
  @override
  final AccountingStoreAccountRequestAccountTypeEnum accountType;
  @override
  final String? description;
  @override
  final bool? isActive;

  factory _$AccountingStoreAccountRequest([
    void Function(AccountingStoreAccountRequestBuilder)? updates,
  ]) => (AccountingStoreAccountRequestBuilder()..update(updates))._build();

  _$AccountingStoreAccountRequest._({
    required this.accountCode,
    required this.accountName,
    required this.accountType,
    this.description,
    this.isActive,
  }) : super._();
  @override
  AccountingStoreAccountRequest rebuild(
    void Function(AccountingStoreAccountRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingStoreAccountRequestBuilder toBuilder() =>
      AccountingStoreAccountRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingStoreAccountRequest &&
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
    return (newBuiltValueToStringHelper(r'AccountingStoreAccountRequest')
          ..add('accountCode', accountCode)
          ..add('accountName', accountName)
          ..add('accountType', accountType)
          ..add('description', description)
          ..add('isActive', isActive))
        .toString();
  }
}

class AccountingStoreAccountRequestBuilder
    implements
        Builder<
          AccountingStoreAccountRequest,
          AccountingStoreAccountRequestBuilder
        > {
  _$AccountingStoreAccountRequest? _$v;

  String? _accountCode;
  String? get accountCode => _$this._accountCode;
  set accountCode(String? accountCode) => _$this._accountCode = accountCode;

  String? _accountName;
  String? get accountName => _$this._accountName;
  set accountName(String? accountName) => _$this._accountName = accountName;

  AccountingStoreAccountRequestAccountTypeEnum? _accountType;
  AccountingStoreAccountRequestAccountTypeEnum? get accountType =>
      _$this._accountType;
  set accountType(AccountingStoreAccountRequestAccountTypeEnum? accountType) =>
      _$this._accountType = accountType;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  AccountingStoreAccountRequestBuilder() {
    AccountingStoreAccountRequest._defaults(this);
  }

  AccountingStoreAccountRequestBuilder get _$this {
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
  void replace(AccountingStoreAccountRequest other) {
    _$v = other as _$AccountingStoreAccountRequest;
  }

  @override
  void update(void Function(AccountingStoreAccountRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountingStoreAccountRequest build() => _build();

  _$AccountingStoreAccountRequest _build() {
    final _$result =
        _$v ??
        _$AccountingStoreAccountRequest._(
          accountCode: BuiltValueNullFieldError.checkNotNull(
            accountCode,
            r'AccountingStoreAccountRequest',
            'accountCode',
          ),
          accountName: BuiltValueNullFieldError.checkNotNull(
            accountName,
            r'AccountingStoreAccountRequest',
            'accountName',
          ),
          accountType: BuiltValueNullFieldError.checkNotNull(
            accountType,
            r'AccountingStoreAccountRequest',
            'accountType',
          ),
          description: description,
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
