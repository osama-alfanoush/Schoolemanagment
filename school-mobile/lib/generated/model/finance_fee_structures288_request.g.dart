// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_fee_structures288_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinanceFeeStructures288RequestBillingCycleEnum
_$financeFeeStructures288RequestBillingCycleEnum_monthly =
    const FinanceFeeStructures288RequestBillingCycleEnum._('monthly');
const FinanceFeeStructures288RequestBillingCycleEnum
_$financeFeeStructures288RequestBillingCycleEnum_semester =
    const FinanceFeeStructures288RequestBillingCycleEnum._('semester');
const FinanceFeeStructures288RequestBillingCycleEnum
_$financeFeeStructures288RequestBillingCycleEnum_yearly =
    const FinanceFeeStructures288RequestBillingCycleEnum._('yearly');
const FinanceFeeStructures288RequestBillingCycleEnum
_$financeFeeStructures288RequestBillingCycleEnum_oneTime =
    const FinanceFeeStructures288RequestBillingCycleEnum._('oneTime');

FinanceFeeStructures288RequestBillingCycleEnum
_$financeFeeStructures288RequestBillingCycleEnumValueOf(String name) {
  switch (name) {
    case 'monthly':
      return _$financeFeeStructures288RequestBillingCycleEnum_monthly;
    case 'semester':
      return _$financeFeeStructures288RequestBillingCycleEnum_semester;
    case 'yearly':
      return _$financeFeeStructures288RequestBillingCycleEnum_yearly;
    case 'oneTime':
      return _$financeFeeStructures288RequestBillingCycleEnum_oneTime;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinanceFeeStructures288RequestBillingCycleEnum>
_$financeFeeStructures288RequestBillingCycleEnumValues =
    BuiltSet<FinanceFeeStructures288RequestBillingCycleEnum>(
      const <FinanceFeeStructures288RequestBillingCycleEnum>[
        _$financeFeeStructures288RequestBillingCycleEnum_monthly,
        _$financeFeeStructures288RequestBillingCycleEnum_semester,
        _$financeFeeStructures288RequestBillingCycleEnum_yearly,
        _$financeFeeStructures288RequestBillingCycleEnum_oneTime,
      ],
    );

Serializer<FinanceFeeStructures288RequestBillingCycleEnum>
_$financeFeeStructures288RequestBillingCycleEnumSerializer =
    _$FinanceFeeStructures288RequestBillingCycleEnumSerializer();

class _$FinanceFeeStructures288RequestBillingCycleEnumSerializer
    implements
        PrimitiveSerializer<FinanceFeeStructures288RequestBillingCycleEnum> {
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
    FinanceFeeStructures288RequestBillingCycleEnum,
  ];
  @override
  final String wireName = 'FinanceFeeStructures288RequestBillingCycleEnum';

  @override
  Object serialize(
    Serializers serializers,
    FinanceFeeStructures288RequestBillingCycleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FinanceFeeStructures288RequestBillingCycleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FinanceFeeStructures288RequestBillingCycleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FinanceFeeStructures288Request extends FinanceFeeStructures288Request {
  @override
  final String name;
  @override
  final String? grade;
  @override
  final FinanceFeeStructures288RequestBillingCycleEnum billingCycle;
  @override
  final num amount;
  @override
  final bool? isActive;

  factory _$FinanceFeeStructures288Request([
    void Function(FinanceFeeStructures288RequestBuilder)? updates,
  ]) => (FinanceFeeStructures288RequestBuilder()..update(updates))._build();

  _$FinanceFeeStructures288Request._({
    required this.name,
    this.grade,
    required this.billingCycle,
    required this.amount,
    this.isActive,
  }) : super._();
  @override
  FinanceFeeStructures288Request rebuild(
    void Function(FinanceFeeStructures288RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceFeeStructures288RequestBuilder toBuilder() =>
      FinanceFeeStructures288RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceFeeStructures288Request &&
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
    return (newBuiltValueToStringHelper(r'FinanceFeeStructures288Request')
          ..add('name', name)
          ..add('grade', grade)
          ..add('billingCycle', billingCycle)
          ..add('amount', amount)
          ..add('isActive', isActive))
        .toString();
  }
}

class FinanceFeeStructures288RequestBuilder
    implements
        Builder<
          FinanceFeeStructures288Request,
          FinanceFeeStructures288RequestBuilder
        > {
  _$FinanceFeeStructures288Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  FinanceFeeStructures288RequestBillingCycleEnum? _billingCycle;
  FinanceFeeStructures288RequestBillingCycleEnum? get billingCycle =>
      _$this._billingCycle;
  set billingCycle(
    FinanceFeeStructures288RequestBillingCycleEnum? billingCycle,
  ) => _$this._billingCycle = billingCycle;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  FinanceFeeStructures288RequestBuilder() {
    FinanceFeeStructures288Request._defaults(this);
  }

  FinanceFeeStructures288RequestBuilder get _$this {
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
  void replace(FinanceFeeStructures288Request other) {
    _$v = other as _$FinanceFeeStructures288Request;
  }

  @override
  void update(void Function(FinanceFeeStructures288RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceFeeStructures288Request build() => _build();

  _$FinanceFeeStructures288Request _build() {
    final _$result =
        _$v ??
        _$FinanceFeeStructures288Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'FinanceFeeStructures288Request',
            'name',
          ),
          grade: grade,
          billingCycle: BuiltValueNullFieldError.checkNotNull(
            billingCycle,
            r'FinanceFeeStructures288Request',
            'billingCycle',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'FinanceFeeStructures288Request',
            'amount',
          ),
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
