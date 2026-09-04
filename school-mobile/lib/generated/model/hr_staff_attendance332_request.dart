//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/hr_staff_attendance331_records_parameter_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance332_request.g.dart';

/// HrStaffAttendance332Request
///
/// Properties:
/// * [records] 
@BuiltValue()
abstract class HrStaffAttendance332Request implements Built<HrStaffAttendance332Request, HrStaffAttendance332RequestBuilder> {
  @BuiltValueField(wireName: r'records')
  BuiltList<HrStaffAttendance331RecordsParameterInner> get records;

  HrStaffAttendance332Request._();

  factory HrStaffAttendance332Request([void updates(HrStaffAttendance332RequestBuilder b)]) = _$HrStaffAttendance332Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance332RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance332Request> get serializer => _$HrStaffAttendance332RequestSerializer();
}

class _$HrStaffAttendance332RequestSerializer implements PrimitiveSerializer<HrStaffAttendance332Request> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance332Request, _$HrStaffAttendance332Request];

  @override
  final String wireName = r'HrStaffAttendance332Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance332Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'records';
    yield serializers.serialize(
      object.records,
      specifiedType: const FullType(BuiltList, [FullType(HrStaffAttendance331RecordsParameterInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance332Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance332RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'records':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(HrStaffAttendance331RecordsParameterInner)]),
          ) as BuiltList<HrStaffAttendance331RecordsParameterInner>;
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
  HrStaffAttendance332Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance332RequestBuilder();
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

