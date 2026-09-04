//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/parent_inbox_timetable200_response_data_any_of.dart';
import 'package:school_mobile/generated/model/parent_inbox_timetable200_response_data_any_of1.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'parent_inbox_timetable200_response_data.g.dart';

/// ParentInboxTimetable200ResponseData
///
/// Properties:
/// * [studentUserId] 
/// * [today] 
/// * [days] 
@BuiltValue()
abstract class ParentInboxTimetable200ResponseData implements Built<ParentInboxTimetable200ResponseData, ParentInboxTimetable200ResponseDataBuilder> {
  /// Any Of [ParentInboxTimetable200ResponseDataAnyOf], [ParentInboxTimetable200ResponseDataAnyOf1]
  AnyOf get anyOf;

  ParentInboxTimetable200ResponseData._();

  factory ParentInboxTimetable200ResponseData([void updates(ParentInboxTimetable200ResponseDataBuilder b)]) = _$ParentInboxTimetable200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxTimetable200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxTimetable200ResponseData> get serializer => _$ParentInboxTimetable200ResponseDataSerializer();
}

class _$ParentInboxTimetable200ResponseDataSerializer implements PrimitiveSerializer<ParentInboxTimetable200ResponseData> {
  @override
  final Iterable<Type> types = const [ParentInboxTimetable200ResponseData, _$ParentInboxTimetable200ResponseData];

  @override
  final String wireName = r'ParentInboxTimetable200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxTimetable200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxTimetable200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  ParentInboxTimetable200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxTimetable200ResponseDataBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(ParentInboxTimetable200ResponseDataAnyOf), FullType(ParentInboxTimetable200ResponseDataAnyOf1), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

