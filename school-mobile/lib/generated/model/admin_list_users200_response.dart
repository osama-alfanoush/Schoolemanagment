//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/admin_list_users200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_list_users200_response.g.dart';

/// AdminListUsers200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class AdminListUsers200Response implements Built<AdminListUsers200Response, AdminListUsers200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  AdminListUsers200ResponseData get data;

  AdminListUsers200Response._();

  factory AdminListUsers200Response([void updates(AdminListUsers200ResponseBuilder b)]) = _$AdminListUsers200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminListUsers200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminListUsers200Response> get serializer => _$AdminListUsers200ResponseSerializer();
}

class _$AdminListUsers200ResponseSerializer implements PrimitiveSerializer<AdminListUsers200Response> {
  @override
  final Iterable<Type> types = const [AdminListUsers200Response, _$AdminListUsers200Response];

  @override
  final String wireName = r'AdminListUsers200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminListUsers200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(AdminListUsers200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminListUsers200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminListUsers200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdminListUsers200ResponseData),
          ) as AdminListUsers200ResponseData;
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
  AdminListUsers200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminListUsers200ResponseBuilder();
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

