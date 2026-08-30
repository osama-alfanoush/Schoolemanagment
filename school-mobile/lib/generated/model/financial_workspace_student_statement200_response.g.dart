// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_workspace_student_statement200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FinancialWorkspaceStudentStatement200Response
    extends FinancialWorkspaceStudentStatement200Response {
  @override
  final BuiltList<String> data;
  @override
  final JsonObject? currentPage;
  @override
  final JsonObject? perPage;
  @override
  final JsonObject? lastPage;
  @override
  final int total;
  @override
  final String openingBalance;
  @override
  final String periodDebit;
  @override
  final String periodCredit;
  @override
  final String closingBalance;

  factory _$FinancialWorkspaceStudentStatement200Response([
    void Function(FinancialWorkspaceStudentStatement200ResponseBuilder)?
    updates,
  ]) =>
      (FinancialWorkspaceStudentStatement200ResponseBuilder()..update(updates))
          ._build();

  _$FinancialWorkspaceStudentStatement200Response._({
    required this.data,
    this.currentPage,
    this.perPage,
    this.lastPage,
    required this.total,
    required this.openingBalance,
    required this.periodDebit,
    required this.periodCredit,
    required this.closingBalance,
  }) : super._();
  @override
  FinancialWorkspaceStudentStatement200Response rebuild(
    void Function(FinancialWorkspaceStudentStatement200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinancialWorkspaceStudentStatement200ResponseBuilder toBuilder() =>
      FinancialWorkspaceStudentStatement200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinancialWorkspaceStudentStatement200Response &&
        data == other.data &&
        currentPage == other.currentPage &&
        perPage == other.perPage &&
        lastPage == other.lastPage &&
        total == other.total &&
        openingBalance == other.openingBalance &&
        periodDebit == other.periodDebit &&
        periodCredit == other.periodCredit &&
        closingBalance == other.closingBalance;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, currentPage.hashCode);
    _$hash = $jc(_$hash, perPage.hashCode);
    _$hash = $jc(_$hash, lastPage.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, openingBalance.hashCode);
    _$hash = $jc(_$hash, periodDebit.hashCode);
    _$hash = $jc(_$hash, periodCredit.hashCode);
    _$hash = $jc(_$hash, closingBalance.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'FinancialWorkspaceStudentStatement200Response',
          )
          ..add('data', data)
          ..add('currentPage', currentPage)
          ..add('perPage', perPage)
          ..add('lastPage', lastPage)
          ..add('total', total)
          ..add('openingBalance', openingBalance)
          ..add('periodDebit', periodDebit)
          ..add('periodCredit', periodCredit)
          ..add('closingBalance', closingBalance))
        .toString();
  }
}

class FinancialWorkspaceStudentStatement200ResponseBuilder
    implements
        Builder<
          FinancialWorkspaceStudentStatement200Response,
          FinancialWorkspaceStudentStatement200ResponseBuilder
        > {
  _$FinancialWorkspaceStudentStatement200Response? _$v;

  ListBuilder<String>? _data;
  ListBuilder<String> get data => _$this._data ??= ListBuilder<String>();
  set data(ListBuilder<String>? data) => _$this._data = data;

  JsonObject? _currentPage;
  JsonObject? get currentPage => _$this._currentPage;
  set currentPage(JsonObject? currentPage) => _$this._currentPage = currentPage;

  JsonObject? _perPage;
  JsonObject? get perPage => _$this._perPage;
  set perPage(JsonObject? perPage) => _$this._perPage = perPage;

  JsonObject? _lastPage;
  JsonObject? get lastPage => _$this._lastPage;
  set lastPage(JsonObject? lastPage) => _$this._lastPage = lastPage;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  String? _openingBalance;
  String? get openingBalance => _$this._openingBalance;
  set openingBalance(String? openingBalance) =>
      _$this._openingBalance = openingBalance;

  String? _periodDebit;
  String? get periodDebit => _$this._periodDebit;
  set periodDebit(String? periodDebit) => _$this._periodDebit = periodDebit;

  String? _periodCredit;
  String? get periodCredit => _$this._periodCredit;
  set periodCredit(String? periodCredit) => _$this._periodCredit = periodCredit;

  String? _closingBalance;
  String? get closingBalance => _$this._closingBalance;
  set closingBalance(String? closingBalance) =>
      _$this._closingBalance = closingBalance;

  FinancialWorkspaceStudentStatement200ResponseBuilder() {
    FinancialWorkspaceStudentStatement200Response._defaults(this);
  }

  FinancialWorkspaceStudentStatement200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _currentPage = $v.currentPage;
      _perPage = $v.perPage;
      _lastPage = $v.lastPage;
      _total = $v.total;
      _openingBalance = $v.openingBalance;
      _periodDebit = $v.periodDebit;
      _periodCredit = $v.periodCredit;
      _closingBalance = $v.closingBalance;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinancialWorkspaceStudentStatement200Response other) {
    _$v = other as _$FinancialWorkspaceStudentStatement200Response;
  }

  @override
  void update(
    void Function(FinancialWorkspaceStudentStatement200ResponseBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  FinancialWorkspaceStudentStatement200Response build() => _build();

  _$FinancialWorkspaceStudentStatement200Response _build() {
    _$FinancialWorkspaceStudentStatement200Response _$result;
    try {
      _$result =
          _$v ??
          _$FinancialWorkspaceStudentStatement200Response._(
            data: data.build(),
            currentPage: currentPage,
            perPage: perPage,
            lastPage: lastPage,
            total: BuiltValueNullFieldError.checkNotNull(
              total,
              r'FinancialWorkspaceStudentStatement200Response',
              'total',
            ),
            openingBalance: BuiltValueNullFieldError.checkNotNull(
              openingBalance,
              r'FinancialWorkspaceStudentStatement200Response',
              'openingBalance',
            ),
            periodDebit: BuiltValueNullFieldError.checkNotNull(
              periodDebit,
              r'FinancialWorkspaceStudentStatement200Response',
              'periodDebit',
            ),
            periodCredit: BuiltValueNullFieldError.checkNotNull(
              periodCredit,
              r'FinancialWorkspaceStudentStatement200Response',
              'periodCredit',
            ),
            closingBalance: BuiltValueNullFieldError.checkNotNull(
              closingBalance,
              r'FinancialWorkspaceStudentStatement200Response',
              'closingBalance',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'FinancialWorkspaceStudentStatement200Response',
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
