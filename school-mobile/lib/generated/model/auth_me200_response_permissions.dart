//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'auth_me200_response_permissions.g.dart';

/// Granular sub-module permissions so clients can gate UI. ['*'] for admin.
@BuiltValue()
abstract class AuthMe200ResponsePermissions implements Built<AuthMe200ResponsePermissions, AuthMe200ResponsePermissionsBuilder> {
  /// Any Of [BuiltList<JsonObject>]
  AnyOf get anyOf;

  AuthMe200ResponsePermissions._();

  factory AuthMe200ResponsePermissions([void updates(AuthMe200ResponsePermissionsBuilder b)]) = _$AuthMe200ResponsePermissions;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AuthMe200ResponsePermissionsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AuthMe200ResponsePermissions> get serializer => _$AuthMe200ResponsePermissionsSerializer();
}

class _$AuthMe200ResponsePermissionsSerializer implements PrimitiveSerializer<AuthMe200ResponsePermissions> {
  @override
  final Iterable<Type> types = const [AuthMe200ResponsePermissions, _$AuthMe200ResponsePermissions];

  @override
  final String wireName = r'AuthMe200ResponsePermissions';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AuthMe200ResponsePermissions object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    AuthMe200ResponsePermissions object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  AuthMe200ResponsePermissions deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AuthMe200ResponsePermissionsBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(BuiltList, [FullType.nullable(JsonObject)]), FullType(BuiltList, [FullType.nullable(JsonObject)]), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

