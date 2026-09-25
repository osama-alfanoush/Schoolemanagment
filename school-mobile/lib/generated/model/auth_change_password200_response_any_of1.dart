//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_change_password200_response_any_of1.g.dart';

/// AuthChangePassword200ResponseAnyOf1
///
/// Properties:
/// * [message] 
/// * [accessToken] 
/// * [refreshToken] 
/// * [tokenType] 
/// * [expiresIn] 
@BuiltValue()
abstract class AuthChangePassword200ResponseAnyOf1 implements Built<AuthChangePassword200ResponseAnyOf1, AuthChangePassword200ResponseAnyOf1Builder> {
  @BuiltValueField(wireName: r'message')
  AuthChangePassword200ResponseAnyOf1MessageEnum get message;
  // enum messageEnum {  Password updated,  };

  @BuiltValueField(wireName: r'access_token')
  String get accessToken;

  @BuiltValueField(wireName: r'refresh_token')
  String get refreshToken;

  @BuiltValueField(wireName: r'token_type')
  AuthChangePassword200ResponseAnyOf1TokenTypeEnum get tokenType;
  // enum tokenTypeEnum {  Bearer,  };

  @BuiltValueField(wireName: r'expires_in')
  AuthChangePassword200ResponseAnyOf1ExpiresInEnum get expiresIn;
  // enum expiresInEnum {  7200,  };

  AuthChangePassword200ResponseAnyOf1._();

  factory AuthChangePassword200ResponseAnyOf1([void updates(AuthChangePassword200ResponseAnyOf1Builder b)]) = _$AuthChangePassword200ResponseAnyOf1;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthChangePassword200ResponseAnyOf1Builder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthChangePassword200ResponseAnyOf1> get serializer => _$AuthChangePassword200ResponseAnyOf1Serializer();
}

class _$AuthChangePassword200ResponseAnyOf1Serializer implements PrimitiveSerializer<AuthChangePassword200ResponseAnyOf1> {
  @override
  final Iterable<Type> types = const [AuthChangePassword200ResponseAnyOf1, _$AuthChangePassword200ResponseAnyOf1];

  @override
  final String wireName = r'AuthChangePassword200ResponseAnyOf1';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthChangePassword200ResponseAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(AuthChangePassword200ResponseAnyOf1MessageEnum),
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
      specifiedType: const FullType(AuthChangePassword200ResponseAnyOf1TokenTypeEnum),
    );
    yield r'expires_in';
    yield serializers.serialize(
      object.expiresIn,
      specifiedType: const FullType(AuthChangePassword200ResponseAnyOf1ExpiresInEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthChangePassword200ResponseAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthChangePassword200ResponseAnyOf1Builder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthChangePassword200ResponseAnyOf1MessageEnum),
          ) as AuthChangePassword200ResponseAnyOf1MessageEnum;
          result.message = valueDes;
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
            specifiedType: const FullType(AuthChangePassword200ResponseAnyOf1TokenTypeEnum),
          ) as AuthChangePassword200ResponseAnyOf1TokenTypeEnum;
          result.tokenType = valueDes;
          break;
        case r'expires_in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthChangePassword200ResponseAnyOf1ExpiresInEnum),
          ) as AuthChangePassword200ResponseAnyOf1ExpiresInEnum;
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
  AuthChangePassword200ResponseAnyOf1 deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthChangePassword200ResponseAnyOf1Builder();
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

class AuthChangePassword200ResponseAnyOf1MessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Password updated')
  static const AuthChangePassword200ResponseAnyOf1MessageEnum passwordUpdated = _$authChangePassword200ResponseAnyOf1MessageEnum_passwordUpdated;

  static Serializer<AuthChangePassword200ResponseAnyOf1MessageEnum> get serializer => _$authChangePassword200ResponseAnyOf1MessageEnumSerializer;

  const AuthChangePassword200ResponseAnyOf1MessageEnum._(String name): super(name);

  static BuiltSet<AuthChangePassword200ResponseAnyOf1MessageEnum> get values => _$authChangePassword200ResponseAnyOf1MessageEnumValues;
  static AuthChangePassword200ResponseAnyOf1MessageEnum valueOf(String name) => _$authChangePassword200ResponseAnyOf1MessageEnumValueOf(name);
}

class AuthChangePassword200ResponseAnyOf1TokenTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Bearer')
  static const AuthChangePassword200ResponseAnyOf1TokenTypeEnum bearer = _$authChangePassword200ResponseAnyOf1TokenTypeEnum_bearer;

  static Serializer<AuthChangePassword200ResponseAnyOf1TokenTypeEnum> get serializer => _$authChangePassword200ResponseAnyOf1TokenTypeEnumSerializer;

  const AuthChangePassword200ResponseAnyOf1TokenTypeEnum._(String name): super(name);

  static BuiltSet<AuthChangePassword200ResponseAnyOf1TokenTypeEnum> get values => _$authChangePassword200ResponseAnyOf1TokenTypeEnumValues;
  static AuthChangePassword200ResponseAnyOf1TokenTypeEnum valueOf(String name) => _$authChangePassword200ResponseAnyOf1TokenTypeEnumValueOf(name);
}

class AuthChangePassword200ResponseAnyOf1ExpiresInEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 7200)
  static const AuthChangePassword200ResponseAnyOf1ExpiresInEnum number7200 = _$authChangePassword200ResponseAnyOf1ExpiresInEnum_number7200;

  static Serializer<AuthChangePassword200ResponseAnyOf1ExpiresInEnum> get serializer => _$authChangePassword200ResponseAnyOf1ExpiresInEnumSerializer;

  const AuthChangePassword200ResponseAnyOf1ExpiresInEnum._(String name): super(name);

  static BuiltSet<AuthChangePassword200ResponseAnyOf1ExpiresInEnum> get values => _$authChangePassword200ResponseAnyOf1ExpiresInEnumValues;
  static AuthChangePassword200ResponseAnyOf1ExpiresInEnum valueOf(String name) => _$authChangePassword200ResponseAnyOf1ExpiresInEnumValueOf(name);
}

