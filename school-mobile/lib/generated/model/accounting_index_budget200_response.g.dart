// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_index_budget200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingIndexBudget200Response
    extends AccountingIndexBudget200Response {
  @override
  final BuiltList<BudgetPlan> data;
  @override
  final AccountingIndexBudget200ResponseSummary summary;

  factory _$AccountingIndexBudget200Response([
    void Function(AccountingIndexBudget200ResponseBuilder)? updates,
  ]) => (AccountingIndexBudget200ResponseBuilder()..update(updates))._build();

  _$AccountingIndexBudget200Response._({
    required this.data,
    required this.summary,
  }) : super._();
  @override
  AccountingIndexBudget200Response rebuild(
    void Function(AccountingIndexBudget200ResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingIndexBudget200ResponseBuilder toBuilder() =>
      AccountingIndexBudget200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingIndexBudget200Response &&
        data == other.data &&
        summary == other.summary;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, summary.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AccountingIndexBudget200Response')
          ..add('data', data)
          ..add('summary', summary))
        .toString();
  }
}

class AccountingIndexBudget200ResponseBuilder
    implements
        Builder<
          AccountingIndexBudget200Response,
          AccountingIndexBudget200ResponseBuilder
        > {
  _$AccountingIndexBudget200Response? _$v;

  ListBuilder<BudgetPlan>? _data;
  ListBuilder<BudgetPlan> get data =>
      _$this._data ??= ListBuilder<BudgetPlan>();
  set data(ListBuilder<BudgetPlan>? data) => _$this._data = data;

  AccountingIndexBudget200ResponseSummaryBuilder? _summary;
  AccountingIndexBudget200ResponseSummaryBuilder get summary =>
      _$this._summary ??= AccountingIndexBudget200ResponseSummaryBuilder();
  set summary(AccountingIndexBudget200ResponseSummaryBuilder? summary) =>
      _$this._summary = summary;

  AccountingIndexBudget200ResponseBuilder() {
    AccountingIndexBudget200Response._defaults(this);
  }

  AccountingIndexBudget200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _data = $v.data.toBuilder();
      _summary = $v.summary.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingIndexBudget200Response other) {
    _$v = other as _$AccountingIndexBudget200Response;
  }

  @override
  void update(void Function(AccountingIndexBudget200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AccountingIndexBudget200Response build() => _build();

  _$AccountingIndexBudget200Response _build() {
    _$AccountingIndexBudget200Response _$result;
    try {
      _$result =
          _$v ??
          _$AccountingIndexBudget200Response._(
            data: data.build(),
            summary: summary.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
        _$failedField = 'summary';
        summary.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountingIndexBudget200Response',
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
