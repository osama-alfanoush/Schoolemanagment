//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'password_reset200_response.g.dart';

/// PasswordReset200Response
///
/// Properties:
/// * [message] 
/// * [token] 
@BuiltValue()
abstract class PasswordReset200Response implements Built<PasswordReset200Response, PasswordReset200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  PasswordReset200ResponseMessageEnum get message;
  // enum messageEnum {  Use POST /api/auth/reset-password with this token, your email, and the new password.,  };

  @BuiltValueField(wireName: r'token')
  String get token;

  PasswordReset200Response._();

  factory PasswordReset200Response([void updates(PasswordReset200ResponseBuilder b)]) = _$PasswordReset200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PasswordReset200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PasswordReset200Response> get serializer => _$PasswordReset200ResponseSerializer();
}

class _$PasswordReset200ResponseSerializer implements PrimitiveSerializer<PasswordReset200Response> {
  @override
  final Iterable<Type> types = const [PasswordReset200Response, _$PasswordReset200Response];

  @override
  final String wireName = r'PasswordReset200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PasswordReset200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(PasswordReset200ResponseMessageEnum),
    );
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PasswordReset200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PasswordReset200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PasswordReset200ResponseMessageEnum),
          ) as PasswordReset200ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PasswordReset200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PasswordReset200ResponseBuilder();
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

class PasswordReset200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Use POST /api/auth/reset-password with this token, your email, and the new password.')
  static const PasswordReset200ResponseMessageEnum usePOSTSlashApiSlashAuthSlashResetPasswordWithThisTokenCommaYourEmailCommaAndTheNewPasswordPeriod = _$passwordReset200ResponseMessageEnum_usePOSTSlashApiSlashAuthSlashResetPasswordWithThisTokenCommaYourEmailCommaAndTheNewPasswordPeriod;

  static Serializer<PasswordReset200ResponseMessageEnum> get serializer => _$passwordReset200ResponseMessageEnumSerializer;

  const PasswordReset200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<PasswordReset200ResponseMessageEnum> get values => _$passwordReset200ResponseMessageEnumValues;
  static PasswordReset200ResponseMessageEnum valueOf(String name) => _$passwordReset200ResponseMessageEnumValueOf(name);
}

