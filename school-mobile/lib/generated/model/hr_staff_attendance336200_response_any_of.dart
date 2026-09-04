//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance336200_response_any_of.g.dart';

/// HrStaffAttendance336200ResponseAnyOf
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrStaffAttendance336200ResponseAnyOf implements Built<HrStaffAttendance336200ResponseAnyOf, HrStaffAttendance336200ResponseAnyOfBuilder> {
  @BuiltValueField(wireName: r'message')
  HrStaffAttendance336200ResponseAnyOfMessageEnum get message;
  // enum messageEnum {  Saved,  };

  HrStaffAttendance336200ResponseAnyOf._();

  factory HrStaffAttendance336200ResponseAnyOf([void updates(HrStaffAttendance336200ResponseAnyOfBuilder b)]) = _$HrStaffAttendance336200ResponseAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance336200ResponseAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance336200ResponseAnyOf> get serializer => _$HrStaffAttendance336200ResponseAnyOfSerializer();
}

class _$HrStaffAttendance336200ResponseAnyOfSerializer implements PrimitiveSerializer<HrStaffAttendance336200ResponseAnyOf> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance336200ResponseAnyOf, _$HrStaffAttendance336200ResponseAnyOf];

  @override
  final String wireName = r'HrStaffAttendance336200ResponseAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance336200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(HrStaffAttendance336200ResponseAnyOfMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance336200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance336200ResponseAnyOfBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrStaffAttendance336200ResponseAnyOfMessageEnum),
          ) as HrStaffAttendance336200ResponseAnyOfMessageEnum;
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
  HrStaffAttendance336200ResponseAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance336200ResponseAnyOfBuilder();
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

class HrStaffAttendance336200ResponseAnyOfMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Saved')
  static const HrStaffAttendance336200ResponseAnyOfMessageEnum saved = _$hrStaffAttendance336200ResponseAnyOfMessageEnum_saved;

  static Serializer<HrStaffAttendance336200ResponseAnyOfMessageEnum> get serializer => _$hrStaffAttendance336200ResponseAnyOfMessageEnumSerializer;

  const HrStaffAttendance336200ResponseAnyOfMessageEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance336200ResponseAnyOfMessageEnum> get values => _$hrStaffAttendance336200ResponseAnyOfMessageEnumValues;
  static HrStaffAttendance336200ResponseAnyOfMessageEnum valueOf(String name) => _$hrStaffAttendance336200ResponseAnyOfMessageEnumValueOf(name);
}

