//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'class_room.g.dart';

/// ClassRoom
///
/// Properties:
/// * [id] 
/// * [name] 
/// * [grade] 
/// * [section] 
/// * [capacity] 
/// * [academicYearId] 
/// * [homeroomTeacherId] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
/// * [archivedAt] 
/// * [archivedBy] 
/// * [archiveReason] 
@BuiltValue()
abstract class ClassRoom implements Built<ClassRoom, ClassRoomBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'grade')
  String get grade;

  @BuiltValueField(wireName: r'section')
  String? get section;

  @BuiltValueField(wireName: r'capacity')
  int get capacity;

  @BuiltValueField(wireName: r'academic_year_id')
  int? get academicYearId;

  @BuiltValueField(wireName: r'homeroom_teacher_id')
  int? get homeroomTeacherId;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  @BuiltValueField(wireName: r'archived_at')
  String? get archivedAt;

  @BuiltValueField(wireName: r'archived_by')
  int? get archivedBy;

  @BuiltValueField(wireName: r'archive_reason')
  String? get archiveReason;

  ClassRoom._();

  factory ClassRoom([void updates(ClassRoomBuilder b)]) = _$ClassRoom;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ClassRoomBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ClassRoom> get serializer => _$ClassRoomSerializer();
}

class _$ClassRoomSerializer implements PrimitiveSerializer<ClassRoom> {
  @override
  final Iterable<Type> types = const [ClassRoom, _$ClassRoom];

  @override
  final String wireName = r'ClassRoom';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ClassRoom object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'grade';
    yield serializers.serialize(
      object.grade,
      specifiedType: const FullType(String),
    );
    yield r'section';
    yield object.section == null ? null : serializers.serialize(
      object.section,
      specifiedType: const FullType.nullable(String),
    );
    yield r'capacity';
    yield serializers.serialize(
      object.capacity,
      specifiedType: const FullType(int),
    );
    yield r'academic_year_id';
    yield object.academicYearId == null ? null : serializers.serialize(
      object.academicYearId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'homeroom_teacher_id';
    yield object.homeroomTeacherId == null ? null : serializers.serialize(
      object.homeroomTeacherId,
      specifiedType: const FullType.nullable(int),
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
    yield r'archived_at';
    yield object.archivedAt == null ? null : serializers.serialize(
      object.archivedAt,
      specifiedType: const FullType.nullable(String),
    );
    yield r'archived_by';
    yield object.archivedBy == null ? null : serializers.serialize(
      object.archivedBy,
      specifiedType: const FullType.nullable(int),
    );
    yield r'archive_reason';
    yield object.archiveReason == null ? null : serializers.serialize(
      object.archiveReason,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ClassRoom object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ClassRoomBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'grade':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.grade = valueDes;
          break;
        case r'section':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.section = valueDes;
          break;
        case r'capacity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.capacity = valueDes;
          break;
        case r'academic_year_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.academicYearId = valueDes;
          break;
        case r'homeroom_teacher_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.homeroomTeacherId = valueDes;
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
        case r'archived_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.archivedAt = valueDes;
          break;
        case r'archived_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.archivedBy = valueDes;
          break;
        case r'archive_reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.archiveReason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ClassRoom deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ClassRoomBuilder();
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

