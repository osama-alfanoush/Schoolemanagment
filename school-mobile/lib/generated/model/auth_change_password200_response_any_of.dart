//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_change_password200_response_any_of.g.dart';

/// AuthChangePassword200ResponseAnyOf
///
/// Properties:
/// * [message] 
/// * [tokenType] 
/// * [expiresIn] 
@BuiltValue()
abstract class AuthChangePassword200ResponseAnyOf implements Built<AuthChangePassword200ResponseAnyOf, AuthChangePassword200ResponseAnyOfBuilder> {
  @BuiltValueField(wireName: r'message')
  AuthChangePassword200ResponseAnyOfMessageEnum get message;
  // enum messageEnum {  Password updated,  };

  @BuiltValueField(wireName: r'token_type')
  AuthChangePassword200ResponseAnyOfTokenTypeEnum get tokenType;
  // enum tokenTypeEnum {  Bearer,  };

  @BuiltValueField(wireName: r'expires_in')
  AuthChangePassword200ResponseAnyOfExpiresInEnum get expiresIn;
  // enum expiresInEnum {  7200,  };

  AuthChangePassword200ResponseAnyOf._();

  factory AuthChangePassword200ResponseAnyOf([void updates(AuthChangePassword200ResponseAnyOfBuilder b)]) = _$AuthChangePassword200ResponseAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthChangePassword200ResponseAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthChangePassword200ResponseAnyOf> get serializer => _$AuthChangePassword200ResponseAnyOfSerializer();
}

class _$AuthChangePassword200ResponseAnyOfSerializer implements PrimitiveSerializer<AuthChangePassword200ResponseAnyOf> {
  @override
  final Iterable<Type> types = const [AuthChangePassword200ResponseAnyOf, _$AuthChangePassword200ResponseAnyOf];

  @override
  final String wireName = r'AuthChangePassword200ResponseAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthChangePassword200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(AuthChangePassword200ResponseAnyOfMessageEnum),
    );
    yield r'token_type';
    yield serializers.serialize(
      object.tokenType,
      specifiedType: const FullType(AuthChangePassword200ResponseAnyOfTokenTypeEnum),
    );
    yield r'expires_in';
    yield serializers.serialize(
      object.expiresIn,
      specifiedType: const FullType(AuthChangePassword200ResponseAnyOfExpiresInEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthChangePassword200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthChangePassword200ResponseAnyOfBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthChangePassword200ResponseAnyOfMessageEnum),
          ) as AuthChangePassword200ResponseAnyOfMessageEnum;
          result.message = valueDes;
          break;
        case r'token_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthChangePassword200ResponseAnyOfTokenTypeEnum),
          ) as AuthChangePassword200ResponseAnyOfTokenTypeEnum;
          result.tokenType = valueDes;
          break;
        case r'expires_in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthChangePassword200ResponseAnyOfExpiresInEnum),
          ) as AuthChangePassword200ResponseAnyOfExpiresInEnum;
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
  AuthChangePassword200ResponseAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthChangePassword200ResponseAnyOfBuilder();
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

class AuthChangePassword200ResponseAnyOfMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Password updated')
  static const AuthChangePassword200ResponseAnyOfMessageEnum passwordUpdated = _$authChangePassword200ResponseAnyOfMessageEnum_passwordUpdated;

  static Serializer<AuthChangePassword200ResponseAnyOfMessageEnum> get serializer => _$authChangePassword200ResponseAnyOfMessageEnumSerializer;

  const AuthChangePassword200ResponseAnyOfMessageEnum._(String name): super(name);

  static BuiltSet<AuthChangePassword200ResponseAnyOfMessageEnum> get values => _$authChangePassword200ResponseAnyOfMessageEnumValues;
  static AuthChangePassword200ResponseAnyOfMessageEnum valueOf(String name) => _$authChangePassword200ResponseAnyOfMessageEnumValueOf(name);
}

class AuthChangePassword200ResponseAnyOfTokenTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Bearer')
  static const AuthChangePassword200ResponseAnyOfTokenTypeEnum bearer = _$authChangePassword200ResponseAnyOfTokenTypeEnum_bearer;

  static Serializer<AuthChangePassword200ResponseAnyOfTokenTypeEnum> get serializer => _$authChangePassword200ResponseAnyOfTokenTypeEnumSerializer;

  const AuthChangePassword200ResponseAnyOfTokenTypeEnum._(String name): super(name);

  static BuiltSet<AuthChangePassword200ResponseAnyOfTokenTypeEnum> get values => _$authChangePassword200ResponseAnyOfTokenTypeEnumValues;
  static AuthChangePassword200ResponseAnyOfTokenTypeEnum valueOf(String name) => _$authChangePassword200ResponseAnyOfTokenTypeEnumValueOf(name);
}

class AuthChangePassword200ResponseAnyOfExpiresInEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 7200)
  static const AuthChangePassword200ResponseAnyOfExpiresInEnum number7200 = _$authChangePassword200ResponseAnyOfExpiresInEnum_number7200;

  static Serializer<AuthChangePassword200ResponseAnyOfExpiresInEnum> get serializer => _$authChangePassword200ResponseAnyOfExpiresInEnumSerializer;

  const AuthChangePassword200ResponseAnyOfExpiresInEnum._(String name): super(name);

  static BuiltSet<AuthChangePassword200ResponseAnyOfExpiresInEnum> get values => _$authChangePassword200ResponseAnyOfExpiresInEnumValues;
  static AuthChangePassword200ResponseAnyOfExpiresInEnum valueOf(String name) => _$authChangePassword200ResponseAnyOfExpiresInEnumValueOf(name);
}

