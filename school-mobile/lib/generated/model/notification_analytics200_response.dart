//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notification_analytics200_response.g.dart';

/// NotificationAnalytics200Response
///
/// Properties:
/// * [totalSent] 
/// * [totalRead] 
/// * [byType] 
/// * [byCategory] 
/// * [deliverySuccessRate] 
@BuiltValue()
abstract class NotificationAnalytics200Response implements Built<NotificationAnalytics200Response, NotificationAnalytics200ResponseBuilder> {
  @BuiltValueField(wireName: r'total_sent')
  int get totalSent;

  @BuiltValueField(wireName: r'total_read')
  int get totalRead;

  @BuiltValueField(wireName: r'by_type')
  BuiltMap<String, JsonObject?> get byType;

  @BuiltValueField(wireName: r'by_category')
  BuiltMap<String, JsonObject?> get byCategory;

  @BuiltValueField(wireName: r'delivery_success_rate')
  BuiltMap<String, JsonObject?> get deliverySuccessRate;

  NotificationAnalytics200Response._();

  factory NotificationAnalytics200Response([void updates(NotificationAnalytics200ResponseBuilder b)]) = _$NotificationAnalytics200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationAnalytics200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationAnalytics200Response> get serializer => _$NotificationAnalytics200ResponseSerializer();
}

class _$NotificationAnalytics200ResponseSerializer implements PrimitiveSerializer<NotificationAnalytics200Response> {
  @override
  final Iterable<Type> types = const [NotificationAnalytics200Response, _$NotificationAnalytics200Response];

  @override
  final String wireName = r'NotificationAnalytics200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationAnalytics200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'total_sent';
    yield serializers.serialize(
      object.totalSent,
      specifiedType: const FullType(int),
    );
    yield r'total_read';
    yield serializers.serialize(
      object.totalRead,
      specifiedType: const FullType(int),
    );
    yield r'by_type';
    yield serializers.serialize(
      object.byType,
      specifiedType: const FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
    );
    yield r'by_category';
    yield serializers.serialize(
      object.byCategory,
      specifiedType: const FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
    );
    yield r'delivery_success_rate';
    yield serializers.serialize(
      object.deliverySuccessRate,
      specifiedType: const FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationAnalytics200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationAnalytics200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'total_sent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalSent = valueDes;
          break;
        case r'total_read':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalRead = valueDes;
          break;
        case r'by_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
          ) as BuiltMap<String, JsonObject?>;
          result.byType.replace(valueDes);
          break;
        case r'by_category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
          ) as BuiltMap<String, JsonObject?>;
          result.byCategory.replace(valueDes);
          break;
        case r'delivery_success_rate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
          ) as BuiltMap<String, JsonObject?>;
          result.deliverySuccessRate.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationAnalytics200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationAnalytics200ResponseBuilder();
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

