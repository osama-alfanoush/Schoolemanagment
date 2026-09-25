//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'timetable_entry.g.dart';

/// TimetableEntry
///
/// Properties:
/// * [id] 
/// * [classRoomId] 
/// * [subjectId] 
/// * [teacherUserId] 
/// * [dayOfWeek] 
/// * [startTime] 
/// * [endTime] 
/// * [room] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [schoolId] 
/// * [termId] 
/// * [courseSectionId] 
/// * [effectiveStart] 
/// * [effectiveEnd] 
/// * [weekPattern] 
/// * [rotationWeek] 
/// * [startMinute] 
/// * [endMinute] 
@BuiltValue()
abstract class TimetableEntry implements Built<TimetableEntry, TimetableEntryBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'class_room_id')
  int get classRoomId;

  @BuiltValueField(wireName: r'subject_id')
  int get subjectId;

  @BuiltValueField(wireName: r'teacher_user_id')
  int get teacherUserId;

  @BuiltValueField(wireName: r'day_of_week')
  int get dayOfWeek;

  @BuiltValueField(wireName: r'start_time')
  String get startTime;

  @BuiltValueField(wireName: r'end_time')
  String get endTime;

  @BuiltValueField(wireName: r'room')
  String? get room;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  @BuiltValueField(wireName: r'term_id')
  int? get termId;

  @BuiltValueField(wireName: r'course_section_id')
  int? get courseSectionId;

  @BuiltValueField(wireName: r'effective_start')
  DateTime? get effectiveStart;

  @BuiltValueField(wireName: r'effective_end')
  DateTime? get effectiveEnd;

  @BuiltValueField(wireName: r'week_pattern')
  String get weekPattern;

  @BuiltValueField(wireName: r'rotation_week')
  int get rotationWeek;

  @BuiltValueField(wireName: r'start_minute')
  int? get startMinute;

  @BuiltValueField(wireName: r'end_minute')
  int? get endMinute;

  TimetableEntry._();

  factory TimetableEntry([void updates(TimetableEntryBuilder b)]) = _$TimetableEntry;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TimetableEntryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TimetableEntry> get serializer => _$TimetableEntrySerializer();
}

class _$TimetableEntrySerializer implements PrimitiveSerializer<TimetableEntry> {
  @override
  final Iterable<Type> types = const [TimetableEntry, _$TimetableEntry];

  @override
  final String wireName = r'TimetableEntry';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TimetableEntry object, {
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
    yield r'teacher_user_id';
    yield serializers.serialize(
      object.teacherUserId,
      specifiedType: const FullType(int),
    );
    yield r'day_of_week';
    yield serializers.serialize(
      object.dayOfWeek,
      specifiedType: const FullType(int),
    );
    yield r'start_time';
    yield serializers.serialize(
      object.startTime,
      specifiedType: const FullType(String),
    );
    yield r'end_time';
    yield serializers.serialize(
      object.endTime,
      specifiedType: const FullType(String),
    );
    yield r'room';
    yield object.room == null ? null : serializers.serialize(
      object.room,
      specifiedType: const FullType.nullable(String),
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
    yield r'term_id';
    yield object.termId == null ? null : serializers.serialize(
      object.termId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'course_section_id';
    yield object.courseSectionId == null ? null : serializers.serialize(
      object.courseSectionId,
      specifiedType: const FullType.nullable(int),
    );
    yield r'effective_start';
    yield object.effectiveStart == null ? null : serializers.serialize(
      object.effectiveStart,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'effective_end';
    yield object.effectiveEnd == null ? null : serializers.serialize(
      object.effectiveEnd,
      specifiedType: const FullType.nullable(DateTime),
    );
    yield r'week_pattern';
    yield serializers.serialize(
      object.weekPattern,
      specifiedType: const FullType(String),
    );
    yield r'rotation_week';
    yield serializers.serialize(
      object.rotationWeek,
      specifiedType: const FullType(int),
    );
    yield r'start_minute';
    yield object.startMinute == null ? null : serializers.serialize(
      object.startMinute,
      specifiedType: const FullType.nullable(int),
    );
    yield r'end_minute';
    yield object.endMinute == null ? null : serializers.serialize(
      object.endMinute,
      specifiedType: const FullType.nullable(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TimetableEntry object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TimetableEntryBuilder result,
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
        case r'teacher_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.teacherUserId = valueDes;
          break;
        case r'day_of_week':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.dayOfWeek = valueDes;
          break;
        case r'start_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.startTime = valueDes;
          break;
        case r'end_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.endTime = valueDes;
          break;
        case r'room':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.room = valueDes;
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
        case r'term_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.termId = valueDes;
          break;
        case r'course_section_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.courseSectionId = valueDes;
          break;
        case r'effective_start':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.effectiveStart = valueDes;
          break;
        case r'effective_end':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.effectiveEnd = valueDes;
          break;
        case r'week_pattern':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.weekPattern = valueDes;
          break;
        case r'rotation_week':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.rotationWeek = valueDes;
          break;
        case r'start_minute':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.startMinute = valueDes;
          break;
        case r'end_minute':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.endMinute = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TimetableEntry deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TimetableEntryBuilder();
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

