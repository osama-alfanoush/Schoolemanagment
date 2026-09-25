//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_mark_attendance200_response.g.dart';

/// TeacherMarkAttendance200Response
///
/// Properties:
/// * [message] 
/// * [submissionBatchId] 
/// * [idempotencyKey] 
@BuiltValue()
abstract class TeacherMarkAttendance200Response implements Built<TeacherMarkAttendance200Response, TeacherMarkAttendance200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  TeacherMarkAttendance200ResponseMessageEnum get message;
  // enum messageEnum {  Attendance saved,  };

  @BuiltValueField(wireName: r'submission_batch_id')
  int get submissionBatchId;

  @BuiltValueField(wireName: r'idempotency_key')
  String get idempotencyKey;

  TeacherMarkAttendance200Response._();

  factory TeacherMarkAttendance200Response([void updates(TeacherMarkAttendance200ResponseBuilder b)]) = _$TeacherMarkAttendance200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherMarkAttendance200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherMarkAttendance200Response> get serializer => _$TeacherMarkAttendance200ResponseSerializer();
}

class _$TeacherMarkAttendance200ResponseSerializer implements PrimitiveSerializer<TeacherMarkAttendance200Response> {
  @override
  final Iterable<Type> types = const [TeacherMarkAttendance200Response, _$TeacherMarkAttendance200Response];

  @override
  final String wireName = r'TeacherMarkAttendance200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherMarkAttendance200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(TeacherMarkAttendance200ResponseMessageEnum),
    );
    yield r'submission_batch_id';
    yield serializers.serialize(
      object.submissionBatchId,
      specifiedType: const FullType(int),
    );
    yield r'idempotency_key';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherMarkAttendance200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherMarkAttendance200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TeacherMarkAttendance200ResponseMessageEnum),
          ) as TeacherMarkAttendance200ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'submission_batch_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.submissionBatchId = valueDes;
          break;
        case r'idempotency_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherMarkAttendance200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherMarkAttendance200ResponseBuilder();
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

class TeacherMarkAttendance200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Attendance saved')
  static const TeacherMarkAttendance200ResponseMessageEnum attendanceSaved = _$teacherMarkAttendance200ResponseMessageEnum_attendanceSaved;

  static Serializer<TeacherMarkAttendance200ResponseMessageEnum> get serializer => _$teacherMarkAttendance200ResponseMessageEnumSerializer;

  const TeacherMarkAttendance200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<TeacherMarkAttendance200ResponseMessageEnum> get values => _$teacherMarkAttendance200ResponseMessageEnumValues;
  static TeacherMarkAttendance200ResponseMessageEnum valueOf(String name) => _$teacherMarkAttendance200ResponseMessageEnumValueOf(name);
}

