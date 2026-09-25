//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'parent_finance_invoice200_response.g.dart';

/// ParentFinanceInvoice200Response
///
/// Properties:
/// * [data] 
@BuiltValue()
abstract class ParentFinanceInvoice200Response implements Built<ParentFinanceInvoice200Response, ParentFinanceInvoice200ResponseBuilder> {
  @BuiltValueField(wireName: r'data')
  BuiltMap<String, JsonObject?> get data;

  ParentFinanceInvoice200Response._();

  factory ParentFinanceInvoice200Response([void updates(ParentFinanceInvoice200ResponseBuilder b)]) = _$ParentFinanceInvoice200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ParentFinanceInvoice200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ParentFinanceInvoice200Response> get serializer => _$ParentFinanceInvoice200ResponseSerializer();
}

class _$ParentFinanceInvoice200ResponseSerializer implements PrimitiveSerializer<ParentFinanceInvoice200Response> {
  @override
  final Iterable<Type> types = const [ParentFinanceInvoice200Response, _$ParentFinanceInvoice200Response];

  @override
  final String wireName = r'ParentFinanceInvoice200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ParentFinanceInvoice200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'data';
    yield serializers.serialize(
      object.data,
      specifiedType: const FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ParentFinanceInvoice200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ParentFinanceInvoice200ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'data':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
          ) as BuiltMap<String, JsonObject?>;
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
  ParentFinanceInvoice200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ParentFinanceInvoice200ResponseBuilder();
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

