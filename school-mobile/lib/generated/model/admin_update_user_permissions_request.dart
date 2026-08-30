//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_update_user_permissions_request.g.dart';

/// AdminUpdateUserPermissionsRequest
///
/// Properties:
/// * [grants] 
/// * [denies] 
@BuiltValue()
abstract class AdminUpdateUserPermissionsRequest implements Built<AdminUpdateUserPermissionsRequest, AdminUpdateUserPermissionsRequestBuilder> {
  @BuiltValueField(wireName: r'grants')
  BuiltList<String> get grants;

  @BuiltValueField(wireName: r'denies')
  BuiltList<String> get denies;

  AdminUpdateUserPermissionsRequest._();

  factory AdminUpdateUserPermissionsRequest([void updates(AdminUpdateUserPermissionsRequestBuilder b)]) = _$AdminUpdateUserPermissionsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminUpdateUserPermissionsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminUpdateUserPermissionsRequest> get serializer => _$AdminUpdateUserPermissionsRequestSerializer();
}

class _$AdminUpdateUserPermissionsRequestSerializer implements PrimitiveSerializer<AdminUpdateUserPermissionsRequest> {
  @override
  final Iterable<Type> types = const [AdminUpdateUserPermissionsRequest, _$AdminUpdateUserPermissionsRequest];

  @override
  final String wireName = r'AdminUpdateUserPermissionsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminUpdateUserPermissionsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'grants';
    yield serializers.serialize(
      object.grants,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'denies';
    yield serializers.serialize(
      object.denies,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminUpdateUserPermissionsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminUpdateUserPermissionsRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'grants':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.grants.replace(valueDes);
          break;
        case r'denies':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.denies.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminUpdateUserPermissionsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminUpdateUserPermissionsRequestBuilder();
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

