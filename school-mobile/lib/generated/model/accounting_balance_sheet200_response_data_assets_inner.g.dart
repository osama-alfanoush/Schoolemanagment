// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_balance_sheet200_response_data_assets_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingBalanceSheet200ResponseDataAssetsInner
    extends AccountingBalanceSheet200ResponseDataAssetsInner {
  @override
  final String accountCode;
  @override
  final String accountName;
  @override
  final String balance;

  factory _$AccountingBalanceSheet200ResponseDataAssetsInner([
    void Function(AccountingBalanceSheet200ResponseDataAssetsInnerBuilder)?
    updates,
  ]) =>
      (AccountingBalanceSheet200ResponseDataAssetsInnerBuilder()
            ..update(updates))
          ._build();

  _$AccountingBalanceSheet200ResponseDataAssetsInner._({
    required this.accountCode,
    required this.accountName,
    required this.balance,
  }) : super._();
  @override
  AccountingBalanceSheet200ResponseDataAssetsInner rebuild(
    void Function(AccountingBalanceSheet200ResponseDataAssetsInnerBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingBalanceSheet200ResponseDataAssetsInnerBuilder toBuilder() =>
      AccountingBalanceSheet200ResponseDataAssetsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingBalanceSheet200ResponseDataAssetsInner &&
        accountCode == other.accountCode &&
        accountName == other.accountName &&
        balance == other.balance;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountCode.hashCode);
    _$hash = $jc(_$hash, accountName.hashCode);
    _$hash = $jc(_$hash, balance.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'AccountingBalanceSheet200ResponseDataAssetsInner',
          )
          ..add('accountCode', accountCode)
          ..add('accountName', accountName)
          ..add('balance', balance))
        .toString();
  }
}

class AccountingBalanceSheet200ResponseDataAssetsInnerBuilder
    implements
        Builder<
          AccountingBalanceSheet200ResponseDataAssetsInner,
          AccountingBalanceSheet200ResponseDataAssetsInnerBuilder
        > {
  _$AccountingBalanceSheet200ResponseDataAssetsInner? _$v;

  String? _accountCode;
  String? get accountCode => _$this._accountCode;
  set accountCode(String? accountCode) => _$this._accountCode = accountCode;

  String? _accountName;
  String? get accountName => _$this._accountName;
  set accountName(String? accountName) => _$this._accountName = accountName;

  String? _balance;
  String? get balance => _$this._balance;
  set balance(String? balance) => _$this._balance = balance;

  AccountingBalanceSheet200ResponseDataAssetsInnerBuilder() {
    AccountingBalanceSheet200ResponseDataAssetsInner._defaults(this);
  }

  AccountingBalanceSheet200ResponseDataAssetsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountCode = $v.accountCode;
      _accountName = $v.accountName;
      _balance = $v.balance;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingBalanceSheet200ResponseDataAssetsInner other) {
    _$v = other as _$AccountingBalanceSheet200ResponseDataAssetsInner;
  }

  @override
  void update(
    void Function(AccountingBalanceSheet200ResponseDataAssetsInnerBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingBalanceSheet200ResponseDataAssetsInner build() => _build();

  _$AccountingBalanceSheet200ResponseDataAssetsInner _build() {
    final _$result =
        _$v ??
        _$AccountingBalanceSheet200ResponseDataAssetsInner._(
          accountCode: BuiltValueNullFieldError.checkNotNull(
            accountCode,
            r'AccountingBalanceSheet200ResponseDataAssetsInner',
            'accountCode',
          ),
          accountName: BuiltValueNullFieldError.checkNotNull(
            accountName,
            r'AccountingBalanceSheet200ResponseDataAssetsInner',
            'accountName',
          ),
          balance: BuiltValueNullFieldError.checkNotNull(
            balance,
            r'AccountingBalanceSheet200ResponseDataAssetsInner',
            'balance',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
