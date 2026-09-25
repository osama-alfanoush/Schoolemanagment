// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_income_statement200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingIncomeStatement200ResponseData
    extends AccountingIncomeStatement200ResponseData {
  @override
  final num totalIncome;
  @override
  final num totalPayroll;
  @override
  final num totalExpenses;
  @override
  final String netIncome;

  factory _$AccountingIncomeStatement200ResponseData([
    void Function(AccountingIncomeStatement200ResponseDataBuilder)? updates,
  ]) => (AccountingIncomeStatement200ResponseDataBuilder()..update(updates))
      ._build();

  _$AccountingIncomeStatement200ResponseData._({
    required this.totalIncome,
    required this.totalPayroll,
    required this.totalExpenses,
    required this.netIncome,
  }) : super._();
  @override
  AccountingIncomeStatement200ResponseData rebuild(
    void Function(AccountingIncomeStatement200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingIncomeStatement200ResponseDataBuilder toBuilder() =>
      AccountingIncomeStatement200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingIncomeStatement200ResponseData &&
        totalIncome == other.totalIncome &&
        totalPayroll == other.totalPayroll &&
        totalExpenses == other.totalExpenses &&
        netIncome == other.netIncome;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalIncome.hashCode);
    _$hash = $jc(_$hash, totalPayroll.hashCode);
    _$hash = $jc(_$hash, totalExpenses.hashCode);
    _$hash = $jc(_$hash, netIncome.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'AccountingIncomeStatement200ResponseData',
          )
          ..add('totalIncome', totalIncome)
          ..add('totalPayroll', totalPayroll)
          ..add('totalExpenses', totalExpenses)
          ..add('netIncome', netIncome))
        .toString();
  }
}

class AccountingIncomeStatement200ResponseDataBuilder
    implements
        Builder<
          AccountingIncomeStatement200ResponseData,
          AccountingIncomeStatement200ResponseDataBuilder
        > {
  _$AccountingIncomeStatement200ResponseData? _$v;

  num? _totalIncome;
  num? get totalIncome => _$this._totalIncome;
  set totalIncome(num? totalIncome) => _$this._totalIncome = totalIncome;

  num? _totalPayroll;
  num? get totalPayroll => _$this._totalPayroll;
  set totalPayroll(num? totalPayroll) => _$this._totalPayroll = totalPayroll;

  num? _totalExpenses;
  num? get totalExpenses => _$this._totalExpenses;
  set totalExpenses(num? totalExpenses) =>
      _$this._totalExpenses = totalExpenses;

  String? _netIncome;
  String? get netIncome => _$this._netIncome;
  set netIncome(String? netIncome) => _$this._netIncome = netIncome;

  AccountingIncomeStatement200ResponseDataBuilder() {
    AccountingIncomeStatement200ResponseData._defaults(this);
  }

  AccountingIncomeStatement200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalIncome = $v.totalIncome;
      _totalPayroll = $v.totalPayroll;
      _totalExpenses = $v.totalExpenses;
      _netIncome = $v.netIncome;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingIncomeStatement200ResponseData other) {
    _$v = other as _$AccountingIncomeStatement200ResponseData;
  }

  @override
  void update(
    void Function(AccountingIncomeStatement200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingIncomeStatement200ResponseData build() => _build();

  _$AccountingIncomeStatement200ResponseData _build() {
    final _$result =
        _$v ??
        _$AccountingIncomeStatement200ResponseData._(
          totalIncome: BuiltValueNullFieldError.checkNotNull(
            totalIncome,
            r'AccountingIncomeStatement200ResponseData',
            'totalIncome',
          ),
          totalPayroll: BuiltValueNullFieldError.checkNotNull(
            totalPayroll,
            r'AccountingIncomeStatement200ResponseData',
            'totalPayroll',
          ),
          totalExpenses: BuiltValueNullFieldError.checkNotNull(
            totalExpenses,
            r'AccountingIncomeStatement200ResponseData',
            'totalExpenses',
          ),
          netIncome: BuiltValueNullFieldError.checkNotNull(
            netIncome,
            r'AccountingIncomeStatement200ResponseData',
            'netIncome',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
