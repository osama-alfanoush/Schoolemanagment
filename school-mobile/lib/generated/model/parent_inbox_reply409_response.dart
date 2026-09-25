//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_reply409_response.g.dart';

/// ParentInboxReply409Response
///
/// Properties:
/// * [message] 
/// * [errors] 
@BuiltValue()
abstract class ParentInboxReply409Response implements Built<ParentInboxReply409Response, ParentInboxReply409ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  ParentInboxReply409ResponseMessageEnum get message;
  // enum messageEnum {  Messages can only be sent during school hours.,  };

  @BuiltValueField(wireName: r'errors')
  String get errors;

  ParentInboxReply409Response._();

  factory ParentInboxReply409Response([void updates(ParentInboxReply409ResponseBuilder b)]) = _$ParentInboxReply409Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxReply409ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxReply409Response> get serializer => _$ParentInboxReply409ResponseSerializer();
}

class _$ParentInboxReply409ResponseSerializer implements PrimitiveSerializer<ParentInboxReply409Response> {
  @override
  final Iterable<Type> types = const [ParentInboxReply409Response, _$ParentInboxReply409Response];

  @override
  final String wireName = r'ParentInboxReply409Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxReply409Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(ParentInboxReply409ResponseMessageEnum),
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
    ParentInboxReply409Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxReply409ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ParentInboxReply409ResponseMessageEnum),
          ) as ParentInboxReply409ResponseMessageEnum;
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
  ParentInboxReply409Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxReply409ResponseBuilder();
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

class ParentInboxReply409ResponseMessageEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Messages can only be sent during school hours.')
  static const ParentInboxReply409ResponseMessageEnum messagesCanOnlyBeSentDuringSchoolHoursPeriod = _$parentInboxReply409ResponseMessageEnum_messagesCanOnlyBeSentDuringSchoolHoursPeriod;

  static Serializer<ParentInboxReply409ResponseMessageEnum> get serializer => _$parentInboxReply409ResponseMessageEnumSerializer;

  const ParentInboxReply409ResponseMessageEnum._(String name): super(name);

  static BuiltSet<ParentInboxReply409ResponseMessageEnum> get values => _$parentInboxReply409ResponseMessageEnumValues;
  static ParentInboxReply409ResponseMessageEnum valueOf(String name) => _$parentInboxReply409ResponseMessageEnumValueOf(name);
}

