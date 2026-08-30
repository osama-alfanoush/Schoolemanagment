// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_trial_balance200_response_data_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingTrialBalance200ResponseDataInner
    extends AccountingTrialBalance200ResponseDataInner {
  @override
  final String accountCode;
  @override
  final String accountName;
  @override
  final num totalDebit;
  @override
  final num totalCredit;
  @override
  final String balance;

  factory _$AccountingTrialBalance200ResponseDataInner([
    void Function(AccountingTrialBalance200ResponseDataInnerBuilder)? updates,
  ]) => (AccountingTrialBalance200ResponseDataInnerBuilder()..update(updates))
      ._build();

  _$AccountingTrialBalance200ResponseDataInner._({
    required this.accountCode,
    required this.accountName,
    required this.totalDebit,
    required this.totalCredit,
    required this.balance,
  }) : super._();
  @override
  AccountingTrialBalance200ResponseDataInner rebuild(
    void Function(AccountingTrialBalance200ResponseDataInnerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingTrialBalance200ResponseDataInnerBuilder toBuilder() =>
      AccountingTrialBalance200ResponseDataInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingTrialBalance200ResponseDataInner &&
        accountCode == other.accountCode &&
        accountName == other.accountName &&
        totalDebit == other.totalDebit &&
        totalCredit == other.totalCredit &&
        balance == other.balance;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountCode.hashCode);
    _$hash = $jc(_$hash, accountName.hashCode);
    _$hash = $jc(_$hash, totalDebit.hashCode);
    _$hash = $jc(_$hash, totalCredit.hashCode);
    _$hash = $jc(_$hash, balance.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'AccountingTrialBalance200ResponseDataInner',
          )
          ..add('accountCode', accountCode)
          ..add('accountName', accountName)
          ..add('totalDebit', totalDebit)
          ..add('totalCredit', totalCredit)
          ..add('balance', balance))
        .toString();
  }
}

class AccountingTrialBalance200ResponseDataInnerBuilder
    implements
        Builder<
          AccountingTrialBalance200ResponseDataInner,
          AccountingTrialBalance200ResponseDataInnerBuilder
        > {
  _$AccountingTrialBalance200ResponseDataInner? _$v;

  String? _accountCode;
  String? get accountCode => _$this._accountCode;
  set accountCode(String? accountCode) => _$this._accountCode = accountCode;

  String? _accountName;
  String? get accountName => _$this._accountName;
  set accountName(String? accountName) => _$this._accountName = accountName;

  num? _totalDebit;
  num? get totalDebit => _$this._totalDebit;
  set totalDebit(num? totalDebit) => _$this._totalDebit = totalDebit;

  num? _totalCredit;
  num? get totalCredit => _$this._totalCredit;
  set totalCredit(num? totalCredit) => _$this._totalCredit = totalCredit;

  String? _balance;
  String? get balance => _$this._balance;
  set balance(String? balance) => _$this._balance = balance;

  AccountingTrialBalance200ResponseDataInnerBuilder() {
    AccountingTrialBalance200ResponseDataInner._defaults(this);
  }

  AccountingTrialBalance200ResponseDataInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountCode = $v.accountCode;
      _accountName = $v.accountName;
      _totalDebit = $v.totalDebit;
      _totalCredit = $v.totalCredit;
      _balance = $v.balance;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingTrialBalance200ResponseDataInner other) {
    _$v = other as _$AccountingTrialBalance200ResponseDataInner;
  }

  @override
  void update(
    void Function(AccountingTrialBalance200ResponseDataInnerBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingTrialBalance200ResponseDataInner build() => _build();

  _$AccountingTrialBalance200ResponseDataInner _build() {
    final _$result =
        _$v ??
        _$AccountingTrialBalance200ResponseDataInner._(
          accountCode: BuiltValueNullFieldError.checkNotNull(
            accountCode,
            r'AccountingTrialBalance200ResponseDataInner',
            'accountCode',
          ),
          accountName: BuiltValueNullFieldError.checkNotNull(
            accountName,
            r'AccountingTrialBalance200ResponseDataInner',
            'accountName',
          ),
          totalDebit: BuiltValueNullFieldError.checkNotNull(
            totalDebit,
            r'AccountingTrialBalance200ResponseDataInner',
            'totalDebit',
          ),
          totalCredit: BuiltValueNullFieldError.checkNotNull(
            totalCredit,
            r'AccountingTrialBalance200ResponseDataInner',
            'totalCredit',
          ),
          balance: BuiltValueNullFieldError.checkNotNull(
            balance,
            r'AccountingTrialBalance200ResponseDataInner',
            'balance',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
