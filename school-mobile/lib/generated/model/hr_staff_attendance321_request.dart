//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/hr_staff_attendance320_records_parameter_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance321_request.g.dart';

/// HrStaffAttendance321Request
///
/// Properties:
/// * [records] 
@BuiltValue()
abstract class HrStaffAttendance321Request implements Built<HrStaffAttendance321Request, HrStaffAttendance321RequestBuilder> {
  @BuiltValueField(wireName: r'records')
  BuiltList<HrStaffAttendance320RecordsParameterInner> get records;

  HrStaffAttendance321Request._();

  factory HrStaffAttendance321Request([void updates(HrStaffAttendance321RequestBuilder b)]) = _$HrStaffAttendance321Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance321RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance321Request> get serializer => _$HrStaffAttendance321RequestSerializer();
}

class _$HrStaffAttendance321RequestSerializer implements PrimitiveSerializer<HrStaffAttendance321Request> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance321Request, _$HrStaffAttendance321Request];

  @override
  final String wireName = r'HrStaffAttendance321Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance321Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'records';
    yield serializers.serialize(
      object.records,
      specifiedType: const FullType(BuiltList, [FullType(HrStaffAttendance320RecordsParameterInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance321Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance321RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'records':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(HrStaffAttendance320RecordsParameterInner)]),
          ) as BuiltList<HrStaffAttendance320RecordsParameterInner>;
          result.records.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrStaffAttendance321Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance321RequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

