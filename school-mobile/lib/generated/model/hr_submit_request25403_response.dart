//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_submit_request25403_response.g.dart';

/// HrSubmitRequest25403Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrSubmitRequest25403Response implements Built<HrSubmitRequest25403Response, HrSubmitRequest25403ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  HrSubmitRequest25403ResponseMessageEnum get message;
  // enum messageEnum {  Only staff can submit HR requests.,  };

  HrSubmitRequest25403Response._();

  factory HrSubmitRequest25403Response([void updates(HrSubmitRequest25403ResponseBuilder b)]) = _$HrSubmitRequest25403Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrSubmitRequest25403ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrSubmitRequest25403Response> get serializer => _$HrSubmitRequest25403ResponseSerializer();
}

class _$HrSubmitRequest25403ResponseSerializer implements PrimitiveSerializer<HrSubmitRequest25403Response> {
  @override
  final Iterable<Type> types = const [HrSubmitRequest25403Response, _$HrSubmitRequest25403Response];

  @override
  final String wireName = r'HrSubmitRequest25403Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrSubmitRequest25403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(HrSubmitRequest25403ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrSubmitRequest25403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrSubmitRequest25403ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrSubmitRequest25403ResponseMessageEnum),
          ) as HrSubmitRequest25403ResponseMessageEnum;
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
  HrSubmitRequest25403Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrSubmitRequest25403ResponseBuilder();
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

class HrSubmitRequest25403ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Only staff can submit HR requests.')
  static const HrSubmitRequest25403ResponseMessageEnum onlyStaffCanSubmitHRRequestsPeriod = _$hrSubmitRequest25403ResponseMessageEnum_onlyStaffCanSubmitHRRequestsPeriod;

  static Serializer<HrSubmitRequest25403ResponseMessageEnum> get serializer => _$hrSubmitRequest25403ResponseMessageEnumSerializer;

  const HrSubmitRequest25403ResponseMessageEnum._(String name): super(name);

  static BuiltSet<HrSubmitRequest25403ResponseMessageEnum> get values => _$hrSubmitRequest25403ResponseMessageEnumValues;
  static HrSubmitRequest25403ResponseMessageEnum valueOf(String name) => _$hrSubmitRequest25403ResponseMessageEnumValueOf(name);
}

