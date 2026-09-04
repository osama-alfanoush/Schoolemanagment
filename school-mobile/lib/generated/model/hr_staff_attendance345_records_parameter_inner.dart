//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance345_records_parameter_inner.g.dart';

/// HrStaffAttendance345RecordsParameterInner
///
/// Properties:
/// * [staffUserId] 
/// * [date] 
/// * [status] 
/// * [checkIn] 
/// * [checkOut] 
@BuiltValue()
abstract class HrStaffAttendance345RecordsParameterInner implements Built<HrStaffAttendance345RecordsParameterInner, HrStaffAttendance345RecordsParameterInnerBuilder> {
  @BuiltValueField(wireName: r'staff_user_id')
  int get staffUserId;

  @BuiltValueField(wireName: r'date')
  DateTime get date;

  @BuiltValueField(wireName: r'status')
  HrStaffAttendance345RecordsParameterInnerStatusEnum get status;
  // enum statusEnum {  present,  absent,  late,  leave,  };

  @BuiltValueField(wireName: r'check_in')
  String? get checkIn;

  @BuiltValueField(wireName: r'check_out')
  String? get checkOut;

  HrStaffAttendance345RecordsParameterInner._();

  factory HrStaffAttendance345RecordsParameterInner([void updates(HrStaffAttendance345RecordsParameterInnerBuilder b)]) = _$HrStaffAttendance345RecordsParameterInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance345RecordsParameterInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance345RecordsParameterInner> get serializer => _$HrStaffAttendance345RecordsParameterInnerSerializer();
}

class _$HrStaffAttendance345RecordsParameterInnerSerializer implements PrimitiveSerializer<HrStaffAttendance345RecordsParameterInner> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance345RecordsParameterInner, _$HrStaffAttendance345RecordsParameterInner];

  @override
  final String wireName = r'HrStaffAttendance345RecordsParameterInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance345RecordsParameterInner object, {
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
      specifiedType: const FullType(HrStaffAttendance345RecordsParameterInnerStatusEnum),
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
    HrStaffAttendance345RecordsParameterInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance345RecordsParameterInnerBuilder result,
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
            specifiedType: const FullType(HrStaffAttendance345RecordsParameterInnerStatusEnum),
          ) as HrStaffAttendance345RecordsParameterInnerStatusEnum;
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
  HrStaffAttendance345RecordsParameterInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance345RecordsParameterInnerBuilder();
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

class HrStaffAttendance345RecordsParameterInnerStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'present')
  static const HrStaffAttendance345RecordsParameterInnerStatusEnum present = _$hrStaffAttendance345RecordsParameterInnerStatusEnum_present;
  @BuiltValueEnumConst(wireName: r'absent')
  static const HrStaffAttendance345RecordsParameterInnerStatusEnum absent = _$hrStaffAttendance345RecordsParameterInnerStatusEnum_absent;
  @BuiltValueEnumConst(wireName: r'late')
  static const HrStaffAttendance345RecordsParameterInnerStatusEnum late_ = _$hrStaffAttendance345RecordsParameterInnerStatusEnum_late_;
  @BuiltValueEnumConst(wireName: r'leave')
  static const HrStaffAttendance345RecordsParameterInnerStatusEnum leave = _$hrStaffAttendance345RecordsParameterInnerStatusEnum_leave;

  static Serializer<HrStaffAttendance345RecordsParameterInnerStatusEnum> get serializer => _$hrStaffAttendance345RecordsParameterInnerStatusEnumSerializer;

  const HrStaffAttendance345RecordsParameterInnerStatusEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance345RecordsParameterInnerStatusEnum> get values => _$hrStaffAttendance345RecordsParameterInnerStatusEnumValues;
  static HrStaffAttendance345RecordsParameterInnerStatusEnum valueOf(String name) => _$hrStaffAttendance345RecordsParameterInnerStatusEnumValueOf(name);
}

