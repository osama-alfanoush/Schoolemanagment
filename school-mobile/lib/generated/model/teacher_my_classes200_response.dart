//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/class_room.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_my_classes200_response.g.dart';

/// TeacherMyClasses200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class TeacherMyClasses200Response implements Built<TeacherMyClasses200Response, TeacherMyClasses200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<ClassRoom> get data;

  TeacherMyClasses200Response._();

  factory TeacherMyClasses200Response([void updates(TeacherMyClasses200ResponseBuilder b)]) = _$TeacherMyClasses200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherMyClasses200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherMyClasses200Response> get serializer => _$TeacherMyClasses200ResponseSerializer();
}

class _$TeacherMyClasses200ResponseSerializer implements PrimitiveSerializer<TeacherMyClasses200Response> {
  @override
  final Iterable<Type> types = const [TeacherMyClasses200Response, _$TeacherMyClasses200Response];

  @override
  final String wireName = r'TeacherMyClasses200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherMyClasses200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(ClassRoom)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherMyClasses200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherMyClasses200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ClassRoom)]),
          ) as BuiltList<ClassRoom>;
          result.data.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherMyClasses200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherMyClasses200ResponseBuilder();
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

