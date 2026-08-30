//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_list_permissions200_response.g.dart';

/// AdminListPermissions200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class AdminListPermissions200Response implements Built<AdminListPermissions200Response, AdminListPermissions200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<BuiltList<String>> get data;

  AdminListPermissions200Response._();

  factory AdminListPermissions200Response([void updates(AdminListPermissions200ResponseBuilder b)]) = _$AdminListPermissions200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminListPermissions200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminListPermissions200Response> get serializer => _$AdminListPermissions200ResponseSerializer();
}

class _$AdminListPermissions200ResponseSerializer implements PrimitiveSerializer<AdminListPermissions200Response> {
  @override
  final Iterable<Type> types = const [AdminListPermissions200Response, _$AdminListPermissions200Response];

  @override
  final String wireName = r'AdminListPermissions200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminListPermissions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(BuiltList, [FullType(String)])]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminListPermissions200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminListPermissions200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(BuiltList, [FullType(String)])]),
          ) as BuiltList<BuiltList<String>>;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AdminListPermissions200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminListPermissions200ResponseBuilder();
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

