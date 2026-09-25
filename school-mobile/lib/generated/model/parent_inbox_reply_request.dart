//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_reply_request.g.dart';

/// ParentInboxReplyRequest
///
/// Properties:
/// * [body] 
/// * [idempotencyKey] 
@BuiltValue()
abstract class ParentInboxReplyRequest implements Built<ParentInboxReplyRequest, ParentInboxReplyRequestBuilder> {
  @BuiltValueField(wireName: r'body')
  String get body;

  @BuiltValueField(wireName: r'idempotency_key')
  String get idempotencyKey;

  ParentInboxReplyRequest._();

  factory ParentInboxReplyRequest([void updates(ParentInboxReplyRequestBuilder b)]) = _$ParentInboxReplyRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxReplyRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxReplyRequest> get serializer => _$ParentInboxReplyRequestSerializer();
}

class _$ParentInboxReplyRequestSerializer implements PrimitiveSerializer<ParentInboxReplyRequest> {
  @override
  final Iterable<Type> types = const [ParentInboxReplyRequest, _$ParentInboxReplyRequest];

  @override
  final String wireName = r'ParentInboxReplyRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxReplyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'body';
    yield serializers.serialize(
      object.body,
      specifiedType: const FullType(String),
    );
    yield r'idempotency_key';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentInboxReplyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxReplyRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'body':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.body = valueDes;
          break;
        case r'idempotency_key':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ParentInboxReplyRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxReplyRequestBuilder();
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

