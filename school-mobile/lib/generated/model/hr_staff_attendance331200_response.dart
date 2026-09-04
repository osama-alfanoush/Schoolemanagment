//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/hr_staff_attendance331200_response_any_of.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/staff_attendance.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'hr_staff_attendance331200_response.g.dart';

/// HrStaffAttendance331200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrStaffAttendance331200Response implements Built<HrStaffAttendance331200Response, HrStaffAttendance331200ResponseBuilder> {
  /// Any Of [BuiltList<StaffAttendance>], [HrStaffAttendance331200ResponseAnyOf]
  AnyOf get anyOf;

  HrStaffAttendance331200Response._();

  factory HrStaffAttendance331200Response([void updates(HrStaffAttendance331200ResponseBuilder b)]) = _$HrStaffAttendance331200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance331200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance331200Response> get serializer => _$HrStaffAttendance331200ResponseSerializer();
}

class _$HrStaffAttendance331200ResponseSerializer implements PrimitiveSerializer<HrStaffAttendance331200Response> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance331200Response, _$HrStaffAttendance331200Response];

  @override
  final String wireName = r'HrStaffAttendance331200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance331200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance331200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  HrStaffAttendance331200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance331200ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(BuiltList, [FullType(StaffAttendance)]), FullType(HrStaffAttendance331200ResponseAnyOf), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

class HrStaffAttendance331200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Saved')
  static const HrStaffAttendance331200ResponseMessageEnum saved = _$hrStaffAttendance331200ResponseMessageEnum_saved;

  static Serializer<HrStaffAttendance331200ResponseMessageEnum> get serializer => _$hrStaffAttendance331200ResponseMessageEnumSerializer;

  const HrStaffAttendance331200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance331200ResponseMessageEnum> get values => _$hrStaffAttendance331200ResponseMessageEnumValues;
  static HrStaffAttendance331200ResponseMessageEnum valueOf(String name) => _$hrStaffAttendance331200ResponseMessageEnumValueOf(name);
}

