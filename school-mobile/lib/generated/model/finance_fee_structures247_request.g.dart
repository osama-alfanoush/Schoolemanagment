// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_fee_structures247_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinanceFeeStructures247RequestBillingCycleEnum
_$financeFeeStructures247RequestBillingCycleEnum_monthly =
    const FinanceFeeStructures247RequestBillingCycleEnum._('monthly');
const FinanceFeeStructures247RequestBillingCycleEnum
_$financeFeeStructures247RequestBillingCycleEnum_semester =
    const FinanceFeeStructures247RequestBillingCycleEnum._('semester');
const FinanceFeeStructures247RequestBillingCycleEnum
_$financeFeeStructures247RequestBillingCycleEnum_yearly =
    const FinanceFeeStructures247RequestBillingCycleEnum._('yearly');
const FinanceFeeStructures247RequestBillingCycleEnum
_$financeFeeStructures247RequestBillingCycleEnum_oneTime =
    const FinanceFeeStructures247RequestBillingCycleEnum._('oneTime');

FinanceFeeStructures247RequestBillingCycleEnum
_$financeFeeStructures247RequestBillingCycleEnumValueOf(String name) {
  switch (name) {
    case 'monthly':
      return _$financeFeeStructures247RequestBillingCycleEnum_monthly;
    case 'semester':
      return _$financeFeeStructures247RequestBillingCycleEnum_semester;
    case 'yearly':
      return _$financeFeeStructures247RequestBillingCycleEnum_yearly;
    case 'oneTime':
      return _$financeFeeStructures247RequestBillingCycleEnum_oneTime;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinanceFeeStructures247RequestBillingCycleEnum>
_$financeFeeStructures247RequestBillingCycleEnumValues =
    BuiltSet<FinanceFeeStructures247RequestBillingCycleEnum>(
      const <FinanceFeeStructures247RequestBillingCycleEnum>[
        _$financeFeeStructures247RequestBillingCycleEnum_monthly,
        _$financeFeeStructures247RequestBillingCycleEnum_semester,
        _$financeFeeStructures247RequestBillingCycleEnum_yearly,
        _$financeFeeStructures247RequestBillingCycleEnum_oneTime,
      ],
    );

Serializer<FinanceFeeStructures247RequestBillingCycleEnum>
_$financeFeeStructures247RequestBillingCycleEnumSerializer =
    _$FinanceFeeStructures247RequestBillingCycleEnumSerializer();

class _$FinanceFeeStructures247RequestBillingCycleEnumSerializer
    implements
        PrimitiveSerializer<FinanceFeeStructures247RequestBillingCycleEnum> {
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
    FinanceFeeStructures247RequestBillingCycleEnum,
  ];
  @override
  final String wireName = 'FinanceFeeStructures247RequestBillingCycleEnum';

  @override
  Object serialize(
    Serializers serializers,
    FinanceFeeStructures247RequestBillingCycleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FinanceFeeStructures247RequestBillingCycleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FinanceFeeStructures247RequestBillingCycleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FinanceFeeStructures247Request extends FinanceFeeStructures247Request {
  @override
  final String name;
  @override
  final String? grade;
  @override
  final FinanceFeeStructures247RequestBillingCycleEnum billingCycle;
  @override
  final num amount;
  @override
  final bool? isActive;

  factory _$FinanceFeeStructures247Request([
    void Function(FinanceFeeStructures247RequestBuilder)? updates,
  ]) => (FinanceFeeStructures247RequestBuilder()..update(updates))._build();

  _$FinanceFeeStructures247Request._({
    required this.name,
    this.grade,
    required this.billingCycle,
    required this.amount,
    this.isActive,
  }) : super._();
  @override
  FinanceFeeStructures247Request rebuild(
    void Function(FinanceFeeStructures247RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceFeeStructures247RequestBuilder toBuilder() =>
      FinanceFeeStructures247RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceFeeStructures247Request &&
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
    return (newBuiltValueToStringHelper(r'FinanceFeeStructures247Request')
          ..add('name', name)
          ..add('grade', grade)
          ..add('billingCycle', billingCycle)
          ..add('amount', amount)
          ..add('isActive', isActive))
        .toString();
  }
}

class FinanceFeeStructures247RequestBuilder
    implements
        Builder<
          FinanceFeeStructures247Request,
          FinanceFeeStructures247RequestBuilder
        > {
  _$FinanceFeeStructures247Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  FinanceFeeStructures247RequestBillingCycleEnum? _billingCycle;
  FinanceFeeStructures247RequestBillingCycleEnum? get billingCycle =>
      _$this._billingCycle;
  set billingCycle(
    FinanceFeeStructures247RequestBillingCycleEnum? billingCycle,
  ) => _$this._billingCycle = billingCycle;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  FinanceFeeStructures247RequestBuilder() {
    FinanceFeeStructures247Request._defaults(this);
  }

  FinanceFeeStructures247RequestBuilder get _$this {
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
  void replace(FinanceFeeStructures247Request other) {
    _$v = other as _$FinanceFeeStructures247Request;
  }

  @override
  void update(void Function(FinanceFeeStructures247RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceFeeStructures247Request build() => _build();

  _$FinanceFeeStructures247Request _build() {
    final _$result =
        _$v ??
        _$FinanceFeeStructures247Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'FinanceFeeStructures247Request',
            'name',
          ),
          grade: grade,
          billingCycle: BuiltValueNullFieldError.checkNotNull(
            billingCycle,
            r'FinanceFeeStructures247Request',
            'billingCycle',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'FinanceFeeStructures247Request',
            'amount',
          ),
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
