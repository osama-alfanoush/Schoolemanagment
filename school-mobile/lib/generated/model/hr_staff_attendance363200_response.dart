//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/staff_attendance.dart';
import 'package:school_mobile/generated/model/hr_staff_attendance363200_response_any_of.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'hr_staff_attendance363200_response.g.dart';

/// HrStaffAttendance363200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrStaffAttendance363200Response implements Built<HrStaffAttendance363200Response, HrStaffAttendance363200ResponseBuilder> {
  /// Any Of [BuiltList<StaffAttendance>], [HrStaffAttendance363200ResponseAnyOf]
  AnyOf get anyOf;

  HrStaffAttendance363200Response._();

  factory HrStaffAttendance363200Response([void updates(HrStaffAttendance363200ResponseBuilder b)]) = _$HrStaffAttendance363200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance363200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance363200Response> get serializer => _$HrStaffAttendance363200ResponseSerializer();
}

class _$HrStaffAttendance363200ResponseSerializer implements PrimitiveSerializer<HrStaffAttendance363200Response> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance363200Response, _$HrStaffAttendance363200Response];

  @override
  final String wireName = r'HrStaffAttendance363200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance363200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance363200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  HrStaffAttendance363200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance363200ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(BuiltList, [FullType(StaffAttendance)]), FullType(HrStaffAttendance363200ResponseAnyOf), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

class HrStaffAttendance363200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Saved')
  static const HrStaffAttendance363200ResponseMessageEnum saved = _$hrStaffAttendance363200ResponseMessageEnum_saved;

  static Serializer<HrStaffAttendance363200ResponseMessageEnum> get serializer => _$hrStaffAttendance363200ResponseMessageEnumSerializer;

  const HrStaffAttendance363200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance363200ResponseMessageEnum> get values => _$hrStaffAttendance363200ResponseMessageEnumValues;
  static HrStaffAttendance363200ResponseMessageEnum valueOf(String name) => _$hrStaffAttendance363200ResponseMessageEnumValueOf(name);
}

