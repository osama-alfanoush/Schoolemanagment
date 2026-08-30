//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'grade.g.dart';

/// Grade
///
/// Properties:
/// * [id] 
/// * [studentUserId] 
/// * [gradeComponentId] 
/// * [score] 
/// * [enteredBy] 
/// * [createdAt] 
/// * [updatedAt] 
/// * [version] 
/// * [schoolId] 
@BuiltValue()
abstract class Grade implements Built<Grade, GradeBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'grade_component_id')
  int get gradeComponentId;

  @BuiltValueField(wireName: r'score')
  String get score;

  @BuiltValueField(wireName: r'entered_by')
  int get enteredBy;

  @BuiltValueField(wireName: r'created_at')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'version')
  int get version;

  @BuiltValueField(wireName: r'school_id')
  int get schoolId;

  Grade._();

  factory Grade([void updates(GradeBuilder b)]) = _$Grade;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GradeBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Grade> get serializer => _$GradeSerializer();
}

class _$GradeSerializer implements PrimitiveSerializer<Grade> {
  @override
  final Iterable<Type> types = const [Grade, _$Grade];

  @override
  final String wireName = r'Grade';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Grade object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'grade_component_id';
    yield serializers.serialize(
      object.gradeComponentId,
      specifiedType: const FullType(int),
    );
    yield r'score';
    yield serializers.serialize(
      object.score,
      specifiedType: const FullType(String),
    );
    yield r'entered_by';
    yield serializers.serialize(
      object.enteredBy,
      specifiedType: const FullType(int),
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
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(int),
    );
    yield r'school_id';
    yield serializers.serialize(
      object.schoolId,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Grade object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GradeBuilder result,
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
        case r'student_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.studentUserId = valueDes;
          break;
        case r'grade_component_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.gradeComponentId = valueDes;
          break;
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.score = valueDes;
          break;
        case r'entered_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.enteredBy = valueDes;
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
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.version = valueDes;
          break;
        case r'school_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.schoolId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Grade deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GradeBuilder();
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

