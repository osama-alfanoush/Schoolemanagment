//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_login202_response.g.dart';

/// AuthLogin202Response
///
/// Properties:
/// * [mfaRequired] 
/// * [mfaEnrollmentRequired] 
/// * [mfaToken] 
/// * [tokenType] 
/// * [expiresIn] 
@BuiltValue()
abstract class AuthLogin202Response implements Built<AuthLogin202Response, AuthLogin202ResponseBuilder> {
  @BuiltValueField(wireName: r'mfa_required')
  bool get mfaRequired;

  @BuiltValueField(wireName: r'mfa_enrollment_required')
  bool get mfaEnrollmentRequired;

  @BuiltValueField(wireName: r'mfa_token')
  String get mfaToken;

  @BuiltValueField(wireName: r'token_type')
  AuthLogin202ResponseTokenTypeEnum get tokenType;
  // enum tokenTypeEnum {  Bearer,  };

  @BuiltValueField(wireName: r'expires_in')
  String get expiresIn;

  AuthLogin202Response._();

  factory AuthLogin202Response([void updates(AuthLogin202ResponseBuilder b)]) = _$AuthLogin202Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthLogin202ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthLogin202Response> get serializer => _$AuthLogin202ResponseSerializer();
}

class _$AuthLogin202ResponseSerializer implements PrimitiveSerializer<AuthLogin202Response> {
  @override
  final Iterable<Type> types = const [AuthLogin202Response, _$AuthLogin202Response];

  @override
  final String wireName = r'AuthLogin202Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthLogin202Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'mfa_required';
    yield serializers.serialize(
      object.mfaRequired,
      specifiedType: const FullType(bool),
    );
    yield r'mfa_enrollment_required';
    yield serializers.serialize(
      object.mfaEnrollmentRequired,
      specifiedType: const FullType(bool),
    );
    yield r'mfa_token';
    yield serializers.serialize(
      object.mfaToken,
      specifiedType: const FullType(String),
    );
    yield r'token_type';
    yield serializers.serialize(
      object.tokenType,
      specifiedType: const FullType(AuthLogin202ResponseTokenTypeEnum),
    );
    yield r'expires_in';
    yield serializers.serialize(
      object.expiresIn,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthLogin202Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthLogin202ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'mfa_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.mfaRequired = valueDes;
          break;
        case r'mfa_enrollment_required':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.mfaEnrollmentRequired = valueDes;
          break;
        case r'mfa_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.mfaToken = valueDes;
          break;
        case r'token_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthLogin202ResponseTokenTypeEnum),
          ) as AuthLogin202ResponseTokenTypeEnum;
          result.tokenType = valueDes;
          break;
        case r'expires_in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.expiresIn = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AuthLogin202Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthLogin202ResponseBuilder();
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

class AuthLogin202ResponseTokenTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Bearer')
  static const AuthLogin202ResponseTokenTypeEnum bearer = _$authLogin202ResponseTokenTypeEnum_bearer;

  static Serializer<AuthLogin202ResponseTokenTypeEnum> get serializer => _$authLogin202ResponseTokenTypeEnumSerializer;

  const AuthLogin202ResponseTokenTypeEnum._(String name): super(name);

  static BuiltSet<AuthLogin202ResponseTokenTypeEnum> get values => _$authLogin202ResponseTokenTypeEnumValues;
  static AuthLogin202ResponseTokenTypeEnum valueOf(String name) => _$authLogin202ResponseTokenTypeEnumValueOf(name);
}

