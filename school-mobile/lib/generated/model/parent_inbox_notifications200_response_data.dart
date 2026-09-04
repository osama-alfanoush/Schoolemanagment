//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_notifications200_response_data.g.dart';

/// ParentInboxNotifications200ResponseData
///
/// Properties:
/// * [unreadCount] 
/// * [notifications] 
@BuiltValue()
abstract class ParentInboxNotifications200ResponseData implements Built<ParentInboxNotifications200ResponseData, ParentInboxNotifications200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'unread_count')
  int get unreadCount;

  @BuiltValueField(wireName: r'notifications')
  BuiltList<String> get notifications;

  ParentInboxNotifications200ResponseData._();

  factory ParentInboxNotifications200ResponseData([void updates(ParentInboxNotifications200ResponseDataBuilder b)]) = _$ParentInboxNotifications200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxNotifications200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxNotifications200ResponseData> get serializer => _$ParentInboxNotifications200ResponseDataSerializer();
}

class _$ParentInboxNotifications200ResponseDataSerializer implements PrimitiveSerializer<ParentInboxNotifications200ResponseData> {
  @override
  final Iterable<Type> types = const [ParentInboxNotifications200ResponseData, _$ParentInboxNotifications200ResponseData];

  @override
  final String wireName = r'ParentInboxNotifications200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxNotifications200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'unread_count';
    yield serializers.serialize(
      object.unreadCount,
      specifiedType: const FullType(int),
    );
    yield r'notifications';
    yield serializers.serialize(
      object.notifications,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxNotifications200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxNotifications200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'unread_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unreadCount = valueDes;
          break;
        case r'notifications':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.notifications.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInboxNotifications200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxNotifications200ResponseDataBuilder();
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

