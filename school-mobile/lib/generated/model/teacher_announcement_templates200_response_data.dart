//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:school_mobile/generated/model/teacher_announcement_templates200_response_data_templates_inner.dart';
import 'package:school_mobile/generated/model/parent_inbox_conversation200_response_data_reply_window.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'teacher_announcement_templates200_response_data.g.dart';

/// TeacherAnnouncementTemplates200ResponseData
///
/// Properties:
/// * [templates] 
/// * [window] 
/// * [openNow] 
@BuiltValue()
abstract class TeacherAnnouncementTemplates200ResponseData implements Built<TeacherAnnouncementTemplates200ResponseData, TeacherAnnouncementTemplates200ResponseDataBuilder> {
  @BuiltValueField(wireName: r'templates')
  BuiltList<TeacherAnnouncementTemplates200ResponseDataTemplatesInner> get templates;

  @BuiltValueField(wireName: r'window')
  ParentInboxConversation200ResponseDataReplyWindow get window;

  @BuiltValueField(wireName: r'open_now')
  bool get openNow;

  TeacherAnnouncementTemplates200ResponseData._();

  factory TeacherAnnouncementTemplates200ResponseData([void updates(TeacherAnnouncementTemplates200ResponseDataBuilder b)]) = _$TeacherAnnouncementTemplates200ResponseData;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TeacherAnnouncementTemplates200ResponseDataBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TeacherAnnouncementTemplates200ResponseData> get serializer => _$TeacherAnnouncementTemplates200ResponseDataSerializer();
}

class _$TeacherAnnouncementTemplates200ResponseDataSerializer implements PrimitiveSerializer<TeacherAnnouncementTemplates200ResponseData> {
  @override
  final Iterable<Type> types = const [TeacherAnnouncementTemplates200ResponseData, _$TeacherAnnouncementTemplates200ResponseData];

  @override
  final String wireName = r'TeacherAnnouncementTemplates200ResponseData';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TeacherAnnouncementTemplates200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'templates';
    yield serializers.serialize(
      object.templates,
      specifiedType: const FullType(BuiltList, [FullType(TeacherAnnouncementTemplates200ResponseDataTemplatesInner)]),
    );
    yield r'window';
    yield serializers.serialize(
      object.window,
      specifiedType: const FullType(ParentInboxConversation200ResponseDataReplyWindow),
    );
    yield r'open_now';
    yield serializers.serialize(
      object.openNow,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TeacherAnnouncementTemplates200ResponseData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TeacherAnnouncementTemplates200ResponseDataBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'templates':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(TeacherAnnouncementTemplates200ResponseDataTemplatesInner)]),
          ) as BuiltList<TeacherAnnouncementTemplates200ResponseDataTemplatesInner>;
          result.templates.replace(valueDes);
          break;
        case r'window':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentInboxConversation200ResponseDataReplyWindow),
          ) as ParentInboxConversation200ResponseDataReplyWindow;
          result.window.replace(valueDes);
          break;
        case r'open_now':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.openNow = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TeacherAnnouncementTemplates200ResponseData deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TeacherAnnouncementTemplates200ResponseDataBuilder();
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

