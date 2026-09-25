//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/timetable_entry.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_my_timetable200_response.g.dart';

/// TeacherMyTimetable200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class TeacherMyTimetable200Response implements Built<TeacherMyTimetable200Response, TeacherMyTimetable200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<TimetableEntry> get data;

  TeacherMyTimetable200Response._();

  factory TeacherMyTimetable200Response([void updates(TeacherMyTimetable200ResponseBuilder b)]) = _$TeacherMyTimetable200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherMyTimetable200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherMyTimetable200Response> get serializer => _$TeacherMyTimetable200ResponseSerializer();
}

class _$TeacherMyTimetable200ResponseSerializer implements PrimitiveSerializer<TeacherMyTimetable200Response> {
  @override
  final Iterable<Type> types = const [TeacherMyTimetable200Response, _$TeacherMyTimetable200Response];

  @override
  final String wireName = r'TeacherMyTimetable200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherMyTimetable200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(TimetableEntry)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherMyTimetable200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherMyTimetable200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TimetableEntry)]),
          ) as BuiltList<TimetableEntry>;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherMyTimetable200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherMyTimetable200ResponseBuilder();
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

