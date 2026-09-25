//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auth_refresh200_response_any_of.g.dart';

/// AuthRefresh200ResponseAnyOf
///
/// Properties:
/// * [tokenType] 
/// * [expiresIn] 
@BuiltValue()
abstract class AuthRefresh200ResponseAnyOf implements Built<AuthRefresh200ResponseAnyOf, AuthRefresh200ResponseAnyOfBuilder> {
  @BuiltValueField(wireName: r'token_type')
  AuthRefresh200ResponseAnyOfTokenTypeEnum get tokenType;
  // enum tokenTypeEnum {  Bearer,  };

  @BuiltValueField(wireName: r'expires_in')
  AuthRefresh200ResponseAnyOfExpiresInEnum get expiresIn;
  // enum expiresInEnum {  7200,  };

  AuthRefresh200ResponseAnyOf._();

  factory AuthRefresh200ResponseAnyOf([void updates(AuthRefresh200ResponseAnyOfBuilder b)]) = _$AuthRefresh200ResponseAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthRefresh200ResponseAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthRefresh200ResponseAnyOf> get serializer => _$AuthRefresh200ResponseAnyOfSerializer();
}

class _$AuthRefresh200ResponseAnyOfSerializer implements PrimitiveSerializer<AuthRefresh200ResponseAnyOf> {
  @override
  final Iterable<Type> types = const [AuthRefresh200ResponseAnyOf, _$AuthRefresh200ResponseAnyOf];

  @override
  final String wireName = r'AuthRefresh200ResponseAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthRefresh200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'token_type';
    yield serializers.serialize(
      object.tokenType,
      specifiedType: const FullType(AuthRefresh200ResponseAnyOfTokenTypeEnum),
    );
    yield r'expires_in';
    yield serializers.serialize(
      object.expiresIn,
      specifiedType: const FullType(AuthRefresh200ResponseAnyOfExpiresInEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthRefresh200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AuthRefresh200ResponseAnyOfBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthRefresh200ResponseAnyOfTokenTypeEnum),
          ) as AuthRefresh200ResponseAnyOfTokenTypeEnum;
          result.tokenType = valueDes;
          break;
        case r'expires_in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AuthRefresh200ResponseAnyOfExpiresInEnum),
          ) as AuthRefresh200ResponseAnyOfExpiresInEnum;
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
  AuthRefresh200ResponseAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthRefresh200ResponseAnyOfBuilder();
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

class AuthRefresh200ResponseAnyOfTokenTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Bearer')
  static const AuthRefresh200ResponseAnyOfTokenTypeEnum bearer = _$authRefresh200ResponseAnyOfTokenTypeEnum_bearer;

  static Serializer<AuthRefresh200ResponseAnyOfTokenTypeEnum> get serializer => _$authRefresh200ResponseAnyOfTokenTypeEnumSerializer;

  const AuthRefresh200ResponseAnyOfTokenTypeEnum._(String name): super(name);

  static BuiltSet<AuthRefresh200ResponseAnyOfTokenTypeEnum> get values => _$authRefresh200ResponseAnyOfTokenTypeEnumValues;
  static AuthRefresh200ResponseAnyOfTokenTypeEnum valueOf(String name) => _$authRefresh200ResponseAnyOfTokenTypeEnumValueOf(name);
}

class AuthRefresh200ResponseAnyOfExpiresInEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 7200)
  static const AuthRefresh200ResponseAnyOfExpiresInEnum number7200 = _$authRefresh200ResponseAnyOfExpiresInEnum_number7200;

  static Serializer<AuthRefresh200ResponseAnyOfExpiresInEnum> get serializer => _$authRefresh200ResponseAnyOfExpiresInEnumSerializer;

  const AuthRefresh200ResponseAnyOfExpiresInEnum._(String name): super(name);

  static BuiltSet<AuthRefresh200ResponseAnyOfExpiresInEnum> get values => _$authRefresh200ResponseAnyOfExpiresInEnumValues;
  static AuthRefresh200ResponseAnyOfExpiresInEnum valueOf(String name) => _$authRefresh200ResponseAnyOfExpiresInEnumValueOf(name);
}

