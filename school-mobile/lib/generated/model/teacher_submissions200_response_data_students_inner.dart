//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_submissions200_response_data_students_inner.g.dart';

/// TeacherSubmissions200ResponseDataStudentsInner
///
/// Properties:
/// * [studentUserId] 
/// * [name] 
/// * [status] - Absent means not handed in. Reporting nothing at all would let the screen render a blank that reads as \"fine\".
/// * [submittedAt] 
/// * [score] 
/// * [hasFile] 
@BuiltValue()
abstract class TeacherSubmissions200ResponseDataStudentsInner implements Built<TeacherSubmissions200ResponseDataStudentsInner, TeacherSubmissions200ResponseDataStudentsInnerBuilder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'name')
  String get name;

  /// Absent means not handed in. Reporting nothing at all would let the screen render a blank that reads as \"fine\".
  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'submitted_at')
  String? get submittedAt;

  @BuiltValueField(wireName: r'score')
  String? get score;

  @BuiltValueField(wireName: r'has_file')
  bool get hasFile;

  TeacherSubmissions200ResponseDataStudentsInner._();

  factory TeacherSubmissions200ResponseDataStudentsInner([void updates(TeacherSubmissions200ResponseDataStudentsInnerBuilder b)]) = _$TeacherSubmissions200ResponseDataStudentsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherSubmissions200ResponseDataStudentsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherSubmissions200ResponseDataStudentsInner> get serializer => _$TeacherSubmissions200ResponseDataStudentsInnerSerializer();
}

class _$TeacherSubmissions200ResponseDataStudentsInnerSerializer implements PrimitiveSerializer<TeacherSubmissions200ResponseDataStudentsInner> {
  @override
  final Iterable<Type> types = const [TeacherSubmissions200ResponseDataStudentsInner, _$TeacherSubmissions200ResponseDataStudentsInner];

  @override
  final String wireName = r'TeacherSubmissions200ResponseDataStudentsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherSubmissions200ResponseDataStudentsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'submitted_at';
    yield object.submittedAt == null ? null : serializers.serialize(
      object.submittedAt,
      specifiedType: const FullType.nullable(String),
    );
    yield r'score';
    yield object.score == null ? null : serializers.serialize(
      object.score,
      specifiedType: const FullType.nullable(String),
    );
    yield r'has_file';
    yield serializers.serialize(
      object.hasFile,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherSubmissions200ResponseDataStudentsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherSubmissions200ResponseDataStudentsInnerBuilder result,
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
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'submitted_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.submittedAt = valueDes;
          break;
        case r'score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.score = valueDes;
          break;
        case r'has_file':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasFile = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherSubmissions200ResponseDataStudentsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherSubmissions200ResponseDataStudentsInnerBuilder();
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

