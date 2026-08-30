//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/staff_attendance.dart';
import 'package:school_mobile/generated/model/hr_staff_attendance319200_response_any_of.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'hr_staff_attendance319200_response.g.dart';

/// HrStaffAttendance319200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrStaffAttendance319200Response implements Built<HrStaffAttendance319200Response, HrStaffAttendance319200ResponseBuilder> {
  /// Any Of [BuiltList<StaffAttendance>], [HrStaffAttendance319200ResponseAnyOf]
  AnyOf get anyOf;

  HrStaffAttendance319200Response._();

  factory HrStaffAttendance319200Response([void updates(HrStaffAttendance319200ResponseBuilder b)]) = _$HrStaffAttendance319200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance319200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance319200Response> get serializer => _$HrStaffAttendance319200ResponseSerializer();
}

class _$HrStaffAttendance319200ResponseSerializer implements PrimitiveSerializer<HrStaffAttendance319200Response> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance319200Response, _$HrStaffAttendance319200Response];

  @override
  final String wireName = r'HrStaffAttendance319200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance319200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance319200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  HrStaffAttendance319200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance319200ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(BuiltList, [FullType(StaffAttendance)]), FullType(HrStaffAttendance319200ResponseAnyOf), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

class HrStaffAttendance319200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Saved')
  static const HrStaffAttendance319200ResponseMessageEnum saved = _$hrStaffAttendance319200ResponseMessageEnum_saved;

  static Serializer<HrStaffAttendance319200ResponseMessageEnum> get serializer => _$hrStaffAttendance319200ResponseMessageEnumSerializer;

  const HrStaffAttendance319200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance319200ResponseMessageEnum> get values => _$hrStaffAttendance319200ResponseMessageEnumValues;
  static HrStaffAttendance319200ResponseMessageEnum valueOf(String name) => _$hrStaffAttendance319200ResponseMessageEnumValueOf(name);
}

