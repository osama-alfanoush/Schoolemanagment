//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_login200_response_any_of1.g.dart';

/// AuthLogin200ResponseAnyOf1
///
/// Properties:
/// * [token] 
/// * [accessToken] - alias kept for backwards compatibility
/// * [refreshToken] 
/// * [tokenType] 
/// * [expiresIn] 
/// * [mustChangePassword] 
/// * [user] 
@BuiltValue()
abstract class AuthLogin200ResponseAnyOf1 implements Built<AuthLogin200ResponseAnyOf1, AuthLogin200ResponseAnyOf1Builder> {
  @BuiltValueField(wireName: r'token')
  String get token;

  /// alias kept for backwards compatibility
  @BuiltValueField(wireName: r'access_token')
  String get accessToken;

  @BuiltValueField(wireName: r'refresh_token')
  String get refreshToken;

  @BuiltValueField(wireName: r'token_type')
  AuthLogin200ResponseAnyOf1TokenTypeEnum get tokenType;
  // enum tokenTypeEnum {  Bearer,  };

  @BuiltValueField(wireName: r'expires_in')
  AuthLogin200ResponseAnyOf1ExpiresInEnum get expiresIn;
  // enum expiresInEnum {  7200,  };

  @BuiltValueField(wireName: r'must_change_password')
  bool get mustChangePassword;

  @BuiltValueField(wireName: r'user')
  JsonObject? get user;

  AuthLogin200ResponseAnyOf1._();

  factory AuthLogin200ResponseAnyOf1([void updates(AuthLogin200ResponseAnyOf1Builder b)]) = _$AuthLogin200ResponseAnyOf1;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthLogin200ResponseAnyOf1Builder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthLogin200ResponseAnyOf1> get serializer => _$AuthLogin200ResponseAnyOf1Serializer();
}

class _$AuthLogin200ResponseAnyOf1Serializer implements PrimitiveSerializer<AuthLogin200ResponseAnyOf1> {
  @override
  final Iterable<Type> types = const [AuthLogin200ResponseAnyOf1, _$AuthLogin200ResponseAnyOf1];

  @override
  final String wireName = r'AuthLogin200ResponseAnyOf1';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthLogin200ResponseAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
    yield r'access_token';
    yield serializers.serialize(
      object.accessToken,
      specifiedType: const FullType(String),
    );
    yield r'refresh_token';
    yield serializers.serialize(
      object.refreshToken,
      specifiedType: const FullType(String),
    );
    yield r'token_type';
    yield serializers.serialize(
      object.tokenType,
      specifiedType: const FullType(AuthLogin200ResponseAnyOf1TokenTypeEnum),
    );
    yield r'expires_in';
    yield serializers.serialize(
      object.expiresIn,
      specifiedType: const FullType(AuthLogin200ResponseAnyOf1ExpiresInEnum),
    );
    yield r'must_change_password';
    yield serializers.serialize(
      object.mustChangePassword,
      specifiedType: const FullType(bool),
    );
    yield r'user';
    yield object.user == null ? null : serializers.serialize(
      object.user,
      specifiedType: const FullType.nullable(JsonObject),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthLogin200ResponseAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthLogin200ResponseAnyOf1Builder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        case r'access_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accessToken = valueDes;
          break;
        case r'refresh_token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.refreshToken = valueDes;
          break;
        case r'token_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthLogin200ResponseAnyOf1TokenTypeEnum),
          ) as AuthLogin200ResponseAnyOf1TokenTypeEnum;
          result.tokenType = valueDes;
          break;
        case r'expires_in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthLogin200ResponseAnyOf1ExpiresInEnum),
          ) as AuthLogin200ResponseAnyOf1ExpiresInEnum;
          result.expiresIn = valueDes;
          break;
        case r'must_change_password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.mustChangePassword = valueDes;
          break;
        case r'user':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.user = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AuthLogin200ResponseAnyOf1 deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthLogin200ResponseAnyOf1Builder();
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

class AuthLogin200ResponseAnyOf1TokenTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Bearer')
  static const AuthLogin200ResponseAnyOf1TokenTypeEnum bearer = _$authLogin200ResponseAnyOf1TokenTypeEnum_bearer;

  static Serializer<AuthLogin200ResponseAnyOf1TokenTypeEnum> get serializer => _$authLogin200ResponseAnyOf1TokenTypeEnumSerializer;

  const AuthLogin200ResponseAnyOf1TokenTypeEnum._(String name): super(name);

  static BuiltSet<AuthLogin200ResponseAnyOf1TokenTypeEnum> get values => _$authLogin200ResponseAnyOf1TokenTypeEnumValues;
  static AuthLogin200ResponseAnyOf1TokenTypeEnum valueOf(String name) => _$authLogin200ResponseAnyOf1TokenTypeEnumValueOf(name);
}

class AuthLogin200ResponseAnyOf1ExpiresInEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 7200)
  static const AuthLogin200ResponseAnyOf1ExpiresInEnum number7200 = _$authLogin200ResponseAnyOf1ExpiresInEnum_number7200;

  static Serializer<AuthLogin200ResponseAnyOf1ExpiresInEnum> get serializer => _$authLogin200ResponseAnyOf1ExpiresInEnumSerializer;

  const AuthLogin200ResponseAnyOf1ExpiresInEnum._(String name): super(name);

  static BuiltSet<AuthLogin200ResponseAnyOf1ExpiresInEnum> get values => _$authLogin200ResponseAnyOf1ExpiresInEnumValues;
  static AuthLogin200ResponseAnyOf1ExpiresInEnum valueOf(String name) => _$authLogin200ResponseAnyOf1ExpiresInEnumValueOf(name);
}

