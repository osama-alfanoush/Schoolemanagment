//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_announce_request.g.dart';

/// TeacherAnnounceRequest
///
/// Properties:
/// * [classRoomId] 
/// * [title] 
/// * [body] 
@BuiltValue()
abstract class TeacherAnnounceRequest implements Built<TeacherAnnounceRequest, TeacherAnnounceRequestBuilder> {
  @BuiltValueField(wireName: r'class_room_id')
  int get classRoomId;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'body')
  String get body;

  TeacherAnnounceRequest._();

  factory TeacherAnnounceRequest([void updates(TeacherAnnounceRequestBuilder b)]) = _$TeacherAnnounceRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherAnnounceRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherAnnounceRequest> get serializer => _$TeacherAnnounceRequestSerializer();
}

class _$TeacherAnnounceRequestSerializer implements PrimitiveSerializer<TeacherAnnounceRequest> {
  @override
  final Iterable<Type> types = const [TeacherAnnounceRequest, _$TeacherAnnounceRequest];

  @override
  final String wireName = r'TeacherAnnounceRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherAnnounceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'class_room_id';
    yield serializers.serialize(
      object.classRoomId,
      specifiedType: const FullType(int),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'body';
    yield serializers.serialize(
      object.body,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherAnnounceRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherAnnounceRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'class_room_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.classRoomId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.body = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherAnnounceRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherAnnounceRequestBuilder();
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

