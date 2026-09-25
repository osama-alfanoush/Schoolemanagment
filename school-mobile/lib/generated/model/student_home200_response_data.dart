//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/student_home200_response_data_today_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/student_home200_response_data_attendance.dart';
import 'package:school_mobile/generated/model/student_home200_response_data_next_due.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'student_home200_response_data.g.dart';

/// StudentHome200ResponseData
///
/// Properties:
/// * [studentUserId] 
/// * [className] 
/// * [today] 
/// * [attendance] 
/// * [nextDue] 
/// * [unreadCount] 
@BuiltValue()
abstract class StudentHome200ResponseData implements Built<StudentHome200ResponseData, StudentHome200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'class_name')
  String? get className;

  @BuiltValueField(wireName: r'today')
  BuiltList<StudentHome200ResponseDataTodayInner> get today;

  @BuiltValueField(wireName: r'attendance')
  StudentHome200ResponseDataAttendance get attendance;

  @BuiltValueField(wireName: r'next_due')
  StudentHome200ResponseDataNextDue get nextDue;

  @BuiltValueField(wireName: r'unread_count')
  int get unreadCount;

  StudentHome200ResponseData._();

  factory StudentHome200ResponseData([void updates(StudentHome200ResponseDataBuilder b)]) = _$StudentHome200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StudentHome200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StudentHome200ResponseData> get serializer => _$StudentHome200ResponseDataSerializer();
}

class _$StudentHome200ResponseDataSerializer implements PrimitiveSerializer<StudentHome200ResponseData> {
  @override
  final Iterable<Type> types = const [StudentHome200ResponseData, _$StudentHome200ResponseData];

  @override
  final String wireName = r'StudentHome200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StudentHome200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'class_name';
    yield object.className == null ? null : serializers.serialize(
      object.className,
      specifiedType: const FullType.nullable(String),
    );
    yield r'today';
    yield serializers.serialize(
      object.today,
      specifiedType: const FullType(BuiltList, [FullType(StudentHome200ResponseDataTodayInner)]),
    );
    yield r'attendance';
    yield serializers.serialize(
      object.attendance,
      specifiedType: const FullType(StudentHome200ResponseDataAttendance),
    );
    yield r'next_due';
    yield serializers.serialize(
      object.nextDue,
      specifiedType: const FullType(StudentHome200ResponseDataNextDue),
    );
    yield r'unread_count';
    yield serializers.serialize(
      object.unreadCount,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StudentHome200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StudentHome200ResponseDataBuilder result,
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
        case r'class_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.className = valueDes;
          break;
        case r'today':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(StudentHome200ResponseDataTodayInner)]),
          ) as BuiltList<StudentHome200ResponseDataTodayInner>;
          result.today.replace(valueDes);
          break;
        case r'attendance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StudentHome200ResponseDataAttendance),
          ) as StudentHome200ResponseDataAttendance;
          result.attendance.replace(valueDes);
          break;
        case r'next_due':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StudentHome200ResponseDataNextDue),
          ) as StudentHome200ResponseDataNextDue;
          result.nextDue.replace(valueDes);
          break;
        case r'unread_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unreadCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StudentHome200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StudentHome200ResponseDataBuilder();
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

