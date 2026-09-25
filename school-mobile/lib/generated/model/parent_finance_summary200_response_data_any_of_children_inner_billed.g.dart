// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_summary200_response_data_any_of_children_inner_billed.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum
_$parentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum_number2 =
    const ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum._(
      'number2',
    );

ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum
_$parentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnumValueOf(
  String name,
) {
  switch (name) {
    case 'number2':
      return _$parentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum_number2;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum
>
_$parentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnumValues =
    BuiltSet<
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum
    >(const <
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum
    >[
      _$parentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum_number2,
    ]);

Serializer<
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum
>
_$parentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnumSerializer =
    _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnumSerializer();

class _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnumSerializer
    implements
        PrimitiveSerializer<
          ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number2': 2,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    2: 'number2',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum,
  ];
  @override
  final String wireName =
      'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum';

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum
    object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum
  deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) =>
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum.valueOf(
        _fromWire[serialized] ?? (serialized is String ? serialized : ''),
      );
}

class _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled
    extends ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled {
  @override
  final String minor;
  @override
  final String currency;
  @override
  final ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum
  decimals;

  factory _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled([
    void Function(
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder,
    )?
    updates,
  ]) =>
      (ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder()
            ..update(updates))
          ._build();

  _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled._({
    required this.minor,
    required this.currency,
    required this.decimals,
  }) : super._();
  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled rebuild(
    void Function(
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder
  toBuilder() =>
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled &&
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
            r'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled',
          )
          ..add('minor', minor)
          ..add('currency', currency)
          ..add('decimals', decimals))
        .toString();
  }
}

class ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder
    implements
        Builder<
          ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled,
          ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder
        > {
  _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled? _$v;

  String? _minor;
  String? get minor => _$this._minor;
  set minor(String? minor) => _$this._minor = minor;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum?
  _decimals;
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum?
  get decimals => _$this._decimals;
  set decimals(
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledDecimalsEnum?
    decimals,
  ) => _$this._decimals = decimals;

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder() {
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled._defaults(this);
  }

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder
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
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled other,
  ) {
    _$v =
        other as _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled;
  }

  @override
  void update(
    void Function(
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilledBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled build() =>
      _build();

  _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled _build() {
    final _$result =
        _$v ??
        _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled._(
          minor: BuiltValueNullFieldError.checkNotNull(
            minor,
            r'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled',
            'minor',
          ),
          currency: BuiltValueNullFieldError.checkNotNull(
            currency,
            r'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled',
            'currency',
          ),
          decimals: BuiltValueNullFieldError.checkNotNull(
            decimals,
            r'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled',
            'decimals',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
