//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/teacher_submissions200_response_data_students_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_submissions200_response_data.g.dart';

/// TeacherSubmissions200ResponseData
///
/// Properties:
/// * [assignmentId] 
/// * [title] 
/// * [dueAt] 
/// * [published] 
/// * [students] 
@BuiltValue()
abstract class TeacherSubmissions200ResponseData implements Built<TeacherSubmissions200ResponseData, TeacherSubmissions200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'assignment_id')
  int get assignmentId;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'due_at')
  String get dueAt;

  @BuiltValueField(wireName: r'published')
  bool get published;

  @BuiltValueField(wireName: r'students')
  BuiltList<TeacherSubmissions200ResponseDataStudentsInner> get students;

  TeacherSubmissions200ResponseData._();

  factory TeacherSubmissions200ResponseData([void updates(TeacherSubmissions200ResponseDataBuilder b)]) = _$TeacherSubmissions200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherSubmissions200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherSubmissions200ResponseData> get serializer => _$TeacherSubmissions200ResponseDataSerializer();
}

class _$TeacherSubmissions200ResponseDataSerializer implements PrimitiveSerializer<TeacherSubmissions200ResponseData> {
  @override
  final Iterable<Type> types = const [TeacherSubmissions200ResponseData, _$TeacherSubmissions200ResponseData];

  @override
  final String wireName = r'TeacherSubmissions200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherSubmissions200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'assignment_id';
    yield serializers.serialize(
      object.assignmentId,
      specifiedType: const FullType(int),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
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
    yield r'students';
    yield serializers.serialize(
      object.students,
      specifiedType: const FullType(BuiltList, [FullType(TeacherSubmissions200ResponseDataStudentsInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherSubmissions200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherSubmissions200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'assignment_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.assignmentId = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
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
        case r'students':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TeacherSubmissions200ResponseDataStudentsInner)]),
          ) as BuiltList<TeacherSubmissions200ResponseDataStudentsInner>;
          result.students.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherSubmissions200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherSubmissions200ResponseDataBuilder();
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

