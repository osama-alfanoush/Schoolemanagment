// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_summary200_response_data_any_of_children_inner_outstanding.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding
    extends ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding {
  @override
  final JsonObject? minor;
  @override
  final String currency;
  @override
  final int decimals;

  factory _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding([
    void Function(
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder,
    )?
    updates,
  ]) =>
      (ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder()
            ..update(updates))
          ._build();

  _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding._({
    this.minor,
    required this.currency,
    required this.decimals,
  }) : super._();
  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding rebuild(
    void Function(
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder
  toBuilder() =>
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding &&
        minor == other.minor &&
        currency == other.currency &&
        decimals == other.decimals;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, minor.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, decimals.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding',
          )
          ..add('minor', minor)
          ..add('currency', currency)
          ..add('decimals', decimals))
        .toString();
  }
}

class ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder
    implements
        Builder<
          ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding,
          ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder
        > {
  _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding? _$v;

  JsonObject? _minor;
  JsonObject? get minor => _$this._minor;
  set minor(JsonObject? minor) => _$this._minor = minor;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  int? _decimals;
  int? get decimals => _$this._decimals;
  set decimals(int? decimals) => _$this._decimals = decimals;

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder() {
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding._defaults(
      this,
    );
  }

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder
  get _$this {
    final $v = _$v;
    if ($v != null) {
      _minor = $v.minor;
      _currency = $v.currency;
      _decimals = $v.decimals;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding other,
  ) {
    _$v =
        other
            as _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding;
  }

  @override
  void update(
    void Function(
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding build() =>
      _build();

  _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding _build() {
    final _$result =
        _$v ??
        _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding._(
          minor: minor,
          currency: BuiltValueNullFieldError.checkNotNull(
            currency,
            r'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding',
            'currency',
          ),
          decimals: BuiltValueNullFieldError.checkNotNull(
            decimals,
            r'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding',
            'decimals',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
