//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:school_mobile/generated/model/teacher_announcement_templates200_response_data.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_announcement_templates200_response.g.dart';

/// TeacherAnnouncementTemplates200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class TeacherAnnouncementTemplates200Response implements Built<TeacherAnnouncementTemplates200Response, TeacherAnnouncementTemplates200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  TeacherAnnouncementTemplates200ResponseData get data;

  TeacherAnnouncementTemplates200Response._();

  factory TeacherAnnouncementTemplates200Response([void updates(TeacherAnnouncementTemplates200ResponseBuilder b)]) = _$TeacherAnnouncementTemplates200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherAnnouncementTemplates200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherAnnouncementTemplates200Response> get serializer => _$TeacherAnnouncementTemplates200ResponseSerializer();
}

class _$TeacherAnnouncementTemplates200ResponseSerializer implements PrimitiveSerializer<TeacherAnnouncementTemplates200Response> {
  @override
  final Iterable<Type> types = const [TeacherAnnouncementTemplates200Response, _$TeacherAnnouncementTemplates200Response];

  @override
  final String wireName = r'TeacherAnnouncementTemplates200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherAnnouncementTemplates200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(TeacherAnnouncementTemplates200ResponseData),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherAnnouncementTemplates200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherAnnouncementTemplates200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TeacherAnnouncementTemplates200ResponseData),
          ) as TeacherAnnouncementTemplates200ResponseData;
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
  TeacherAnnouncementTemplates200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherAnnouncementTemplates200ResponseBuilder();
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

