// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_fee_structures270_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinanceFeeStructures270RequestBillingCycleEnum
_$financeFeeStructures270RequestBillingCycleEnum_monthly =
    const FinanceFeeStructures270RequestBillingCycleEnum._('monthly');
const FinanceFeeStructures270RequestBillingCycleEnum
_$financeFeeStructures270RequestBillingCycleEnum_semester =
    const FinanceFeeStructures270RequestBillingCycleEnum._('semester');
const FinanceFeeStructures270RequestBillingCycleEnum
_$financeFeeStructures270RequestBillingCycleEnum_yearly =
    const FinanceFeeStructures270RequestBillingCycleEnum._('yearly');
const FinanceFeeStructures270RequestBillingCycleEnum
_$financeFeeStructures270RequestBillingCycleEnum_oneTime =
    const FinanceFeeStructures270RequestBillingCycleEnum._('oneTime');

FinanceFeeStructures270RequestBillingCycleEnum
_$financeFeeStructures270RequestBillingCycleEnumValueOf(String name) {
  switch (name) {
    case 'monthly':
      return _$financeFeeStructures270RequestBillingCycleEnum_monthly;
    case 'semester':
      return _$financeFeeStructures270RequestBillingCycleEnum_semester;
    case 'yearly':
      return _$financeFeeStructures270RequestBillingCycleEnum_yearly;
    case 'oneTime':
      return _$financeFeeStructures270RequestBillingCycleEnum_oneTime;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinanceFeeStructures270RequestBillingCycleEnum>
_$financeFeeStructures270RequestBillingCycleEnumValues =
    BuiltSet<FinanceFeeStructures270RequestBillingCycleEnum>(
      const <FinanceFeeStructures270RequestBillingCycleEnum>[
        _$financeFeeStructures270RequestBillingCycleEnum_monthly,
        _$financeFeeStructures270RequestBillingCycleEnum_semester,
        _$financeFeeStructures270RequestBillingCycleEnum_yearly,
        _$financeFeeStructures270RequestBillingCycleEnum_oneTime,
      ],
    );

Serializer<FinanceFeeStructures270RequestBillingCycleEnum>
_$financeFeeStructures270RequestBillingCycleEnumSerializer =
    _$FinanceFeeStructures270RequestBillingCycleEnumSerializer();

class _$FinanceFeeStructures270RequestBillingCycleEnumSerializer
    implements
        PrimitiveSerializer<FinanceFeeStructures270RequestBillingCycleEnum> {
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
    FinanceFeeStructures270RequestBillingCycleEnum,
  ];
  @override
  final String wireName = 'FinanceFeeStructures270RequestBillingCycleEnum';

  @override
  Object serialize(
    Serializers serializers,
    FinanceFeeStructures270RequestBillingCycleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FinanceFeeStructures270RequestBillingCycleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FinanceFeeStructures270RequestBillingCycleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FinanceFeeStructures270Request extends FinanceFeeStructures270Request {
  @override
  final String name;
  @override
  final String? grade;
  @override
  final FinanceFeeStructures270RequestBillingCycleEnum billingCycle;
  @override
  final num amount;
  @override
  final bool? isActive;

  factory _$FinanceFeeStructures270Request([
    void Function(FinanceFeeStructures270RequestBuilder)? updates,
  ]) => (FinanceFeeStructures270RequestBuilder()..update(updates))._build();

  _$FinanceFeeStructures270Request._({
    required this.name,
    this.grade,
    required this.billingCycle,
    required this.amount,
    this.isActive,
  }) : super._();
  @override
  FinanceFeeStructures270Request rebuild(
    void Function(FinanceFeeStructures270RequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceFeeStructures270RequestBuilder toBuilder() =>
      FinanceFeeStructures270RequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceFeeStructures270Request &&
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
    return (newBuiltValueToStringHelper(r'FinanceFeeStructures270Request')
          ..add('name', name)
          ..add('grade', grade)
          ..add('billingCycle', billingCycle)
          ..add('amount', amount)
          ..add('isActive', isActive))
        .toString();
  }
}

class FinanceFeeStructures270RequestBuilder
    implements
        Builder<
          FinanceFeeStructures270Request,
          FinanceFeeStructures270RequestBuilder
        > {
  _$FinanceFeeStructures270Request? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  FinanceFeeStructures270RequestBillingCycleEnum? _billingCycle;
  FinanceFeeStructures270RequestBillingCycleEnum? get billingCycle =>
      _$this._billingCycle;
  set billingCycle(
    FinanceFeeStructures270RequestBillingCycleEnum? billingCycle,
  ) => _$this._billingCycle = billingCycle;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  FinanceFeeStructures270RequestBuilder() {
    FinanceFeeStructures270Request._defaults(this);
  }

  FinanceFeeStructures270RequestBuilder get _$this {
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
  void replace(FinanceFeeStructures270Request other) {
    _$v = other as _$FinanceFeeStructures270Request;
  }

  @override
  void update(void Function(FinanceFeeStructures270RequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceFeeStructures270Request build() => _build();

  _$FinanceFeeStructures270Request _build() {
    final _$result =
        _$v ??
        _$FinanceFeeStructures270Request._(
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'FinanceFeeStructures270Request',
            'name',
          ),
          grade: grade,
          billingCycle: BuiltValueNullFieldError.checkNotNull(
            billingCycle,
            r'FinanceFeeStructures270Request',
            'billingCycle',
          ),
          amount: BuiltValueNullFieldError.checkNotNull(
            amount,
            r'FinanceFeeStructures270Request',
            'amount',
          ),
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
