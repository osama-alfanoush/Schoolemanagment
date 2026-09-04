//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/hr_staff_attendance320200_response_any_of.dart';
import 'package:school_mobile/generated/model/staff_attendance.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'hr_staff_attendance320200_response.g.dart';

/// HrStaffAttendance320200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrStaffAttendance320200Response implements Built<HrStaffAttendance320200Response, HrStaffAttendance320200ResponseBuilder> {
  /// Any Of [BuiltList<StaffAttendance>], [HrStaffAttendance320200ResponseAnyOf]
  AnyOf get anyOf;

  HrStaffAttendance320200Response._();

  factory HrStaffAttendance320200Response([void updates(HrStaffAttendance320200ResponseBuilder b)]) = _$HrStaffAttendance320200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance320200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance320200Response> get serializer => _$HrStaffAttendance320200ResponseSerializer();
}

class _$HrStaffAttendance320200ResponseSerializer implements PrimitiveSerializer<HrStaffAttendance320200Response> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance320200Response, _$HrStaffAttendance320200Response];

  @override
  final String wireName = r'HrStaffAttendance320200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance320200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance320200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  HrStaffAttendance320200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance320200ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(BuiltList, [FullType(StaffAttendance)]), FullType(HrStaffAttendance320200ResponseAnyOf), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

class HrStaffAttendance320200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Saved')
  static const HrStaffAttendance320200ResponseMessageEnum saved = _$hrStaffAttendance320200ResponseMessageEnum_saved;

  static Serializer<HrStaffAttendance320200ResponseMessageEnum> get serializer => _$hrStaffAttendance320200ResponseMessageEnumSerializer;

  const HrStaffAttendance320200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance320200ResponseMessageEnum> get values => _$hrStaffAttendance320200ResponseMessageEnumValues;
  static HrStaffAttendance320200ResponseMessageEnum valueOf(String name) => _$hrStaffAttendance320200ResponseMessageEnumValueOf(name);
}

