//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_finance_pay_intent_request.g.dart';

/// ParentFinancePayIntentRequest
///
/// Properties:
/// * [idempotencyKey] 
@BuiltValue()
abstract class ParentFinancePayIntentRequest implements Built<ParentFinancePayIntentRequest, ParentFinancePayIntentRequestBuilder> {
  @BuiltValueField(wireName: r'idempotency_key')
  String get idempotencyKey;

  ParentFinancePayIntentRequest._();

  factory ParentFinancePayIntentRequest([void updates(ParentFinancePayIntentRequestBuilder b)]) = _$ParentFinancePayIntentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinancePayIntentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinancePayIntentRequest> get serializer => _$ParentFinancePayIntentRequestSerializer();
}

class _$ParentFinancePayIntentRequestSerializer implements PrimitiveSerializer<ParentFinancePayIntentRequest> {
  @override
  final Iterable<Type> types = const [ParentFinancePayIntentRequest, _$ParentFinancePayIntentRequest];

  @override
  final String wireName = r'ParentFinancePayIntentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinancePayIntentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'idempotency_key';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentFinancePayIntentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentFinancePayIntentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  ParentFinancePayIntentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinancePayIntentRequestBuilder();
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

