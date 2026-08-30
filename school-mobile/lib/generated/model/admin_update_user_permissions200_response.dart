//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/admin_user_permissions200_response_effective.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_update_user_permissions200_response.g.dart';

/// AdminUpdateUserPermissions200Response
///
/// Properties:
/// * [userId] 
/// * [permissions] 
@BuiltValue()
abstract class AdminUpdateUserPermissions200Response implements Built<AdminUpdateUserPermissions200Response, AdminUpdateUserPermissions200ResponseBuilder> {
  @BuiltValueField(wireName: r'user_id')
  int get userId;

  @BuiltValueField(wireName: r'permissions')
  AdminUserPermissions200ResponseEffective get permissions;

  AdminUpdateUserPermissions200Response._();

  factory AdminUpdateUserPermissions200Response([void updates(AdminUpdateUserPermissions200ResponseBuilder b)]) = _$AdminUpdateUserPermissions200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminUpdateUserPermissions200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminUpdateUserPermissions200Response> get serializer => _$AdminUpdateUserPermissions200ResponseSerializer();
}

class _$AdminUpdateUserPermissions200ResponseSerializer implements PrimitiveSerializer<AdminUpdateUserPermissions200Response> {
  @override
  final Iterable<Type> types = const [AdminUpdateUserPermissions200Response, _$AdminUpdateUserPermissions200Response];

  @override
  final String wireName = r'AdminUpdateUserPermissions200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminUpdateUserPermissions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'user_id';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
    yield r'permissions';
    yield serializers.serialize(
      object.permissions,
      specifiedType: const FullType(AdminUserPermissions200ResponseEffective),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminUpdateUserPermissions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminUpdateUserPermissions200ResponseBuilder result,
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
        case r'permissions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdminUserPermissions200ResponseEffective),
          ) as AdminUserPermissions200ResponseEffective;
          result.permissions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminUpdateUserPermissions200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminUpdateUserPermissions200ResponseBuilder();
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

