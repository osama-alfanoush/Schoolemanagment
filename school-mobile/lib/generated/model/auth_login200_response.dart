//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/auth_login200_response_any_of.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/auth_login200_response_any_of1.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'auth_login200_response.g.dart';

/// AuthLogin200Response
///
/// Properties:
/// * [tokenType] 
/// * [expiresIn] 
/// * [mustChangePassword] 
/// * [user] 
/// * [token] 
/// * [accessToken] - alias kept for backwards compatibility
/// * [refreshToken] 
@BuiltValue()
abstract class AuthLogin200Response implements Built<AuthLogin200Response, AuthLogin200ResponseBuilder> {
  /// Any Of [AuthLogin200ResponseAnyOf], [AuthLogin200ResponseAnyOf1]
  AnyOf get anyOf;

  AuthLogin200Response._();

  factory AuthLogin200Response([void updates(AuthLogin200ResponseBuilder b)]) = _$AuthLogin200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthLogin200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthLogin200Response> get serializer => _$AuthLogin200ResponseSerializer();
}

class _$AuthLogin200ResponseSerializer implements PrimitiveSerializer<AuthLogin200Response> {
  @override
  final Iterable<Type> types = const [AuthLogin200Response, _$AuthLogin200Response];

  @override
  final String wireName = r'AuthLogin200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthLogin200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthLogin200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  AuthLogin200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthLogin200ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(AuthLogin200ResponseAnyOf), FullType(AuthLogin200ResponseAnyOf1), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

class AuthLogin200ResponseTokenTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Bearer')
  static const AuthLogin200ResponseTokenTypeEnum bearer = _$authLogin200ResponseTokenTypeEnum_bearer;

  static Serializer<AuthLogin200ResponseTokenTypeEnum> get serializer => _$authLogin200ResponseTokenTypeEnumSerializer;

  const AuthLogin200ResponseTokenTypeEnum._(String name): super(name);

  static BuiltSet<AuthLogin200ResponseTokenTypeEnum> get values => _$authLogin200ResponseTokenTypeEnumValues;
  static AuthLogin200ResponseTokenTypeEnum valueOf(String name) => _$authLogin200ResponseTokenTypeEnumValueOf(name);
}

class AuthLogin200ResponseExpiresInEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 7200)
  static const AuthLogin200ResponseExpiresInEnum number7200 = _$authLogin200ResponseExpiresInEnum_number7200;

  static Serializer<AuthLogin200ResponseExpiresInEnum> get serializer => _$authLogin200ResponseExpiresInEnumSerializer;

  const AuthLogin200ResponseExpiresInEnum._(String name): super(name);

  static BuiltSet<AuthLogin200ResponseExpiresInEnum> get values => _$authLogin200ResponseExpiresInEnumValues;
  static AuthLogin200ResponseExpiresInEnum valueOf(String name) => _$authLogin200ResponseExpiresInEnumValueOf(name);
}

