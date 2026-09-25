//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_inbox_request_correction_request.g.dart';

/// ParentInboxRequestCorrectionRequest
///
/// Properties:
/// * [field] 
/// * [detail] 
/// * [idempotencyKey] 
@BuiltValue()
abstract class ParentInboxRequestCorrectionRequest implements Built<ParentInboxRequestCorrectionRequest, ParentInboxRequestCorrectionRequestBuilder> {
  @BuiltValueField(wireName: r'field')
  String get field;

  @BuiltValueField(wireName: r'detail')
  String get detail;

  @BuiltValueField(wireName: r'idempotency_key')
  String get idempotencyKey;

  ParentInboxRequestCorrectionRequest._();

  factory ParentInboxRequestCorrectionRequest([void updates(ParentInboxRequestCorrectionRequestBuilder b)]) = _$ParentInboxRequestCorrectionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentInboxRequestCorrectionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentInboxRequestCorrectionRequest> get serializer => _$ParentInboxRequestCorrectionRequestSerializer();
}

class _$ParentInboxRequestCorrectionRequestSerializer implements PrimitiveSerializer<ParentInboxRequestCorrectionRequest> {
  @override
  final Iterable<Type> types = const [ParentInboxRequestCorrectionRequest, _$ParentInboxRequestCorrectionRequest];

  @override
  final String wireName = r'ParentInboxRequestCorrectionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentInboxRequestCorrectionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'field';
    yield serializers.serialize(
      object.field,
      specifiedType: const FullType(String),
    );
    yield r'detail';
    yield serializers.serialize(
      object.detail,
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
    ParentInboxRequestCorrectionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentInboxRequestCorrectionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'field':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.field = valueDes;
          break;
        case r'detail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.detail = valueDes;
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
  ParentInboxRequestCorrectionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentInboxRequestCorrectionRequestBuilder();
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

