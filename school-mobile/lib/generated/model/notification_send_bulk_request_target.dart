//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_send_bulk_request_target.g.dart';

/// NotificationSendBulkRequestTarget
///
/// Properties:
/// * [role] 
/// * [classRoomId] 
/// * [userIds] 
@BuiltValue()
abstract class NotificationSendBulkRequestTarget implements Built<NotificationSendBulkRequestTarget, NotificationSendBulkRequestTargetBuilder> {
  @BuiltValueField(wireName: r'role')
  String? get role;

  @BuiltValueField(wireName: r'class_room_id')
  int? get classRoomId;

  @BuiltValueField(wireName: r'user_ids')
  BuiltList<String>? get userIds;

  NotificationSendBulkRequestTarget._();

  factory NotificationSendBulkRequestTarget([void updates(NotificationSendBulkRequestTargetBuilder b)]) = _$NotificationSendBulkRequestTarget;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationSendBulkRequestTargetBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationSendBulkRequestTarget> get serializer => _$NotificationSendBulkRequestTargetSerializer();
}

class _$NotificationSendBulkRequestTargetSerializer implements PrimitiveSerializer<NotificationSendBulkRequestTarget> {
  @override
  final Iterable<Type> types = const [NotificationSendBulkRequestTarget, _$NotificationSendBulkRequestTarget];

  @override
  final String wireName = r'NotificationSendBulkRequestTarget';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationSendBulkRequestTarget object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.role != null) {
      yield r'role';
      yield serializers.serialize(
        object.role,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.classRoomId != null) {
      yield r'class_room_id';
      yield serializers.serialize(
        object.classRoomId,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.userIds != null) {
      yield r'user_ids';
      yield serializers.serialize(
        object.userIds,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationSendBulkRequestTarget object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationSendBulkRequestTargetBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.role = valueDes;
          break;
        case r'class_room_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.classRoomId = valueDes;
          break;
        case r'user_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.userIds.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationSendBulkRequestTarget deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationSendBulkRequestTargetBuilder();
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

