// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_fee_structures250_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinanceFeeStructures250RequestBillingCycleEnum
_$financeFeeStructures250RequestBillingCycleEnum_monthly =
    const FinanceFeeStructures250RequestBillingCycleEnum._('monthly');
const FinanceFeeStructures250RequestBillingCycleEnum
_$financeFeeStructures250RequestBillingCycleEnum_semester =
    const FinanceFeeStructures250RequestBillingCycleEnum._('semester');
const FinanceFeeStructures250RequestBillingCycleEnum
_$financeFeeStructures250RequestBillingCycleEnum_yearly =
    const FinanceFeeStructures250RequestBillingCycleEnum._('yearly');
const FinanceFeeStructures250RequestBillingCycleEnum
_$financeFeeStructures250RequestBillingCycleEnum_oneTime =
    const FinanceFeeStructures250RequestBillingCycleEnum._('oneTime');

FinanceFeeStructures250RequestBillingCycleEnum
_$financeFeeStructures250RequestBillingCycleEnumValueOf(String name) {
  switch (name) {
    case 'monthly':
      return _$financeFeeStructures250RequestBillingCycleEnum_monthly;
    case 'semester':
      return _$financeFeeStructures250RequestBillingCycleEnum_semester;
    case 'yearly':
      return _$financeFeeStructures250RequestBillingCycleEnum_yearly;
    case 'oneTime':
      return _$financeFeeStructures250RequestBillingCycleEnum_oneTime;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinanceFeeStructures250RequestBillingCycleEnum>
_$financeFeeStructures250RequestBillingCycleEnumValues =
    BuiltSet<FinanceFeeStructures250RequestBillingCycleEnum>(
      const <FinanceFeeStructures250RequestBillingCycleEnum>[
        _$financeFeeStructures250RequestBillingCycleEnum_monthly,
        _$financeFeeStructures250RequestBillingCycleEnum_semester,
        _$financeFeeStructures250RequestBillingCycleEnum_yearly,
        _$financeFeeStructures250RequestBillingCycleEnum_oneTime,
      ],
    );

Serializer<FinanceFeeStructures250RequestBillingCycleEnum>
_$financeFeeStructures250RequestBillingCycleEnumSerializer =
    _$FinanceFeeStructures250RequestBillingCycleEnumSerializer();

class _$FinanceFeeStructures250RequestBillingCycleEnumSerializer
    implements
        PrimitiveSerializer<FinanceFeeStructures250RequestBillingCycleEnum> {
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
    FinanceFeeStructures250RequestBillingCycleEnum,
  ];
  @override
  final String wireName = 'FinanceFeeStructures250RequestBillingCycleEnum';

  @override
  Object serialize(
    Serializers serializers,
    FinanceFeeStructures250RequestBillingCycleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FinanceFeeStructures250RequestBillingCycleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FinanceFeeStructures250RequestBillingCycleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FinanceFeeStructures250Request extends FinanceFeeStructures250Request {
  @override
  final String name;
  @override
  final String? grade;
  @override
  final FinanceFeeStructures250RequestBillingCycleEnum billingCycle;
  @override
  final num amount;
  @override
  final bool? isActive;

  factory _$FinanceFeeStructures250Request([
    void Function(FinanceFeeStructures250RequestBuilder)? updates,
  ]) => (FinanceFeeStructures250RequestBuilder()..update(updates))._build();

  _$FinanceFeeStructures250Request._({
    required this.name,
    this.grade,
    required this.billingCycle,
    required this.amount,
    this.isActive,
  }) : super._();
  @override
  FinanceFeeStructures250Request rebuild(
    void Function(FinanceFeeStructures250RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceFeeStructures250RequestBuilder toBuilder() =>
      FinanceFeeStructures250RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceFeeStructures250Request &&
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
    return (newBuiltValueToStringHelper(r'FinanceFeeStructures250Request')
          ..add('name', name)
          ..add('grade', grade)
          ..add('billingCycle', billingCycle)
          ..add('amount', amount)
          ..add('isActive', isActive))
        .toString();
  }
}

class FinanceFeeStructures250RequestBuilder
    implements
        Builder<
          FinanceFeeStructures250Request,
          FinanceFeeStructures250RequestBuilder
        > {
  _$FinanceFeeStructures250Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  FinanceFeeStructures250RequestBillingCycleEnum? _billingCycle;
  FinanceFeeStructures250RequestBillingCycleEnum? get billingCycle =>
      _$this._billingCycle;
  set billingCycle(
    FinanceFeeStructures250RequestBillingCycleEnum? billingCycle,
  ) => _$this._billingCycle = billingCycle;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  FinanceFeeStructures250RequestBuilder() {
    FinanceFeeStructures250Request._defaults(this);
  }

  FinanceFeeStructures250RequestBuilder get _$this {
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
  void replace(FinanceFeeStructures250Request other) {
    _$v = other as _$FinanceFeeStructures250Request;
  }

  @override
  void update(void Function(FinanceFeeStructures250RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceFeeStructures250Request build() => _build();

  _$FinanceFeeStructures250Request _build() {
    final _$result =
        _$v ??
        _$FinanceFeeStructures250Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'FinanceFeeStructures250Request',
            'name',
          ),
          grade: grade,
          billingCycle: BuiltValueNullFieldError.checkNotNull(
            billingCycle,
            r'FinanceFeeStructures250Request',
            'billingCycle',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'FinanceFeeStructures250Request',
            'amount',
          ),
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
