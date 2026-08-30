//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_send_test_request.g.dart';

/// NotificationSendTestRequest
///
/// Properties:
/// * [userId] 
/// * [templateKey] 
/// * [templateData] 
@BuiltValue()
abstract class NotificationSendTestRequest implements Built<NotificationSendTestRequest, NotificationSendTestRequestBuilder> {
  @BuiltValueField(wireName: r'user_id')
  int get userId;

  @BuiltValueField(wireName: r'template_key')
  String get templateKey;

  @BuiltValueField(wireName: r'template_data')
  BuiltList<String>? get templateData;

  NotificationSendTestRequest._();

  factory NotificationSendTestRequest([void updates(NotificationSendTestRequestBuilder b)]) = _$NotificationSendTestRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationSendTestRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationSendTestRequest> get serializer => _$NotificationSendTestRequestSerializer();
}

class _$NotificationSendTestRequestSerializer implements PrimitiveSerializer<NotificationSendTestRequest> {
  @override
  final Iterable<Type> types = const [NotificationSendTestRequest, _$NotificationSendTestRequest];

  @override
  final String wireName = r'NotificationSendTestRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationSendTestRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'user_id';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(int),
    );
    yield r'template_key';
    yield serializers.serialize(
      object.templateKey,
      specifiedType: const FullType(String),
    );
    if (object.templateData != null) {
      yield r'template_data';
      yield serializers.serialize(
        object.templateData,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationSendTestRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationSendTestRequestBuilder result,
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
        case r'template_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.templateKey = valueDes;
          break;
        case r'template_data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.templateData.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationSendTestRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationSendTestRequestBuilder();
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

