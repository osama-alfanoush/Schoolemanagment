//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_forgot_password200_response.g.dart';

/// AuthForgotPassword200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class AuthForgotPassword200Response implements Built<AuthForgotPassword200Response, AuthForgotPassword200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  AuthForgotPassword200ResponseMessageEnum get message;
  // enum messageEnum {  If an account exists for that email, a password reset link has been sent.,  };

  AuthForgotPassword200Response._();

  factory AuthForgotPassword200Response([void updates(AuthForgotPassword200ResponseBuilder b)]) = _$AuthForgotPassword200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthForgotPassword200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthForgotPassword200Response> get serializer => _$AuthForgotPassword200ResponseSerializer();
}

class _$AuthForgotPassword200ResponseSerializer implements PrimitiveSerializer<AuthForgotPassword200Response> {
  @override
  final Iterable<Type> types = const [AuthForgotPassword200Response, _$AuthForgotPassword200Response];

  @override
  final String wireName = r'AuthForgotPassword200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthForgotPassword200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(AuthForgotPassword200ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthForgotPassword200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthForgotPassword200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthForgotPassword200ResponseMessageEnum),
          ) as AuthForgotPassword200ResponseMessageEnum;
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
  AuthForgotPassword200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthForgotPassword200ResponseBuilder();
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

class AuthForgotPassword200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'If an account exists for that email, a password reset link has been sent.')
  static const AuthForgotPassword200ResponseMessageEnum ifAnAccountExistsForThatEmailCommaAPasswordResetLinkHasBeenSentPeriod = _$authForgotPassword200ResponseMessageEnum_ifAnAccountExistsForThatEmailCommaAPasswordResetLinkHasBeenSentPeriod;

  static Serializer<AuthForgotPassword200ResponseMessageEnum> get serializer => _$authForgotPassword200ResponseMessageEnumSerializer;

  const AuthForgotPassword200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<AuthForgotPassword200ResponseMessageEnum> get values => _$authForgotPassword200ResponseMessageEnumValues;
  static AuthForgotPassword200ResponseMessageEnum valueOf(String name) => _$authForgotPassword200ResponseMessageEnumValueOf(name);
}

