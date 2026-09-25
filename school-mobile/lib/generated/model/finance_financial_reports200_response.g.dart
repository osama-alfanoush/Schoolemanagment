// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_financial_reports200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinanceFinancialReports200Response
    extends FinanceFinancialReports200Response {
  @override
  final BuiltList<JsonObject?> period;
  @override
  final BuiltList<Payment> incomeByMethod;
  @override
  final num totalCollected;
  @override
  final num totalBilled;
  @override
  final num totalOutstanding;
  @override
  final num totalPayroll;
  @override
  final int invoicesIssued;
  @override
  final int payrollCount;
  @override
  final String net;

  factory _$FinanceFinancialReports200Response([
    void Function(FinanceFinancialReports200ResponseBuilder)? updates,
  ]) => (FinanceFinancialReports200ResponseBuilder()..update(updates))._build();

  _$FinanceFinancialReports200Response._({
    required this.period,
    required this.incomeByMethod,
    required this.totalCollected,
    required this.totalBilled,
    required this.totalOutstanding,
    required this.totalPayroll,
    required this.invoicesIssued,
    required this.payrollCount,
    required this.net,
  }) : super._();
  @override
  FinanceFinancialReports200Response rebuild(
    void Function(FinanceFinancialReports200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceFinancialReports200ResponseBuilder toBuilder() =>
      FinanceFinancialReports200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceFinancialReports200Response &&
        period == other.period &&
        incomeByMethod == other.incomeByMethod &&
        totalCollected == other.totalCollected &&
        totalBilled == other.totalBilled &&
        totalOutstanding == other.totalOutstanding &&
        totalPayroll == other.totalPayroll &&
        invoicesIssued == other.invoicesIssued &&
        payrollCount == other.payrollCount &&
        net == other.net;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, period.hashCode);
    _$hash = $jc(_$hash, incomeByMethod.hashCode);
    _$hash = $jc(_$hash, totalCollected.hashCode);
    _$hash = $jc(_$hash, totalBilled.hashCode);
    _$hash = $jc(_$hash, totalOutstanding.hashCode);
    _$hash = $jc(_$hash, totalPayroll.hashCode);
    _$hash = $jc(_$hash, invoicesIssued.hashCode);
    _$hash = $jc(_$hash, payrollCount.hashCode);
    _$hash = $jc(_$hash, net.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinanceFinancialReports200Response')
          ..add('period', period)
          ..add('incomeByMethod', incomeByMethod)
          ..add('totalCollected', totalCollected)
          ..add('totalBilled', totalBilled)
          ..add('totalOutstanding', totalOutstanding)
          ..add('totalPayroll', totalPayroll)
          ..add('invoicesIssued', invoicesIssued)
          ..add('payrollCount', payrollCount)
          ..add('net', net))
        .toString();
  }
}

class FinanceFinancialReports200ResponseBuilder
    implements
        Builder<
          FinanceFinancialReports200Response,
          FinanceFinancialReports200ResponseBuilder
        > {
  _$FinanceFinancialReports200Response? _$v;

  ListBuilder<JsonObject?>? _period;
  ListBuilder<JsonObject?> get period =>
      _$this._period ??= ListBuilder<JsonObject?>();
  set period(ListBuilder<JsonObject?>? period) => _$this._period = period;

  ListBuilder<Payment>? _incomeByMethod;
  ListBuilder<Payment> get incomeByMethod =>
      _$this._incomeByMethod ??= ListBuilder<Payment>();
  set incomeByMethod(ListBuilder<Payment>? incomeByMethod) =>
      _$this._incomeByMethod = incomeByMethod;

  num? _totalCollected;
  num? get totalCollected => _$this._totalCollected;
  set totalCollected(num? totalCollected) =>
      _$this._totalCollected = totalCollected;

  num? _totalBilled;
  num? get totalBilled => _$this._totalBilled;
  set totalBilled(num? totalBilled) => _$this._totalBilled = totalBilled;

  num? _totalOutstanding;
  num? get totalOutstanding => _$this._totalOutstanding;
  set totalOutstanding(num? totalOutstanding) =>
      _$this._totalOutstanding = totalOutstanding;

  num? _totalPayroll;
  num? get totalPayroll => _$this._totalPayroll;
  set totalPayroll(num? totalPayroll) => _$this._totalPayroll = totalPayroll;

  int? _invoicesIssued;
  int? get invoicesIssued => _$this._invoicesIssued;
  set invoicesIssued(int? invoicesIssued) =>
      _$this._invoicesIssued = invoicesIssued;

  int? _payrollCount;
  int? get payrollCount => _$this._payrollCount;
  set payrollCount(int? payrollCount) => _$this._payrollCount = payrollCount;

  String? _net;
  String? get net => _$this._net;
  set net(String? net) => _$this._net = net;

  FinanceFinancialReports200ResponseBuilder() {
    FinanceFinancialReports200Response._defaults(this);
  }

  FinanceFinancialReports200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _period = $v.period.toBuilder();
      _incomeByMethod = $v.incomeByMethod.toBuilder();
      _totalCollected = $v.totalCollected;
      _totalBilled = $v.totalBilled;
      _totalOutstanding = $v.totalOutstanding;
      _totalPayroll = $v.totalPayroll;
      _invoicesIssued = $v.invoicesIssued;
      _payrollCount = $v.payrollCount;
      _net = $v.net;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceFinancialReports200Response other) {
    _$v = other as _$FinanceFinancialReports200Response;
  }

  @override
  void update(
    void Function(FinanceFinancialReports200ResponseBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  FinanceFinancialReports200Response build() => _build();

  _$FinanceFinancialReports200Response _build() {
    _$FinanceFinancialReports200Response _$result;
    try {
      _$result =
          _$v ??
          _$FinanceFinancialReports200Response._(
            period: period.build(),
            incomeByMethod: incomeByMethod.build(),
            totalCollected: BuiltValueNullFieldError.checkNotNull(
              totalCollected,
              r'FinanceFinancialReports200Response',
              'totalCollected',
            ),
            totalBilled: BuiltValueNullFieldError.checkNotNull(
              totalBilled,
              r'FinanceFinancialReports200Response',
              'totalBilled',
            ),
            totalOutstanding: BuiltValueNullFieldError.checkNotNull(
              totalOutstanding,
              r'FinanceFinancialReports200Response',
              'totalOutstanding',
            ),
            totalPayroll: BuiltValueNullFieldError.checkNotNull(
              totalPayroll,
              r'FinanceFinancialReports200Response',
              'totalPayroll',
            ),
            invoicesIssued: BuiltValueNullFieldError.checkNotNull(
              invoicesIssued,
              r'FinanceFinancialReports200Response',
              'invoicesIssued',
            ),
            payrollCount: BuiltValueNullFieldError.checkNotNull(
              payrollCount,
              r'FinanceFinancialReports200Response',
              'payrollCount',
            ),
            net: BuiltValueNullFieldError.checkNotNull(
              net,
              r'FinanceFinancialReports200Response',
              'net',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'period';
        period.build();
        _$failedField = 'incomeByMethod';
        incomeByMethod.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'FinanceFinancialReports200Response',
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
