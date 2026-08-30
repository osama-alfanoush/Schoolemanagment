//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_csrf_cookie200_response.g.dart';

/// AuthCsrfCookie200Response
///
/// Properties:
/// * [csrfToken] 
@BuiltValue()
abstract class AuthCsrfCookie200Response implements Built<AuthCsrfCookie200Response, AuthCsrfCookie200ResponseBuilder> {
  @BuiltValueField(wireName: r'csrf_token')
  String get csrfToken;

  AuthCsrfCookie200Response._();

  factory AuthCsrfCookie200Response([void updates(AuthCsrfCookie200ResponseBuilder b)]) = _$AuthCsrfCookie200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthCsrfCookie200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthCsrfCookie200Response> get serializer => _$AuthCsrfCookie200ResponseSerializer();
}

class _$AuthCsrfCookie200ResponseSerializer implements PrimitiveSerializer<AuthCsrfCookie200Response> {
  @override
  final Iterable<Type> types = const [AuthCsrfCookie200Response, _$AuthCsrfCookie200Response];

  @override
  final String wireName = r'AuthCsrfCookie200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthCsrfCookie200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'csrf_token';
    yield serializers.serialize(
      object.csrfToken,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthCsrfCookie200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthCsrfCookie200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'csrf_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.csrfToken = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AuthCsrfCookie200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthCsrfCookie200ResponseBuilder();
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

