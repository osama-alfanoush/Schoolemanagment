//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'admin_user_permissions200_response_role_keys.g.dart';

/// AdminUserPermissions200ResponseRoleKeys
@BuiltValue()
abstract class AdminUserPermissions200ResponseRoleKeys implements Built<AdminUserPermissions200ResponseRoleKeys, AdminUserPermissions200ResponseRoleKeysBuilder> {
  /// Any Of [BuiltList<JsonObject>], [BuiltMap<String, JsonObject>]
  AnyOf get anyOf;

  AdminUserPermissions200ResponseRoleKeys._();

  factory AdminUserPermissions200ResponseRoleKeys([void updates(AdminUserPermissions200ResponseRoleKeysBuilder b)]) = _$AdminUserPermissions200ResponseRoleKeys;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminUserPermissions200ResponseRoleKeysBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminUserPermissions200ResponseRoleKeys> get serializer => _$AdminUserPermissions200ResponseRoleKeysSerializer();
}

class _$AdminUserPermissions200ResponseRoleKeysSerializer implements PrimitiveSerializer<AdminUserPermissions200ResponseRoleKeys> {
  @override
  final Iterable<Type> types = const [AdminUserPermissions200ResponseRoleKeys, _$AdminUserPermissions200ResponseRoleKeys];

  @override
  final String wireName = r'AdminUserPermissions200ResponseRoleKeys';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminUserPermissions200ResponseRoleKeys object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminUserPermissions200ResponseRoleKeys object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  AdminUserPermissions200ResponseRoleKeys deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminUserPermissions200ResponseRoleKeysBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(BuiltList, [FullType.nullable(JsonObject)]), FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)]), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

