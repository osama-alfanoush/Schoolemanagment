//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_timetable200_response_data_any_of1.g.dart';

/// ParentInboxTimetable200ResponseDataAnyOf1
///
/// Properties:
/// * [studentUserId] 
/// * [days] 
@BuiltValue()
abstract class ParentInboxTimetable200ResponseDataAnyOf1 implements Built<ParentInboxTimetable200ResponseDataAnyOf1, ParentInboxTimetable200ResponseDataAnyOf1Builder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'days')
  BuiltList<String> get days;

  ParentInboxTimetable200ResponseDataAnyOf1._();

  factory ParentInboxTimetable200ResponseDataAnyOf1([void updates(ParentInboxTimetable200ResponseDataAnyOf1Builder b)]) = _$ParentInboxTimetable200ResponseDataAnyOf1;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxTimetable200ResponseDataAnyOf1Builder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxTimetable200ResponseDataAnyOf1> get serializer => _$ParentInboxTimetable200ResponseDataAnyOf1Serializer();
}

class _$ParentInboxTimetable200ResponseDataAnyOf1Serializer implements PrimitiveSerializer<ParentInboxTimetable200ResponseDataAnyOf1> {
  @override
  final Iterable<Type> types = const [ParentInboxTimetable200ResponseDataAnyOf1, _$ParentInboxTimetable200ResponseDataAnyOf1];

  @override
  final String wireName = r'ParentInboxTimetable200ResponseDataAnyOf1';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxTimetable200ResponseDataAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'days';
    yield serializers.serialize(
      object.days,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxTimetable200ResponseDataAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxTimetable200ResponseDataAnyOf1Builder result,
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
        case r'days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
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
  ParentInboxTimetable200ResponseDataAnyOf1 deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxTimetable200ResponseDataAnyOf1Builder();
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

