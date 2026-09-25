// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_index_budget200_response_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingIndexBudget200ResponseSummary
    extends AccountingIndexBudget200ResponseSummary {
  @override
  final num totalPlanned;
  @override
  final num totalActual;
  @override
  final String totalVariance;

  factory _$AccountingIndexBudget200ResponseSummary([
    void Function(AccountingIndexBudget200ResponseSummaryBuilder)? updates,
  ]) => (AccountingIndexBudget200ResponseSummaryBuilder()..update(updates))
      ._build();

  _$AccountingIndexBudget200ResponseSummary._({
    required this.totalPlanned,
    required this.totalActual,
    required this.totalVariance,
  }) : super._();
  @override
  AccountingIndexBudget200ResponseSummary rebuild(
    void Function(AccountingIndexBudget200ResponseSummaryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingIndexBudget200ResponseSummaryBuilder toBuilder() =>
      AccountingIndexBudget200ResponseSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingIndexBudget200ResponseSummary &&
        totalPlanned == other.totalPlanned &&
        totalActual == other.totalActual &&
        totalVariance == other.totalVariance;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalPlanned.hashCode);
    _$hash = $jc(_$hash, totalActual.hashCode);
    _$hash = $jc(_$hash, totalVariance.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'AccountingIndexBudget200ResponseSummary',
          )
          ..add('totalPlanned', totalPlanned)
          ..add('totalActual', totalActual)
          ..add('totalVariance', totalVariance))
        .toString();
  }
}

class AccountingIndexBudget200ResponseSummaryBuilder
    implements
        Builder<
          AccountingIndexBudget200ResponseSummary,
          AccountingIndexBudget200ResponseSummaryBuilder
        > {
  _$AccountingIndexBudget200ResponseSummary? _$v;

  num? _totalPlanned;
  num? get totalPlanned => _$this._totalPlanned;
  set totalPlanned(num? totalPlanned) => _$this._totalPlanned = totalPlanned;

  num? _totalActual;
  num? get totalActual => _$this._totalActual;
  set totalActual(num? totalActual) => _$this._totalActual = totalActual;

  String? _totalVariance;
  String? get totalVariance => _$this._totalVariance;
  set totalVariance(String? totalVariance) =>
      _$this._totalVariance = totalVariance;

  AccountingIndexBudget200ResponseSummaryBuilder() {
    AccountingIndexBudget200ResponseSummary._defaults(this);
  }

  AccountingIndexBudget200ResponseSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalPlanned = $v.totalPlanned;
      _totalActual = $v.totalActual;
      _totalVariance = $v.totalVariance;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingIndexBudget200ResponseSummary other) {
    _$v = other as _$AccountingIndexBudget200ResponseSummary;
  }

  @override
  void update(
    void Function(AccountingIndexBudget200ResponseSummaryBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingIndexBudget200ResponseSummary build() => _build();

  _$AccountingIndexBudget200ResponseSummary _build() {
    final _$result =
        _$v ??
        _$AccountingIndexBudget200ResponseSummary._(
          totalPlanned: BuiltValueNullFieldError.checkNotNull(
            totalPlanned,
            r'AccountingIndexBudget200ResponseSummary',
            'totalPlanned',
          ),
          totalActual: BuiltValueNullFieldError.checkNotNull(
            totalActual,
            r'AccountingIndexBudget200ResponseSummary',
            'totalActual',
          ),
          totalVariance: BuiltValueNullFieldError.checkNotNull(
            totalVariance,
            r'AccountingIndexBudget200ResponseSummary',
            'totalVariance',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
