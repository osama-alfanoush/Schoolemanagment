//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/hr_staff_attendance336_records_parameter_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance337_request.g.dart';

/// HrStaffAttendance337Request
///
/// Properties:
/// * [records] 
@BuiltValue()
abstract class HrStaffAttendance337Request implements Built<HrStaffAttendance337Request, HrStaffAttendance337RequestBuilder> {
  @BuiltValueField(wireName: r'records')
  BuiltList<HrStaffAttendance336RecordsParameterInner> get records;

  HrStaffAttendance337Request._();

  factory HrStaffAttendance337Request([void updates(HrStaffAttendance337RequestBuilder b)]) = _$HrStaffAttendance337Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance337RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance337Request> get serializer => _$HrStaffAttendance337RequestSerializer();
}

class _$HrStaffAttendance337RequestSerializer implements PrimitiveSerializer<HrStaffAttendance337Request> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance337Request, _$HrStaffAttendance337Request];

  @override
  final String wireName = r'HrStaffAttendance337Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance337Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'records';
    yield serializers.serialize(
      object.records,
      specifiedType: const FullType(BuiltList, [FullType(HrStaffAttendance336RecordsParameterInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance337Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance337RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'records':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(HrStaffAttendance336RecordsParameterInner)]),
          ) as BuiltList<HrStaffAttendance336RecordsParameterInner>;
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
  HrStaffAttendance337Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance337RequestBuilder();
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

