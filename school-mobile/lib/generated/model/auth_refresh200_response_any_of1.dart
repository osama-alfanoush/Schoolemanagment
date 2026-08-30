//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_refresh200_response_any_of1.g.dart';

/// AuthRefresh200ResponseAnyOf1
///
/// Properties:
/// * [accessToken] 
/// * [refreshToken] 
/// * [tokenType] 
/// * [expiresIn] 
@BuiltValue()
abstract class AuthRefresh200ResponseAnyOf1 implements Built<AuthRefresh200ResponseAnyOf1, AuthRefresh200ResponseAnyOf1Builder> {
  @BuiltValueField(wireName: r'access_token')
  String get accessToken;

  @BuiltValueField(wireName: r'refresh_token')
  String get refreshToken;

  @BuiltValueField(wireName: r'token_type')
  AuthRefresh200ResponseAnyOf1TokenTypeEnum get tokenType;
  // enum tokenTypeEnum {  Bearer,  };

  @BuiltValueField(wireName: r'expires_in')
  AuthRefresh200ResponseAnyOf1ExpiresInEnum get expiresIn;
  // enum expiresInEnum {  7200,  };

  AuthRefresh200ResponseAnyOf1._();

  factory AuthRefresh200ResponseAnyOf1([void updates(AuthRefresh200ResponseAnyOf1Builder b)]) = _$AuthRefresh200ResponseAnyOf1;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthRefresh200ResponseAnyOf1Builder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthRefresh200ResponseAnyOf1> get serializer => _$AuthRefresh200ResponseAnyOf1Serializer();
}

class _$AuthRefresh200ResponseAnyOf1Serializer implements PrimitiveSerializer<AuthRefresh200ResponseAnyOf1> {
  @override
  final Iterable<Type> types = const [AuthRefresh200ResponseAnyOf1, _$AuthRefresh200ResponseAnyOf1];

  @override
  final String wireName = r'AuthRefresh200ResponseAnyOf1';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthRefresh200ResponseAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
      specifiedType: const FullType(AuthRefresh200ResponseAnyOf1TokenTypeEnum),
    );
    yield r'expires_in';
    yield serializers.serialize(
      object.expiresIn,
      specifiedType: const FullType(AuthRefresh200ResponseAnyOf1ExpiresInEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthRefresh200ResponseAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthRefresh200ResponseAnyOf1Builder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(AuthRefresh200ResponseAnyOf1TokenTypeEnum),
          ) as AuthRefresh200ResponseAnyOf1TokenTypeEnum;
          result.tokenType = valueDes;
          break;
        case r'expires_in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthRefresh200ResponseAnyOf1ExpiresInEnum),
          ) as AuthRefresh200ResponseAnyOf1ExpiresInEnum;
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
  AuthRefresh200ResponseAnyOf1 deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthRefresh200ResponseAnyOf1Builder();
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

class AuthRefresh200ResponseAnyOf1TokenTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Bearer')
  static const AuthRefresh200ResponseAnyOf1TokenTypeEnum bearer = _$authRefresh200ResponseAnyOf1TokenTypeEnum_bearer;

  static Serializer<AuthRefresh200ResponseAnyOf1TokenTypeEnum> get serializer => _$authRefresh200ResponseAnyOf1TokenTypeEnumSerializer;

  const AuthRefresh200ResponseAnyOf1TokenTypeEnum._(String name): super(name);

  static BuiltSet<AuthRefresh200ResponseAnyOf1TokenTypeEnum> get values => _$authRefresh200ResponseAnyOf1TokenTypeEnumValues;
  static AuthRefresh200ResponseAnyOf1TokenTypeEnum valueOf(String name) => _$authRefresh200ResponseAnyOf1TokenTypeEnumValueOf(name);
}

class AuthRefresh200ResponseAnyOf1ExpiresInEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 7200)
  static const AuthRefresh200ResponseAnyOf1ExpiresInEnum number7200 = _$authRefresh200ResponseAnyOf1ExpiresInEnum_number7200;

  static Serializer<AuthRefresh200ResponseAnyOf1ExpiresInEnum> get serializer => _$authRefresh200ResponseAnyOf1ExpiresInEnumSerializer;

  const AuthRefresh200ResponseAnyOf1ExpiresInEnum._(String name): super(name);

  static BuiltSet<AuthRefresh200ResponseAnyOf1ExpiresInEnum> get values => _$authRefresh200ResponseAnyOf1ExpiresInEnumValues;
  static AuthRefresh200ResponseAnyOf1ExpiresInEnum valueOf(String name) => _$authRefresh200ResponseAnyOf1ExpiresInEnumValueOf(name);
}

