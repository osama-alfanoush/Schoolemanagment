//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/hr_staff_attendance322_records_parameter_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance323_request.g.dart';

/// HrStaffAttendance323Request
///
/// Properties:
/// * [records] 
@BuiltValue()
abstract class HrStaffAttendance323Request implements Built<HrStaffAttendance323Request, HrStaffAttendance323RequestBuilder> {
  @BuiltValueField(wireName: r'records')
  BuiltList<HrStaffAttendance322RecordsParameterInner> get records;

  HrStaffAttendance323Request._();

  factory HrStaffAttendance323Request([void updates(HrStaffAttendance323RequestBuilder b)]) = _$HrStaffAttendance323Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance323RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance323Request> get serializer => _$HrStaffAttendance323RequestSerializer();
}

class _$HrStaffAttendance323RequestSerializer implements PrimitiveSerializer<HrStaffAttendance323Request> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance323Request, _$HrStaffAttendance323Request];

  @override
  final String wireName = r'HrStaffAttendance323Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance323Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'records';
    yield serializers.serialize(
      object.records,
      specifiedType: const FullType(BuiltList, [FullType(HrStaffAttendance322RecordsParameterInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance323Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance323RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'records':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(HrStaffAttendance322RecordsParameterInner)]),
          ) as BuiltList<HrStaffAttendance322RecordsParameterInner>;
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
  HrStaffAttendance323Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance323RequestBuilder();
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

