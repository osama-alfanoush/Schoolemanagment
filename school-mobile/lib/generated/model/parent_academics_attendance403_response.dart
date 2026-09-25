//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_academics_attendance403_response.g.dart';

/// ParentAcademicsAttendance403Response
///
/// Properties:
/// * [message] 
/// * [errors] 
@BuiltValue()
abstract class ParentAcademicsAttendance403Response implements Built<ParentAcademicsAttendance403Response, ParentAcademicsAttendance403ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  ParentAcademicsAttendance403ResponseMessageEnum get message;
  // enum messageEnum {  You do not have access to this record.,  };

  @BuiltValueField(wireName: r'errors')
  String get errors;

  ParentAcademicsAttendance403Response._();

  factory ParentAcademicsAttendance403Response([void updates(ParentAcademicsAttendance403ResponseBuilder b)]) = _$ParentAcademicsAttendance403Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentAcademicsAttendance403ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentAcademicsAttendance403Response> get serializer => _$ParentAcademicsAttendance403ResponseSerializer();
}

class _$ParentAcademicsAttendance403ResponseSerializer implements PrimitiveSerializer<ParentAcademicsAttendance403Response> {
  @override
  final Iterable<Type> types = const [ParentAcademicsAttendance403Response, _$ParentAcademicsAttendance403Response];

  @override
  final String wireName = r'ParentAcademicsAttendance403Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentAcademicsAttendance403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(ParentAcademicsAttendance403ResponseMessageEnum),
    );
    yield r'errors';
    yield serializers.serialize(
      object.errors,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentAcademicsAttendance403Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentAcademicsAttendance403ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentAcademicsAttendance403ResponseMessageEnum),
          ) as ParentAcademicsAttendance403ResponseMessageEnum;
          result.message = valueDes;
          break;
        case r'errors':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.errors = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentAcademicsAttendance403Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentAcademicsAttendance403ResponseBuilder();
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

class ParentAcademicsAttendance403ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'You do not have access to this record.')
  static const ParentAcademicsAttendance403ResponseMessageEnum youDoNotHaveAccessToThisRecordPeriod = _$parentAcademicsAttendance403ResponseMessageEnum_youDoNotHaveAccessToThisRecordPeriod;

  static Serializer<ParentAcademicsAttendance403ResponseMessageEnum> get serializer => _$parentAcademicsAttendance403ResponseMessageEnumSerializer;

  const ParentAcademicsAttendance403ResponseMessageEnum._(String name): super(name);

  static BuiltSet<ParentAcademicsAttendance403ResponseMessageEnum> get values => _$parentAcademicsAttendance403ResponseMessageEnumValues;
  static ParentAcademicsAttendance403ResponseMessageEnum valueOf(String name) => _$parentAcademicsAttendance403ResponseMessageEnumValueOf(name);
}

