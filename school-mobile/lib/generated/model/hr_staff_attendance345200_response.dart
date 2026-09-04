//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/hr_staff_attendance345200_response_any_of.dart';
import 'package:school_mobile/generated/model/staff_attendance.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'hr_staff_attendance345200_response.g.dart';

/// HrStaffAttendance345200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrStaffAttendance345200Response implements Built<HrStaffAttendance345200Response, HrStaffAttendance345200ResponseBuilder> {
  /// Any Of [BuiltList<StaffAttendance>], [HrStaffAttendance345200ResponseAnyOf]
  AnyOf get anyOf;

  HrStaffAttendance345200Response._();

  factory HrStaffAttendance345200Response([void updates(HrStaffAttendance345200ResponseBuilder b)]) = _$HrStaffAttendance345200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance345200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance345200Response> get serializer => _$HrStaffAttendance345200ResponseSerializer();
}

class _$HrStaffAttendance345200ResponseSerializer implements PrimitiveSerializer<HrStaffAttendance345200Response> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance345200Response, _$HrStaffAttendance345200Response];

  @override
  final String wireName = r'HrStaffAttendance345200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance345200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance345200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  HrStaffAttendance345200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance345200ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(BuiltList, [FullType(StaffAttendance)]), FullType(HrStaffAttendance345200ResponseAnyOf), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

class HrStaffAttendance345200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Saved')
  static const HrStaffAttendance345200ResponseMessageEnum saved = _$hrStaffAttendance345200ResponseMessageEnum_saved;

  static Serializer<HrStaffAttendance345200ResponseMessageEnum> get serializer => _$hrStaffAttendance345200ResponseMessageEnumSerializer;

  const HrStaffAttendance345200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance345200ResponseMessageEnum> get values => _$hrStaffAttendance345200ResponseMessageEnumValues;
  static HrStaffAttendance345200ResponseMessageEnum valueOf(String name) => _$hrStaffAttendance345200ResponseMessageEnumValueOf(name);
}

