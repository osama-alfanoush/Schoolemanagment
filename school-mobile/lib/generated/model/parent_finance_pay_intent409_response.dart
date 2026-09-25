//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_finance_pay_intent409_response.g.dart';

/// ParentFinancePayIntent409Response
///
/// Properties:
/// * [message] 
/// * [errors] 
@BuiltValue()
abstract class ParentFinancePayIntent409Response implements Built<ParentFinancePayIntent409Response, ParentFinancePayIntent409ResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String get message;

  @BuiltValueField(wireName: r'errors')
  String get errors;

  ParentFinancePayIntent409Response._();

  factory ParentFinancePayIntent409Response([void updates(ParentFinancePayIntent409ResponseBuilder b)]) = _$ParentFinancePayIntent409Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinancePayIntent409ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinancePayIntent409Response> get serializer => _$ParentFinancePayIntent409ResponseSerializer();
}

class _$ParentFinancePayIntent409ResponseSerializer implements PrimitiveSerializer<ParentFinancePayIntent409Response> {
  @override
  final Iterable<Type> types = const [ParentFinancePayIntent409Response, _$ParentFinancePayIntent409Response];

  @override
  final String wireName = r'ParentFinancePayIntent409Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinancePayIntent409Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
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
    ParentFinancePayIntent409Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentFinancePayIntent409ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  ParentFinancePayIntent409Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinancePayIntent409ResponseBuilder();
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

