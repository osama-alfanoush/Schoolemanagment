//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_update_preferences_request.g.dart';

/// ParentInboxUpdatePreferencesRequest
///
/// Properties:
/// * [categories] 
/// * [pushEnabled] 
@BuiltValue()
abstract class ParentInboxUpdatePreferencesRequest implements Built<ParentInboxUpdatePreferencesRequest, ParentInboxUpdatePreferencesRequestBuilder> {
  @BuiltValueField(wireName: r'categories')
  BuiltList<bool>? get categories;

  @BuiltValueField(wireName: r'push_enabled')
  bool? get pushEnabled;

  ParentInboxUpdatePreferencesRequest._();

  factory ParentInboxUpdatePreferencesRequest([void updates(ParentInboxUpdatePreferencesRequestBuilder b)]) = _$ParentInboxUpdatePreferencesRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxUpdatePreferencesRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxUpdatePreferencesRequest> get serializer => _$ParentInboxUpdatePreferencesRequestSerializer();
}

class _$ParentInboxUpdatePreferencesRequestSerializer implements PrimitiveSerializer<ParentInboxUpdatePreferencesRequest> {
  @override
  final Iterable<Type> types = const [ParentInboxUpdatePreferencesRequest, _$ParentInboxUpdatePreferencesRequest];

  @override
  final String wireName = r'ParentInboxUpdatePreferencesRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxUpdatePreferencesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.categories != null) {
      yield r'categories';
      yield serializers.serialize(
        object.categories,
        specifiedType: const FullType.nullable(BuiltList, [FullType(bool)]),
      );
    }
    if (object.pushEnabled != null) {
      yield r'push_enabled';
      yield serializers.serialize(
        object.pushEnabled,
        specifiedType: const FullType.nullable(bool),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxUpdatePreferencesRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxUpdatePreferencesRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'categories':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BuiltList, [FullType(bool)]),
          ) as BuiltList<bool>?;
          if (valueDes == null) continue;
          result.categories.replace(valueDes);
          break;
        case r'push_enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.pushEnabled = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInboxUpdatePreferencesRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxUpdatePreferencesRequestBuilder();
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

