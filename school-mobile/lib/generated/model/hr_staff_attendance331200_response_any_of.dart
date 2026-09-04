//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance331200_response_any_of.g.dart';

/// HrStaffAttendance331200ResponseAnyOf
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrStaffAttendance331200ResponseAnyOf implements Built<HrStaffAttendance331200ResponseAnyOf, HrStaffAttendance331200ResponseAnyOfBuilder> {
  @BuiltValueField(wireName: r'message')
  HrStaffAttendance331200ResponseAnyOfMessageEnum get message;
  // enum messageEnum {  Saved,  };

  HrStaffAttendance331200ResponseAnyOf._();

  factory HrStaffAttendance331200ResponseAnyOf([void updates(HrStaffAttendance331200ResponseAnyOfBuilder b)]) = _$HrStaffAttendance331200ResponseAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance331200ResponseAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance331200ResponseAnyOf> get serializer => _$HrStaffAttendance331200ResponseAnyOfSerializer();
}

class _$HrStaffAttendance331200ResponseAnyOfSerializer implements PrimitiveSerializer<HrStaffAttendance331200ResponseAnyOf> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance331200ResponseAnyOf, _$HrStaffAttendance331200ResponseAnyOf];

  @override
  final String wireName = r'HrStaffAttendance331200ResponseAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance331200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(HrStaffAttendance331200ResponseAnyOfMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance331200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance331200ResponseAnyOfBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrStaffAttendance331200ResponseAnyOfMessageEnum),
          ) as HrStaffAttendance331200ResponseAnyOfMessageEnum;
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
  HrStaffAttendance331200ResponseAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance331200ResponseAnyOfBuilder();
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

class HrStaffAttendance331200ResponseAnyOfMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Saved')
  static const HrStaffAttendance331200ResponseAnyOfMessageEnum saved = _$hrStaffAttendance331200ResponseAnyOfMessageEnum_saved;

  static Serializer<HrStaffAttendance331200ResponseAnyOfMessageEnum> get serializer => _$hrStaffAttendance331200ResponseAnyOfMessageEnumSerializer;

  const HrStaffAttendance331200ResponseAnyOfMessageEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance331200ResponseAnyOfMessageEnum> get values => _$hrStaffAttendance331200ResponseAnyOfMessageEnumValues;
  static HrStaffAttendance331200ResponseAnyOfMessageEnum valueOf(String name) => _$hrStaffAttendance331200ResponseAnyOfMessageEnumValueOf(name);
}

