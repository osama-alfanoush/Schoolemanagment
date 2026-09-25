//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_reply201_response_data.g.dart';

/// ParentInboxReply201ResponseData
///
/// Properties:
/// * [id] 
/// * [body] 
/// * [sentAt] 
@BuiltValue()
abstract class ParentInboxReply201ResponseData implements Built<ParentInboxReply201ResponseData, ParentInboxReply201ResponseDataBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'body')
  String get body;

  @BuiltValueField(wireName: r'sent_at')
  String? get sentAt;

  ParentInboxReply201ResponseData._();

  factory ParentInboxReply201ResponseData([void updates(ParentInboxReply201ResponseDataBuilder b)]) = _$ParentInboxReply201ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxReply201ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxReply201ResponseData> get serializer => _$ParentInboxReply201ResponseDataSerializer();
}

class _$ParentInboxReply201ResponseDataSerializer implements PrimitiveSerializer<ParentInboxReply201ResponseData> {
  @override
  final Iterable<Type> types = const [ParentInboxReply201ResponseData, _$ParentInboxReply201ResponseData];

  @override
  final String wireName = r'ParentInboxReply201ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxReply201ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'body';
    yield serializers.serialize(
      object.body,
      specifiedType: const FullType(String),
    );
    yield r'sent_at';
    yield object.sentAt == null ? null : serializers.serialize(
      object.sentAt,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxReply201ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxReply201ResponseDataBuilder result,
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
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.body = valueDes;
          break;
        case r'sent_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.sentAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInboxReply201ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxReply201ResponseDataBuilder();
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

