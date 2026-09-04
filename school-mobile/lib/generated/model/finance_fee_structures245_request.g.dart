// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_fee_structures245_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinanceFeeStructures245RequestBillingCycleEnum
_$financeFeeStructures245RequestBillingCycleEnum_monthly =
    const FinanceFeeStructures245RequestBillingCycleEnum._('monthly');
const FinanceFeeStructures245RequestBillingCycleEnum
_$financeFeeStructures245RequestBillingCycleEnum_semester =
    const FinanceFeeStructures245RequestBillingCycleEnum._('semester');
const FinanceFeeStructures245RequestBillingCycleEnum
_$financeFeeStructures245RequestBillingCycleEnum_yearly =
    const FinanceFeeStructures245RequestBillingCycleEnum._('yearly');
const FinanceFeeStructures245RequestBillingCycleEnum
_$financeFeeStructures245RequestBillingCycleEnum_oneTime =
    const FinanceFeeStructures245RequestBillingCycleEnum._('oneTime');

FinanceFeeStructures245RequestBillingCycleEnum
_$financeFeeStructures245RequestBillingCycleEnumValueOf(String name) {
  switch (name) {
    case 'monthly':
      return _$financeFeeStructures245RequestBillingCycleEnum_monthly;
    case 'semester':
      return _$financeFeeStructures245RequestBillingCycleEnum_semester;
    case 'yearly':
      return _$financeFeeStructures245RequestBillingCycleEnum_yearly;
    case 'oneTime':
      return _$financeFeeStructures245RequestBillingCycleEnum_oneTime;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinanceFeeStructures245RequestBillingCycleEnum>
_$financeFeeStructures245RequestBillingCycleEnumValues =
    BuiltSet<FinanceFeeStructures245RequestBillingCycleEnum>(
      const <FinanceFeeStructures245RequestBillingCycleEnum>[
        _$financeFeeStructures245RequestBillingCycleEnum_monthly,
        _$financeFeeStructures245RequestBillingCycleEnum_semester,
        _$financeFeeStructures245RequestBillingCycleEnum_yearly,
        _$financeFeeStructures245RequestBillingCycleEnum_oneTime,
      ],
    );

Serializer<FinanceFeeStructures245RequestBillingCycleEnum>
_$financeFeeStructures245RequestBillingCycleEnumSerializer =
    _$FinanceFeeStructures245RequestBillingCycleEnumSerializer();

class _$FinanceFeeStructures245RequestBillingCycleEnumSerializer
    implements
        PrimitiveSerializer<FinanceFeeStructures245RequestBillingCycleEnum> {
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
    FinanceFeeStructures245RequestBillingCycleEnum,
  ];
  @override
  final String wireName = 'FinanceFeeStructures245RequestBillingCycleEnum';

  @override
  Object serialize(
    Serializers serializers,
    FinanceFeeStructures245RequestBillingCycleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FinanceFeeStructures245RequestBillingCycleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FinanceFeeStructures245RequestBillingCycleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FinanceFeeStructures245Request extends FinanceFeeStructures245Request {
  @override
  final String name;
  @override
  final String? grade;
  @override
  final FinanceFeeStructures245RequestBillingCycleEnum billingCycle;
  @override
  final num amount;
  @override
  final bool? isActive;

  factory _$FinanceFeeStructures245Request([
    void Function(FinanceFeeStructures245RequestBuilder)? updates,
  ]) => (FinanceFeeStructures245RequestBuilder()..update(updates))._build();

  _$FinanceFeeStructures245Request._({
    required this.name,
    this.grade,
    required this.billingCycle,
    required this.amount,
    this.isActive,
  }) : super._();
  @override
  FinanceFeeStructures245Request rebuild(
    void Function(FinanceFeeStructures245RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceFeeStructures245RequestBuilder toBuilder() =>
      FinanceFeeStructures245RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceFeeStructures245Request &&
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
    return (newBuiltValueToStringHelper(r'FinanceFeeStructures245Request')
          ..add('name', name)
          ..add('grade', grade)
          ..add('billingCycle', billingCycle)
          ..add('amount', amount)
          ..add('isActive', isActive))
        .toString();
  }
}

class FinanceFeeStructures245RequestBuilder
    implements
        Builder<
          FinanceFeeStructures245Request,
          FinanceFeeStructures245RequestBuilder
        > {
  _$FinanceFeeStructures245Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  FinanceFeeStructures245RequestBillingCycleEnum? _billingCycle;
  FinanceFeeStructures245RequestBillingCycleEnum? get billingCycle =>
      _$this._billingCycle;
  set billingCycle(
    FinanceFeeStructures245RequestBillingCycleEnum? billingCycle,
  ) => _$this._billingCycle = billingCycle;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  FinanceFeeStructures245RequestBuilder() {
    FinanceFeeStructures245Request._defaults(this);
  }

  FinanceFeeStructures245RequestBuilder get _$this {
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
  void replace(FinanceFeeStructures245Request other) {
    _$v = other as _$FinanceFeeStructures245Request;
  }

  @override
  void update(void Function(FinanceFeeStructures245RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceFeeStructures245Request build() => _build();

  _$FinanceFeeStructures245Request _build() {
    final _$result =
        _$v ??
        _$FinanceFeeStructures245Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'FinanceFeeStructures245Request',
            'name',
          ),
          grade: grade,
          billingCycle: BuiltValueNullFieldError.checkNotNull(
            billingCycle,
            r'FinanceFeeStructures245Request',
            'billingCycle',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'FinanceFeeStructures245Request',
            'amount',
          ),
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
