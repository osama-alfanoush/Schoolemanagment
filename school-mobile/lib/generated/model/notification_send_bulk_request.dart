//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/notification_send_bulk_request_target.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_send_bulk_request.g.dart';

/// NotificationSendBulkRequest
///
/// Properties:
/// * [templateKey] 
/// * [templateData] 
/// * [target] 
@BuiltValue()
abstract class NotificationSendBulkRequest implements Built<NotificationSendBulkRequest, NotificationSendBulkRequestBuilder> {
  @BuiltValueField(wireName: r'template_key')
  String get templateKey;

  @BuiltValueField(wireName: r'template_data')
  BuiltList<String>? get templateData;

  @BuiltValueField(wireName: r'target')
  NotificationSendBulkRequestTarget get target;

  NotificationSendBulkRequest._();

  factory NotificationSendBulkRequest([void updates(NotificationSendBulkRequestBuilder b)]) = _$NotificationSendBulkRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationSendBulkRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationSendBulkRequest> get serializer => _$NotificationSendBulkRequestSerializer();
}

class _$NotificationSendBulkRequestSerializer implements PrimitiveSerializer<NotificationSendBulkRequest> {
  @override
  final Iterable<Type> types = const [NotificationSendBulkRequest, _$NotificationSendBulkRequest];

  @override
  final String wireName = r'NotificationSendBulkRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationSendBulkRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    yield r'target';
    yield serializers.serialize(
      object.target,
      specifiedType: const FullType(NotificationSendBulkRequestTarget),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationSendBulkRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationSendBulkRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
        case r'target':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NotificationSendBulkRequestTarget),
          ) as NotificationSendBulkRequestTarget;
          result.target.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationSendBulkRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationSendBulkRequestBuilder();
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

