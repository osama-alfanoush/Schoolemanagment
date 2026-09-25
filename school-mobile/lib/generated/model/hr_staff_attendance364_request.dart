//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/hr_staff_attendance363_records_parameter_inner.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance364_request.g.dart';

/// HrStaffAttendance364Request
///
/// Properties:
/// * [records] 
@BuiltValue()
abstract class HrStaffAttendance364Request implements Built<HrStaffAttendance364Request, HrStaffAttendance364RequestBuilder> {
  @BuiltValueField(wireName: r'records')
  BuiltList<HrStaffAttendance363RecordsParameterInner> get records;

  HrStaffAttendance364Request._();

  factory HrStaffAttendance364Request([void updates(HrStaffAttendance364RequestBuilder b)]) = _$HrStaffAttendance364Request;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance364RequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance364Request> get serializer => _$HrStaffAttendance364RequestSerializer();
}

class _$HrStaffAttendance364RequestSerializer implements PrimitiveSerializer<HrStaffAttendance364Request> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance364Request, _$HrStaffAttendance364Request];

  @override
  final String wireName = r'HrStaffAttendance364Request';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance364Request object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'records';
    yield serializers.serialize(
      object.records,
      specifiedType: const FullType(BuiltList, [FullType(HrStaffAttendance363RecordsParameterInner)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance364Request object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance364RequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'records':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(HrStaffAttendance363RecordsParameterInner)]),
          ) as BuiltList<HrStaffAttendance363RecordsParameterInner>;
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
  HrStaffAttendance364Request deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance364RequestBuilder();
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

