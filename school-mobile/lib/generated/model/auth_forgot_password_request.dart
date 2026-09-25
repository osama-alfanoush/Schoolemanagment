//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_forgot_password_request.g.dart';

/// AuthForgotPasswordRequest
///
/// Properties:
/// * [email] 
@BuiltValue()
abstract class AuthForgotPasswordRequest implements Built<AuthForgotPasswordRequest, AuthForgotPasswordRequestBuilder> {
  @BuiltValueField(wireName: r'email')
  String get email;

  AuthForgotPasswordRequest._();

  factory AuthForgotPasswordRequest([void updates(AuthForgotPasswordRequestBuilder b)]) = _$AuthForgotPasswordRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthForgotPasswordRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthForgotPasswordRequest> get serializer => _$AuthForgotPasswordRequestSerializer();
}

class _$AuthForgotPasswordRequestSerializer implements PrimitiveSerializer<AuthForgotPasswordRequest> {
  @override
  final Iterable<Type> types = const [AuthForgotPasswordRequest, _$AuthForgotPasswordRequest];

  @override
  final String wireName = r'AuthForgotPasswordRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthForgotPasswordRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthForgotPasswordRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthForgotPasswordRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AuthForgotPasswordRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthForgotPasswordRequestBuilder();
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

