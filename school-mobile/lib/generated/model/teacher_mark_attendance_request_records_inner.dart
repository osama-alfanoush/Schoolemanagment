//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_mark_attendance_request_records_inner.g.dart';

/// TeacherMarkAttendanceRequestRecordsInner
///
/// Properties:
/// * [studentUserId] 
/// * [status] 
/// * [note] 
@BuiltValue()
abstract class TeacherMarkAttendanceRequestRecordsInner implements Built<TeacherMarkAttendanceRequestRecordsInner, TeacherMarkAttendanceRequestRecordsInnerBuilder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'status')
  TeacherMarkAttendanceRequestRecordsInnerStatusEnum get status;
  // enum statusEnum {  present,  absent,  late,  excused,  };

  @BuiltValueField(wireName: r'note')
  String? get note;

  TeacherMarkAttendanceRequestRecordsInner._();

  factory TeacherMarkAttendanceRequestRecordsInner([void updates(TeacherMarkAttendanceRequestRecordsInnerBuilder b)]) = _$TeacherMarkAttendanceRequestRecordsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherMarkAttendanceRequestRecordsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherMarkAttendanceRequestRecordsInner> get serializer => _$TeacherMarkAttendanceRequestRecordsInnerSerializer();
}

class _$TeacherMarkAttendanceRequestRecordsInnerSerializer implements PrimitiveSerializer<TeacherMarkAttendanceRequestRecordsInner> {
  @override
  final Iterable<Type> types = const [TeacherMarkAttendanceRequestRecordsInner, _$TeacherMarkAttendanceRequestRecordsInner];

  @override
  final String wireName = r'TeacherMarkAttendanceRequestRecordsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherMarkAttendanceRequestRecordsInner object, {
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
      specifiedType: const FullType(TeacherMarkAttendanceRequestRecordsInnerStatusEnum),
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
    TeacherMarkAttendanceRequestRecordsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherMarkAttendanceRequestRecordsInnerBuilder result,
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
            specifiedType: const FullType(TeacherMarkAttendanceRequestRecordsInnerStatusEnum),
          ) as TeacherMarkAttendanceRequestRecordsInnerStatusEnum;
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
  TeacherMarkAttendanceRequestRecordsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherMarkAttendanceRequestRecordsInnerBuilder();
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

class TeacherMarkAttendanceRequestRecordsInnerStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'present')
  static const TeacherMarkAttendanceRequestRecordsInnerStatusEnum present = _$teacherMarkAttendanceRequestRecordsInnerStatusEnum_present;
  @BuiltValueEnumConst(wireName: r'absent')
  static const TeacherMarkAttendanceRequestRecordsInnerStatusEnum absent = _$teacherMarkAttendanceRequestRecordsInnerStatusEnum_absent;
  @BuiltValueEnumConst(wireName: r'late')
  static const TeacherMarkAttendanceRequestRecordsInnerStatusEnum late_ = _$teacherMarkAttendanceRequestRecordsInnerStatusEnum_late_;
  @BuiltValueEnumConst(wireName: r'excused')
  static const TeacherMarkAttendanceRequestRecordsInnerStatusEnum excused = _$teacherMarkAttendanceRequestRecordsInnerStatusEnum_excused;

  static Serializer<TeacherMarkAttendanceRequestRecordsInnerStatusEnum> get serializer => _$teacherMarkAttendanceRequestRecordsInnerStatusEnumSerializer;

  const TeacherMarkAttendanceRequestRecordsInnerStatusEnum._(String name): super(name);

  static BuiltSet<TeacherMarkAttendanceRequestRecordsInnerStatusEnum> get values => _$teacherMarkAttendanceRequestRecordsInnerStatusEnumValues;
  static TeacherMarkAttendanceRequestRecordsInnerStatusEnum valueOf(String name) => _$teacherMarkAttendanceRequestRecordsInnerStatusEnumValueOf(name);
}

