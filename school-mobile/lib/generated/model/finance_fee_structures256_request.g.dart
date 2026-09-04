// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_fee_structures256_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinanceFeeStructures256RequestBillingCycleEnum
_$financeFeeStructures256RequestBillingCycleEnum_monthly =
    const FinanceFeeStructures256RequestBillingCycleEnum._('monthly');
const FinanceFeeStructures256RequestBillingCycleEnum
_$financeFeeStructures256RequestBillingCycleEnum_semester =
    const FinanceFeeStructures256RequestBillingCycleEnum._('semester');
const FinanceFeeStructures256RequestBillingCycleEnum
_$financeFeeStructures256RequestBillingCycleEnum_yearly =
    const FinanceFeeStructures256RequestBillingCycleEnum._('yearly');
const FinanceFeeStructures256RequestBillingCycleEnum
_$financeFeeStructures256RequestBillingCycleEnum_oneTime =
    const FinanceFeeStructures256RequestBillingCycleEnum._('oneTime');

FinanceFeeStructures256RequestBillingCycleEnum
_$financeFeeStructures256RequestBillingCycleEnumValueOf(String name) {
  switch (name) {
    case 'monthly':
      return _$financeFeeStructures256RequestBillingCycleEnum_monthly;
    case 'semester':
      return _$financeFeeStructures256RequestBillingCycleEnum_semester;
    case 'yearly':
      return _$financeFeeStructures256RequestBillingCycleEnum_yearly;
    case 'oneTime':
      return _$financeFeeStructures256RequestBillingCycleEnum_oneTime;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinanceFeeStructures256RequestBillingCycleEnum>
_$financeFeeStructures256RequestBillingCycleEnumValues =
    BuiltSet<FinanceFeeStructures256RequestBillingCycleEnum>(
      const <FinanceFeeStructures256RequestBillingCycleEnum>[
        _$financeFeeStructures256RequestBillingCycleEnum_monthly,
        _$financeFeeStructures256RequestBillingCycleEnum_semester,
        _$financeFeeStructures256RequestBillingCycleEnum_yearly,
        _$financeFeeStructures256RequestBillingCycleEnum_oneTime,
      ],
    );

Serializer<FinanceFeeStructures256RequestBillingCycleEnum>
_$financeFeeStructures256RequestBillingCycleEnumSerializer =
    _$FinanceFeeStructures256RequestBillingCycleEnumSerializer();

class _$FinanceFeeStructures256RequestBillingCycleEnumSerializer
    implements
        PrimitiveSerializer<FinanceFeeStructures256RequestBillingCycleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'monthly': 'monthly',
    'semester': 'semester',
    'yearly': 'yearly',
    'oneTime': 'one-time',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'monthly': 'monthly',
    'semester': 'semester',
    'yearly': 'yearly',
    'one-time': 'oneTime',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FinanceFeeStructures256RequestBillingCycleEnum,
  ];
  @override
  final String wireName = 'FinanceFeeStructures256RequestBillingCycleEnum';

  @override
  Object serialize(
    Serializers serializers,
    FinanceFeeStructures256RequestBillingCycleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FinanceFeeStructures256RequestBillingCycleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FinanceFeeStructures256RequestBillingCycleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FinanceFeeStructures256Request extends FinanceFeeStructures256Request {
  @override
  final String name;
  @override
  final String? grade;
  @override
  final FinanceFeeStructures256RequestBillingCycleEnum billingCycle;
  @override
  final num amount;
  @override
  final bool? isActive;

  factory _$FinanceFeeStructures256Request([
    void Function(FinanceFeeStructures256RequestBuilder)? updates,
  ]) => (FinanceFeeStructures256RequestBuilder()..update(updates))._build();

  _$FinanceFeeStructures256Request._({
    required this.name,
    this.grade,
    required this.billingCycle,
    required this.amount,
    this.isActive,
  }) : super._();
  @override
  FinanceFeeStructures256Request rebuild(
    void Function(FinanceFeeStructures256RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceFeeStructures256RequestBuilder toBuilder() =>
      FinanceFeeStructures256RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceFeeStructures256Request &&
        name == other.name &&
        grade == other.grade &&
        billingCycle == other.billingCycle &&
        amount == other.amount &&
        isActive == other.isActive;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, grade.hashCode);
    _$hash = $jc(_$hash, billingCycle.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinanceFeeStructures256Request')
          ..add('name', name)
          ..add('grade', grade)
          ..add('billingCycle', billingCycle)
          ..add('amount', amount)
          ..add('isActive', isActive))
        .toString();
  }
}

class FinanceFeeStructures256RequestBuilder
    implements
        Builder<
          FinanceFeeStructures256Request,
          FinanceFeeStructures256RequestBuilder
        > {
  _$FinanceFeeStructures256Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  FinanceFeeStructures256RequestBillingCycleEnum? _billingCycle;
  FinanceFeeStructures256RequestBillingCycleEnum? get billingCycle =>
      _$this._billingCycle;
  set billingCycle(
    FinanceFeeStructures256RequestBillingCycleEnum? billingCycle,
  ) => _$this._billingCycle = billingCycle;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  FinanceFeeStructures256RequestBuilder() {
    FinanceFeeStructures256Request._defaults(this);
  }

  FinanceFeeStructures256RequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _grade = $v.grade;
      _billingCycle = $v.billingCycle;
      _amount = $v.amount;
      _isActive = $v.isActive;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinanceFeeStructures256Request other) {
    _$v = other as _$FinanceFeeStructures256Request;
  }

  @override
  void update(void Function(FinanceFeeStructures256RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceFeeStructures256Request build() => _build();

  _$FinanceFeeStructures256Request _build() {
    final _$result =
        _$v ??
        _$FinanceFeeStructures256Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'FinanceFeeStructures256Request',
            'name',
          ),
          grade: grade,
          billingCycle: BuiltValueNullFieldError.checkNotNull(
            billingCycle,
            r'FinanceFeeStructures256Request',
            'billingCycle',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'FinanceFeeStructures256Request',
            'amount',
          ),
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
