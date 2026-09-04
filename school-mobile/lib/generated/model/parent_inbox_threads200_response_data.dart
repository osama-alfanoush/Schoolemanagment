//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_threads200_response_data.g.dart';

/// ParentInboxThreads200ResponseData
///
/// Properties:
/// * [threads] 
@BuiltValue()
abstract class ParentInboxThreads200ResponseData implements Built<ParentInboxThreads200ResponseData, ParentInboxThreads200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'threads')
  BuiltList<JsonObject?> get threads;

  ParentInboxThreads200ResponseData._();

  factory ParentInboxThreads200ResponseData([void updates(ParentInboxThreads200ResponseDataBuilder b)]) = _$ParentInboxThreads200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxThreads200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxThreads200ResponseData> get serializer => _$ParentInboxThreads200ResponseDataSerializer();
}

class _$ParentInboxThreads200ResponseDataSerializer implements PrimitiveSerializer<ParentInboxThreads200ResponseData> {
  @override
  final Iterable<Type> types = const [ParentInboxThreads200ResponseData, _$ParentInboxThreads200ResponseData];

  @override
  final String wireName = r'ParentInboxThreads200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxThreads200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'threads';
    yield serializers.serialize(
      object.threads,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxThreads200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxThreads200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'threads':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.threads.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInboxThreads200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxThreads200ResponseDataBuilder();
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

