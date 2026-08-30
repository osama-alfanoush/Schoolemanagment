//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/grade.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_child_grades200_response.g.dart';

/// ParentChildGrades200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentChildGrades200Response implements Built<ParentChildGrades200Response, ParentChildGrades200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltList<Grade> get data;

  ParentChildGrades200Response._();

  factory ParentChildGrades200Response([void updates(ParentChildGrades200ResponseBuilder b)]) = _$ParentChildGrades200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentChildGrades200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentChildGrades200Response> get serializer => _$ParentChildGrades200ResponseSerializer();
}

class _$ParentChildGrades200ResponseSerializer implements PrimitiveSerializer<ParentChildGrades200Response> {
  @override
  final Iterable<Type> types = const [ParentChildGrades200Response, _$ParentChildGrades200Response];

  @override
  final String wireName = r'ParentChildGrades200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentChildGrades200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltList, [FullType(Grade)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentChildGrades200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentChildGrades200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Grade)]),
          ) as BuiltList<Grade>;
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
  ParentChildGrades200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentChildGrades200ResponseBuilder();
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

