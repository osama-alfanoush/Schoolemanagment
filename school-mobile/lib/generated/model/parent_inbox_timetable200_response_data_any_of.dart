//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_timetable200_response_data_any_of.g.dart';

/// ParentInboxTimetable200ResponseDataAnyOf
///
/// Properties:
/// * [studentUserId] 
/// * [today] 
/// * [days] 
@BuiltValue()
abstract class ParentInboxTimetable200ResponseDataAnyOf implements Built<ParentInboxTimetable200ResponseDataAnyOf, ParentInboxTimetable200ResponseDataAnyOfBuilder> {
  @BuiltValueField(wireName: r'student_user_id')
  int get studentUserId;

  @BuiltValueField(wireName: r'today')
  String get today;

  @BuiltValueField(wireName: r'days')
  String get days;

  ParentInboxTimetable200ResponseDataAnyOf._();

  factory ParentInboxTimetable200ResponseDataAnyOf([void updates(ParentInboxTimetable200ResponseDataAnyOfBuilder b)]) = _$ParentInboxTimetable200ResponseDataAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxTimetable200ResponseDataAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxTimetable200ResponseDataAnyOf> get serializer => _$ParentInboxTimetable200ResponseDataAnyOfSerializer();
}

class _$ParentInboxTimetable200ResponseDataAnyOfSerializer implements PrimitiveSerializer<ParentInboxTimetable200ResponseDataAnyOf> {
  @override
  final Iterable<Type> types = const [ParentInboxTimetable200ResponseDataAnyOf, _$ParentInboxTimetable200ResponseDataAnyOf];

  @override
  final String wireName = r'ParentInboxTimetable200ResponseDataAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxTimetable200ResponseDataAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'student_user_id';
    yield serializers.serialize(
      object.studentUserId,
      specifiedType: const FullType(int),
    );
    yield r'today';
    yield serializers.serialize(
      object.today,
      specifiedType: const FullType(String),
    );
    yield r'days';
    yield serializers.serialize(
      object.days,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxTimetable200ResponseDataAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxTimetable200ResponseDataAnyOfBuilder result,
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
        case r'today':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.today = valueDes;
          break;
        case r'days':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.days = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInboxTimetable200ResponseDataAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxTimetable200ResponseDataAnyOfBuilder();
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

