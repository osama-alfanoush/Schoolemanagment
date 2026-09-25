//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_academics_grades200_response_data.g.dart';

/// ParentAcademicsGrades200ResponseData
///
/// Properties:
/// * [studentUserId] 
/// * [subjects] 
@BuiltValue()
abstract class ParentAcademicsGrades200ResponseData implements Built<ParentAcademicsGrades200ResponseData, ParentAcademicsGrades200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'subjects')
  BuiltList<JsonObject?> get subjects;

  ParentAcademicsGrades200ResponseData._();

  factory ParentAcademicsGrades200ResponseData([void updates(ParentAcademicsGrades200ResponseDataBuilder b)]) = _$ParentAcademicsGrades200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentAcademicsGrades200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentAcademicsGrades200ResponseData> get serializer => _$ParentAcademicsGrades200ResponseDataSerializer();
}

class _$ParentAcademicsGrades200ResponseDataSerializer implements PrimitiveSerializer<ParentAcademicsGrades200ResponseData> {
  @override
  final Iterable<Type> types = const [ParentAcademicsGrades200ResponseData, _$ParentAcademicsGrades200ResponseData];

  @override
  final String wireName = r'ParentAcademicsGrades200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentAcademicsGrades200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'subjects';
    yield serializers.serialize(
      object.subjects,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentAcademicsGrades200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentAcademicsGrades200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'student_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.studentUserId = valueDes;
          break;
        case r'subjects':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.subjects.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentAcademicsGrades200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentAcademicsGrades200ResponseDataBuilder();
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

