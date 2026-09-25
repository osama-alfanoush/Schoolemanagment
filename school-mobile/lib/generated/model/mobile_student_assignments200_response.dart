//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/mobile_student_assignments200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'mobile_student_assignments200_response.g.dart';

/// MobileStudentAssignments200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class MobileStudentAssignments200Response implements Built<MobileStudentAssignments200Response, MobileStudentAssignments200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  MobileStudentAssignments200ResponseData get data;

  MobileStudentAssignments200Response._();

  factory MobileStudentAssignments200Response([void updates(MobileStudentAssignments200ResponseBuilder b)]) = _$MobileStudentAssignments200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MobileStudentAssignments200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MobileStudentAssignments200Response> get serializer => _$MobileStudentAssignments200ResponseSerializer();
}

class _$MobileStudentAssignments200ResponseSerializer implements PrimitiveSerializer<MobileStudentAssignments200Response> {
  @override
  final Iterable<Type> types = const [MobileStudentAssignments200Response, _$MobileStudentAssignments200Response];

  @override
  final String wireName = r'MobileStudentAssignments200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MobileStudentAssignments200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(MobileStudentAssignments200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MobileStudentAssignments200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MobileStudentAssignments200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MobileStudentAssignments200ResponseData),
          ) as MobileStudentAssignments200ResponseData;
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
  MobileStudentAssignments200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MobileStudentAssignments200ResponseBuilder();
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

