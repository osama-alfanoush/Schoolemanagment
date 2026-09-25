//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_review_hr_request403_response.g.dart';

/// AdminReviewHrRequest403Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class AdminReviewHrRequest403Response implements Built<AdminReviewHrRequest403Response, AdminReviewHrRequest403ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  AdminReviewHrRequest403ResponseMessageEnum get message;
  // enum messageEnum {  Only HR can review HR requests.,  };

  AdminReviewHrRequest403Response._();

  factory AdminReviewHrRequest403Response([void updates(AdminReviewHrRequest403ResponseBuilder b)]) = _$AdminReviewHrRequest403Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminReviewHrRequest403ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminReviewHrRequest403Response> get serializer => _$AdminReviewHrRequest403ResponseSerializer();
}

class _$AdminReviewHrRequest403ResponseSerializer implements PrimitiveSerializer<AdminReviewHrRequest403Response> {
  @override
  final Iterable<Type> types = const [AdminReviewHrRequest403Response, _$AdminReviewHrRequest403Response];

  @override
  final String wireName = r'AdminReviewHrRequest403Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminReviewHrRequest403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(AdminReviewHrRequest403ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminReviewHrRequest403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminReviewHrRequest403ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdminReviewHrRequest403ResponseMessageEnum),
          ) as AdminReviewHrRequest403ResponseMessageEnum;
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
  AdminReviewHrRequest403Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminReviewHrRequest403ResponseBuilder();
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

class AdminReviewHrRequest403ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Only HR can review HR requests.')
  static const AdminReviewHrRequest403ResponseMessageEnum onlyHRCanReviewHRRequestsPeriod = _$adminReviewHrRequest403ResponseMessageEnum_onlyHRCanReviewHRRequestsPeriod;

  static Serializer<AdminReviewHrRequest403ResponseMessageEnum> get serializer => _$adminReviewHrRequest403ResponseMessageEnumSerializer;

  const AdminReviewHrRequest403ResponseMessageEnum._(String name): super(name);

  static BuiltSet<AdminReviewHrRequest403ResponseMessageEnum> get values => _$adminReviewHrRequest403ResponseMessageEnumValues;
  static AdminReviewHrRequest403ResponseMessageEnum valueOf(String name) => _$adminReviewHrRequest403ResponseMessageEnumValueOf(name);
}

