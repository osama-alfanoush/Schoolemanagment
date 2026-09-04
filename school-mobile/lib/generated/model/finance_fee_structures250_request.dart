//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_fee_structures250_request.g.dart';

/// FinanceFeeStructures250Request
///
/// Properties:
/// * [name] 
/// * [grade] 
/// * [billingCycle] 
/// * [amount] 
/// * [isActive] 
@BuiltValue()
abstract class FinanceFeeStructures250Request implements Built<FinanceFeeStructures250Request, FinanceFeeStructures250RequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'grade')
  String? get grade;

  @BuiltValueField(wireName: r'billing_cycle')
  FinanceFeeStructures250RequestBillingCycleEnum get billingCycle;
  // enum billingCycleEnum {  monthly,  semester,  yearly,  one-time,  };

  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'is_active')
  bool? get isActive;

  FinanceFeeStructures250Request._();

  factory FinanceFeeStructures250Request([void updates(FinanceFeeStructures250RequestBuilder b)]) = _$FinanceFeeStructures250Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceFeeStructures250RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceFeeStructures250Request> get serializer => _$FinanceFeeStructures250RequestSerializer();
}

class _$FinanceFeeStructures250RequestSerializer implements PrimitiveSerializer<FinanceFeeStructures250Request> {
  @override
  final Iterable<Type> types = const [FinanceFeeStructures250Request, _$FinanceFeeStructures250Request];

  @override
  final String wireName = r'FinanceFeeStructures250Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceFeeStructures250Request object, {
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
      specifiedType: const FullType(FinanceFeeStructures250RequestBillingCycleEnum),
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
    FinanceFeeStructures250Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinanceFeeStructures250RequestBuilder result,
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
            specifiedType: const FullType(FinanceFeeStructures250RequestBillingCycleEnum),
          ) as FinanceFeeStructures250RequestBillingCycleEnum;
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
  FinanceFeeStructures250Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceFeeStructures250RequestBuilder();
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

class FinanceFeeStructures250RequestBillingCycleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'monthly')
  static const FinanceFeeStructures250RequestBillingCycleEnum monthly = _$financeFeeStructures250RequestBillingCycleEnum_monthly;
  @BuiltValueEnumConst(wireName: r'semester')
  static const FinanceFeeStructures250RequestBillingCycleEnum semester = _$financeFeeStructures250RequestBillingCycleEnum_semester;
  @BuiltValueEnumConst(wireName: r'yearly')
  static const FinanceFeeStructures250RequestBillingCycleEnum yearly = _$financeFeeStructures250RequestBillingCycleEnum_yearly;
  @BuiltValueEnumConst(wireName: r'one-time')
  static const FinanceFeeStructures250RequestBillingCycleEnum oneTime = _$financeFeeStructures250RequestBillingCycleEnum_oneTime;

  static Serializer<FinanceFeeStructures250RequestBillingCycleEnum> get serializer => _$financeFeeStructures250RequestBillingCycleEnumSerializer;

  const FinanceFeeStructures250RequestBillingCycleEnum._(String name): super(name);

  static BuiltSet<FinanceFeeStructures250RequestBillingCycleEnum> get values => _$financeFeeStructures250RequestBillingCycleEnumValues;
  static FinanceFeeStructures250RequestBillingCycleEnum valueOf(String name) => _$financeFeeStructures250RequestBillingCycleEnumValueOf(name);
}

