//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_inbox_reply201_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_reply201_response.g.dart';

/// ParentInboxReply201Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentInboxReply201Response implements Built<ParentInboxReply201Response, ParentInboxReply201ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ParentInboxReply201ResponseData get data;

  ParentInboxReply201Response._();

  factory ParentInboxReply201Response([void updates(ParentInboxReply201ResponseBuilder b)]) = _$ParentInboxReply201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxReply201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxReply201Response> get serializer => _$ParentInboxReply201ResponseSerializer();
}

class _$ParentInboxReply201ResponseSerializer implements PrimitiveSerializer<ParentInboxReply201Response> {
  @override
  final Iterable<Type> types = const [ParentInboxReply201Response, _$ParentInboxReply201Response];

  @override
  final String wireName = r'ParentInboxReply201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxReply201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ParentInboxReply201ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxReply201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxReply201ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentInboxReply201ResponseData),
          ) as ParentInboxReply201ResponseData;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInboxReply201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxReply201ResponseBuilder();
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

