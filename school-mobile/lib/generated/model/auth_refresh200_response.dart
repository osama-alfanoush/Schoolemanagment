//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/auth_refresh200_response_any_of1.dart';
import 'package:school_mobile/generated/model/auth_refresh200_response_any_of.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'auth_refresh200_response.g.dart';

/// AuthRefresh200Response
///
/// Properties:
/// * [tokenType] 
/// * [expiresIn] 
/// * [accessToken] 
/// * [refreshToken] 
@BuiltValue()
abstract class AuthRefresh200Response implements Built<AuthRefresh200Response, AuthRefresh200ResponseBuilder> {
  /// Any Of [AuthRefresh200ResponseAnyOf], [AuthRefresh200ResponseAnyOf1]
  AnyOf get anyOf;

  AuthRefresh200Response._();

  factory AuthRefresh200Response([void updates(AuthRefresh200ResponseBuilder b)]) = _$AuthRefresh200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthRefresh200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthRefresh200Response> get serializer => _$AuthRefresh200ResponseSerializer();
}

class _$AuthRefresh200ResponseSerializer implements PrimitiveSerializer<AuthRefresh200Response> {
  @override
  final Iterable<Type> types = const [AuthRefresh200Response, _$AuthRefresh200Response];

  @override
  final String wireName = r'AuthRefresh200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthRefresh200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthRefresh200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  AuthRefresh200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthRefresh200ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(AuthRefresh200ResponseAnyOf), FullType(AuthRefresh200ResponseAnyOf1), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

class AuthRefresh200ResponseTokenTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Bearer')
  static const AuthRefresh200ResponseTokenTypeEnum bearer = _$authRefresh200ResponseTokenTypeEnum_bearer;

  static Serializer<AuthRefresh200ResponseTokenTypeEnum> get serializer => _$authRefresh200ResponseTokenTypeEnumSerializer;

  const AuthRefresh200ResponseTokenTypeEnum._(String name): super(name);

  static BuiltSet<AuthRefresh200ResponseTokenTypeEnum> get values => _$authRefresh200ResponseTokenTypeEnumValues;
  static AuthRefresh200ResponseTokenTypeEnum valueOf(String name) => _$authRefresh200ResponseTokenTypeEnumValueOf(name);
}

class AuthRefresh200ResponseExpiresInEnum extends EnumClass {

  @BuiltValueEnumConst(wireNumber: 7200)
  static const AuthRefresh200ResponseExpiresInEnum number7200 = _$authRefresh200ResponseExpiresInEnum_number7200;

  static Serializer<AuthRefresh200ResponseExpiresInEnum> get serializer => _$authRefresh200ResponseExpiresInEnumSerializer;

  const AuthRefresh200ResponseExpiresInEnum._(String name): super(name);

  static BuiltSet<AuthRefresh200ResponseExpiresInEnum> get values => _$authRefresh200ResponseExpiresInEnumValues;
  static AuthRefresh200ResponseExpiresInEnum valueOf(String name) => _$authRefresh200ResponseExpiresInEnumValueOf(name);
}

