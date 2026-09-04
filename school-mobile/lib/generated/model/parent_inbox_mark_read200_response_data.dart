//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_mark_read200_response_data.g.dart';

/// ParentInboxMarkRead200ResponseData
///
/// Properties:
/// * [id] 
/// * [read] 
@BuiltValue()
abstract class ParentInboxMarkRead200ResponseData implements Built<ParentInboxMarkRead200ResponseData, ParentInboxMarkRead200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'read')
  bool get read;

  ParentInboxMarkRead200ResponseData._();

  factory ParentInboxMarkRead200ResponseData([void updates(ParentInboxMarkRead200ResponseDataBuilder b)]) = _$ParentInboxMarkRead200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxMarkRead200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxMarkRead200ResponseData> get serializer => _$ParentInboxMarkRead200ResponseDataSerializer();
}

class _$ParentInboxMarkRead200ResponseDataSerializer implements PrimitiveSerializer<ParentInboxMarkRead200ResponseData> {
  @override
  final Iterable<Type> types = const [ParentInboxMarkRead200ResponseData, _$ParentInboxMarkRead200ResponseData];

  @override
  final String wireName = r'ParentInboxMarkRead200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxMarkRead200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'read';
    yield serializers.serialize(
      object.read,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxMarkRead200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxMarkRead200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.id = valueDes;
          break;
        case r'read':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.read = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInboxMarkRead200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxMarkRead200ResponseDataBuilder();
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

