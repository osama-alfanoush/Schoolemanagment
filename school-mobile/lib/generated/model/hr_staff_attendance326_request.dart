//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/hr_staff_attendance325_records_parameter_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance326_request.g.dart';

/// HrStaffAttendance326Request
///
/// Properties:
/// * [records] 
@BuiltValue()
abstract class HrStaffAttendance326Request implements Built<HrStaffAttendance326Request, HrStaffAttendance326RequestBuilder> {
  @BuiltValueField(wireName: r'records')
  BuiltList<HrStaffAttendance325RecordsParameterInner> get records;

  HrStaffAttendance326Request._();

  factory HrStaffAttendance326Request([void updates(HrStaffAttendance326RequestBuilder b)]) = _$HrStaffAttendance326Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance326RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance326Request> get serializer => _$HrStaffAttendance326RequestSerializer();
}

class _$HrStaffAttendance326RequestSerializer implements PrimitiveSerializer<HrStaffAttendance326Request> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance326Request, _$HrStaffAttendance326Request];

  @override
  final String wireName = r'HrStaffAttendance326Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance326Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'records';
    yield serializers.serialize(
      object.records,
      specifiedType: const FullType(BuiltList, [FullType(HrStaffAttendance325RecordsParameterInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance326Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance326RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'records':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(HrStaffAttendance325RecordsParameterInner)]),
          ) as BuiltList<HrStaffAttendance325RecordsParameterInner>;
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
  HrStaffAttendance326Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance326RequestBuilder();
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

