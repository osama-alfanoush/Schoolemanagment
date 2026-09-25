//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/mobile_student_assignments200_response_data_any_of.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/mobile_student_assignments200_response_data_any_of1.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'mobile_student_assignments200_response_data.g.dart';

/// MobileStudentAssignments200ResponseData
///
/// Properties:
/// * [assignments] 
@BuiltValue()
abstract class MobileStudentAssignments200ResponseData implements Built<MobileStudentAssignments200ResponseData, MobileStudentAssignments200ResponseDataBuilder> {
  /// Any Of [MobileStudentAssignments200ResponseDataAnyOf], [MobileStudentAssignments200ResponseDataAnyOf1]
  AnyOf get anyOf;

  MobileStudentAssignments200ResponseData._();

  factory MobileStudentAssignments200ResponseData([void updates(MobileStudentAssignments200ResponseDataBuilder b)]) = _$MobileStudentAssignments200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MobileStudentAssignments200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MobileStudentAssignments200ResponseData> get serializer => _$MobileStudentAssignments200ResponseDataSerializer();
}

class _$MobileStudentAssignments200ResponseDataSerializer implements PrimitiveSerializer<MobileStudentAssignments200ResponseData> {
  @override
  final Iterable<Type> types = const [MobileStudentAssignments200ResponseData, _$MobileStudentAssignments200ResponseData];

  @override
  final String wireName = r'MobileStudentAssignments200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MobileStudentAssignments200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    MobileStudentAssignments200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  MobileStudentAssignments200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MobileStudentAssignments200ResponseDataBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(MobileStudentAssignments200ResponseDataAnyOf), FullType(MobileStudentAssignments200ResponseDataAnyOf1), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

