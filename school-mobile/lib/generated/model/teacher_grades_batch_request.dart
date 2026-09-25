//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/teacher_grades_batch_request_grades_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_grades_batch_request.g.dart';

/// TeacherGradesBatchRequest
///
/// Properties:
/// * [idempotencyKey] 
/// * [classRoomId] 
/// * [subjectId] 
/// * [grades] 
@BuiltValue()
abstract class TeacherGradesBatchRequest implements Built<TeacherGradesBatchRequest, TeacherGradesBatchRequestBuilder> {
  @BuiltValueField(wireName: r'idempotency_key')
  String get idempotencyKey;

  @BuiltValueField(wireName: r'class_room_id')
  int get classRoomId;

  @BuiltValueField(wireName: r'subject_id')
  int get subjectId;

  @BuiltValueField(wireName: r'grades')
  BuiltList<TeacherGradesBatchRequestGradesInner> get grades;

  TeacherGradesBatchRequest._();

  factory TeacherGradesBatchRequest([void updates(TeacherGradesBatchRequestBuilder b)]) = _$TeacherGradesBatchRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherGradesBatchRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherGradesBatchRequest> get serializer => _$TeacherGradesBatchRequestSerializer();
}

class _$TeacherGradesBatchRequestSerializer implements PrimitiveSerializer<TeacherGradesBatchRequest> {
  @override
  final Iterable<Type> types = const [TeacherGradesBatchRequest, _$TeacherGradesBatchRequest];

  @override
  final String wireName = r'TeacherGradesBatchRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherGradesBatchRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'idempotency_key';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
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
    yield r'grades';
    yield serializers.serialize(
      object.grades,
      specifiedType: const FullType(BuiltList, [FullType(TeacherGradesBatchRequestGradesInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherGradesBatchRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherGradesBatchRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'idempotency_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
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
        case r'grades':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TeacherGradesBatchRequestGradesInner)]),
          ) as BuiltList<TeacherGradesBatchRequestGradesInner>;
          result.grades.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherGradesBatchRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherGradesBatchRequestBuilder();
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

