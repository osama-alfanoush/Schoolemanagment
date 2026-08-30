//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_login200_response_any_of.g.dart';

/// AuthLogin200ResponseAnyOf
///
/// Properties:
/// * [tokenType] 
/// * [expiresIn] 
/// * [mustChangePassword] 
/// * [user] 
@BuiltValue()
abstract class AuthLogin200ResponseAnyOf implements Built<AuthLogin200ResponseAnyOf, AuthLogin200ResponseAnyOfBuilder> {
  @BuiltValueField(wireName: r'token_type')
  AuthLogin200ResponseAnyOfTokenTypeEnum get tokenType;
  // enum tokenTypeEnum {  Bearer,  };

  @BuiltValueField(wireName: r'expires_in')
  AuthLogin200ResponseAnyOfExpiresInEnum get expiresIn;
  // enum expiresInEnum {  7200,  };

  @BuiltValueField(wireName: r'must_change_password')
  bool get mustChangePassword;

  @BuiltValueField(wireName: r'user')
  JsonObject? get user;

  AuthLogin200ResponseAnyOf._();

  factory AuthLogin200ResponseAnyOf([void updates(AuthLogin200ResponseAnyOfBuilder b)]) = _$AuthLogin200ResponseAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthLogin200ResponseAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthLogin200ResponseAnyOf> get serializer => _$AuthLogin200ResponseAnyOfSerializer();
}

class _$AuthLogin200ResponseAnyOfSerializer implements PrimitiveSerializer<AuthLogin200ResponseAnyOf> {
  @override
  final Iterable<Type> types = const [AuthLogin200ResponseAnyOf, _$AuthLogin200ResponseAnyOf];

  @override
  final String wireName = r'AuthLogin200ResponseAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthLogin200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'token_type';
    yield serializers.serialize(
      object.tokenType,
      specifiedType: const FullType(AuthLogin200ResponseAnyOfTokenTypeEnum),
    );
    yield r'expires_in';
    yield serializers.serialize(
      object.expiresIn,
      specifiedType: const FullType(AuthLogin200ResponseAnyOfExpiresInEnum),
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
    AuthLogin200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthLogin200ResponseAnyOfBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthLogin200ResponseAnyOfTokenTypeEnum),
          ) as AuthLogin200ResponseAnyOfTokenTypeEnum;
          result.tokenType = valueDes;
          break;
        case r'expires_in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthLogin200ResponseAnyOfExpiresInEnum),
          ) as AuthLogin200ResponseAnyOfExpiresInEnum;
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
  AuthLogin200ResponseAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthLogin200ResponseAnyOfBuilder();
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

class AuthLogin200ResponseAnyOfTokenTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Bearer')
  static const AuthLogin200ResponseAnyOfTokenTypeEnum bearer = _$authLogin200ResponseAnyOfTokenTypeEnum_bearer;

  static Serializer<AuthLogin200ResponseAnyOfTokenTypeEnum> get serializer => _$authLogin200ResponseAnyOfTokenTypeEnumSerializer;

  const AuthLogin200ResponseAnyOfTokenTypeEnum._(String name): super(name);

  static BuiltSet<AuthLogin200ResponseAnyOfTokenTypeEnum> get values => _$authLogin200ResponseAnyOfTokenTypeEnumValues;
  static AuthLogin200ResponseAnyOfTokenTypeEnum valueOf(String name) => _$authLogin200ResponseAnyOfTokenTypeEnumValueOf(name);
}

class AuthLogin200ResponseAnyOfExpiresInEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 7200)
  static const AuthLogin200ResponseAnyOfExpiresInEnum number7200 = _$authLogin200ResponseAnyOfExpiresInEnum_number7200;

  static Serializer<AuthLogin200ResponseAnyOfExpiresInEnum> get serializer => _$authLogin200ResponseAnyOfExpiresInEnumSerializer;

  const AuthLogin200ResponseAnyOfExpiresInEnum._(String name): super(name);

  static BuiltSet<AuthLogin200ResponseAnyOfExpiresInEnum> get values => _$authLogin200ResponseAnyOfExpiresInEnumValues;
  static AuthLogin200ResponseAnyOfExpiresInEnum valueOf(String name) => _$authLogin200ResponseAnyOfExpiresInEnumValueOf(name);
}

