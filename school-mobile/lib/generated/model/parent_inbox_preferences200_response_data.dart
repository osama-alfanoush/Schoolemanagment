//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_preferences200_response_data.g.dart';

/// ParentInboxPreferences200ResponseData
///
/// Properties:
/// * [pushEnabled] 
/// * [categories] 
/// * [alwaysOn] - Reported so the client can say why nothing arrived last night, but not mutable here.
/// * [quietHours] 
@BuiltValue()
abstract class ParentInboxPreferences200ResponseData implements Built<ParentInboxPreferences200ResponseData, ParentInboxPreferences200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'push_enabled')
  bool get pushEnabled;

  @BuiltValueField(wireName: r'categories')
  String get categories;

  /// Reported so the client can say why nothing arrived last night, but not mutable here.
  @BuiltValueField(wireName: r'always_on')
  BuiltList<JsonObject?> get alwaysOn;

  @BuiltValueField(wireName: r'quiet_hours')
  BuiltList<JsonObject?>? get quietHours;

  ParentInboxPreferences200ResponseData._();

  factory ParentInboxPreferences200ResponseData([void updates(ParentInboxPreferences200ResponseDataBuilder b)]) = _$ParentInboxPreferences200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxPreferences200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxPreferences200ResponseData> get serializer => _$ParentInboxPreferences200ResponseDataSerializer();
}

class _$ParentInboxPreferences200ResponseDataSerializer implements PrimitiveSerializer<ParentInboxPreferences200ResponseData> {
  @override
  final Iterable<Type> types = const [ParentInboxPreferences200ResponseData, _$ParentInboxPreferences200ResponseData];

  @override
  final String wireName = r'ParentInboxPreferences200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxPreferences200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'push_enabled';
    yield serializers.serialize(
      object.pushEnabled,
      specifiedType: const FullType(bool),
    );
    yield r'categories';
    yield serializers.serialize(
      object.categories,
      specifiedType: const FullType(String),
    );
    yield r'always_on';
    yield serializers.serialize(
      object.alwaysOn,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
    yield r'quiet_hours';
    yield object.quietHours == null ? null : serializers.serialize(
      object.quietHours,
      specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxPreferences200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxPreferences200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'push_enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.pushEnabled = valueDes;
          break;
        case r'categories':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.categories = valueDes;
          break;
        case r'always_on':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.alwaysOn.replace(valueDes);
          break;
        case r'quiet_hours':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>?;
          if (valueDes == null) continue;
          result.quietHours.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInboxPreferences200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxPreferences200ResponseDataBuilder();
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

