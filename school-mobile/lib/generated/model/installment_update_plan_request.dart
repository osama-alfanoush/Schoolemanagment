//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'installment_update_plan_request.g.dart';

/// InstallmentUpdatePlanRequest
///
/// Properties:
/// * [shiftDays] 
/// * [status] 
@BuiltValue()
abstract class InstallmentUpdatePlanRequest implements Built<InstallmentUpdatePlanRequest, InstallmentUpdatePlanRequestBuilder> {
  @BuiltValueField(wireName: r'shift_days')
  int? get shiftDays;

  @BuiltValueField(wireName: r'status')
  InstallmentUpdatePlanRequestStatusEnum? get status;
  // enum statusEnum {  active,  defaulted,  ,  };

  InstallmentUpdatePlanRequest._();

  factory InstallmentUpdatePlanRequest([void updates(InstallmentUpdatePlanRequestBuilder b)]) = _$InstallmentUpdatePlanRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InstallmentUpdatePlanRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InstallmentUpdatePlanRequest> get serializer => _$InstallmentUpdatePlanRequestSerializer();
}

class _$InstallmentUpdatePlanRequestSerializer implements PrimitiveSerializer<InstallmentUpdatePlanRequest> {
  @override
  final Iterable<Type> types = const [InstallmentUpdatePlanRequest, _$InstallmentUpdatePlanRequest];

  @override
  final String wireName = r'InstallmentUpdatePlanRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InstallmentUpdatePlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.shiftDays != null) {
      yield r'shift_days';
      yield serializers.serialize(
        object.shiftDays,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType.nullable(InstallmentUpdatePlanRequestStatusEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    InstallmentUpdatePlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InstallmentUpdatePlanRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'shift_days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.shiftDays = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(InstallmentUpdatePlanRequestStatusEnum),
          ) as InstallmentUpdatePlanRequestStatusEnum?;
          if (valueDes == null) continue;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InstallmentUpdatePlanRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InstallmentUpdatePlanRequestBuilder();
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

class InstallmentUpdatePlanRequestStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'active')
  static const InstallmentUpdatePlanRequestStatusEnum active = _$installmentUpdatePlanRequestStatusEnum_active;
  @BuiltValueEnumConst(wireName: r'defaulted')
  static const InstallmentUpdatePlanRequestStatusEnum defaulted = _$installmentUpdatePlanRequestStatusEnum_defaulted;

  static Serializer<InstallmentUpdatePlanRequestStatusEnum> get serializer => _$installmentUpdatePlanRequestStatusEnumSerializer;

  const InstallmentUpdatePlanRequestStatusEnum._(String name): super(name);

  static BuiltSet<InstallmentUpdatePlanRequestStatusEnum> get values => _$installmentUpdatePlanRequestStatusEnumValues;
  static InstallmentUpdatePlanRequestStatusEnum valueOf(String name) => _$installmentUpdatePlanRequestStatusEnumValueOf(name);
}

