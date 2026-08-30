//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'finance_generate_invoices201_response.g.dart';

/// FinanceGenerateInvoices201Response
///
/// Properties:
/// * [created] 
@BuiltValue()
abstract class FinanceGenerateInvoices201Response implements Built<FinanceGenerateInvoices201Response, FinanceGenerateInvoices201ResponseBuilder> {
  @BuiltValueField(wireName: r'created')
  int get created;

  FinanceGenerateInvoices201Response._();

  factory FinanceGenerateInvoices201Response([void updates(FinanceGenerateInvoices201ResponseBuilder b)]) = _$FinanceGenerateInvoices201Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FinanceGenerateInvoices201ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FinanceGenerateInvoices201Response> get serializer => _$FinanceGenerateInvoices201ResponseSerializer();
}

class _$FinanceGenerateInvoices201ResponseSerializer implements PrimitiveSerializer<FinanceGenerateInvoices201Response> {
  @override
  final Iterable<Type> types = const [FinanceGenerateInvoices201Response, _$FinanceGenerateInvoices201Response];

  @override
  final String wireName = r'FinanceGenerateInvoices201Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FinanceGenerateInvoices201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'created';
    yield serializers.serialize(
      object.created,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FinanceGenerateInvoices201Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FinanceGenerateInvoices201ResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'created':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.created = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FinanceGenerateInvoices201Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FinanceGenerateInvoices201ResponseBuilder();
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

