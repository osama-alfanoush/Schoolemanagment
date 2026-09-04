//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/staff_attendance.dart';
import 'package:school_mobile/generated/model/hr_staff_attendance322200_response_any_of.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'hr_staff_attendance322200_response.g.dart';

/// HrStaffAttendance322200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrStaffAttendance322200Response implements Built<HrStaffAttendance322200Response, HrStaffAttendance322200ResponseBuilder> {
  /// Any Of [BuiltList<StaffAttendance>], [HrStaffAttendance322200ResponseAnyOf]
  AnyOf get anyOf;

  HrStaffAttendance322200Response._();

  factory HrStaffAttendance322200Response([void updates(HrStaffAttendance322200ResponseBuilder b)]) = _$HrStaffAttendance322200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance322200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance322200Response> get serializer => _$HrStaffAttendance322200ResponseSerializer();
}

class _$HrStaffAttendance322200ResponseSerializer implements PrimitiveSerializer<HrStaffAttendance322200Response> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance322200Response, _$HrStaffAttendance322200Response];

  @override
  final String wireName = r'HrStaffAttendance322200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance322200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance322200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  HrStaffAttendance322200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance322200ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(BuiltList, [FullType(StaffAttendance)]), FullType(HrStaffAttendance322200ResponseAnyOf), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

class HrStaffAttendance322200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Saved')
  static const HrStaffAttendance322200ResponseMessageEnum saved = _$hrStaffAttendance322200ResponseMessageEnum_saved;

  static Serializer<HrStaffAttendance322200ResponseMessageEnum> get serializer => _$hrStaffAttendance322200ResponseMessageEnumSerializer;

  const HrStaffAttendance322200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance322200ResponseMessageEnum> get values => _$hrStaffAttendance322200ResponseMessageEnumValues;
  static HrStaffAttendance322200ResponseMessageEnum valueOf(String name) => _$hrStaffAttendance322200ResponseMessageEnumValueOf(name);
}

