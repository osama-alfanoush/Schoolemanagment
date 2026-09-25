//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_attendance_batch_request_records_inner.g.dart';

/// TeacherAttendanceBatchRequestRecordsInner
///
/// Properties:
/// * [studentUserId] 
/// * [status] 
/// * [note] 
@BuiltValue()
abstract class TeacherAttendanceBatchRequestRecordsInner implements Built<TeacherAttendanceBatchRequestRecordsInner, TeacherAttendanceBatchRequestRecordsInnerBuilder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'status')
  TeacherAttendanceBatchRequestRecordsInnerStatusEnum get status;
  // enum statusEnum {  present,  absent,  late,  excused,  };

  @BuiltValueField(wireName: r'note')
  String? get note;

  TeacherAttendanceBatchRequestRecordsInner._();

  factory TeacherAttendanceBatchRequestRecordsInner([void updates(TeacherAttendanceBatchRequestRecordsInnerBuilder b)]) = _$TeacherAttendanceBatchRequestRecordsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherAttendanceBatchRequestRecordsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherAttendanceBatchRequestRecordsInner> get serializer => _$TeacherAttendanceBatchRequestRecordsInnerSerializer();
}

class _$TeacherAttendanceBatchRequestRecordsInnerSerializer implements PrimitiveSerializer<TeacherAttendanceBatchRequestRecordsInner> {
  @override
  final Iterable<Type> types = const [TeacherAttendanceBatchRequestRecordsInner, _$TeacherAttendanceBatchRequestRecordsInner];

  @override
  final String wireName = r'TeacherAttendanceBatchRequestRecordsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherAttendanceBatchRequestRecordsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(TeacherAttendanceBatchRequestRecordsInnerStatusEnum),
    );
    if (object.note != null) {
      yield r'note';
      yield serializers.serialize(
        object.note,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherAttendanceBatchRequestRecordsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherAttendanceBatchRequestRecordsInnerBuilder result,
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TeacherAttendanceBatchRequestRecordsInnerStatusEnum),
          ) as TeacherAttendanceBatchRequestRecordsInnerStatusEnum;
          result.status = valueDes;
          break;
        case r'note':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.note = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherAttendanceBatchRequestRecordsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherAttendanceBatchRequestRecordsInnerBuilder();
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

class TeacherAttendanceBatchRequestRecordsInnerStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'present')
  static const TeacherAttendanceBatchRequestRecordsInnerStatusEnum present = _$teacherAttendanceBatchRequestRecordsInnerStatusEnum_present;
  @BuiltValueEnumConst(wireName: r'absent')
  static const TeacherAttendanceBatchRequestRecordsInnerStatusEnum absent = _$teacherAttendanceBatchRequestRecordsInnerStatusEnum_absent;
  @BuiltValueEnumConst(wireName: r'late')
  static const TeacherAttendanceBatchRequestRecordsInnerStatusEnum late_ = _$teacherAttendanceBatchRequestRecordsInnerStatusEnum_late_;
  @BuiltValueEnumConst(wireName: r'excused')
  static const TeacherAttendanceBatchRequestRecordsInnerStatusEnum excused = _$teacherAttendanceBatchRequestRecordsInnerStatusEnum_excused;

  static Serializer<TeacherAttendanceBatchRequestRecordsInnerStatusEnum> get serializer => _$teacherAttendanceBatchRequestRecordsInnerStatusEnumSerializer;

  const TeacherAttendanceBatchRequestRecordsInnerStatusEnum._(String name): super(name);

  static BuiltSet<TeacherAttendanceBatchRequestRecordsInnerStatusEnum> get values => _$teacherAttendanceBatchRequestRecordsInnerStatusEnumValues;
  static TeacherAttendanceBatchRequestRecordsInnerStatusEnum valueOf(String name) => _$teacherAttendanceBatchRequestRecordsInnerStatusEnumValueOf(name);
}

