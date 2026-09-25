//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_fee_structures288_request.g.dart';

/// FinanceFeeStructures288Request
///
/// Properties:
/// * [name] 
/// * [grade] 
/// * [billingCycle] 
/// * [amount] 
/// * [isActive] 
@BuiltValue()
abstract class FinanceFeeStructures288Request implements Built<FinanceFeeStructures288Request, FinanceFeeStructures288RequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'grade')
  String? get grade;

  @BuiltValueField(wireName: r'billing_cycle')
  FinanceFeeStructures288RequestBillingCycleEnum get billingCycle;
  // enum billingCycleEnum {  monthly,  semester,  yearly,  one-time,  };

  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'is_active')
  bool? get isActive;

  FinanceFeeStructures288Request._();

  factory FinanceFeeStructures288Request([void updates(FinanceFeeStructures288RequestBuilder b)]) = _$FinanceFeeStructures288Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceFeeStructures288RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceFeeStructures288Request> get serializer => _$FinanceFeeStructures288RequestSerializer();
}

class _$FinanceFeeStructures288RequestSerializer implements PrimitiveSerializer<FinanceFeeStructures288Request> {
  @override
  final Iterable<Type> types = const [FinanceFeeStructures288Request, _$FinanceFeeStructures288Request];

  @override
  final String wireName = r'FinanceFeeStructures288Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceFeeStructures288Request object, {
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
      specifiedType: const FullType(FinanceFeeStructures288RequestBillingCycleEnum),
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
    FinanceFeeStructures288Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinanceFeeStructures288RequestBuilder result,
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
            specifiedType: const FullType(FinanceFeeStructures288RequestBillingCycleEnum),
          ) as FinanceFeeStructures288RequestBillingCycleEnum;
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
  FinanceFeeStructures288Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceFeeStructures288RequestBuilder();
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

class FinanceFeeStructures288RequestBillingCycleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'monthly')
  static const FinanceFeeStructures288RequestBillingCycleEnum monthly = _$financeFeeStructures288RequestBillingCycleEnum_monthly;
  @BuiltValueEnumConst(wireName: r'semester')
  static const FinanceFeeStructures288RequestBillingCycleEnum semester = _$financeFeeStructures288RequestBillingCycleEnum_semester;
  @BuiltValueEnumConst(wireName: r'yearly')
  static const FinanceFeeStructures288RequestBillingCycleEnum yearly = _$financeFeeStructures288RequestBillingCycleEnum_yearly;
  @BuiltValueEnumConst(wireName: r'one-time')
  static const FinanceFeeStructures288RequestBillingCycleEnum oneTime = _$financeFeeStructures288RequestBillingCycleEnum_oneTime;

  static Serializer<FinanceFeeStructures288RequestBillingCycleEnum> get serializer => _$financeFeeStructures288RequestBillingCycleEnumSerializer;

  const FinanceFeeStructures288RequestBillingCycleEnum._(String name): super(name);

  static BuiltSet<FinanceFeeStructures288RequestBillingCycleEnum> get values => _$financeFeeStructures288RequestBillingCycleEnumValues;
  static FinanceFeeStructures288RequestBillingCycleEnum valueOf(String name) => _$financeFeeStructures288RequestBillingCycleEnumValueOf(name);
}

