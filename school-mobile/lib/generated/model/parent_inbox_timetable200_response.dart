//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_inbox_timetable200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_timetable200_response.g.dart';

/// ParentInboxTimetable200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentInboxTimetable200Response implements Built<ParentInboxTimetable200Response, ParentInboxTimetable200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ParentInboxTimetable200ResponseData get data;

  ParentInboxTimetable200Response._();

  factory ParentInboxTimetable200Response([void updates(ParentInboxTimetable200ResponseBuilder b)]) = _$ParentInboxTimetable200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxTimetable200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxTimetable200Response> get serializer => _$ParentInboxTimetable200ResponseSerializer();
}

class _$ParentInboxTimetable200ResponseSerializer implements PrimitiveSerializer<ParentInboxTimetable200Response> {
  @override
  final Iterable<Type> types = const [ParentInboxTimetable200Response, _$ParentInboxTimetable200Response];

  @override
  final String wireName = r'ParentInboxTimetable200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxTimetable200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ParentInboxTimetable200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxTimetable200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxTimetable200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentInboxTimetable200ResponseData),
          ) as ParentInboxTimetable200ResponseData;
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
  ParentInboxTimetable200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxTimetable200ResponseBuilder();
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

