// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_sync_budget_actuals200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingSyncBudgetActuals200ResponseData
    extends AccountingSyncBudgetActuals200ResponseData {
  @override
  final BuiltList<AccountingSyncBudgetActuals200ResponseDataUpdatedInner>
  updated;
  @override
  final int overruns;

  factory _$AccountingSyncBudgetActuals200ResponseData([
    void Function(AccountingSyncBudgetActuals200ResponseDataBuilder)? updates,
  ]) => (AccountingSyncBudgetActuals200ResponseDataBuilder()..update(updates))
      ._build();

  _$AccountingSyncBudgetActuals200ResponseData._({
    required this.updated,
    required this.overruns,
  }) : super._();
  @override
  AccountingSyncBudgetActuals200ResponseData rebuild(
    void Function(AccountingSyncBudgetActuals200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingSyncBudgetActuals200ResponseDataBuilder toBuilder() =>
      AccountingSyncBudgetActuals200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingSyncBudgetActuals200ResponseData &&
        updated == other.updated &&
        overruns == other.overruns;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, updated.hashCode);
    _$hash = $jc(_$hash, overruns.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'AccountingSyncBudgetActuals200ResponseData',
          )
          ..add('updated', updated)
          ..add('overruns', overruns))
        .toString();
  }
}

class AccountingSyncBudgetActuals200ResponseDataBuilder
    implements
        Builder<
          AccountingSyncBudgetActuals200ResponseData,
          AccountingSyncBudgetActuals200ResponseDataBuilder
        > {
  _$AccountingSyncBudgetActuals200ResponseData? _$v;

  ListBuilder<AccountingSyncBudgetActuals200ResponseDataUpdatedInner>? _updated;
  ListBuilder<AccountingSyncBudgetActuals200ResponseDataUpdatedInner>
  get updated => _$this._updated ??=
      ListBuilder<AccountingSyncBudgetActuals200ResponseDataUpdatedInner>();
  set updated(
    ListBuilder<AccountingSyncBudgetActuals200ResponseDataUpdatedInner>?
    updated,
  ) => _$this._updated = updated;

  int? _overruns;
  int? get overruns => _$this._overruns;
  set overruns(int? overruns) => _$this._overruns = overruns;

  AccountingSyncBudgetActuals200ResponseDataBuilder() {
    AccountingSyncBudgetActuals200ResponseData._defaults(this);
  }

  AccountingSyncBudgetActuals200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _updated = $v.updated.toBuilder();
      _overruns = $v.overruns;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingSyncBudgetActuals200ResponseData other) {
    _$v = other as _$AccountingSyncBudgetActuals200ResponseData;
  }

  @override
  void update(
    void Function(AccountingSyncBudgetActuals200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingSyncBudgetActuals200ResponseData build() => _build();

  _$AccountingSyncBudgetActuals200ResponseData _build() {
    _$AccountingSyncBudgetActuals200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$AccountingSyncBudgetActuals200ResponseData._(
            updated: updated.build(),
            overruns: BuiltValueNullFieldError.checkNotNull(
              overruns,
              r'AccountingSyncBudgetActuals200ResponseData',
              'overruns',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'updated';
        updated.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountingSyncBudgetActuals200ResponseData',
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
