//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_fee_structures247_request.g.dart';

/// FinanceFeeStructures247Request
///
/// Properties:
/// * [name] 
/// * [grade] 
/// * [billingCycle] 
/// * [amount] 
/// * [isActive] 
@BuiltValue()
abstract class FinanceFeeStructures247Request implements Built<FinanceFeeStructures247Request, FinanceFeeStructures247RequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'grade')
  String? get grade;

  @BuiltValueField(wireName: r'billing_cycle')
  FinanceFeeStructures247RequestBillingCycleEnum get billingCycle;
  // enum billingCycleEnum {  monthly,  semester,  yearly,  one-time,  };

  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'is_active')
  bool? get isActive;

  FinanceFeeStructures247Request._();

  factory FinanceFeeStructures247Request([void updates(FinanceFeeStructures247RequestBuilder b)]) = _$FinanceFeeStructures247Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceFeeStructures247RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceFeeStructures247Request> get serializer => _$FinanceFeeStructures247RequestSerializer();
}

class _$FinanceFeeStructures247RequestSerializer implements PrimitiveSerializer<FinanceFeeStructures247Request> {
  @override
  final Iterable<Type> types = const [FinanceFeeStructures247Request, _$FinanceFeeStructures247Request];

  @override
  final String wireName = r'FinanceFeeStructures247Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceFeeStructures247Request object, {
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
      specifiedType: const FullType(FinanceFeeStructures247RequestBillingCycleEnum),
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
    FinanceFeeStructures247Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinanceFeeStructures247RequestBuilder result,
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
            specifiedType: const FullType(FinanceFeeStructures247RequestBillingCycleEnum),
          ) as FinanceFeeStructures247RequestBillingCycleEnum;
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
  FinanceFeeStructures247Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceFeeStructures247RequestBuilder();
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

class FinanceFeeStructures247RequestBillingCycleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'monthly')
  static const FinanceFeeStructures247RequestBillingCycleEnum monthly = _$financeFeeStructures247RequestBillingCycleEnum_monthly;
  @BuiltValueEnumConst(wireName: r'semester')
  static const FinanceFeeStructures247RequestBillingCycleEnum semester = _$financeFeeStructures247RequestBillingCycleEnum_semester;
  @BuiltValueEnumConst(wireName: r'yearly')
  static const FinanceFeeStructures247RequestBillingCycleEnum yearly = _$financeFeeStructures247RequestBillingCycleEnum_yearly;
  @BuiltValueEnumConst(wireName: r'one-time')
  static const FinanceFeeStructures247RequestBillingCycleEnum oneTime = _$financeFeeStructures247RequestBillingCycleEnum_oneTime;

  static Serializer<FinanceFeeStructures247RequestBillingCycleEnum> get serializer => _$financeFeeStructures247RequestBillingCycleEnumSerializer;

  const FinanceFeeStructures247RequestBillingCycleEnum._(String name): super(name);

  static BuiltSet<FinanceFeeStructures247RequestBillingCycleEnum> get values => _$financeFeeStructures247RequestBillingCycleEnumValues;
  static FinanceFeeStructures247RequestBillingCycleEnum valueOf(String name) => _$financeFeeStructures247RequestBillingCycleEnumValueOf(name);
}

