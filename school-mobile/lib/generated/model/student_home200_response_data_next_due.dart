//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'student_home200_response_data_next_due.g.dart';

/// StudentHome200ResponseDataNextDue
///
/// Properties:
/// * [assignmentId] 
/// * [title] 
/// * [dueAt] 
@BuiltValue()
abstract class StudentHome200ResponseDataNextDue implements Built<StudentHome200ResponseDataNextDue, StudentHome200ResponseDataNextDueBuilder> {
  @BuiltValueField(wireName: r'assignment_id')
  int get assignmentId;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'due_at')
  String get dueAt;

  StudentHome200ResponseDataNextDue._();

  factory StudentHome200ResponseDataNextDue([void updates(StudentHome200ResponseDataNextDueBuilder b)]) = _$StudentHome200ResponseDataNextDue;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StudentHome200ResponseDataNextDueBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StudentHome200ResponseDataNextDue> get serializer => _$StudentHome200ResponseDataNextDueSerializer();
}

class _$StudentHome200ResponseDataNextDueSerializer implements PrimitiveSerializer<StudentHome200ResponseDataNextDue> {
  @override
  final Iterable<Type> types = const [StudentHome200ResponseDataNextDue, _$StudentHome200ResponseDataNextDue];

  @override
  final String wireName = r'StudentHome200ResponseDataNextDue';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StudentHome200ResponseDataNextDue object, {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    StudentHome200ResponseDataNextDue object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StudentHome200ResponseDataNextDueBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StudentHome200ResponseDataNextDue deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StudentHome200ResponseDataNextDueBuilder();
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

