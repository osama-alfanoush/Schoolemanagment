//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/admin_user_permissions200_response_role_keys.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/admin_user_permissions200_response_effective.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_user_permissions200_response.g.dart';

/// AdminUserPermissions200Response
///
/// Properties:
/// * [userId] 
/// * [role] 
/// * [roleKeys] 
/// * [grants] 
/// * [denies] 
/// * [effective] 
@BuiltValue()
abstract class AdminUserPermissions200Response implements Built<AdminUserPermissions200Response, AdminUserPermissions200ResponseBuilder> {
  @BuiltValueField(wireName: r'user_id')
  int get userId;

  @BuiltValueField(wireName: r'role')
  String get role;

  @BuiltValueField(wireName: r'role_keys')
  AdminUserPermissions200ResponseRoleKeys get roleKeys;

  @BuiltValueField(wireName: r'grants')
  BuiltList<JsonObject?> get grants;

  @BuiltValueField(wireName: r'denies')
  BuiltList<JsonObject?> get denies;

  @BuiltValueField(wireName: r'effective')
  AdminUserPermissions200ResponseEffective get effective;

  AdminUserPermissions200Response._();

  factory AdminUserPermissions200Response([void updates(AdminUserPermissions200ResponseBuilder b)]) = _$AdminUserPermissions200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminUserPermissions200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminUserPermissions200Response> get serializer => _$AdminUserPermissions200ResponseSerializer();
}

class _$AdminUserPermissions200ResponseSerializer implements PrimitiveSerializer<AdminUserPermissions200Response> {
  @override
  final Iterable<Type> types = const [AdminUserPermissions200Response, _$AdminUserPermissions200Response];

  @override
  final String wireName = r'AdminUserPermissions200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminUserPermissions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'user_id';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(String),
    );
    yield r'role_keys';
    yield serializers.serialize(
      object.roleKeys,
      specifiedType: const FullType(AdminUserPermissions200ResponseRoleKeys),
    );
    yield r'grants';
    yield serializers.serialize(
      object.grants,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'denies';
    yield serializers.serialize(
      object.denies,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'effective';
    yield serializers.serialize(
      object.effective,
      specifiedType: const FullType(AdminUserPermissions200ResponseEffective),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminUserPermissions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminUserPermissions200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.userId = valueDes;
          break;
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.role = valueDes;
          break;
        case r'role_keys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdminUserPermissions200ResponseRoleKeys),
          ) as AdminUserPermissions200ResponseRoleKeys;
          result.roleKeys.replace(valueDes);
          break;
        case r'grants':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.grants.replace(valueDes);
          break;
        case r'denies':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.denies.replace(valueDes);
          break;
        case r'effective':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdminUserPermissions200ResponseEffective),
          ) as AdminUserPermissions200ResponseEffective;
          result.effective.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminUserPermissions200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminUserPermissions200ResponseBuilder();
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

