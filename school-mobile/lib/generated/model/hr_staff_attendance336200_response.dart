//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/hr_staff_attendance336200_response_any_of.dart';
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/staff_attendance.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/any_of.dart';

part 'hr_staff_attendance336200_response.g.dart';

/// HrStaffAttendance336200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrStaffAttendance336200Response implements Built<HrStaffAttendance336200Response, HrStaffAttendance336200ResponseBuilder> {
  /// Any Of [BuiltList<StaffAttendance>], [HrStaffAttendance336200ResponseAnyOf]
  AnyOf get anyOf;

  HrStaffAttendance336200Response._();

  factory HrStaffAttendance336200Response([void updates(HrStaffAttendance336200ResponseBuilder b)]) = _$HrStaffAttendance336200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance336200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance336200Response> get serializer => _$HrStaffAttendance336200ResponseSerializer();
}

class _$HrStaffAttendance336200ResponseSerializer implements PrimitiveSerializer<HrStaffAttendance336200Response> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance336200Response, _$HrStaffAttendance336200Response];

  @override
  final String wireName = r'HrStaffAttendance336200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance336200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance336200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final anyOf = object.anyOf;
    return serializers.serialize(anyOf, specifiedType: FullType(AnyOf, anyOf.valueTypes.map((type) => FullType(type)).toList()))!;
  }

  @override
  HrStaffAttendance336200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance336200ResponseBuilder();
    Object? anyOfDataSrc;
    final targetType = const FullType(AnyOf, [FullType(BuiltList, [FullType(StaffAttendance)]), FullType(HrStaffAttendance336200ResponseAnyOf), ]);
    anyOfDataSrc = serialized;
    result.anyOf = serializers.deserialize(anyOfDataSrc, specifiedType: targetType) as AnyOf;
    return result.build();
  }
}

class HrStaffAttendance336200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Saved')
  static const HrStaffAttendance336200ResponseMessageEnum saved = _$hrStaffAttendance336200ResponseMessageEnum_saved;

  static Serializer<HrStaffAttendance336200ResponseMessageEnum> get serializer => _$hrStaffAttendance336200ResponseMessageEnumSerializer;

  const HrStaffAttendance336200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance336200ResponseMessageEnum> get values => _$hrStaffAttendance336200ResponseMessageEnumValues;
  static HrStaffAttendance336200ResponseMessageEnum valueOf(String name) => _$hrStaffAttendance336200ResponseMessageEnumValueOf(name);
}

