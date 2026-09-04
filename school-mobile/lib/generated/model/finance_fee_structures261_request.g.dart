// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_fee_structures261_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinanceFeeStructures261RequestBillingCycleEnum
_$financeFeeStructures261RequestBillingCycleEnum_monthly =
    const FinanceFeeStructures261RequestBillingCycleEnum._('monthly');
const FinanceFeeStructures261RequestBillingCycleEnum
_$financeFeeStructures261RequestBillingCycleEnum_semester =
    const FinanceFeeStructures261RequestBillingCycleEnum._('semester');
const FinanceFeeStructures261RequestBillingCycleEnum
_$financeFeeStructures261RequestBillingCycleEnum_yearly =
    const FinanceFeeStructures261RequestBillingCycleEnum._('yearly');
const FinanceFeeStructures261RequestBillingCycleEnum
_$financeFeeStructures261RequestBillingCycleEnum_oneTime =
    const FinanceFeeStructures261RequestBillingCycleEnum._('oneTime');

FinanceFeeStructures261RequestBillingCycleEnum
_$financeFeeStructures261RequestBillingCycleEnumValueOf(String name) {
  switch (name) {
    case 'monthly':
      return _$financeFeeStructures261RequestBillingCycleEnum_monthly;
    case 'semester':
      return _$financeFeeStructures261RequestBillingCycleEnum_semester;
    case 'yearly':
      return _$financeFeeStructures261RequestBillingCycleEnum_yearly;
    case 'oneTime':
      return _$financeFeeStructures261RequestBillingCycleEnum_oneTime;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinanceFeeStructures261RequestBillingCycleEnum>
_$financeFeeStructures261RequestBillingCycleEnumValues =
    BuiltSet<FinanceFeeStructures261RequestBillingCycleEnum>(
      const <FinanceFeeStructures261RequestBillingCycleEnum>[
        _$financeFeeStructures261RequestBillingCycleEnum_monthly,
        _$financeFeeStructures261RequestBillingCycleEnum_semester,
        _$financeFeeStructures261RequestBillingCycleEnum_yearly,
        _$financeFeeStructures261RequestBillingCycleEnum_oneTime,
      ],
    );

Serializer<FinanceFeeStructures261RequestBillingCycleEnum>
_$financeFeeStructures261RequestBillingCycleEnumSerializer =
    _$FinanceFeeStructures261RequestBillingCycleEnumSerializer();

class _$FinanceFeeStructures261RequestBillingCycleEnumSerializer
    implements
        PrimitiveSerializer<FinanceFeeStructures261RequestBillingCycleEnum> {
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
    FinanceFeeStructures261RequestBillingCycleEnum,
  ];
  @override
  final String wireName = 'FinanceFeeStructures261RequestBillingCycleEnum';

  @override
  Object serialize(
    Serializers serializers,
    FinanceFeeStructures261RequestBillingCycleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FinanceFeeStructures261RequestBillingCycleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FinanceFeeStructures261RequestBillingCycleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FinanceFeeStructures261Request extends FinanceFeeStructures261Request {
  @override
  final String name;
  @override
  final String? grade;
  @override
  final FinanceFeeStructures261RequestBillingCycleEnum billingCycle;
  @override
  final num amount;
  @override
  final bool? isActive;

  factory _$FinanceFeeStructures261Request([
    void Function(FinanceFeeStructures261RequestBuilder)? updates,
  ]) => (FinanceFeeStructures261RequestBuilder()..update(updates))._build();

  _$FinanceFeeStructures261Request._({
    required this.name,
    this.grade,
    required this.billingCycle,
    required this.amount,
    this.isActive,
  }) : super._();
  @override
  FinanceFeeStructures261Request rebuild(
    void Function(FinanceFeeStructures261RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceFeeStructures261RequestBuilder toBuilder() =>
      FinanceFeeStructures261RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceFeeStructures261Request &&
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
    return (newBuiltValueToStringHelper(r'FinanceFeeStructures261Request')
          ..add('name', name)
          ..add('grade', grade)
          ..add('billingCycle', billingCycle)
          ..add('amount', amount)
          ..add('isActive', isActive))
        .toString();
  }
}

class FinanceFeeStructures261RequestBuilder
    implements
        Builder<
          FinanceFeeStructures261Request,
          FinanceFeeStructures261RequestBuilder
        > {
  _$FinanceFeeStructures261Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  FinanceFeeStructures261RequestBillingCycleEnum? _billingCycle;
  FinanceFeeStructures261RequestBillingCycleEnum? get billingCycle =>
      _$this._billingCycle;
  set billingCycle(
    FinanceFeeStructures261RequestBillingCycleEnum? billingCycle,
  ) => _$this._billingCycle = billingCycle;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  FinanceFeeStructures261RequestBuilder() {
    FinanceFeeStructures261Request._defaults(this);
  }

  FinanceFeeStructures261RequestBuilder get _$this {
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
  void replace(FinanceFeeStructures261Request other) {
    _$v = other as _$FinanceFeeStructures261Request;
  }

  @override
  void update(void Function(FinanceFeeStructures261RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceFeeStructures261Request build() => _build();

  _$FinanceFeeStructures261Request _build() {
    final _$result =
        _$v ??
        _$FinanceFeeStructures261Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'FinanceFeeStructures261Request',
            'name',
          ),
          grade: grade,
          billingCycle: BuiltValueNullFieldError.checkNotNull(
            billingCycle,
            r'FinanceFeeStructures261Request',
            'billingCycle',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'FinanceFeeStructures261Request',
            'amount',
          ),
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
