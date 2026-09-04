//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance325200_response_any_of.g.dart';

/// HrStaffAttendance325200ResponseAnyOf
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrStaffAttendance325200ResponseAnyOf implements Built<HrStaffAttendance325200ResponseAnyOf, HrStaffAttendance325200ResponseAnyOfBuilder> {
  @BuiltValueField(wireName: r'message')
  HrStaffAttendance325200ResponseAnyOfMessageEnum get message;
  // enum messageEnum {  Saved,  };

  HrStaffAttendance325200ResponseAnyOf._();

  factory HrStaffAttendance325200ResponseAnyOf([void updates(HrStaffAttendance325200ResponseAnyOfBuilder b)]) = _$HrStaffAttendance325200ResponseAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance325200ResponseAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance325200ResponseAnyOf> get serializer => _$HrStaffAttendance325200ResponseAnyOfSerializer();
}

class _$HrStaffAttendance325200ResponseAnyOfSerializer implements PrimitiveSerializer<HrStaffAttendance325200ResponseAnyOf> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance325200ResponseAnyOf, _$HrStaffAttendance325200ResponseAnyOf];

  @override
  final String wireName = r'HrStaffAttendance325200ResponseAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance325200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(HrStaffAttendance325200ResponseAnyOfMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance325200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance325200ResponseAnyOfBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrStaffAttendance325200ResponseAnyOfMessageEnum),
          ) as HrStaffAttendance325200ResponseAnyOfMessageEnum;
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
  HrStaffAttendance325200ResponseAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance325200ResponseAnyOfBuilder();
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

class HrStaffAttendance325200ResponseAnyOfMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Saved')
  static const HrStaffAttendance325200ResponseAnyOfMessageEnum saved = _$hrStaffAttendance325200ResponseAnyOfMessageEnum_saved;

  static Serializer<HrStaffAttendance325200ResponseAnyOfMessageEnum> get serializer => _$hrStaffAttendance325200ResponseAnyOfMessageEnumSerializer;

  const HrStaffAttendance325200ResponseAnyOfMessageEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance325200ResponseAnyOfMessageEnum> get values => _$hrStaffAttendance325200ResponseAnyOfMessageEnumValues;
  static HrStaffAttendance325200ResponseAnyOfMessageEnum valueOf(String name) => _$hrStaffAttendance325200ResponseAnyOfMessageEnumValueOf(name);
}

