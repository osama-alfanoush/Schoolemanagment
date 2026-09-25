//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_announcement_templates200_response_data_templates_inner.g.dart';

/// TeacherAnnouncementTemplates200ResponseDataTemplatesInner
///
/// Properties:
/// * [key] 
/// * [title] 
/// * [body] 
@BuiltValue()
abstract class TeacherAnnouncementTemplates200ResponseDataTemplatesInner implements Built<TeacherAnnouncementTemplates200ResponseDataTemplatesInner, TeacherAnnouncementTemplates200ResponseDataTemplatesInnerBuilder> {
  @BuiltValueField(wireName: r'key')
  String get key;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'body')
  String get body;

  TeacherAnnouncementTemplates200ResponseDataTemplatesInner._();

  factory TeacherAnnouncementTemplates200ResponseDataTemplatesInner([void updates(TeacherAnnouncementTemplates200ResponseDataTemplatesInnerBuilder b)]) = _$TeacherAnnouncementTemplates200ResponseDataTemplatesInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherAnnouncementTemplates200ResponseDataTemplatesInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherAnnouncementTemplates200ResponseDataTemplatesInner> get serializer => _$TeacherAnnouncementTemplates200ResponseDataTemplatesInnerSerializer();
}

class _$TeacherAnnouncementTemplates200ResponseDataTemplatesInnerSerializer implements PrimitiveSerializer<TeacherAnnouncementTemplates200ResponseDataTemplatesInner> {
  @override
  final Iterable<Type> types = const [TeacherAnnouncementTemplates200ResponseDataTemplatesInner, _$TeacherAnnouncementTemplates200ResponseDataTemplatesInner];

  @override
  final String wireName = r'TeacherAnnouncementTemplates200ResponseDataTemplatesInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherAnnouncementTemplates200ResponseDataTemplatesInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'key';
    yield serializers.serialize(
      object.key,
      specifiedType: const FullType(String),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'body';
    yield serializers.serialize(
      object.body,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherAnnouncementTemplates200ResponseDataTemplatesInner object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherAnnouncementTemplates200ResponseDataTemplatesInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.key = valueDes;
          break;
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.body = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherAnnouncementTemplates200ResponseDataTemplatesInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherAnnouncementTemplates200ResponseDataTemplatesInnerBuilder();
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

