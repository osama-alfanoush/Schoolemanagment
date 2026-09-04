//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance336_records_parameter_inner.g.dart';

/// HrStaffAttendance336RecordsParameterInner
///
/// Properties:
/// * [staffUserId] 
/// * [date] 
/// * [status] 
/// * [checkIn] 
/// * [checkOut] 
@BuiltValue()
abstract class HrStaffAttendance336RecordsParameterInner implements Built<HrStaffAttendance336RecordsParameterInner, HrStaffAttendance336RecordsParameterInnerBuilder> {
  @BuiltValueField(wireName: r'staff_user_id')
  int get staffUserId;

  @BuiltValueField(wireName: r'date')
  DateTime get date;

  @BuiltValueField(wireName: r'status')
  HrStaffAttendance336RecordsParameterInnerStatusEnum get status;
  // enum statusEnum {  present,  absent,  late,  leave,  };

  @BuiltValueField(wireName: r'check_in')
  String? get checkIn;

  @BuiltValueField(wireName: r'check_out')
  String? get checkOut;

  HrStaffAttendance336RecordsParameterInner._();

  factory HrStaffAttendance336RecordsParameterInner([void updates(HrStaffAttendance336RecordsParameterInnerBuilder b)]) = _$HrStaffAttendance336RecordsParameterInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance336RecordsParameterInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance336RecordsParameterInner> get serializer => _$HrStaffAttendance336RecordsParameterInnerSerializer();
}

class _$HrStaffAttendance336RecordsParameterInnerSerializer implements PrimitiveSerializer<HrStaffAttendance336RecordsParameterInner> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance336RecordsParameterInner, _$HrStaffAttendance336RecordsParameterInner];

  @override
  final String wireName = r'HrStaffAttendance336RecordsParameterInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance336RecordsParameterInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'staff_user_id';
    yield serializers.serialize(
      object.staffUserId,
      specifiedType: const FullType(int),
    );
    yield r'date';
    yield serializers.serialize(
      object.date,
      specifiedType: const FullType(DateTime),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(HrStaffAttendance336RecordsParameterInnerStatusEnum),
    );
    if (object.checkIn != null) {
      yield r'check_in';
      yield serializers.serialize(
        object.checkIn,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.checkOut != null) {
      yield r'check_out';
      yield serializers.serialize(
        object.checkOut,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance336RecordsParameterInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance336RecordsParameterInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'staff_user_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.staffUserId = valueDes;
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.date = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrStaffAttendance336RecordsParameterInnerStatusEnum),
          ) as HrStaffAttendance336RecordsParameterInnerStatusEnum;
          result.status = valueDes;
          break;
        case r'check_in':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.checkIn = valueDes;
          break;
        case r'check_out':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.checkOut = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrStaffAttendance336RecordsParameterInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance336RecordsParameterInnerBuilder();
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

class HrStaffAttendance336RecordsParameterInnerStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'present')
  static const HrStaffAttendance336RecordsParameterInnerStatusEnum present = _$hrStaffAttendance336RecordsParameterInnerStatusEnum_present;
  @BuiltValueEnumConst(wireName: r'absent')
  static const HrStaffAttendance336RecordsParameterInnerStatusEnum absent = _$hrStaffAttendance336RecordsParameterInnerStatusEnum_absent;
  @BuiltValueEnumConst(wireName: r'late')
  static const HrStaffAttendance336RecordsParameterInnerStatusEnum late_ = _$hrStaffAttendance336RecordsParameterInnerStatusEnum_late_;
  @BuiltValueEnumConst(wireName: r'leave')
  static const HrStaffAttendance336RecordsParameterInnerStatusEnum leave = _$hrStaffAttendance336RecordsParameterInnerStatusEnum_leave;

  static Serializer<HrStaffAttendance336RecordsParameterInnerStatusEnum> get serializer => _$hrStaffAttendance336RecordsParameterInnerStatusEnumSerializer;

  const HrStaffAttendance336RecordsParameterInnerStatusEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance336RecordsParameterInnerStatusEnum> get values => _$hrStaffAttendance336RecordsParameterInnerStatusEnumValues;
  static HrStaffAttendance336RecordsParameterInnerStatusEnum valueOf(String name) => _$hrStaffAttendance336RecordsParameterInnerStatusEnumValueOf(name);
}

