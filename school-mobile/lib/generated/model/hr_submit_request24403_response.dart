//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_submit_request24403_response.g.dart';

/// HrSubmitRequest24403Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrSubmitRequest24403Response implements Built<HrSubmitRequest24403Response, HrSubmitRequest24403ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  HrSubmitRequest24403ResponseMessageEnum get message;
  // enum messageEnum {  Only staff can submit HR requests.,  };

  HrSubmitRequest24403Response._();

  factory HrSubmitRequest24403Response([void updates(HrSubmitRequest24403ResponseBuilder b)]) = _$HrSubmitRequest24403Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrSubmitRequest24403ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrSubmitRequest24403Response> get serializer => _$HrSubmitRequest24403ResponseSerializer();
}

class _$HrSubmitRequest24403ResponseSerializer implements PrimitiveSerializer<HrSubmitRequest24403Response> {
  @override
  final Iterable<Type> types = const [HrSubmitRequest24403Response, _$HrSubmitRequest24403Response];

  @override
  final String wireName = r'HrSubmitRequest24403Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrSubmitRequest24403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(HrSubmitRequest24403ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrSubmitRequest24403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrSubmitRequest24403ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrSubmitRequest24403ResponseMessageEnum),
          ) as HrSubmitRequest24403ResponseMessageEnum;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrSubmitRequest24403Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrSubmitRequest24403ResponseBuilder();
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

class HrSubmitRequest24403ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Only staff can submit HR requests.')
  static const HrSubmitRequest24403ResponseMessageEnum onlyStaffCanSubmitHRRequestsPeriod = _$hrSubmitRequest24403ResponseMessageEnum_onlyStaffCanSubmitHRRequestsPeriod;

  static Serializer<HrSubmitRequest24403ResponseMessageEnum> get serializer => _$hrSubmitRequest24403ResponseMessageEnumSerializer;

  const HrSubmitRequest24403ResponseMessageEnum._(String name): super(name);

  static BuiltSet<HrSubmitRequest24403ResponseMessageEnum> get values => _$hrSubmitRequest24403ResponseMessageEnumValues;
  static HrSubmitRequest24403ResponseMessageEnum valueOf(String name) => _$hrSubmitRequest24403ResponseMessageEnumValueOf(name);
}

