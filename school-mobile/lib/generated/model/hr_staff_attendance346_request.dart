//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/hr_staff_attendance345_records_parameter_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance346_request.g.dart';

/// HrStaffAttendance346Request
///
/// Properties:
/// * [records] 
@BuiltValue()
abstract class HrStaffAttendance346Request implements Built<HrStaffAttendance346Request, HrStaffAttendance346RequestBuilder> {
  @BuiltValueField(wireName: r'records')
  BuiltList<HrStaffAttendance345RecordsParameterInner> get records;

  HrStaffAttendance346Request._();

  factory HrStaffAttendance346Request([void updates(HrStaffAttendance346RequestBuilder b)]) = _$HrStaffAttendance346Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance346RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance346Request> get serializer => _$HrStaffAttendance346RequestSerializer();
}

class _$HrStaffAttendance346RequestSerializer implements PrimitiveSerializer<HrStaffAttendance346Request> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance346Request, _$HrStaffAttendance346Request];

  @override
  final String wireName = r'HrStaffAttendance346Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance346Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'records';
    yield serializers.serialize(
      object.records,
      specifiedType: const FullType(BuiltList, [FullType(HrStaffAttendance345RecordsParameterInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance346Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance346RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'records':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(HrStaffAttendance345RecordsParameterInner)]),
          ) as BuiltList<HrStaffAttendance345RecordsParameterInner>;
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
  HrStaffAttendance346Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance346RequestBuilder();
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

