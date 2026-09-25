//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/student_home200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'student_home200_response.g.dart';

/// StudentHome200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class StudentHome200Response implements Built<StudentHome200Response, StudentHome200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  StudentHome200ResponseData get data;

  StudentHome200Response._();

  factory StudentHome200Response([void updates(StudentHome200ResponseBuilder b)]) = _$StudentHome200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StudentHome200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StudentHome200Response> get serializer => _$StudentHome200ResponseSerializer();
}

class _$StudentHome200ResponseSerializer implements PrimitiveSerializer<StudentHome200Response> {
  @override
  final Iterable<Type> types = const [StudentHome200Response, _$StudentHome200Response];

  @override
  final String wireName = r'StudentHome200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StudentHome200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(StudentHome200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StudentHome200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required StudentHome200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(StudentHome200ResponseData),
          ) as StudentHome200ResponseData;
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
  StudentHome200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StudentHome200ResponseBuilder();
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

