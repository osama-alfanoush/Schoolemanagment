//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_attach_to_assignment200_response_data.g.dart';

/// TeacherAttachToAssignment200ResponseData
///
/// Properties:
/// * [id] 
/// * [classRoomId] 
/// * [subjectId] 
/// * [title] 
/// * [instructions] 
/// * [dueAt] 
/// * [published] 
/// * [publishedAt] 
/// * [hasAttachment] 
@BuiltValue()
abstract class TeacherAttachToAssignment200ResponseData implements Built<TeacherAttachToAssignment200ResponseData, TeacherAttachToAssignment200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'class_room_id')
  int get classRoomId;

  @BuiltValueField(wireName: r'subject_id')
  int get subjectId;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'instructions')
  String get instructions;

  @BuiltValueField(wireName: r'due_at')
  String get dueAt;

  @BuiltValueField(wireName: r'published')
  bool get published;

  @BuiltValueField(wireName: r'published_at')
  String? get publishedAt;

  @BuiltValueField(wireName: r'has_attachment')
  bool get hasAttachment;

  TeacherAttachToAssignment200ResponseData._();

  factory TeacherAttachToAssignment200ResponseData([void updates(TeacherAttachToAssignment200ResponseDataBuilder b)]) = _$TeacherAttachToAssignment200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherAttachToAssignment200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherAttachToAssignment200ResponseData> get serializer => _$TeacherAttachToAssignment200ResponseDataSerializer();
}

class _$TeacherAttachToAssignment200ResponseDataSerializer implements PrimitiveSerializer<TeacherAttachToAssignment200ResponseData> {
  @override
  final Iterable<Type> types = const [TeacherAttachToAssignment200ResponseData, _$TeacherAttachToAssignment200ResponseData];

  @override
  final String wireName = r'TeacherAttachToAssignment200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherAttachToAssignment200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'class_room_id';
    yield serializers.serialize(
      object.classRoomId,
      specifiedType: const FullType(int),
    );
    yield r'subject_id';
    yield serializers.serialize(
      object.subjectId,
      specifiedType: const FullType(int),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'instructions';
    yield serializers.serialize(
      object.instructions,
      specifiedType: const FullType(String),
    );
    yield r'due_at';
    yield serializers.serialize(
      object.dueAt,
      specifiedType: const FullType(String),
    );
    yield r'published';
    yield serializers.serialize(
      object.published,
      specifiedType: const FullType(bool),
    );
    yield r'published_at';
    yield object.publishedAt == null ? null : serializers.serialize(
      object.publishedAt,
      specifiedType: const FullType.nullable(String),
    );
    yield r'has_attachment';
    yield serializers.serialize(
      object.hasAttachment,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherAttachToAssignment200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherAttachToAssignment200ResponseDataBuilder result,
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
        case r'class_room_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.classRoomId = valueDes;
          break;
        case r'subject_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.subjectId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'instructions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.instructions = valueDes;
          break;
        case r'due_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.dueAt = valueDes;
          break;
        case r'published':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.published = valueDes;
          break;
        case r'published_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.publishedAt = valueDes;
          break;
        case r'has_attachment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasAttachment = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherAttachToAssignment200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherAttachToAssignment200ResponseDataBuilder();
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

