//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_register_push_token200_response.g.dart';

/// AuthRegisterPushToken200Response
///
/// Properties:
/// * [message] 
/// * [deviceId] 
@BuiltValue()
abstract class AuthRegisterPushToken200Response implements Built<AuthRegisterPushToken200Response, AuthRegisterPushToken200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  AuthRegisterPushToken200ResponseMessageEnum get message;
  // enum messageEnum {  Token registered,  };

  @BuiltValueField(wireName: r'device_id')
  String get deviceId;

  AuthRegisterPushToken200Response._();

  factory AuthRegisterPushToken200Response([void updates(AuthRegisterPushToken200ResponseBuilder b)]) = _$AuthRegisterPushToken200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthRegisterPushToken200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthRegisterPushToken200Response> get serializer => _$AuthRegisterPushToken200ResponseSerializer();
}

class _$AuthRegisterPushToken200ResponseSerializer implements PrimitiveSerializer<AuthRegisterPushToken200Response> {
  @override
  final Iterable<Type> types = const [AuthRegisterPushToken200Response, _$AuthRegisterPushToken200Response];

  @override
  final String wireName = r'AuthRegisterPushToken200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthRegisterPushToken200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(AuthRegisterPushToken200ResponseMessageEnum),
    );
    yield r'device_id';
    yield serializers.serialize(
      object.deviceId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthRegisterPushToken200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthRegisterPushToken200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthRegisterPushToken200ResponseMessageEnum),
          ) as AuthRegisterPushToken200ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'device_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.deviceId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AuthRegisterPushToken200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthRegisterPushToken200ResponseBuilder();
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

class AuthRegisterPushToken200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Token registered')
  static const AuthRegisterPushToken200ResponseMessageEnum tokenRegistered = _$authRegisterPushToken200ResponseMessageEnum_tokenRegistered;

  static Serializer<AuthRegisterPushToken200ResponseMessageEnum> get serializer => _$authRegisterPushToken200ResponseMessageEnumSerializer;

  const AuthRegisterPushToken200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<AuthRegisterPushToken200ResponseMessageEnum> get values => _$authRegisterPushToken200ResponseMessageEnumValues;
  static AuthRegisterPushToken200ResponseMessageEnum valueOf(String name) => _$authRegisterPushToken200ResponseMessageEnumValueOf(name);
}

