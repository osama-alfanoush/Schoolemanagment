// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_monthly_report200_response_finance.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AdminMonthlyReport200ResponseFinance
    extends AdminMonthlyReport200ResponseFinance {
  @override
  final num billed;
  @override
  final num collected;

  factory _$AdminMonthlyReport200ResponseFinance([
    void Function(AdminMonthlyReport200ResponseFinanceBuilder)? updates,
  ]) =>
      (AdminMonthlyReport200ResponseFinanceBuilder()..update(updates))._build();

  _$AdminMonthlyReport200ResponseFinance._({
    required this.billed,
    required this.collected,
  }) : super._();
  @override
  AdminMonthlyReport200ResponseFinance rebuild(
    void Function(AdminMonthlyReport200ResponseFinanceBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  AdminMonthlyReport200ResponseFinanceBuilder toBuilder() =>
      AdminMonthlyReport200ResponseFinanceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminMonthlyReport200ResponseFinance &&
        billed == other.billed &&
        collected == other.collected;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, billed.hashCode);
    _$hash = $jc(_$hash, collected.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AdminMonthlyReport200ResponseFinance')
          ..add('billed', billed)
          ..add('collected', collected))
        .toString();
  }
}

class AdminMonthlyReport200ResponseFinanceBuilder
    implements
        Builder<
          AdminMonthlyReport200ResponseFinance,
          AdminMonthlyReport200ResponseFinanceBuilder
        > {
  _$AdminMonthlyReport200ResponseFinance? _$v;

  num? _billed;
  num? get billed => _$this._billed;
  set billed(num? billed) => _$this._billed = billed;

  num? _collected;
  num? get collected => _$this._collected;
  set collected(num? collected) => _$this._collected = collected;

  AdminMonthlyReport200ResponseFinanceBuilder() {
    AdminMonthlyReport200ResponseFinance._defaults(this);
  }

  AdminMonthlyReport200ResponseFinanceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _billed = $v.billed;
      _collected = $v.collected;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminMonthlyReport200ResponseFinance other) {
    _$v = other as _$AdminMonthlyReport200ResponseFinance;
  }

  @override
  void update(
    void Function(AdminMonthlyReport200ResponseFinanceBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  AdminMonthlyReport200ResponseFinance build() => _build();

  _$AdminMonthlyReport200ResponseFinance _build() {
    final _$result =
        _$v ??
        _$AdminMonthlyReport200ResponseFinance._(
          billed: BuiltValueNullFieldError.checkNotNull(
            billed,
            r'AdminMonthlyReport200ResponseFinance',
            'billed',
          ),
          collected: BuiltValueNullFieldError.checkNotNull(
            collected,
            r'AdminMonthlyReport200ResponseFinance',
            'collected',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
