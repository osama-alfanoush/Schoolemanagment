//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'assignment.g.dart';

/// Assignment
///
/// Properties:
/// * [id] 
/// * [teacherUserId] 
/// * [classRoomId] 
/// * [subjectId] 
/// * [title] 
/// * [instructions] 
/// * [attachmentPath] 
/// * [dueAt] 
/// * [maxScore] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
/// * [publishedAt] 
/// * [idempotencyKey] 
@BuiltValue()
abstract class Assignment implements Built<Assignment, AssignmentBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'teacher_user_id')
  int get teacherUserId;

  @BuiltValueField(wireName: r'class_room_id')
  int get classRoomId;

  @BuiltValueField(wireName: r'subject_id')
  int get subjectId;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'instructions')
  String get instructions;

  @BuiltValueField(wireName: r'attachment_path')
  String? get attachmentPath;

  @BuiltValueField(wireName: r'due_at')
  DateTime get dueAt;

  @BuiltValueField(wireName: r'max_score')
  String get maxScore;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  @BuiltValueField(wireName: r'published_at')
  DateTime? get publishedAt;

  @BuiltValueField(wireName: r'idempotency_key')
  String? get idempotencyKey;

  Assignment._();

  factory Assignment([void updates(AssignmentBuilder b)]) = _$Assignment;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AssignmentBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Assignment> get serializer => _$AssignmentSerializer();
}

class _$AssignmentSerializer implements PrimitiveSerializer<Assignment> {
  @override
  final Iterable<Type> types = const [Assignment, _$Assignment];

  @override
  final String wireName = r'Assignment';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Assignment object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'teacher_user_id';
    yield serializers.serialize(
      object.teacherUserId,
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
    yield r'attachment_path';
    yield object.attachmentPath == null ? null : serializers.serialize(
      object.attachmentPath,
      specifiedType: const FullType.nullable(String),
    );
    yield r'due_at';
    yield serializers.serialize(
      object.dueAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'max_score';
    yield serializers.serialize(
      object.maxScore,
      specifiedType: const FullType(String),
    );
    yield r'created_at';
    yield object.createdAt == null ? null : serializers.serialize(
      object.createdAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'updated_at';
    yield object.updatedAt == null ? null : serializers.serialize(
      object.updatedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
    yield r'published_at';
    yield object.publishedAt == null ? null : serializers.serialize(
      object.publishedAt,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'idempotency_key';
    yield object.idempotencyKey == null ? null : serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Assignment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AssignmentBuilder result,
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
        case r'teacher_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.teacherUserId = valueDes;
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
        case r'attachment_path':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.attachmentPath = valueDes;
          break;
        case r'due_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.dueAt = valueDes;
          break;
        case r'max_score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.maxScore = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.createdAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
          break;
        case r'published_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.publishedAt = valueDes;
          break;
        case r'idempotency_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.idempotencyKey = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Assignment deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AssignmentBuilder();
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

