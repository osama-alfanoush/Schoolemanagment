//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/hr_staff_attendance325200_response_any_of.dart';
import 'package:school_mobile/generated/model/staff_attendance.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'hr_staff_attendance325200_response.g.dart';

/// HrStaffAttendance325200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrStaffAttendance325200Response implements Built<HrStaffAttendance325200Response, HrStaffAttendance325200ResponseBuilder> {
  /// Any Of [BuiltList<StaffAttendance>], [HrStaffAttendance325200ResponseAnyOf]
  AnyOf get anyOf;

  HrStaffAttendance325200Response._();

  factory HrStaffAttendance325200Response([void updates(HrStaffAttendance325200ResponseBuilder b)]) = _$HrStaffAttendance325200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance325200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance325200Response> get serializer => _$HrStaffAttendance325200ResponseSerializer();
}

class _$HrStaffAttendance325200ResponseSerializer implements PrimitiveSerializer<HrStaffAttendance325200Response> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance325200Response, _$HrStaffAttendance325200Response];

  @override
  final String wireName = r'HrStaffAttendance325200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance325200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance325200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  HrStaffAttendance325200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance325200ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(BuiltList, [FullType(StaffAttendance)]), FullType(HrStaffAttendance325200ResponseAnyOf), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

class HrStaffAttendance325200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Saved')
  static const HrStaffAttendance325200ResponseMessageEnum saved = _$hrStaffAttendance325200ResponseMessageEnum_saved;

  static Serializer<HrStaffAttendance325200ResponseMessageEnum> get serializer => _$hrStaffAttendance325200ResponseMessageEnumSerializer;

  const HrStaffAttendance325200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance325200ResponseMessageEnum> get values => _$hrStaffAttendance325200ResponseMessageEnumValues;
  static HrStaffAttendance325200ResponseMessageEnum valueOf(String name) => _$hrStaffAttendance325200ResponseMessageEnumValueOf(name);
}

