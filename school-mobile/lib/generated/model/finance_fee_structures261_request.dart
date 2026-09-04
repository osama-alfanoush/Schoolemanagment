//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_fee_structures261_request.g.dart';

/// FinanceFeeStructures261Request
///
/// Properties:
/// * [name] 
/// * [grade] 
/// * [billingCycle] 
/// * [amount] 
/// * [isActive] 
@BuiltValue()
abstract class FinanceFeeStructures261Request implements Built<FinanceFeeStructures261Request, FinanceFeeStructures261RequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'grade')
  String? get grade;

  @BuiltValueField(wireName: r'billing_cycle')
  FinanceFeeStructures261RequestBillingCycleEnum get billingCycle;
  // enum billingCycleEnum {  monthly,  semester,  yearly,  one-time,  };

  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'is_active')
  bool? get isActive;

  FinanceFeeStructures261Request._();

  factory FinanceFeeStructures261Request([void updates(FinanceFeeStructures261RequestBuilder b)]) = _$FinanceFeeStructures261Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceFeeStructures261RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceFeeStructures261Request> get serializer => _$FinanceFeeStructures261RequestSerializer();
}

class _$FinanceFeeStructures261RequestSerializer implements PrimitiveSerializer<FinanceFeeStructures261Request> {
  @override
  final Iterable<Type> types = const [FinanceFeeStructures261Request, _$FinanceFeeStructures261Request];

  @override
  final String wireName = r'FinanceFeeStructures261Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceFeeStructures261Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    if (object.grade != null) {
      yield r'grade';
      yield serializers.serialize(
        object.grade,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'billing_cycle';
    yield serializers.serialize(
      object.billingCycle,
      specifiedType: const FullType(FinanceFeeStructures261RequestBillingCycleEnum),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
    );
    if (object.isActive != null) {
      yield r'is_active';
      yield serializers.serialize(
        object.isActive,
        specifiedType: const FullType(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FinanceFeeStructures261Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinanceFeeStructures261RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'grade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.grade = valueDes;
          break;
        case r'billing_cycle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FinanceFeeStructures261RequestBillingCycleEnum),
          ) as FinanceFeeStructures261RequestBillingCycleEnum;
          result.billingCycle = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
          break;
        case r'is_active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isActive = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinanceFeeStructures261Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceFeeStructures261RequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class FinanceFeeStructures261RequestBillingCycleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'monthly')
  static const FinanceFeeStructures261RequestBillingCycleEnum monthly = _$financeFeeStructures261RequestBillingCycleEnum_monthly;
  @BuiltValueEnumConst(wireName: r'semester')
  static const FinanceFeeStructures261RequestBillingCycleEnum semester = _$financeFeeStructures261RequestBillingCycleEnum_semester;
  @BuiltValueEnumConst(wireName: r'yearly')
  static const FinanceFeeStructures261RequestBillingCycleEnum yearly = _$financeFeeStructures261RequestBillingCycleEnum_yearly;
  @BuiltValueEnumConst(wireName: r'one-time')
  static const FinanceFeeStructures261RequestBillingCycleEnum oneTime = _$financeFeeStructures261RequestBillingCycleEnum_oneTime;

  static Serializer<FinanceFeeStructures261RequestBillingCycleEnum> get serializer => _$financeFeeStructures261RequestBillingCycleEnumSerializer;

  const FinanceFeeStructures261RequestBillingCycleEnum._(String name): super(name);

  static BuiltSet<FinanceFeeStructures261RequestBillingCycleEnum> get values => _$financeFeeStructures261RequestBillingCycleEnumValues;
  static FinanceFeeStructures261RequestBillingCycleEnum valueOf(String name) => _$financeFeeStructures261RequestBillingCycleEnumValueOf(name);
}

