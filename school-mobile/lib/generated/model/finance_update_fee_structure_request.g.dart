// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_update_fee_structure_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinanceUpdateFeeStructureRequestBillingCycleEnum
_$financeUpdateFeeStructureRequestBillingCycleEnum_monthly =
    const FinanceUpdateFeeStructureRequestBillingCycleEnum._('monthly');
const FinanceUpdateFeeStructureRequestBillingCycleEnum
_$financeUpdateFeeStructureRequestBillingCycleEnum_semester =
    const FinanceUpdateFeeStructureRequestBillingCycleEnum._('semester');
const FinanceUpdateFeeStructureRequestBillingCycleEnum
_$financeUpdateFeeStructureRequestBillingCycleEnum_yearly =
    const FinanceUpdateFeeStructureRequestBillingCycleEnum._('yearly');
const FinanceUpdateFeeStructureRequestBillingCycleEnum
_$financeUpdateFeeStructureRequestBillingCycleEnum_oneTime =
    const FinanceUpdateFeeStructureRequestBillingCycleEnum._('oneTime');

FinanceUpdateFeeStructureRequestBillingCycleEnum
_$financeUpdateFeeStructureRequestBillingCycleEnumValueOf(String name) {
  switch (name) {
    case 'monthly':
      return _$financeUpdateFeeStructureRequestBillingCycleEnum_monthly;
    case 'semester':
      return _$financeUpdateFeeStructureRequestBillingCycleEnum_semester;
    case 'yearly':
      return _$financeUpdateFeeStructureRequestBillingCycleEnum_yearly;
    case 'oneTime':
      return _$financeUpdateFeeStructureRequestBillingCycleEnum_oneTime;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinanceUpdateFeeStructureRequestBillingCycleEnum>
_$financeUpdateFeeStructureRequestBillingCycleEnumValues =
    BuiltSet<FinanceUpdateFeeStructureRequestBillingCycleEnum>(
      const <FinanceUpdateFeeStructureRequestBillingCycleEnum>[
        _$financeUpdateFeeStructureRequestBillingCycleEnum_monthly,
        _$financeUpdateFeeStructureRequestBillingCycleEnum_semester,
        _$financeUpdateFeeStructureRequestBillingCycleEnum_yearly,
        _$financeUpdateFeeStructureRequestBillingCycleEnum_oneTime,
      ],
    );

Serializer<FinanceUpdateFeeStructureRequestBillingCycleEnum>
_$financeUpdateFeeStructureRequestBillingCycleEnumSerializer =
    _$FinanceUpdateFeeStructureRequestBillingCycleEnumSerializer();

class _$FinanceUpdateFeeStructureRequestBillingCycleEnumSerializer
    implements
        PrimitiveSerializer<FinanceUpdateFeeStructureRequestBillingCycleEnum> {
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
    FinanceUpdateFeeStructureRequestBillingCycleEnum,
  ];
  @override
  final String wireName = 'FinanceUpdateFeeStructureRequestBillingCycleEnum';

  @override
  Object serialize(
    Serializers serializers,
    FinanceUpdateFeeStructureRequestBillingCycleEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  FinanceUpdateFeeStructureRequestBillingCycleEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => FinanceUpdateFeeStructureRequestBillingCycleEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$FinanceUpdateFeeStructureRequest
    extends FinanceUpdateFeeStructureRequest {
  @override
  final String? name;
  @override
  final String? grade;
  @override
  final FinanceUpdateFeeStructureRequestBillingCycleEnum? billingCycle;
  @override
  final num? amount;
  @override
  final bool? isActive;

  factory _$FinanceUpdateFeeStructureRequest([
    void Function(FinanceUpdateFeeStructureRequestBuilder)? updates,
  ]) => (FinanceUpdateFeeStructureRequestBuilder()..update(updates))._build();

  _$FinanceUpdateFeeStructureRequest._({
    this.name,
    this.grade,
    this.billingCycle,
    this.amount,
    this.isActive,
  }) : super._();
  @override
  FinanceUpdateFeeStructureRequest rebuild(
    void Function(FinanceUpdateFeeStructureRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  FinanceUpdateFeeStructureRequestBuilder toBuilder() =>
      FinanceUpdateFeeStructureRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinanceUpdateFeeStructureRequest &&
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
    return (newBuiltValueToStringHelper(r'FinanceUpdateFeeStructureRequest')
          ..add('name', name)
          ..add('grade', grade)
          ..add('billingCycle', billingCycle)
          ..add('amount', amount)
          ..add('isActive', isActive))
        .toString();
  }
}

class FinanceUpdateFeeStructureRequestBuilder
    implements
        Builder<
          FinanceUpdateFeeStructureRequest,
          FinanceUpdateFeeStructureRequestBuilder
        > {
  _$FinanceUpdateFeeStructureRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _grade;
  String? get grade => _$this._grade;
  set grade(String? grade) => _$this._grade = grade;

  FinanceUpdateFeeStructureRequestBillingCycleEnum? _billingCycle;
  FinanceUpdateFeeStructureRequestBillingCycleEnum? get billingCycle =>
      _$this._billingCycle;
  set billingCycle(
    FinanceUpdateFeeStructureRequestBillingCycleEnum? billingCycle,
  ) => _$this._billingCycle = billingCycle;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  FinanceUpdateFeeStructureRequestBuilder() {
    FinanceUpdateFeeStructureRequest._defaults(this);
  }

  FinanceUpdateFeeStructureRequestBuilder get _$this {
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
  void replace(FinanceUpdateFeeStructureRequest other) {
    _$v = other as _$FinanceUpdateFeeStructureRequest;
  }

  @override
  void update(void Function(FinanceUpdateFeeStructureRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinanceUpdateFeeStructureRequest build() => _build();

  _$FinanceUpdateFeeStructureRequest _build() {
    final _$result =
        _$v ??
        _$FinanceUpdateFeeStructureRequest._(
          name: name,
          grade: grade,
          billingCycle: billingCycle,
          amount: amount,
          isActive: isActive,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
