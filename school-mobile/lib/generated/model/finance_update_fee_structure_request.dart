//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_update_fee_structure_request.g.dart';

/// FinanceUpdateFeeStructureRequest
///
/// Properties:
/// * [name] 
/// * [grade] 
/// * [billingCycle] 
/// * [amount] 
/// * [isActive] 
@BuiltValue()
abstract class FinanceUpdateFeeStructureRequest implements Built<FinanceUpdateFeeStructureRequest, FinanceUpdateFeeStructureRequestBuilder> {
  @BuiltValueField(wireName: r'name')
  String? get name;

  @BuiltValueField(wireName: r'grade')
  String? get grade;

  @BuiltValueField(wireName: r'billing_cycle')
  FinanceUpdateFeeStructureRequestBillingCycleEnum? get billingCycle;
  // enum billingCycleEnum {  monthly,  semester,  yearly,  one-time,  };

  @BuiltValueField(wireName: r'amount')
  num? get amount;

  @BuiltValueField(wireName: r'is_active')
  bool? get isActive;

  FinanceUpdateFeeStructureRequest._();

  factory FinanceUpdateFeeStructureRequest([void updates(FinanceUpdateFeeStructureRequestBuilder b)]) = _$FinanceUpdateFeeStructureRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceUpdateFeeStructureRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceUpdateFeeStructureRequest> get serializer => _$FinanceUpdateFeeStructureRequestSerializer();
}

class _$FinanceUpdateFeeStructureRequestSerializer implements PrimitiveSerializer<FinanceUpdateFeeStructureRequest> {
  @override
  final Iterable<Type> types = const [FinanceUpdateFeeStructureRequest, _$FinanceUpdateFeeStructureRequest];

  @override
  final String wireName = r'FinanceUpdateFeeStructureRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceUpdateFeeStructureRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.name != null) {
      yield r'name';
      yield serializers.serialize(
        object.name,
        specifiedType: const FullType(String),
      );
    }
    if (object.grade != null) {
      yield r'grade';
      yield serializers.serialize(
        object.grade,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.billingCycle != null) {
      yield r'billing_cycle';
      yield serializers.serialize(
        object.billingCycle,
        specifiedType: const FullType(FinanceUpdateFeeStructureRequestBillingCycleEnum),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(num),
      );
    }
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
    FinanceUpdateFeeStructureRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinanceUpdateFeeStructureRequestBuilder result,
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
            specifiedType: const FullType(FinanceUpdateFeeStructureRequestBillingCycleEnum),
          ) as FinanceUpdateFeeStructureRequestBillingCycleEnum;
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
  FinanceUpdateFeeStructureRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceUpdateFeeStructureRequestBuilder();
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

class FinanceUpdateFeeStructureRequestBillingCycleEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'monthly')
  static const FinanceUpdateFeeStructureRequestBillingCycleEnum monthly = _$financeUpdateFeeStructureRequestBillingCycleEnum_monthly;
  @BuiltValueEnumConst(wireName: r'semester')
  static const FinanceUpdateFeeStructureRequestBillingCycleEnum semester = _$financeUpdateFeeStructureRequestBillingCycleEnum_semester;
  @BuiltValueEnumConst(wireName: r'yearly')
  static const FinanceUpdateFeeStructureRequestBillingCycleEnum yearly = _$financeUpdateFeeStructureRequestBillingCycleEnum_yearly;
  @BuiltValueEnumConst(wireName: r'one-time')
  static const FinanceUpdateFeeStructureRequestBillingCycleEnum oneTime = _$financeUpdateFeeStructureRequestBillingCycleEnum_oneTime;

  static Serializer<FinanceUpdateFeeStructureRequestBillingCycleEnum> get serializer => _$financeUpdateFeeStructureRequestBillingCycleEnumSerializer;

  const FinanceUpdateFeeStructureRequestBillingCycleEnum._(String name): super(name);

  static BuiltSet<FinanceUpdateFeeStructureRequestBillingCycleEnum> get values => _$financeUpdateFeeStructureRequestBillingCycleEnumValues;
  static FinanceUpdateFeeStructureRequestBillingCycleEnum valueOf(String name) => _$financeUpdateFeeStructureRequestBillingCycleEnumValueOf(name);
}

