//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance322200_response_any_of.g.dart';

/// HrStaffAttendance322200ResponseAnyOf
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrStaffAttendance322200ResponseAnyOf implements Built<HrStaffAttendance322200ResponseAnyOf, HrStaffAttendance322200ResponseAnyOfBuilder> {
  @BuiltValueField(wireName: r'message')
  HrStaffAttendance322200ResponseAnyOfMessageEnum get message;
  // enum messageEnum {  Saved,  };

  HrStaffAttendance322200ResponseAnyOf._();

  factory HrStaffAttendance322200ResponseAnyOf([void updates(HrStaffAttendance322200ResponseAnyOfBuilder b)]) = _$HrStaffAttendance322200ResponseAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance322200ResponseAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance322200ResponseAnyOf> get serializer => _$HrStaffAttendance322200ResponseAnyOfSerializer();
}

class _$HrStaffAttendance322200ResponseAnyOfSerializer implements PrimitiveSerializer<HrStaffAttendance322200ResponseAnyOf> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance322200ResponseAnyOf, _$HrStaffAttendance322200ResponseAnyOf];

  @override
  final String wireName = r'HrStaffAttendance322200ResponseAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance322200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(HrStaffAttendance322200ResponseAnyOfMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance322200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance322200ResponseAnyOfBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrStaffAttendance322200ResponseAnyOfMessageEnum),
          ) as HrStaffAttendance322200ResponseAnyOfMessageEnum;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  HrStaffAttendance322200ResponseAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance322200ResponseAnyOfBuilder();
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

class HrStaffAttendance322200ResponseAnyOfMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Saved')
  static const HrStaffAttendance322200ResponseAnyOfMessageEnum saved = _$hrStaffAttendance322200ResponseAnyOfMessageEnum_saved;

  static Serializer<HrStaffAttendance322200ResponseAnyOfMessageEnum> get serializer => _$hrStaffAttendance322200ResponseAnyOfMessageEnumSerializer;

  const HrStaffAttendance322200ResponseAnyOfMessageEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance322200ResponseAnyOfMessageEnum> get values => _$hrStaffAttendance322200ResponseAnyOfMessageEnumValues;
  static HrStaffAttendance322200ResponseAnyOfMessageEnum valueOf(String name) => _$hrStaffAttendance322200ResponseAnyOfMessageEnumValueOf(name);
}

