// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_finance_summary200_response_data_any_of_children_inner_outstanding.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum
_$parentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum_number2 =
    const ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum._(
      'number2',
    );

ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum
_$parentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnumValueOf(
  String name,
) {
  switch (name) {
    case 'number2':
      return _$parentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum_number2;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum
>
_$parentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnumValues =
    BuiltSet<
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum
    >(const <
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum
    >[
      _$parentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum_number2,
    ]);

Serializer<
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum
>
_$parentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnumSerializer =
    _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnumSerializer();

class _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnumSerializer
    implements
        PrimitiveSerializer<
          ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum
        > {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number2': 2,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    2: 'number2',
  };

  @override
  final Iterable<Type> types = const <Type>[
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum,
  ];
  @override
  final String wireName =
      'ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum';

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum
    object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum
  deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) =>
      ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum.valueOf(
        _fromWire[serialized] ?? (serialized is String ? serialized : ''),
      );
}

class _$ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding
    extends ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding {
  @override
  final JsonObject? minor;
  @override
  final String currency;
  @override
  final ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum
  decimals;

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

  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum?
  _decimals;
  ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum?
  get decimals => _$this._decimals;
  set decimals(
    ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstandingDecimalsEnum?
    decimals,
  ) => _$this._decimals = decimals;

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
