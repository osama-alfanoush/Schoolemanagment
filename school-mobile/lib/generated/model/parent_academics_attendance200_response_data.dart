//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_academics_attendance200_response_data_days_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_academics_attendance200_response_data.g.dart';

/// ParentAcademicsAttendance200ResponseData
///
/// Properties:
/// * [studentUserId] 
/// * [from] 
/// * [to] 
/// * [recordedDays] - Cast explicitly. Without it the spec generator reads `$counts['x'] ?? 0` as a union of the array's value type and the literal 0, and emits an anyOf the Dart generator cannot compile.
/// * [absentDays] 
/// * [lateDays] 
/// * [presentPercent] - Null, not 100%: a window with no register taken is not a window of perfect attendance.
/// * [days] 
@BuiltValue()
abstract class ParentAcademicsAttendance200ResponseData implements Built<ParentAcademicsAttendance200ResponseData, ParentAcademicsAttendance200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'from')
  String get from;

  @BuiltValueField(wireName: r'to')
  String get to;

  /// Cast explicitly. Without it the spec generator reads `$counts['x'] ?? 0` as a union of the array's value type and the literal 0, and emits an anyOf the Dart generator cannot compile.
  @BuiltValueField(wireName: r'recorded_days')
  int get recordedDays;

  @BuiltValueField(wireName: r'absent_days')
  int get absentDays;

  @BuiltValueField(wireName: r'late_days')
  int get lateDays;

  /// Null, not 100%: a window with no register taken is not a window of perfect attendance.
  @BuiltValueField(wireName: r'present_percent')
  int? get presentPercent;

  @BuiltValueField(wireName: r'days')
  BuiltList<ParentAcademicsAttendance200ResponseDataDaysInner> get days;

  ParentAcademicsAttendance200ResponseData._();

  factory ParentAcademicsAttendance200ResponseData([void updates(ParentAcademicsAttendance200ResponseDataBuilder b)]) = _$ParentAcademicsAttendance200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentAcademicsAttendance200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentAcademicsAttendance200ResponseData> get serializer => _$ParentAcademicsAttendance200ResponseDataSerializer();
}

class _$ParentAcademicsAttendance200ResponseDataSerializer implements PrimitiveSerializer<ParentAcademicsAttendance200ResponseData> {
  @override
  final Iterable<Type> types = const [ParentAcademicsAttendance200ResponseData, _$ParentAcademicsAttendance200ResponseData];

  @override
  final String wireName = r'ParentAcademicsAttendance200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentAcademicsAttendance200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'from';
    yield serializers.serialize(
      object.from,
      specifiedType: const FullType(String),
    );
    yield r'to';
    yield serializers.serialize(
      object.to,
      specifiedType: const FullType(String),
    );
    yield r'recorded_days';
    yield serializers.serialize(
      object.recordedDays,
      specifiedType: const FullType(int),
    );
    yield r'absent_days';
    yield serializers.serialize(
      object.absentDays,
      specifiedType: const FullType(int),
    );
    yield r'late_days';
    yield serializers.serialize(
      object.lateDays,
      specifiedType: const FullType(int),
    );
    yield r'present_percent';
    yield object.presentPercent == null ? null : serializers.serialize(
      object.presentPercent,
      specifiedType: const FullType.nullable(int),
    );
    yield r'days';
    yield serializers.serialize(
      object.days,
      specifiedType: const FullType(BuiltList, [FullType(ParentAcademicsAttendance200ResponseDataDaysInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentAcademicsAttendance200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentAcademicsAttendance200ResponseDataBuilder result,
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
        case r'from':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.from = valueDes;
          break;
        case r'to':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.to = valueDes;
          break;
        case r'recorded_days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.recordedDays = valueDes;
          break;
        case r'absent_days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.absentDays = valueDes;
          break;
        case r'late_days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.lateDays = valueDes;
          break;
        case r'present_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.presentPercent = valueDes;
          break;
        case r'days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ParentAcademicsAttendance200ResponseDataDaysInner)]),
          ) as BuiltList<ParentAcademicsAttendance200ResponseDataDaysInner>;
          result.days.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentAcademicsAttendance200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentAcademicsAttendance200ResponseDataBuilder();
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

