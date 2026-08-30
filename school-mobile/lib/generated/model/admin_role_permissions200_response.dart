//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_role_permissions200_response.g.dart';

/// AdminRolePermissions200Response
///
/// Properties:
/// * [role] 
/// * [keys] 
@BuiltValue()
abstract class AdminRolePermissions200Response implements Built<AdminRolePermissions200Response, AdminRolePermissions200ResponseBuilder> {
  @BuiltValueField(wireName: r'role')
  String get role;

  @BuiltValueField(wireName: r'keys')
  BuiltMap<String, JsonObject?> get keys;

  AdminRolePermissions200Response._();

  factory AdminRolePermissions200Response([void updates(AdminRolePermissions200ResponseBuilder b)]) = _$AdminRolePermissions200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminRolePermissions200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminRolePermissions200Response> get serializer => _$AdminRolePermissions200ResponseSerializer();
}

class _$AdminRolePermissions200ResponseSerializer implements PrimitiveSerializer<AdminRolePermissions200Response> {
  @override
  final Iterable<Type> types = const [AdminRolePermissions200Response, _$AdminRolePermissions200Response];

  @override
  final String wireName = r'AdminRolePermissions200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminRolePermissions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(String),
    );
    yield r'keys';
    yield serializers.serialize(
      object.keys,
      specifiedType: const FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminRolePermissions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminRolePermissions200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.role = valueDes;
          break;
        case r'keys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
          ) as BuiltMap<String, JsonObject?>;
          result.keys.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminRolePermissions200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminRolePermissions200ResponseBuilder();
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

