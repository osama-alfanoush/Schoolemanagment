//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_child_attendance200_response_records.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_child_attendance200_response.g.dart';

/// ParentChildAttendance200Response
///
/// Properties:
/// * [records] 
/// * [monthlySummary] 
@BuiltValue()
abstract class ParentChildAttendance200Response implements Built<ParentChildAttendance200Response, ParentChildAttendance200ResponseBuilder> {
  @BuiltValueField(wireName: r'records')
  ParentChildAttendance200ResponseRecords get records;

  @BuiltValueField(wireName: r'monthly_summary')
  BuiltList<JsonObject?> get monthlySummary;

  ParentChildAttendance200Response._();

  factory ParentChildAttendance200Response([void updates(ParentChildAttendance200ResponseBuilder b)]) = _$ParentChildAttendance200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentChildAttendance200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentChildAttendance200Response> get serializer => _$ParentChildAttendance200ResponseSerializer();
}

class _$ParentChildAttendance200ResponseSerializer implements PrimitiveSerializer<ParentChildAttendance200Response> {
  @override
  final Iterable<Type> types = const [ParentChildAttendance200Response, _$ParentChildAttendance200Response];

  @override
  final String wireName = r'ParentChildAttendance200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentChildAttendance200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'records';
    yield serializers.serialize(
      object.records,
      specifiedType: const FullType(ParentChildAttendance200ResponseRecords),
    );
    yield r'monthly_summary';
    yield serializers.serialize(
      object.monthlySummary,
      specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentChildAttendance200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentChildAttendance200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'records':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentChildAttendance200ResponseRecords),
          ) as ParentChildAttendance200ResponseRecords;
          result.records.replace(valueDes);
          break;
        case r'monthly_summary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType.nullable(JsonObject)]),
          ) as BuiltList<JsonObject?>;
          result.monthlySummary.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentChildAttendance200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentChildAttendance200ResponseBuilder();
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

