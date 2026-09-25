//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance363_records_parameter_inner.g.dart';

/// HrStaffAttendance363RecordsParameterInner
///
/// Properties:
/// * [staffUserId] 
/// * [date] 
/// * [status] 
/// * [checkIn] 
/// * [checkOut] 
@BuiltValue()
abstract class HrStaffAttendance363RecordsParameterInner implements Built<HrStaffAttendance363RecordsParameterInner, HrStaffAttendance363RecordsParameterInnerBuilder> {
  @BuiltValueField(wireName: r'staff_user_id')
  int get staffUserId;

  @BuiltValueField(wireName: r'date')
  DateTime get date;

  @BuiltValueField(wireName: r'status')
  HrStaffAttendance363RecordsParameterInnerStatusEnum get status;
  // enum statusEnum {  present,  absent,  late,  leave,  };

  @BuiltValueField(wireName: r'check_in')
  String? get checkIn;

  @BuiltValueField(wireName: r'check_out')
  String? get checkOut;

  HrStaffAttendance363RecordsParameterInner._();

  factory HrStaffAttendance363RecordsParameterInner([void updates(HrStaffAttendance363RecordsParameterInnerBuilder b)]) = _$HrStaffAttendance363RecordsParameterInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance363RecordsParameterInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance363RecordsParameterInner> get serializer => _$HrStaffAttendance363RecordsParameterInnerSerializer();
}

class _$HrStaffAttendance363RecordsParameterInnerSerializer implements PrimitiveSerializer<HrStaffAttendance363RecordsParameterInner> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance363RecordsParameterInner, _$HrStaffAttendance363RecordsParameterInner];

  @override
  final String wireName = r'HrStaffAttendance363RecordsParameterInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance363RecordsParameterInner object, {
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
      specifiedType: const FullType(HrStaffAttendance363RecordsParameterInnerStatusEnum),
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
    HrStaffAttendance363RecordsParameterInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance363RecordsParameterInnerBuilder result,
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
            specifiedType: const FullType(HrStaffAttendance363RecordsParameterInnerStatusEnum),
          ) as HrStaffAttendance363RecordsParameterInnerStatusEnum;
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
  HrStaffAttendance363RecordsParameterInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance363RecordsParameterInnerBuilder();
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

class HrStaffAttendance363RecordsParameterInnerStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'present')
  static const HrStaffAttendance363RecordsParameterInnerStatusEnum present = _$hrStaffAttendance363RecordsParameterInnerStatusEnum_present;
  @BuiltValueEnumConst(wireName: r'absent')
  static const HrStaffAttendance363RecordsParameterInnerStatusEnum absent = _$hrStaffAttendance363RecordsParameterInnerStatusEnum_absent;
  @BuiltValueEnumConst(wireName: r'late')
  static const HrStaffAttendance363RecordsParameterInnerStatusEnum late_ = _$hrStaffAttendance363RecordsParameterInnerStatusEnum_late_;
  @BuiltValueEnumConst(wireName: r'leave')
  static const HrStaffAttendance363RecordsParameterInnerStatusEnum leave = _$hrStaffAttendance363RecordsParameterInnerStatusEnum_leave;

  static Serializer<HrStaffAttendance363RecordsParameterInnerStatusEnum> get serializer => _$hrStaffAttendance363RecordsParameterInnerStatusEnumSerializer;

  const HrStaffAttendance363RecordsParameterInnerStatusEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance363RecordsParameterInnerStatusEnum> get values => _$hrStaffAttendance363RecordsParameterInnerStatusEnumValues;
  static HrStaffAttendance363RecordsParameterInnerStatusEnum valueOf(String name) => _$hrStaffAttendance363RecordsParameterInnerStatusEnumValueOf(name);
}

