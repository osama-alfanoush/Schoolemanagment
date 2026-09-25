//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_inbox_notifications200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_notifications200_response.g.dart';

/// ParentInboxNotifications200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentInboxNotifications200Response implements Built<ParentInboxNotifications200Response, ParentInboxNotifications200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ParentInboxNotifications200ResponseData get data;

  ParentInboxNotifications200Response._();

  factory ParentInboxNotifications200Response([void updates(ParentInboxNotifications200ResponseBuilder b)]) = _$ParentInboxNotifications200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxNotifications200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxNotifications200Response> get serializer => _$ParentInboxNotifications200ResponseSerializer();
}

class _$ParentInboxNotifications200ResponseSerializer implements PrimitiveSerializer<ParentInboxNotifications200Response> {
  @override
  final Iterable<Type> types = const [ParentInboxNotifications200Response, _$ParentInboxNotifications200Response];

  @override
  final String wireName = r'ParentInboxNotifications200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxNotifications200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ParentInboxNotifications200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxNotifications200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxNotifications200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentInboxNotifications200ResponseData),
          ) as ParentInboxNotifications200ResponseData;
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
  ParentInboxNotifications200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxNotifications200ResponseBuilder();
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

