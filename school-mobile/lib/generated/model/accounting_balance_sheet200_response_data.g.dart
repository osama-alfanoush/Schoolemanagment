// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounting_balance_sheet200_response_data.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AccountingBalanceSheet200ResponseData
    extends AccountingBalanceSheet200ResponseData {
  @override
  final BuiltList<AccountingBalanceSheet200ResponseDataAssetsInner> assets;
  @override
  final BuiltList<AccountingBalanceSheet200ResponseDataAssetsInner> liabilities;
  @override
  final BuiltList<AccountingBalanceSheet200ResponseDataAssetsInner> equity;
  @override
  final int assetTotal;
  @override
  final int liabilityTotal;
  @override
  final int equityTotal;

  factory _$AccountingBalanceSheet200ResponseData([
    void Function(AccountingBalanceSheet200ResponseDataBuilder)? updates,
  ]) => (AccountingBalanceSheet200ResponseDataBuilder()..update(updates))
      ._build();

  _$AccountingBalanceSheet200ResponseData._({
    required this.assets,
    required this.liabilities,
    required this.equity,
    required this.assetTotal,
    required this.liabilityTotal,
    required this.equityTotal,
  }) : super._();
  @override
  AccountingBalanceSheet200ResponseData rebuild(
    void Function(AccountingBalanceSheet200ResponseDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AccountingBalanceSheet200ResponseDataBuilder toBuilder() =>
      AccountingBalanceSheet200ResponseDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AccountingBalanceSheet200ResponseData &&
        assets == other.assets &&
        liabilities == other.liabilities &&
        equity == other.equity &&
        assetTotal == other.assetTotal &&
        liabilityTotal == other.liabilityTotal &&
        equityTotal == other.equityTotal;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, assets.hashCode);
    _$hash = $jc(_$hash, liabilities.hashCode);
    _$hash = $jc(_$hash, equity.hashCode);
    _$hash = $jc(_$hash, assetTotal.hashCode);
    _$hash = $jc(_$hash, liabilityTotal.hashCode);
    _$hash = $jc(_$hash, equityTotal.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'AccountingBalanceSheet200ResponseData',
          )
          ..add('assets', assets)
          ..add('liabilities', liabilities)
          ..add('equity', equity)
          ..add('assetTotal', assetTotal)
          ..add('liabilityTotal', liabilityTotal)
          ..add('equityTotal', equityTotal))
        .toString();
  }
}

class AccountingBalanceSheet200ResponseDataBuilder
    implements
        Builder<
          AccountingBalanceSheet200ResponseData,
          AccountingBalanceSheet200ResponseDataBuilder
        > {
  _$AccountingBalanceSheet200ResponseData? _$v;

  ListBuilder<AccountingBalanceSheet200ResponseDataAssetsInner>? _assets;
  ListBuilder<AccountingBalanceSheet200ResponseDataAssetsInner> get assets =>
      _$this._assets ??=
          ListBuilder<AccountingBalanceSheet200ResponseDataAssetsInner>();
  set assets(
    ListBuilder<AccountingBalanceSheet200ResponseDataAssetsInner>? assets,
  ) => _$this._assets = assets;

  ListBuilder<AccountingBalanceSheet200ResponseDataAssetsInner>? _liabilities;
  ListBuilder<AccountingBalanceSheet200ResponseDataAssetsInner>
  get liabilities => _$this._liabilities ??=
      ListBuilder<AccountingBalanceSheet200ResponseDataAssetsInner>();
  set liabilities(
    ListBuilder<AccountingBalanceSheet200ResponseDataAssetsInner>? liabilities,
  ) => _$this._liabilities = liabilities;

  ListBuilder<AccountingBalanceSheet200ResponseDataAssetsInner>? _equity;
  ListBuilder<AccountingBalanceSheet200ResponseDataAssetsInner> get equity =>
      _$this._equity ??=
          ListBuilder<AccountingBalanceSheet200ResponseDataAssetsInner>();
  set equity(
    ListBuilder<AccountingBalanceSheet200ResponseDataAssetsInner>? equity,
  ) => _$this._equity = equity;

  int? _assetTotal;
  int? get assetTotal => _$this._assetTotal;
  set assetTotal(int? assetTotal) => _$this._assetTotal = assetTotal;

  int? _liabilityTotal;
  int? get liabilityTotal => _$this._liabilityTotal;
  set liabilityTotal(int? liabilityTotal) =>
      _$this._liabilityTotal = liabilityTotal;

  int? _equityTotal;
  int? get equityTotal => _$this._equityTotal;
  set equityTotal(int? equityTotal) => _$this._equityTotal = equityTotal;

  AccountingBalanceSheet200ResponseDataBuilder() {
    AccountingBalanceSheet200ResponseData._defaults(this);
  }

  AccountingBalanceSheet200ResponseDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _assets = $v.assets.toBuilder();
      _liabilities = $v.liabilities.toBuilder();
      _equity = $v.equity.toBuilder();
      _assetTotal = $v.assetTotal;
      _liabilityTotal = $v.liabilityTotal;
      _equityTotal = $v.equityTotal;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AccountingBalanceSheet200ResponseData other) {
    _$v = other as _$AccountingBalanceSheet200ResponseData;
  }

  @override
  void update(
    void Function(AccountingBalanceSheet200ResponseDataBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AccountingBalanceSheet200ResponseData build() => _build();

  _$AccountingBalanceSheet200ResponseData _build() {
    _$AccountingBalanceSheet200ResponseData _$result;
    try {
      _$result =
          _$v ??
          _$AccountingBalanceSheet200ResponseData._(
            assets: assets.build(),
            liabilities: liabilities.build(),
            equity: equity.build(),
            assetTotal: BuiltValueNullFieldError.checkNotNull(
              assetTotal,
              r'AccountingBalanceSheet200ResponseData',
              'assetTotal',
            ),
            liabilityTotal: BuiltValueNullFieldError.checkNotNull(
              liabilityTotal,
              r'AccountingBalanceSheet200ResponseData',
              'liabilityTotal',
            ),
            equityTotal: BuiltValueNullFieldError.checkNotNull(
              equityTotal,
              r'AccountingBalanceSheet200ResponseData',
              'equityTotal',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'assets';
        assets.build();
        _$failedField = 'liabilities';
        liabilities.build();
        _$failedField = 'equity';
        equity.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AccountingBalanceSheet200ResponseData',
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
