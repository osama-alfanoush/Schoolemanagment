//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance322_records_parameter_inner.g.dart';

/// HrStaffAttendance322RecordsParameterInner
///
/// Properties:
/// * [staffUserId] 
/// * [date] 
/// * [status] 
/// * [checkIn] 
/// * [checkOut] 
@BuiltValue()
abstract class HrStaffAttendance322RecordsParameterInner implements Built<HrStaffAttendance322RecordsParameterInner, HrStaffAttendance322RecordsParameterInnerBuilder> {
  @BuiltValueField(wireName: r'staff_user_id')
  int get staffUserId;

  @BuiltValueField(wireName: r'date')
  DateTime get date;

  @BuiltValueField(wireName: r'status')
  HrStaffAttendance322RecordsParameterInnerStatusEnum get status;
  // enum statusEnum {  present,  absent,  late,  leave,  };

  @BuiltValueField(wireName: r'check_in')
  String? get checkIn;

  @BuiltValueField(wireName: r'check_out')
  String? get checkOut;

  HrStaffAttendance322RecordsParameterInner._();

  factory HrStaffAttendance322RecordsParameterInner([void updates(HrStaffAttendance322RecordsParameterInnerBuilder b)]) = _$HrStaffAttendance322RecordsParameterInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance322RecordsParameterInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance322RecordsParameterInner> get serializer => _$HrStaffAttendance322RecordsParameterInnerSerializer();
}

class _$HrStaffAttendance322RecordsParameterInnerSerializer implements PrimitiveSerializer<HrStaffAttendance322RecordsParameterInner> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance322RecordsParameterInner, _$HrStaffAttendance322RecordsParameterInner];

  @override
  final String wireName = r'HrStaffAttendance322RecordsParameterInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance322RecordsParameterInner object, {
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
      specifiedType: const FullType(HrStaffAttendance322RecordsParameterInnerStatusEnum),
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
    HrStaffAttendance322RecordsParameterInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance322RecordsParameterInnerBuilder result,
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
            specifiedType: const FullType(HrStaffAttendance322RecordsParameterInnerStatusEnum),
          ) as HrStaffAttendance322RecordsParameterInnerStatusEnum;
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
  HrStaffAttendance322RecordsParameterInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance322RecordsParameterInnerBuilder();
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

class HrStaffAttendance322RecordsParameterInnerStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'present')
  static const HrStaffAttendance322RecordsParameterInnerStatusEnum present = _$hrStaffAttendance322RecordsParameterInnerStatusEnum_present;
  @BuiltValueEnumConst(wireName: r'absent')
  static const HrStaffAttendance322RecordsParameterInnerStatusEnum absent = _$hrStaffAttendance322RecordsParameterInnerStatusEnum_absent;
  @BuiltValueEnumConst(wireName: r'late')
  static const HrStaffAttendance322RecordsParameterInnerStatusEnum late_ = _$hrStaffAttendance322RecordsParameterInnerStatusEnum_late_;
  @BuiltValueEnumConst(wireName: r'leave')
  static const HrStaffAttendance322RecordsParameterInnerStatusEnum leave = _$hrStaffAttendance322RecordsParameterInnerStatusEnum_leave;

  static Serializer<HrStaffAttendance322RecordsParameterInnerStatusEnum> get serializer => _$hrStaffAttendance322RecordsParameterInnerStatusEnumSerializer;

  const HrStaffAttendance322RecordsParameterInnerStatusEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance322RecordsParameterInnerStatusEnum> get values => _$hrStaffAttendance322RecordsParameterInnerStatusEnumValues;
  static HrStaffAttendance322RecordsParameterInnerStatusEnum valueOf(String name) => _$hrStaffAttendance322RecordsParameterInnerStatusEnumValueOf(name);
}

