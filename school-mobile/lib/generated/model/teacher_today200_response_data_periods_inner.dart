//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_today200_response_data_periods_inner.g.dart';

/// TeacherToday200ResponseDataPeriodsInner
///
/// Properties:
/// * [id] 
/// * [classRoomId] 
/// * [className] 
/// * [subjectId] 
/// * [subject] 
/// * [startTime] 
/// * [endTime] 
/// * [room] 
/// * [attendanceTaken] 
@BuiltValue()
abstract class TeacherToday200ResponseDataPeriodsInner implements Built<TeacherToday200ResponseDataPeriodsInner, TeacherToday200ResponseDataPeriodsInnerBuilder> {
  @BuiltValueField(wireName: r'id')
  int get id;

  @BuiltValueField(wireName: r'class_room_id')
  int get classRoomId;

  @BuiltValueField(wireName: r'class_name')
  String get className;

  @BuiltValueField(wireName: r'subject_id')
  int get subjectId;

  @BuiltValueField(wireName: r'subject')
  String get subject;

  @BuiltValueField(wireName: r'start_time')
  String get startTime;

  @BuiltValueField(wireName: r'end_time')
  String get endTime;

  @BuiltValueField(wireName: r'room')
  String get room;

  @BuiltValueField(wireName: r'attendance_taken')
  bool get attendanceTaken;

  TeacherToday200ResponseDataPeriodsInner._();

  factory TeacherToday200ResponseDataPeriodsInner([void updates(TeacherToday200ResponseDataPeriodsInnerBuilder b)]) = _$TeacherToday200ResponseDataPeriodsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherToday200ResponseDataPeriodsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherToday200ResponseDataPeriodsInner> get serializer => _$TeacherToday200ResponseDataPeriodsInnerSerializer();
}

class _$TeacherToday200ResponseDataPeriodsInnerSerializer implements PrimitiveSerializer<TeacherToday200ResponseDataPeriodsInner> {
  @override
  final Iterable<Type> types = const [TeacherToday200ResponseDataPeriodsInner, _$TeacherToday200ResponseDataPeriodsInner];

  @override
  final String wireName = r'TeacherToday200ResponseDataPeriodsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherToday200ResponseDataPeriodsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(int),
    );
    yield r'class_room_id';
    yield serializers.serialize(
      object.classRoomId,
      specifiedType: const FullType(int),
    );
    yield r'class_name';
    yield serializers.serialize(
      object.className,
      specifiedType: const FullType(String),
    );
    yield r'subject_id';
    yield serializers.serialize(
      object.subjectId,
      specifiedType: const FullType(int),
    );
    yield r'subject';
    yield serializers.serialize(
      object.subject,
      specifiedType: const FullType(String),
    );
    yield r'start_time';
    yield serializers.serialize(
      object.startTime,
      specifiedType: const FullType(String),
    );
    yield r'end_time';
    yield serializers.serialize(
      object.endTime,
      specifiedType: const FullType(String),
    );
    yield r'room';
    yield serializers.serialize(
      object.room,
      specifiedType: const FullType(String),
    );
    yield r'attendance_taken';
    yield serializers.serialize(
      object.attendanceTaken,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherToday200ResponseDataPeriodsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherToday200ResponseDataPeriodsInnerBuilder result,
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
        case r'class_room_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.classRoomId = valueDes;
          break;
        case r'class_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.className = valueDes;
          break;
        case r'subject_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.subjectId = valueDes;
          break;
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'start_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.startTime = valueDes;
          break;
        case r'end_time':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.endTime = valueDes;
          break;
        case r'room':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.room = valueDes;
          break;
        case r'attendance_taken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.attendanceTaken = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherToday200ResponseDataPeriodsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherToday200ResponseDataPeriodsInnerBuilder();
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

