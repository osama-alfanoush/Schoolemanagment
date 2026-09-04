//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/parent_academics_attendance200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_academics_attendance200_response.g.dart';

/// ParentAcademicsAttendance200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentAcademicsAttendance200Response implements Built<ParentAcademicsAttendance200Response, ParentAcademicsAttendance200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  ParentAcademicsAttendance200ResponseData get data;

  ParentAcademicsAttendance200Response._();

  factory ParentAcademicsAttendance200Response([void updates(ParentAcademicsAttendance200ResponseBuilder b)]) = _$ParentAcademicsAttendance200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentAcademicsAttendance200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentAcademicsAttendance200Response> get serializer => _$ParentAcademicsAttendance200ResponseSerializer();
}

class _$ParentAcademicsAttendance200ResponseSerializer implements PrimitiveSerializer<ParentAcademicsAttendance200Response> {
  @override
  final Iterable<Type> types = const [ParentAcademicsAttendance200Response, _$ParentAcademicsAttendance200Response];

  @override
  final String wireName = r'ParentAcademicsAttendance200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentAcademicsAttendance200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(ParentAcademicsAttendance200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentAcademicsAttendance200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentAcademicsAttendance200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentAcademicsAttendance200ResponseData),
          ) as ParentAcademicsAttendance200ResponseData;
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
  ParentAcademicsAttendance200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentAcademicsAttendance200ResponseBuilder();
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

