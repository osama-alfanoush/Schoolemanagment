//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/teacher_gradebook200_response_data_gradebook.dart';
import 'package:school_mobile/generated/model/teacher_gradebook200_response_data_students_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_gradebook200_response_data.g.dart';

/// TeacherGradebook200ResponseData
///
/// Properties:
/// * [classRoomId] 
/// * [subjectId] 
/// * [gradebook] 
/// * [components] 
/// * [students] 
@BuiltValue()
abstract class TeacherGradebook200ResponseData implements Built<TeacherGradebook200ResponseData, TeacherGradebook200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'class_room_id')
  int get classRoomId;

  @BuiltValueField(wireName: r'subject_id')
  int get subjectId;

  @BuiltValueField(wireName: r'gradebook')
  TeacherGradebook200ResponseDataGradebook get gradebook;

  @BuiltValueField(wireName: r'components')
  BuiltList<String> get components;

  @BuiltValueField(wireName: r'students')
  BuiltList<TeacherGradebook200ResponseDataStudentsInner> get students;

  TeacherGradebook200ResponseData._();

  factory TeacherGradebook200ResponseData([void updates(TeacherGradebook200ResponseDataBuilder b)]) = _$TeacherGradebook200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherGradebook200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherGradebook200ResponseData> get serializer => _$TeacherGradebook200ResponseDataSerializer();
}

class _$TeacherGradebook200ResponseDataSerializer implements PrimitiveSerializer<TeacherGradebook200ResponseData> {
  @override
  final Iterable<Type> types = const [TeacherGradebook200ResponseData, _$TeacherGradebook200ResponseData];

  @override
  final String wireName = r'TeacherGradebook200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherGradebook200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
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
    yield r'gradebook';
    yield serializers.serialize(
      object.gradebook,
      specifiedType: const FullType(TeacherGradebook200ResponseDataGradebook),
    );
    yield r'components';
    yield serializers.serialize(
      object.components,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'students';
    yield serializers.serialize(
      object.students,
      specifiedType: const FullType(BuiltList, [FullType(TeacherGradebook200ResponseDataStudentsInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherGradebook200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherGradebook200ResponseDataBuilder result,
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
        case r'subject_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.subjectId = valueDes;
          break;
        case r'gradebook':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TeacherGradebook200ResponseDataGradebook),
          ) as TeacherGradebook200ResponseDataGradebook;
          result.gradebook.replace(valueDes);
          break;
        case r'components':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.components.replace(valueDes);
          break;
        case r'students':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TeacherGradebook200ResponseDataStudentsInner)]),
          ) as BuiltList<TeacherGradebook200ResponseDataStudentsInner>;
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
  TeacherGradebook200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherGradebook200ResponseDataBuilder();
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

