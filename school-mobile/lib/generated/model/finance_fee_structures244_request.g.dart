// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_fee_structures244_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinanceFeeStructures244RequestBillingCycleEnum
_$financeFeeStructures244RequestBillingCycleEnum_monthly =
    const FinanceFeeStructures244RequestBillingCycleEnum._('monthly');
const FinanceFeeStructures244RequestBillingCycleEnum
_$financeFeeStructures244RequestBillingCycleEnum_semester =
    const FinanceFeeStructures244RequestBillingCycleEnum._('semester');
const FinanceFeeStructures244RequestBillingCycleEnum
_$financeFeeStructures244RequestBillingCycleEnum_yearly =
    const FinanceFeeStructures244RequestBillingCycleEnum._('yearly');
const FinanceFeeStructures244RequestBillingCycleEnum
_$financeFeeStructures244RequestBillingCycleEnum_oneTime =
    const FinanceFeeStructures244RequestBillingCycleEnum._('oneTime');

FinanceFeeStructures244RequestBillingCycleEnum
_$financeFeeStructures244RequestBillingCycleEnumValueOf(String name) {
  switch (name) {
    case 'monthly':
      return _$financeFeeStructures244RequestBillingCycleEnum_monthly;
    case 'semester':
      return _$financeFeeStructures244RequestBillingCycleEnum_semester;
    case 'yearly':
      return _$financeFeeStructures244RequestBillingCycleEnum_yearly;
    case 'oneTime':
      return _$financeFeeStructures244RequestBillingCycleEnum_oneTime;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinanceFeeStructures244RequestBillingCycleEnum>
_$financeFeeStructures244RequestBillingCycleEnumValues =
    BuiltSet<FinanceFeeStructures244RequestBillingCycleEnum>(
      const <FinanceFeeStructures244RequestBillingCycleEnum>[
        _$financeFeeStructures244RequestBillingCycleEnum_monthly,
        _$financeFeeStructures244RequestBillingCycleEnum_semester,
        _$financeFeeStructures244RequestBillingCycleEnum_yearly,
        _$financeFeeStructures244RequestBillingCycleEnum_oneTime,
      ],
    );

Serializer<FinanceFeeStructures244RequestBillingCycleEnum>
_$financeFeeStructures244RequestBillingCycleEnumSerializer =
    _$FinanceFeeStructures244RequestBillingCycleEnumSerializer();

class _$FinanceFeeStructures244RequestBillingCycleEnumSerializer
    implements
        PrimitiveSerializer<FinanceFeeStructures244RequestBillingCycleEnum> {
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
    FinanceFeeStructures244RequestBillingCycleEnum,
  ];
  @override
  final String wireName = 'FinanceFeeStructures244RequestBillingCycleEnum';

  @override
  Object serialize(
    Serializers serializers,
    FinanceFeeStructures244RequestBillingCycleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FinanceFeeStructures244RequestBillingCycleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FinanceFeeStructures244RequestBillingCycleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FinanceFeeStructures244Request extends FinanceFeeStructures244Request {
  @override
  final String name;
  @override
  final String? grade;
  @override
  final FinanceFeeStructures244RequestBillingCycleEnum billingCycle;
  @override
  final num amount;
  @override
  final bool? isActive;

  factory _$FinanceFeeStructures244Request([
    void Function(FinanceFeeStructures244RequestBuilder)? updates,
  ]) => (FinanceFeeStructures244RequestBuilder()..update(updates))._build();

  _$FinanceFeeStructures244Request._({
    required this.name,
    this.grade,
    required this.billingCycle,
    required this.amount,
    this.isActive,
  }) : super._();
  @override
  FinanceFeeStructures244Request rebuild(
    void Function(FinanceFeeStructures244RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceFeeStructures244RequestBuilder toBuilder() =>
      FinanceFeeStructures244RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceFeeStructures244Request &&
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
    return (newBuiltValueToStringHelper(r'FinanceFeeStructures244Request')
          ..add('name', name)
          ..add('grade', grade)
          ..add('billingCycle', billingCycle)
          ..add('amount', amount)
          ..add('isActive', isActive))
        .toString();
  }
}

class FinanceFeeStructures244RequestBuilder
    implements
        Builder<
          FinanceFeeStructures244Request,
          FinanceFeeStructures244RequestBuilder
        > {
  _$FinanceFeeStructures244Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  FinanceFeeStructures244RequestBillingCycleEnum? _billingCycle;
  FinanceFeeStructures244RequestBillingCycleEnum? get billingCycle =>
      _$this._billingCycle;
  set billingCycle(
    FinanceFeeStructures244RequestBillingCycleEnum? billingCycle,
  ) => _$this._billingCycle = billingCycle;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  FinanceFeeStructures244RequestBuilder() {
    FinanceFeeStructures244Request._defaults(this);
  }

  FinanceFeeStructures244RequestBuilder get _$this {
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
  void replace(FinanceFeeStructures244Request other) {
    _$v = other as _$FinanceFeeStructures244Request;
  }

  @override
  void update(void Function(FinanceFeeStructures244RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceFeeStructures244Request build() => _build();

  _$FinanceFeeStructures244Request _build() {
    final _$result =
        _$v ??
        _$FinanceFeeStructures244Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'FinanceFeeStructures244Request',
            'name',
          ),
          grade: grade,
          billingCycle: BuiltValueNullFieldError.checkNotNull(
            billingCycle,
            r'FinanceFeeStructures244Request',
            'billingCycle',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'FinanceFeeStructures244Request',
            'amount',
          ),
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
