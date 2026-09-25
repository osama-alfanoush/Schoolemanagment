//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_update_role_permissions_request.g.dart';

/// AdminUpdateRolePermissionsRequest
///
/// Properties:
/// * [keys] 
@BuiltValue()
abstract class AdminUpdateRolePermissionsRequest implements Built<AdminUpdateRolePermissionsRequest, AdminUpdateRolePermissionsRequestBuilder> {
  @BuiltValueField(wireName: r'keys')
  BuiltList<String> get keys;

  AdminUpdateRolePermissionsRequest._();

  factory AdminUpdateRolePermissionsRequest([void updates(AdminUpdateRolePermissionsRequestBuilder b)]) = _$AdminUpdateRolePermissionsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminUpdateRolePermissionsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminUpdateRolePermissionsRequest> get serializer => _$AdminUpdateRolePermissionsRequestSerializer();
}

class _$AdminUpdateRolePermissionsRequestSerializer implements PrimitiveSerializer<AdminUpdateRolePermissionsRequest> {
  @override
  final Iterable<Type> types = const [AdminUpdateRolePermissionsRequest, _$AdminUpdateRolePermissionsRequest];

  @override
  final String wireName = r'AdminUpdateRolePermissionsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminUpdateRolePermissionsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'keys';
    yield serializers.serialize(
      object.keys,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminUpdateRolePermissionsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminUpdateRolePermissionsRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'keys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
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
  AdminUpdateRolePermissionsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminUpdateRolePermissionsRequestBuilder();
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

