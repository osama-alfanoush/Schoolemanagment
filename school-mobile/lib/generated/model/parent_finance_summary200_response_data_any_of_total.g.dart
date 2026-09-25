// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_summary200_response_data_any_of_total.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum
_$parentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum_number2 =
    const ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum._(
      'number2',
    );

ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum
_$parentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnumValueOf(
  String name,
) {
  switch (name) {
    case 'number2':
      return _$parentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum_number2;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum>
_$parentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnumValues =
    BuiltSet<ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum>(
      const <ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum>[
        _$parentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum_number2,
      ],
    );

Serializer<ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum>
_$parentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnumSerializer =
    _$ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnumSerializer();

class _$ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnumSerializer
    implements
        PrimitiveSerializer<
          ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number2': 2,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    2: 'number2',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum,
  ];
  @override
  final String wireName =
      'ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum';

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$ParentFinanceSummary200ResponseDataAnyOfTotal
    extends ParentFinanceSummary200ResponseDataAnyOfTotal {
  @override
  final int minor;
  @override
  final String currency;
  @override
  final ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum decimals;

  factory _$ParentFinanceSummary200ResponseDataAnyOfTotal([
    void Function(ParentFinanceSummary200ResponseDataAnyOfTotalBuilder)?
    updates,
  ]) =>
      (ParentFinanceSummary200ResponseDataAnyOfTotalBuilder()..update(updates))
          ._build();

  _$ParentFinanceSummary200ResponseDataAnyOfTotal._({
    required this.minor,
    required this.currency,
    required this.decimals,
  }) : super._();
  @override
  ParentFinanceSummary200ResponseDataAnyOfTotal rebuild(
    void Function(ParentFinanceSummary200ResponseDataAnyOfTotalBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentFinanceSummary200ResponseDataAnyOfTotalBuilder toBuilder() =>
      ParentFinanceSummary200ResponseDataAnyOfTotalBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentFinanceSummary200ResponseDataAnyOfTotal &&
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
            r'ParentFinanceSummary200ResponseDataAnyOfTotal',
          )
          ..add('minor', minor)
          ..add('currency', currency)
          ..add('decimals', decimals))
        .toString();
  }
}

class ParentFinanceSummary200ResponseDataAnyOfTotalBuilder
    implements
        Builder<
          ParentFinanceSummary200ResponseDataAnyOfTotal,
          ParentFinanceSummary200ResponseDataAnyOfTotalBuilder
        > {
  _$ParentFinanceSummary200ResponseDataAnyOfTotal? _$v;

  int? _minor;
  int? get minor => _$this._minor;
  set minor(int? minor) => _$this._minor = minor;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum? _decimals;
  ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum? get decimals =>
      _$this._decimals;
  set decimals(
    ParentFinanceSummary200ResponseDataAnyOfTotalDecimalsEnum? decimals,
  ) => _$this._decimals = decimals;

  ParentFinanceSummary200ResponseDataAnyOfTotalBuilder() {
    ParentFinanceSummary200ResponseDataAnyOfTotal._defaults(this);
  }

  ParentFinanceSummary200ResponseDataAnyOfTotalBuilder get _$this {
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
  void replace(ParentFinanceSummary200ResponseDataAnyOfTotal other) {
    _$v = other as _$ParentFinanceSummary200ResponseDataAnyOfTotal;
  }

  @override
  void update(
    void Function(ParentFinanceSummary200ResponseDataAnyOfTotalBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentFinanceSummary200ResponseDataAnyOfTotal build() => _build();

  _$ParentFinanceSummary200ResponseDataAnyOfTotal _build() {
    final _$result =
        _$v ??
        _$ParentFinanceSummary200ResponseDataAnyOfTotal._(
          minor: BuiltValueNullFieldError.checkNotNull(
            minor,
            r'ParentFinanceSummary200ResponseDataAnyOfTotal',
            'minor',
          ),
          currency: BuiltValueNullFieldError.checkNotNull(
            currency,
            r'ParentFinanceSummary200ResponseDataAnyOfTotal',
            'currency',
          ),
          decimals: BuiltValueNullFieldError.checkNotNull(
            decimals,
            r'ParentFinanceSummary200ResponseDataAnyOfTotal',
            'decimals',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
