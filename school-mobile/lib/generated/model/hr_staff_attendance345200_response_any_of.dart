//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance345200_response_any_of.g.dart';

/// HrStaffAttendance345200ResponseAnyOf
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrStaffAttendance345200ResponseAnyOf implements Built<HrStaffAttendance345200ResponseAnyOf, HrStaffAttendance345200ResponseAnyOfBuilder> {
  @BuiltValueField(wireName: r'message')
  HrStaffAttendance345200ResponseAnyOfMessageEnum get message;
  // enum messageEnum {  Saved,  };

  HrStaffAttendance345200ResponseAnyOf._();

  factory HrStaffAttendance345200ResponseAnyOf([void updates(HrStaffAttendance345200ResponseAnyOfBuilder b)]) = _$HrStaffAttendance345200ResponseAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance345200ResponseAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance345200ResponseAnyOf> get serializer => _$HrStaffAttendance345200ResponseAnyOfSerializer();
}

class _$HrStaffAttendance345200ResponseAnyOfSerializer implements PrimitiveSerializer<HrStaffAttendance345200ResponseAnyOf> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance345200ResponseAnyOf, _$HrStaffAttendance345200ResponseAnyOf];

  @override
  final String wireName = r'HrStaffAttendance345200ResponseAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance345200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(HrStaffAttendance345200ResponseAnyOfMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance345200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance345200ResponseAnyOfBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrStaffAttendance345200ResponseAnyOfMessageEnum),
          ) as HrStaffAttendance345200ResponseAnyOfMessageEnum;
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
  HrStaffAttendance345200ResponseAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance345200ResponseAnyOfBuilder();
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

class HrStaffAttendance345200ResponseAnyOfMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Saved')
  static const HrStaffAttendance345200ResponseAnyOfMessageEnum saved = _$hrStaffAttendance345200ResponseAnyOfMessageEnum_saved;

  static Serializer<HrStaffAttendance345200ResponseAnyOfMessageEnum> get serializer => _$hrStaffAttendance345200ResponseAnyOfMessageEnumSerializer;

  const HrStaffAttendance345200ResponseAnyOfMessageEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance345200ResponseAnyOfMessageEnum> get values => _$hrStaffAttendance345200ResponseAnyOfMessageEnumValues;
  static HrStaffAttendance345200ResponseAnyOfMessageEnum valueOf(String name) => _$hrStaffAttendance345200ResponseAnyOfMessageEnumValueOf(name);
}

