//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mobile_student_assignments200_response_data_any_of1.g.dart';

/// MobileStudentAssignments200ResponseDataAnyOf1
///
/// Properties:
/// * [assignments] 
@BuiltValue()
abstract class MobileStudentAssignments200ResponseDataAnyOf1 implements Built<MobileStudentAssignments200ResponseDataAnyOf1, MobileStudentAssignments200ResponseDataAnyOf1Builder> {
  @BuiltValueField(wireName: r'assignments')
  BuiltList<String> get assignments;

  MobileStudentAssignments200ResponseDataAnyOf1._();

  factory MobileStudentAssignments200ResponseDataAnyOf1([void updates(MobileStudentAssignments200ResponseDataAnyOf1Builder b)]) = _$MobileStudentAssignments200ResponseDataAnyOf1;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MobileStudentAssignments200ResponseDataAnyOf1Builder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MobileStudentAssignments200ResponseDataAnyOf1> get serializer => _$MobileStudentAssignments200ResponseDataAnyOf1Serializer();
}

class _$MobileStudentAssignments200ResponseDataAnyOf1Serializer implements PrimitiveSerializer<MobileStudentAssignments200ResponseDataAnyOf1> {
  @override
  final Iterable<Type> types = const [MobileStudentAssignments200ResponseDataAnyOf1, _$MobileStudentAssignments200ResponseDataAnyOf1];

  @override
  final String wireName = r'MobileStudentAssignments200ResponseDataAnyOf1';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MobileStudentAssignments200ResponseDataAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'assignments';
    yield serializers.serialize(
      object.assignments,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MobileStudentAssignments200ResponseDataAnyOf1 object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MobileStudentAssignments200ResponseDataAnyOf1Builder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'assignments':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.assignments.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MobileStudentAssignments200ResponseDataAnyOf1 deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MobileStudentAssignments200ResponseDataAnyOf1Builder();
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

