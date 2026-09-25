// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_summary200_response_data_any_of_children_inner_paid.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum
_$parentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum_number2 =
    const ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum._(
      'number2',
    );

ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum
_$parentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnumValueOf(
  String name,
) {
  switch (name) {
    case 'number2':
      return _$parentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum_number2;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum
>
_$parentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnumValues =
    BuiltSet<
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum
    >(const <
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum
    >[
      _$parentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum_number2,
    ]);

Serializer<
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum
>
_$parentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnumSerializer =
    _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnumSerializer();

class _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnumSerializer
    implements
        PrimitiveSerializer<
          ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number2': 2,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    2: 'number2',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum,
  ];
  @override
  final String wireName =
      'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum';

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum
    object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum
  deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) =>
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum.valueOf(
        _fromWire[serialized] ?? (serialized is String ? serialized : ''),
      );
}

class _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid
    extends ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid {
  @override
  final String minor;
  @override
  final String currency;
  @override
  final ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum
  decimals;

  factory _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid([
    void Function(
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder,
    )?
    updates,
  ]) =>
      (ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder()
            ..update(updates))
          ._build();

  _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid._({
    required this.minor,
    required this.currency,
    required this.decimals,
  }) : super._();
  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid rebuild(
    void Function(
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder
  toBuilder() =>
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid &&
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
            r'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid',
          )
          ..add('minor', minor)
          ..add('currency', currency)
          ..add('decimals', decimals))
        .toString();
  }
}

class ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder
    implements
        Builder<
          ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid,
          ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder
        > {
  _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid? _$v;

  String? _minor;
  String? get minor => _$this._minor;
  set minor(String? minor) => _$this._minor = minor;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum?
  _decimals;
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum?
  get decimals => _$this._decimals;
  set decimals(
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidDecimalsEnum?
    decimals,
  ) => _$this._decimals = decimals;

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder() {
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid._defaults(this);
  }

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder get _$this {
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
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid other,
  ) {
    _$v = other as _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid;
  }

  @override
  void update(
    void Function(
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaidBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid build() => _build();

  _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid _build() {
    final _$result =
        _$v ??
        _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid._(
          minor: BuiltValueNullFieldError.checkNotNull(
            minor,
            r'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid',
            'minor',
          ),
          currency: BuiltValueNullFieldError.checkNotNull(
            currency,
            r'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid',
            'currency',
          ),
          decimals: BuiltValueNullFieldError.checkNotNull(
            decimals,
            r'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid',
            'decimals',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
