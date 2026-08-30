//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/auth_change_password200_response_any_of.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/auth_change_password200_response_any_of1.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'auth_change_password200_response.g.dart';

/// AuthChangePassword200Response
///
/// Properties:
/// * [message] 
/// * [tokenType] 
/// * [expiresIn] 
/// * [accessToken] 
/// * [refreshToken] 
@BuiltValue()
abstract class AuthChangePassword200Response implements Built<AuthChangePassword200Response, AuthChangePassword200ResponseBuilder> {
  /// Any Of [AuthChangePassword200ResponseAnyOf], [AuthChangePassword200ResponseAnyOf1]
  AnyOf get anyOf;

  AuthChangePassword200Response._();

  factory AuthChangePassword200Response([void updates(AuthChangePassword200ResponseBuilder b)]) = _$AuthChangePassword200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthChangePassword200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthChangePassword200Response> get serializer => _$AuthChangePassword200ResponseSerializer();
}

class _$AuthChangePassword200ResponseSerializer implements PrimitiveSerializer<AuthChangePassword200Response> {
  @override
  final Iterable<Type> types = const [AuthChangePassword200Response, _$AuthChangePassword200Response];

  @override
  final String wireName = r'AuthChangePassword200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthChangePassword200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthChangePassword200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  AuthChangePassword200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthChangePassword200ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(AuthChangePassword200ResponseAnyOf), FullType(AuthChangePassword200ResponseAnyOf1), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

class AuthChangePassword200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Password updated')
  static const AuthChangePassword200ResponseMessageEnum passwordUpdated = _$authChangePassword200ResponseMessageEnum_passwordUpdated;

  static Serializer<AuthChangePassword200ResponseMessageEnum> get serializer => _$authChangePassword200ResponseMessageEnumSerializer;

  const AuthChangePassword200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<AuthChangePassword200ResponseMessageEnum> get values => _$authChangePassword200ResponseMessageEnumValues;
  static AuthChangePassword200ResponseMessageEnum valueOf(String name) => _$authChangePassword200ResponseMessageEnumValueOf(name);
}

class AuthChangePassword200ResponseTokenTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Bearer')
  static const AuthChangePassword200ResponseTokenTypeEnum bearer = _$authChangePassword200ResponseTokenTypeEnum_bearer;

  static Serializer<AuthChangePassword200ResponseTokenTypeEnum> get serializer => _$authChangePassword200ResponseTokenTypeEnumSerializer;

  const AuthChangePassword200ResponseTokenTypeEnum._(String name): super(name);

  static BuiltSet<AuthChangePassword200ResponseTokenTypeEnum> get values => _$authChangePassword200ResponseTokenTypeEnumValues;
  static AuthChangePassword200ResponseTokenTypeEnum valueOf(String name) => _$authChangePassword200ResponseTokenTypeEnumValueOf(name);
}

class AuthChangePassword200ResponseExpiresInEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 7200)
  static const AuthChangePassword200ResponseExpiresInEnum number7200 = _$authChangePassword200ResponseExpiresInEnum_number7200;

  static Serializer<AuthChangePassword200ResponseExpiresInEnum> get serializer => _$authChangePassword200ResponseExpiresInEnumSerializer;

  const AuthChangePassword200ResponseExpiresInEnum._(String name): super(name);

  static BuiltSet<AuthChangePassword200ResponseExpiresInEnum> get values => _$authChangePassword200ResponseExpiresInEnumValues;
  static AuthChangePassword200ResponseExpiresInEnum valueOf(String name) => _$authChangePassword200ResponseExpiresInEnumValueOf(name);
}

