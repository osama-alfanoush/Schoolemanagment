//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/user.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_update_profile200_response.g.dart';

/// AuthUpdateProfile200Response
///
/// Properties:
/// * [user] 
@BuiltValue()
abstract class AuthUpdateProfile200Response implements Built<AuthUpdateProfile200Response, AuthUpdateProfile200ResponseBuilder> {
  @BuiltValueField(wireName: r'user')
  User? get user;

  AuthUpdateProfile200Response._();

  factory AuthUpdateProfile200Response([void updates(AuthUpdateProfile200ResponseBuilder b)]) = _$AuthUpdateProfile200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthUpdateProfile200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthUpdateProfile200Response> get serializer => _$AuthUpdateProfile200ResponseSerializer();
}

class _$AuthUpdateProfile200ResponseSerializer implements PrimitiveSerializer<AuthUpdateProfile200Response> {
  @override
  final Iterable<Type> types = const [AuthUpdateProfile200Response, _$AuthUpdateProfile200Response];

  @override
  final String wireName = r'AuthUpdateProfile200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthUpdateProfile200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'user';
    yield object.user == null ? null : serializers.serialize(
      object.user,
      specifiedType: const FullType.nullable(User),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthUpdateProfile200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthUpdateProfile200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(User),
          ) as User?;
          if (valueDes == null) continue;
          result.user.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AuthUpdateProfile200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthUpdateProfile200ResponseBuilder();
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

