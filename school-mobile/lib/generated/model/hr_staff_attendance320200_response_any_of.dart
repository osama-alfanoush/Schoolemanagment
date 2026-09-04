//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance320200_response_any_of.g.dart';

/// HrStaffAttendance320200ResponseAnyOf
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrStaffAttendance320200ResponseAnyOf implements Built<HrStaffAttendance320200ResponseAnyOf, HrStaffAttendance320200ResponseAnyOfBuilder> {
  @BuiltValueField(wireName: r'message')
  HrStaffAttendance320200ResponseAnyOfMessageEnum get message;
  // enum messageEnum {  Saved,  };

  HrStaffAttendance320200ResponseAnyOf._();

  factory HrStaffAttendance320200ResponseAnyOf([void updates(HrStaffAttendance320200ResponseAnyOfBuilder b)]) = _$HrStaffAttendance320200ResponseAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance320200ResponseAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance320200ResponseAnyOf> get serializer => _$HrStaffAttendance320200ResponseAnyOfSerializer();
}

class _$HrStaffAttendance320200ResponseAnyOfSerializer implements PrimitiveSerializer<HrStaffAttendance320200ResponseAnyOf> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance320200ResponseAnyOf, _$HrStaffAttendance320200ResponseAnyOf];

  @override
  final String wireName = r'HrStaffAttendance320200ResponseAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance320200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(HrStaffAttendance320200ResponseAnyOfMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance320200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance320200ResponseAnyOfBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrStaffAttendance320200ResponseAnyOfMessageEnum),
          ) as HrStaffAttendance320200ResponseAnyOfMessageEnum;
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
  HrStaffAttendance320200ResponseAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance320200ResponseAnyOfBuilder();
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

class HrStaffAttendance320200ResponseAnyOfMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Saved')
  static const HrStaffAttendance320200ResponseAnyOfMessageEnum saved = _$hrStaffAttendance320200ResponseAnyOfMessageEnum_saved;

  static Serializer<HrStaffAttendance320200ResponseAnyOfMessageEnum> get serializer => _$hrStaffAttendance320200ResponseAnyOfMessageEnumSerializer;

  const HrStaffAttendance320200ResponseAnyOfMessageEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance320200ResponseAnyOfMessageEnum> get values => _$hrStaffAttendance320200ResponseAnyOfMessageEnumValues;
  static HrStaffAttendance320200ResponseAnyOfMessageEnum valueOf(String name) => _$hrStaffAttendance320200ResponseAnyOfMessageEnumValueOf(name);
}

