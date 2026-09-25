// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_sync_budget_actuals200_response_data_updated_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingSyncBudgetActuals200ResponseDataUpdatedInner
    extends AccountingSyncBudgetActuals200ResponseDataUpdatedInner {
  @override
  final String id;
  @override
  final String category;
  @override
  final num actualAmount;
  @override
  final String usagePercent;

  factory _$AccountingSyncBudgetActuals200ResponseDataUpdatedInner([
    void Function(
      AccountingSyncBudgetActuals200ResponseDataUpdatedInnerBuilder,
    )?
    updates,
  ]) =>
      (AccountingSyncBudgetActuals200ResponseDataUpdatedInnerBuilder()
            ..update(updates))
          ._build();

  _$AccountingSyncBudgetActuals200ResponseDataUpdatedInner._({
    required this.id,
    required this.category,
    required this.actualAmount,
    required this.usagePercent,
  }) : super._();
  @override
  AccountingSyncBudgetActuals200ResponseDataUpdatedInner rebuild(
    void Function(AccountingSyncBudgetActuals200ResponseDataUpdatedInnerBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingSyncBudgetActuals200ResponseDataUpdatedInnerBuilder toBuilder() =>
      AccountingSyncBudgetActuals200ResponseDataUpdatedInnerBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingSyncBudgetActuals200ResponseDataUpdatedInner &&
        id == other.id &&
        category == other.category &&
        actualAmount == other.actualAmount &&
        usagePercent == other.usagePercent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, actualAmount.hashCode);
    _$hash = $jc(_$hash, usagePercent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'AccountingSyncBudgetActuals200ResponseDataUpdatedInner',
          )
          ..add('id', id)
          ..add('category', category)
          ..add('actualAmount', actualAmount)
          ..add('usagePercent', usagePercent))
        .toString();
  }
}

class AccountingSyncBudgetActuals200ResponseDataUpdatedInnerBuilder
    implements
        Builder<
          AccountingSyncBudgetActuals200ResponseDataUpdatedInner,
          AccountingSyncBudgetActuals200ResponseDataUpdatedInnerBuilder
        > {
  _$AccountingSyncBudgetActuals200ResponseDataUpdatedInner? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  num? _actualAmount;
  num? get actualAmount => _$this._actualAmount;
  set actualAmount(num? actualAmount) => _$this._actualAmount = actualAmount;

  String? _usagePercent;
  String? get usagePercent => _$this._usagePercent;
  set usagePercent(String? usagePercent) => _$this._usagePercent = usagePercent;

  AccountingSyncBudgetActuals200ResponseDataUpdatedInnerBuilder() {
    AccountingSyncBudgetActuals200ResponseDataUpdatedInner._defaults(this);
  }

  AccountingSyncBudgetActuals200ResponseDataUpdatedInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _category = $v.category;
      _actualAmount = $v.actualAmount;
      _usagePercent = $v.usagePercent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingSyncBudgetActuals200ResponseDataUpdatedInner other) {
    _$v = other as _$AccountingSyncBudgetActuals200ResponseDataUpdatedInner;
  }

  @override
  void update(
    void Function(
      AccountingSyncBudgetActuals200ResponseDataUpdatedInnerBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingSyncBudgetActuals200ResponseDataUpdatedInner build() => _build();

  _$AccountingSyncBudgetActuals200ResponseDataUpdatedInner _build() {
    final _$result =
        _$v ??
        _$AccountingSyncBudgetActuals200ResponseDataUpdatedInner._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'AccountingSyncBudgetActuals200ResponseDataUpdatedInner',
            'id',
          ),
          category: BuiltValueNullFieldError.checkNotNull(
            category,
            r'AccountingSyncBudgetActuals200ResponseDataUpdatedInner',
            'category',
          ),
          actualAmount: BuiltValueNullFieldError.checkNotNull(
            actualAmount,
            r'AccountingSyncBudgetActuals200ResponseDataUpdatedInner',
            'actualAmount',
          ),
          usagePercent: BuiltValueNullFieldError.checkNotNull(
            usagePercent,
            r'AccountingSyncBudgetActuals200ResponseDataUpdatedInner',
            'usagePercent',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
