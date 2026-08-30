//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/hr_staff_attendance319_records_parameter_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance320_request.g.dart';

/// HrStaffAttendance320Request
///
/// Properties:
/// * [records] 
@BuiltValue()
abstract class HrStaffAttendance320Request implements Built<HrStaffAttendance320Request, HrStaffAttendance320RequestBuilder> {
  @BuiltValueField(wireName: r'records')
  BuiltList<HrStaffAttendance319RecordsParameterInner> get records;

  HrStaffAttendance320Request._();

  factory HrStaffAttendance320Request([void updates(HrStaffAttendance320RequestBuilder b)]) = _$HrStaffAttendance320Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance320RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance320Request> get serializer => _$HrStaffAttendance320RequestSerializer();
}

class _$HrStaffAttendance320RequestSerializer implements PrimitiveSerializer<HrStaffAttendance320Request> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance320Request, _$HrStaffAttendance320Request];

  @override
  final String wireName = r'HrStaffAttendance320Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance320Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'records';
    yield serializers.serialize(
      object.records,
      specifiedType: const FullType(BuiltList, [FullType(HrStaffAttendance319RecordsParameterInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance320Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance320RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'records':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(HrStaffAttendance319RecordsParameterInner)]),
          ) as BuiltList<HrStaffAttendance319RecordsParameterInner>;
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
  HrStaffAttendance320Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance320RequestBuilder();
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

