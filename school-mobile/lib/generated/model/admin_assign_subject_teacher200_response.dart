//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'admin_assign_subject_teacher200_response.g.dart';

/// AdminAssignSubjectTeacher200Response
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class AdminAssignSubjectTeacher200Response implements Built<AdminAssignSubjectTeacher200Response, AdminAssignSubjectTeacher200ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  AdminAssignSubjectTeacher200ResponseMessageEnum get message;
  // enum messageEnum {  Assigned,  };

  AdminAssignSubjectTeacher200Response._();

  factory AdminAssignSubjectTeacher200Response([void updates(AdminAssignSubjectTeacher200ResponseBuilder b)]) = _$AdminAssignSubjectTeacher200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AdminAssignSubjectTeacher200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AdminAssignSubjectTeacher200Response> get serializer => _$AdminAssignSubjectTeacher200ResponseSerializer();
}

class _$AdminAssignSubjectTeacher200ResponseSerializer implements PrimitiveSerializer<AdminAssignSubjectTeacher200Response> {
  @override
  final Iterable<Type> types = const [AdminAssignSubjectTeacher200Response, _$AdminAssignSubjectTeacher200Response];

  @override
  final String wireName = r'AdminAssignSubjectTeacher200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AdminAssignSubjectTeacher200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(AdminAssignSubjectTeacher200ResponseMessageEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AdminAssignSubjectTeacher200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AdminAssignSubjectTeacher200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AdminAssignSubjectTeacher200ResponseMessageEnum),
          ) as AdminAssignSubjectTeacher200ResponseMessageEnum;
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
  AdminAssignSubjectTeacher200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AdminAssignSubjectTeacher200ResponseBuilder();
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

class AdminAssignSubjectTeacher200ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Assigned')
  static const AdminAssignSubjectTeacher200ResponseMessageEnum assigned = _$adminAssignSubjectTeacher200ResponseMessageEnum_assigned;

  static Serializer<AdminAssignSubjectTeacher200ResponseMessageEnum> get serializer => _$adminAssignSubjectTeacher200ResponseMessageEnumSerializer;

  const AdminAssignSubjectTeacher200ResponseMessageEnum._(String name): super(name);

  static BuiltSet<AdminAssignSubjectTeacher200ResponseMessageEnum> get values => _$adminAssignSubjectTeacher200ResponseMessageEnumValues;
  static AdminAssignSubjectTeacher200ResponseMessageEnum valueOf(String name) => _$adminAssignSubjectTeacher200ResponseMessageEnumValueOf(name);
}

