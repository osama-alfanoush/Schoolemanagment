//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hr_staff_attendance319200_response_any_of.g.dart';

/// HrStaffAttendance319200ResponseAnyOf
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class HrStaffAttendance319200ResponseAnyOf implements Built<HrStaffAttendance319200ResponseAnyOf, HrStaffAttendance319200ResponseAnyOfBuilder> {
  @BuiltValueField(wireName: r'message')
  HrStaffAttendance319200ResponseAnyOfMessageEnum get message;
  // enum messageEnum {  Saved,  };

  HrStaffAttendance319200ResponseAnyOf._();

  factory HrStaffAttendance319200ResponseAnyOf([void updates(HrStaffAttendance319200ResponseAnyOfBuilder b)]) = _$HrStaffAttendance319200ResponseAnyOf;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(HrStaffAttendance319200ResponseAnyOfBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<HrStaffAttendance319200ResponseAnyOf> get serializer => _$HrStaffAttendance319200ResponseAnyOfSerializer();
}

class _$HrStaffAttendance319200ResponseAnyOfSerializer implements PrimitiveSerializer<HrStaffAttendance319200ResponseAnyOf> {
  @override
  final Iterable<Type> types = const [HrStaffAttendance319200ResponseAnyOf, _$HrStaffAttendance319200ResponseAnyOf];

  @override
  final String wireName = r'HrStaffAttendance319200ResponseAnyOf';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    HrStaffAttendance319200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(HrStaffAttendance319200ResponseAnyOfMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    HrStaffAttendance319200ResponseAnyOf object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required HrStaffAttendance319200ResponseAnyOfBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(HrStaffAttendance319200ResponseAnyOfMessageEnum),
          ) as HrStaffAttendance319200ResponseAnyOfMessageEnum;
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
  HrStaffAttendance319200ResponseAnyOf deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = HrStaffAttendance319200ResponseAnyOfBuilder();
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

class HrStaffAttendance319200ResponseAnyOfMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Saved')
  static const HrStaffAttendance319200ResponseAnyOfMessageEnum saved = _$hrStaffAttendance319200ResponseAnyOfMessageEnum_saved;

  static Serializer<HrStaffAttendance319200ResponseAnyOfMessageEnum> get serializer => _$hrStaffAttendance319200ResponseAnyOfMessageEnumSerializer;

  const HrStaffAttendance319200ResponseAnyOfMessageEnum._(String name): super(name);

  static BuiltSet<HrStaffAttendance319200ResponseAnyOfMessageEnum> get values => _$hrStaffAttendance319200ResponseAnyOfMessageEnumValues;
  static HrStaffAttendance319200ResponseAnyOfMessageEnum valueOf(String name) => _$hrStaffAttendance319200ResponseAnyOfMessageEnumValueOf(name);
}

