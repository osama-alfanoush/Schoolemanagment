// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_invoices200_response_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinanceInvoices200ResponseSummary
    extends FinanceInvoices200ResponseSummary {
  @override
  final num todayTotal;
  @override
  final num monthTotal;
  @override
  final num pendingConfirmationTotal;

  factory _$FinanceInvoices200ResponseSummary([
    void Function(FinanceInvoices200ResponseSummaryBuilder)? updates,
  ]) => (FinanceInvoices200ResponseSummaryBuilder()..update(updates))._build();

  _$FinanceInvoices200ResponseSummary._({
    required this.todayTotal,
    required this.monthTotal,
    required this.pendingConfirmationTotal,
  }) : super._();
  @override
  FinanceInvoices200ResponseSummary rebuild(
    void Function(FinanceInvoices200ResponseSummaryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceInvoices200ResponseSummaryBuilder toBuilder() =>
      FinanceInvoices200ResponseSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceInvoices200ResponseSummary &&
        todayTotal == other.todayTotal &&
        monthTotal == other.monthTotal &&
        pendingConfirmationTotal == other.pendingConfirmationTotal;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, todayTotal.hashCode);
    _$hash = $jc(_$hash, monthTotal.hashCode);
    _$hash = $jc(_$hash, pendingConfirmationTotal.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinanceInvoices200ResponseSummary')
          ..add('todayTotal', todayTotal)
          ..add('monthTotal', monthTotal)
          ..add('pendingConfirmationTotal', pendingConfirmationTotal))
        .toString();
  }
}

class FinanceInvoices200ResponseSummaryBuilder
    implements
        Builder<
          FinanceInvoices200ResponseSummary,
          FinanceInvoices200ResponseSummaryBuilder
        > {
  _$FinanceInvoices200ResponseSummary? _$v;

  num? _todayTotal;
  num? get todayTotal => _$this._todayTotal;
  set todayTotal(num? todayTotal) => _$this._todayTotal = todayTotal;

  num? _monthTotal;
  num? get monthTotal => _$this._monthTotal;
  set monthTotal(num? monthTotal) => _$this._monthTotal = monthTotal;

  num? _pendingConfirmationTotal;
  num? get pendingConfirmationTotal => _$this._pendingConfirmationTotal;
  set pendingConfirmationTotal(num? pendingConfirmationTotal) =>
      _$this._pendingConfirmationTotal = pendingConfirmationTotal;

  FinanceInvoices200ResponseSummaryBuilder() {
    FinanceInvoices200ResponseSummary._defaults(this);
  }

  FinanceInvoices200ResponseSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _todayTotal = $v.todayTotal;
      _monthTotal = $v.monthTotal;
      _pendingConfirmationTotal = $v.pendingConfirmationTotal;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceInvoices200ResponseSummary other) {
    _$v = other as _$FinanceInvoices200ResponseSummary;
  }

  @override
  void update(
    void Function(FinanceInvoices200ResponseSummaryBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  FinanceInvoices200ResponseSummary build() => _build();

  _$FinanceInvoices200ResponseSummary _build() {
    final _$result =
        _$v ??
        _$FinanceInvoices200ResponseSummary._(
          todayTotal: BuiltValueNullFieldError.checkNotNull(
            todayTotal,
            r'FinanceInvoices200ResponseSummary',
            'todayTotal',
          ),
          monthTotal: BuiltValueNullFieldError.checkNotNull(
            monthTotal,
            r'FinanceInvoices200ResponseSummary',
            'monthTotal',
          ),
          pendingConfirmationTotal: BuiltValueNullFieldError.checkNotNull(
            pendingConfirmationTotal,
            r'FinanceInvoices200ResponseSummary',
            'pendingConfirmationTotal',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
