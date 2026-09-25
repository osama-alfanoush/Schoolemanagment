//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance363200_response_any_of.g.dart';

/// HrStaffAttendance363200ResponseAnyOf
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrStaffAttendance363200ResponseAnyOf implements Built<HrStaffAttendance363200ResponseAnyOf, HrStaffAttendance363200ResponseAnyOfBuilder> {
  @BuiltValueField(wireName: r'message')
  HrStaffAttendance363200ResponseAnyOfMessageEnum get message;
  // enum messageEnum {  Saved,  };

  HrStaffAttendance363200ResponseAnyOf._();

  factory HrStaffAttendance363200ResponseAnyOf([void updates(HrStaffAttendance363200ResponseAnyOfBuilder b)]) = _$HrStaffAttendance363200ResponseAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance363200ResponseAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance363200ResponseAnyOf> get serializer => _$HrStaffAttendance363200ResponseAnyOfSerializer();
}

class _$HrStaffAttendance363200ResponseAnyOfSerializer implements PrimitiveSerializer<HrStaffAttendance363200ResponseAnyOf> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance363200ResponseAnyOf, _$HrStaffAttendance363200ResponseAnyOf];

  @override
  final String wireName = r'HrStaffAttendance363200ResponseAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance363200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(HrStaffAttendance363200ResponseAnyOfMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance363200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance363200ResponseAnyOfBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrStaffAttendance363200ResponseAnyOfMessageEnum),
          ) as HrStaffAttendance363200ResponseAnyOfMessageEnum;
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
  HrStaffAttendance363200ResponseAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance363200ResponseAnyOfBuilder();
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

class HrStaffAttendance363200ResponseAnyOfMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Saved')
  static const HrStaffAttendance363200ResponseAnyOfMessageEnum saved = _$hrStaffAttendance363200ResponseAnyOfMessageEnum_saved;

  static Serializer<HrStaffAttendance363200ResponseAnyOfMessageEnum> get serializer => _$hrStaffAttendance363200ResponseAnyOfMessageEnumSerializer;

  const HrStaffAttendance363200ResponseAnyOfMessageEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance363200ResponseAnyOfMessageEnum> get values => _$hrStaffAttendance363200ResponseAnyOfMessageEnumValues;
  static HrStaffAttendance363200ResponseAnyOfMessageEnum valueOf(String name) => _$hrStaffAttendance363200ResponseAnyOfMessageEnumValueOf(name);
}

