//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_link_parent_student200_response.g.dart';

/// AdminLinkParentStudent200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class AdminLinkParentStudent200Response implements Built<AdminLinkParentStudent200Response, AdminLinkParentStudent200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  AdminLinkParentStudent200ResponseMessageEnum get message;
  // enum messageEnum {  Linked,  };

  AdminLinkParentStudent200Response._();

  factory AdminLinkParentStudent200Response([void updates(AdminLinkParentStudent200ResponseBuilder b)]) = _$AdminLinkParentStudent200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminLinkParentStudent200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminLinkParentStudent200Response> get serializer => _$AdminLinkParentStudent200ResponseSerializer();
}

class _$AdminLinkParentStudent200ResponseSerializer implements PrimitiveSerializer<AdminLinkParentStudent200Response> {
  @override
  final Iterable<Type> types = const [AdminLinkParentStudent200Response, _$AdminLinkParentStudent200Response];

  @override
  final String wireName = r'AdminLinkParentStudent200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminLinkParentStudent200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(AdminLinkParentStudent200ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminLinkParentStudent200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminLinkParentStudent200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdminLinkParentStudent200ResponseMessageEnum),
          ) as AdminLinkParentStudent200ResponseMessageEnum;
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
  AdminLinkParentStudent200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminLinkParentStudent200ResponseBuilder();
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

class AdminLinkParentStudent200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Linked')
  static const AdminLinkParentStudent200ResponseMessageEnum linked = _$adminLinkParentStudent200ResponseMessageEnum_linked;

  static Serializer<AdminLinkParentStudent200ResponseMessageEnum> get serializer => _$adminLinkParentStudent200ResponseMessageEnumSerializer;

  const AdminLinkParentStudent200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<AdminLinkParentStudent200ResponseMessageEnum> get values => _$adminLinkParentStudent200ResponseMessageEnumValues;
  static AdminLinkParentStudent200ResponseMessageEnum valueOf(String name) => _$adminLinkParentStudent200ResponseMessageEnumValueOf(name);
}

